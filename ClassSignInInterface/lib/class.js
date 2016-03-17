/**
 * Created by hanchong on 16/3/16.
 */

require('./WarnConfig');
var ObjectID = require("mongodb").ObjectID;
var log4js = require('log4js');
var logger = log4js.getLogger('normal');
var ClassProvider = require("../modules/dao/ClassProvider").ClassProvider;
var classProvider = new ClassProvider();

exports.editClass = function(req, callback) {
    var classId = req.query.classId;
    var className = req.query.className;
    var teacher = req.query.teacher;
    if (classId == null || classId == undefined || classId == "") {
        // 没传id 代表新建一个课程
        // 先看看有没有重的
        classProvider.findOne({className: className, teacher: new ObjectID(teacher)}, {}, function(err, result) {
            if (err) {
                // 数据库错误
                logger.warn(global.warnCode.adminDbError,":",req.url,req.body);
                callback(global.warnCode.adminDbError);
            }
            else if (result != null) {
                // 存在相同的课程，不能创建
                callback(global.warnCode.userNotExistError);
            }
            else {
                var theClass = {
                    "_id" : new ObjectID(),
                    "teacher" : new ObjectID(teacher),
                    "className" : className,
                    "classMate" : [],
                    createTime: new Date(),
                    updateTime: new Date()
                };
                classProvider.count({}, function(err, result) {
                    console.log("result --->>>", "FQ" + getNewClassNum(result + 1, 4));
                    theClass.classNum = "FQ" + getNewClassNum(result + 1, 4);
                    classProvider.insert(theClass, {}, function(err) {
                        if (err) {
                            // 数据库错误
                            logger.warn(global.warnCode.adminDbError,":",req.url,req.body);
                            callback(global.warnCode.adminDbError);
                        }
                        else {
                            callback({code: 0, classNum: theClass.classNum});
                        }
                    });
                });
            }
        });
    }
    else {
        // 更新课程信息
        classProvider.findOne({"classId": classId}, {}, function(err, result) {
            if (err) {
                // 数据库错误
                logger.warn(global.warnCode.adminDbError,":",req.url,req.body);
                callback(global.warnCode.adminDbError);
            }
            else if (result == null) {
                // 没有找到结果
                logger.warn(global.warnCode.userNotExistError,":",req.url,req.body);
                callback(global.warnCode.userNotExistError);
            }
            else {
                var json = {
                    className : className,
                    updateTime : new Date()
                };
                classProvider.update({"classId": classId}, {"$set": json}, function(err) {
                    if (err) {
                        // 数据库错误
                        logger.warn(global.warnCode.adminDbError,":",req.url,req.body);
                        callback(global.warnCode.adminDbError);
                    }
                    else {
                        callback({code: 0});
                    }
                });
            }
        });
    }

};

function getNewClassNum(num, n) {
    var len = num.toString().length;
    while(len < n) {
        num = "0" + num;
        len ++;
    }
    return num;
}

exports.getClassList = function(req, callback) {
    var type = req.query.type;
    var userId = req.query.userId;
    if (type == "teacher") {
        classProvider.find({teacher: new ObjectID(userId)}, {}, function(err, result) {
            if (err || result == null) {
                // 数据库错误
                logger.warn(global.warnCode.adminDbError,":",req.url,req.body);
                callback(global.warnCode.adminDbError);
            }
            else {
                callback({code: 0, list: result});
            }
        });
    }
};
