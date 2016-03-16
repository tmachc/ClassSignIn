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
    var theClass = {
        "_id" : new ObjectID(),
        "teacher" : new ObjectID(teacher._id),
        "className" : "swift",
        "classMate" : [
            new ObjectID(student._id),
            new ObjectID()
        ]
    };

    var classId = req.query.classId;
    var className = req.query.className;
    if (classId == null || classId == undefined || classId == "") {
        // 没传id 代表新建一个课程

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


