/**
 * Created by tmachc on 16/3/18.
 */


require('./WarnConfig');
var ObjectID = require("mongodb").ObjectID;
var log4js = require('log4js');
var logger = log4js.getLogger('normal');
var NoticeProvider = require("../modules/dao/NoticeProvider").NoticeProvider;
var noticeProvider = new NoticeProvider();

exports.editNotice = function(req, callback) {
    var noticeId = req.query.noticeId;
    var noticeName = req.query.noticeName;
    var noticeContent = req.query.noticeContent;
    var classId = req.query.classId;

    if (noticeId == null || noticeId == undefined || noticeId == "") {
        // 没传id 代表新建一个作业
        // 先看看有没有重的
        noticeProvider.findOne({noticeName: noticeName, classId: new ObjectID(classId)}, {}, function(err, result) {
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
                var notice = {
                    "_id" : new ObjectID(),
                    "classId" : new ObjectID(classId),
                    "noticeName" : noticeName,
                    "noticeContent" : noticeContent,
                    createTime: new Date(),
                    updateTime: new Date()
                };
                noticeProvider.insert(notice, {}, function(err) {
                    if (err) {
                        // 数据库错误
                        logger.warn(global.warnCode.adminDbError,":",req.url,req.body);
                        callback(global.warnCode.adminDbError);
                    }
                    else {
                        callback({code: 0, notice: notice});
                    }
                });
            }
        });
    }
    else {
        // 更新课程信息
        noticeProvider.findOne({"_id": new ObjectID(noticeId)}, {}, function(err, result) {
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
                    noticeName : className,
                    noticeContent : noticeContent,
                    updateTime : new Date()
                };
                noticeProvider.update({"_id": new ObjectID(noticeId)}, {"$set": json}, function(err) {
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

exports.getNoticeList = function(req, callback) {
    var classId = req.query.classId;
    noticeProvider.find({"classId": new ObjectID(classId)}, {}, function(err, result) {
        if (err) {
            // 数据库错误
            logger.warn(global.warnCode.adminDbError,":",req.url,req.query);
            callback(global.warnCode.adminDbError);
        }
        else {
            // result 为数组 没有结果的时候 是空数组[]
            var list = [];
            for (var i = 0; i < result.length; i ++) {
                var json = {
                    noticeId : result[i]._id,
                    noticeName : result[i].noticeName,
                    noticeContent : result[i].noticeContent,
                    //createTime : format(result[i].createTime, "yyyy-MM-dd hh:mm:ss"),
                    //updateTime : format(result[i].updateTime, "yyyy-MM-dd hh:mm:ss")
                };
                list.push(json)
            }
            callback({code: 0, list: list});
        }
    });
};

