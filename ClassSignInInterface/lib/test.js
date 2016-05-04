/**
 * Created by tmachc on 15/4/8.
 */

require('./WarnConfig');
var ObjectID = require("mongodb").ObjectID;
var log4js = require('log4js');
var logger = log4js.getLogger('normal');
var UserProvider = require("../modules/dao/UserProvider").UserProvider;
var userProvider = new UserProvider();
var HomeworkProvider = require("../modules/dao/HomeworkProvider").HomeworkProvider;
var homeworkProvider = new HomeworkProvider();
var NoticeProvider = require("../modules/dao/NoticeProvider").NoticeProvider;
var noticeProvider = new NoticeProvider();
var AttendanceProvider = require("../modules/dao/AttendanceProvider").AttendanceProvider;
var attendanceProvider = new AttendanceProvider();
var ClassProvider = require("../modules/dao/ClassProvider").ClassProvider;
var classProvider = new ClassProvider();


exports.initData = function(req,callback){
    var teacher = {
        "_id" : new ObjectID(),
        "phone" : "15010243108",
        "password" : "123",
        "name" : "韩冲",
        "num" : "2010011182",
        "sex" : "男",
        "age" : "24",
        "type" : "teacher"
    };
    //userProvider.insert(teacher,{},function(err){
    //    if (err) {
    //        logger.warn(global.warnCode.adminDbError,":",req.url,req.body);
    //        callback(global.warnCode.adminDbError);
    //    }
    //    //else {
    //    //    callback({"result":true,"isSuccess":true,message:""});
    //    //}
    //});
    var student = {
        "_id" : new ObjectID(),
        "phone" : "18210277823",
        "password" : "123",
        "name" : "高晨阳",
        "num" : "2012010946",
        "sex" : "女",
        "age" : "21",
        "type" : "student"
    };
    //userProvider.insert(student,{},function(err){
    //    if (err) {
    //        logger.warn(global.warnCode.adminDbError,":",req.url,req.body);
    //        callback(global.warnCode.adminDbError);
    //    }
    //});
    var theClass = {
        "_id" : new ObjectID(),
        "teacher" : new ObjectID(teacher._id),
        "className" : "swift",
        "classMate" : [
            new ObjectID(student._id),
            new ObjectID()
        ]
    };
    //classProvider.insert(theClass,{},function(err){
    //    if (err) {
    //        logger.warn(global.warnCode.adminDbError,":",req.url,req.body);
    //        callback(global.warnCode.adminDbError);
    //    }
    //});
    var attendance = {
        "_id" : new ObjectID(),
        "classId" : new ObjectID(theClass._id),
        "state" : "1", // 1,正在签到 2,结束签到
        "attendanceDate" : new Date(),
        "attendanceName" : "抽查签到",
        "classmate" : [
            {
                "stuId" : new ObjectID(student._id),
                "stuName" : student.name,
                "stuNum" : student.num,
                "attendanceState" : "4",
                "attendanceTime" : new Date()
            }
        ]
    };
    //attendanceProvider.insert(attendance,{},function(err){
    //    if (err) {
    //        logger.warn(global.warnCode.adminDbError,":",req.url,req.body);
    //        callback(global.warnCode.adminDbError);
    //    }
    //});
    var homework = {
        "_id" : new ObjectID(),
        "classId" : new ObjectID(theClass._id),
        "homeworkName" : "15号作业",
        "homeworkContent" : "今天的作业是xxxxxxxxxx",
        "homeworkDate" : new Date()
    };
    //homeworkProvider.insert(homework,{},function(err){
    //    if (err) {
    //        logger.warn(global.warnCode.adminDbError,":",req.url,req.body);
    //        callback(global.warnCode.adminDbError);
    //    }
    //});
    var notice = {
        "_id" : new ObjectID(),
        "classId" : new ObjectID(theClass._id),
        "noticeName" : "停课通知",
        "noticeContent" : "今天的课不上了！",
        "noticeDate" : new Date()
    };
    //noticeProvider.insert(notice,{},function(err){
    //    if (err) {
    //        logger.warn(global.warnCode.adminDbError,":",req.url,req.body);
    //        callback(global.warnCode.adminDbError);
    //    }
    //});
    //console.log("111");
    //userProvider.find({},{},function(err,result){
    //    console.log("222",err,result);
    //    if (err) {
    //        logger.warn(global.warnCode.adminDbError,":",req.url,req.body);
    //        callback(global.warnCode.adminDbError);
    //    } else {
    //        console.log("333");
    //        callback({"result":true,"list":result});
    //    }
    //});
    callback({
        "code" : 0,
        "student" : student,
        "theClass" : theClass,
        "attendance" : attendance,
        "homework" : homework,
        "notice" : notice
    });
};