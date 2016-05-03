/**
 * Created by tmachc on 16/3/18.
 */


require('./WarnConfig');
var ObjectID = require("mongodb").ObjectID;
var log4js = require('log4js');
var logger = log4js.getLogger('normal');
var HomeworkProvider = require("../modules/dao/HomeworkProvider").HomeworkProvider;
var homeworkProvider = new HomeworkProvider();

exports.editHomework = function(req, callback) {
    var homeworkId = req.query.homeworkId;
    var homeworkName = req.query.homeworkName;
    var homeworkContent = req.query.homeworkContent;
    var homeworkDate = req.query.homeworkDate;
    var classId = req.query.classId;

    if (homeworkId == null || homeworkId == undefined || homeworkId == "") {
        // 没传id 代表新建一个作业
        // 先看看有没有重的
        homeworkProvider.findOne({homeworkName: homeworkName, classId: new ObjectID(classId)}, {}, function(err, result) {
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
                var homework = {
                    "_id" : new ObjectID(),
                    "classId" : new ObjectID(classId),
                    "homeworkName" : homeworkName,
                    "homeworkContent" : homeworkContent,
                    homeworkDate: homeworkDate,
                    createTime: new Date(),
                    updateTime: new Date()
                };
                console.log("sdsdsdsd   ",homework);
                homeworkProvider.insert(homework, {}, function(err) {
                    if (err) {
                        // 数据库错误
                        logger.warn(global.warnCode.adminDbError,":",req.url,req.body);
                        callback(global.warnCode.adminDbError);
                    }
                    else {
                        callback({code: 0, homework: homework});
                    }
                });
            }
        });
    }
    else {
        // 更新课程信息
        homeworkProvider.findOne({"_id": new ObjectID(homeworkId)}, {}, function(err, result) {
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
                    homeworkName : homeworkName,
                    homeworkContent : homeworkContent,
                    homeworkDate : homeworkDate,
                    updateTime : new Date()
                };
                homeworkProvider.update({"_id": new ObjectID(homeworkId)}, {"$set": json}, function(err) {
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

exports.getHomeworkList = function(req, callback) {
    var classId = req.query.classId;
    homeworkProvider.find({classId: new ObjectID(classId)}, {}, function(err, result) {
        if (err || result == null) {
            // 数据库错误
            logger.warn(global.warnCode.adminDbError,":",req.url,req.body);
            callback(global.warnCode.adminDbError);
        }
        else {
            var list = [];
            for (var i = 0; i < result.length; i ++) {
                var json = {
                    homeworkId : result[i]._id,
                    homeworkName : result[i].homeworkName,
                    homeworkContent : result[i].homeworkContent,
                    homeworkDate : result[i].homeworkDate
                    //createTime : format(result[i].createTime, "yyyy-MM-dd hh:mm:ss"),
                    //updateTime : format(result[i].updateTime, "yyyy-MM-dd hh:mm:ss")
                };
                list.push(json)
            }
            callback({code: 0, list: list});
        }
    });
};

