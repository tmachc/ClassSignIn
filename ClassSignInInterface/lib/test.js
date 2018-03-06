/**
 * Created by tmachc on 15/4/8.
 */

require('./WarnConfig');
var AipFace = require('baidu-aip-sdk').face; //这个‘baidu-ai’就是上面自定义的package.json中名字
var fs = require('fs');
var edge = require('edge');

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


    var callback1 = req.query.callback;
    var json = {
        "code" : 0,
        // "student" : student,
        // "theClass" : theClass,
        // "attendance" : attendance,
        // "homework" : homework,
        "notice" : notice
    };

    var str = JSON.stringify(json);

    callback(callback1 + "(" + str + ")");
};

exports.testBaidu = function (req, callback) {

    var APP_ID = "10858660";
    var API_KEY = "ZLhxHOjbdY4VEt8VzIX9Sxv7";
    var SECRET_KEY = "mOlxnVSZ5a4xutPMpx3oGruWlUvEi6Dd";

    //读取待识别图像并base64编码
    var bitmap = fs.readFileSync('image/001.jpeg'); // 相对于app.js
    var base64str1 = new Buffer(bitmap).toString('base64');
    var bitmap2 = fs.readFileSync('image/002.jpeg'); // 相对于app.js
    var base64str2 = new Buffer(bitmap2).toString('base64');

    var client = new AipFace(APP_ID, API_KEY, SECRET_KEY);
    // client.addUser("test_user_001", "test_userInfo", "test_001", base64str1, {"name": "huangbo"}).then(function(result) {
    //     console.log(result);
    //     console.log(JSON.stringify(result));
    // }).catch(function(err) {
    //     // 如果发生网络错误
    //     console.log(err);
    // });
    
    // client.multiIdentify("test_001", base64str2, {"detect_top_num": "2"}).then(function(result) {
    //     console.log(result);
    //     console.log(JSON.stringify(result));
    //     callback({code: 0, result: result});
    // }).catch(function(err) {
    //     // 如果发生网络错误
    //     console.log(err);
    // });


    // 定义方法
    var StudyMath = edge.func({
        assemblyFile: '../../_lib/Rocky.dll',             // assemblyFile为dll路径
        atypeName: 'RockyNamespace.Study',   // RockyNamespace为命名空间，Study为类名
        methodName: 'StudyMath'                     // StudyMath为方法名
    });

// s为传递方法传递的参数，result为方法返回的结果
    StudyMath (s, function (error, result) {
        if (error) throw error;
        if (0 == result)
            console.log("aaaaaaaaaaaaaaa"); // Success
        else
            console.log("bbbbbbbbbbbbbbb"); // Failure
    });

};