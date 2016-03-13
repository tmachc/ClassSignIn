/**
 * Created by tmachc on 15/4/8.
 */

require('./WarnConfig');
var ObjectID = require("mongodb").ObjectID;
var log4js = require('log4js');
var logger = log4js.getLogger('normal');
var UserProvider = require("../modules/dao/UserProvider").UserProvider;
var userProvider = new UserProvider();


exports.initData = function(req,callback){
    var teacher = {
        "_id" : new ObjectID(),
        "phone" : "15010243108",
        "password" : "123",
        "name" : "韩冲",
        "num" : "2010011182",
        "sex" : "男",
        "age" : 24,
        "type" : "teacher"
    };
    var student = {
        "_id" : new ObjectID(),
        "phone" : "18210277823",
        "password" : "123",
        "name" : "付琦",
        "num" : "2012010945",
        "sex" : "女",
        "age" : 21,
        "type" : "student"
    };
    var theClass = {
        "_id" : new ObjectID(),
        "teacher" : new ObjectID(teacher._id),
        "className" : "swift",
        "classMate" : [
            new ObjectID(student._id),
            new ObjectID()
        ]
    };
    var signIn = {
        "_id" : new ObjectID(),
        "classId" : new ObjectID(theClass._id),
        "date" : new Date(),
        "note" : "抽查签到",
        "classmate" : [
            {
                "stuId" : new ObjectID(student._id),
                "stuName" : "付琦",
                "stuNum" : "2012010945",
                "signInDate" : new Date()
            }
        ]
    };
    var homework = {
        "_id" : new ObjectID(),
        "classId" : new ObjectID(theClass._id),
        "text" : "今天的作业是xxxxxxxxxx",
        "date" : new Date()
    };
    var notice = {
        "_id" : new ObjectID(),
        "classId" : new ObjectID(theClass._id),
        "text" : "今天的课不上了！",
        "date" : new Date()
    };
    console.log("111");
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
        "signIn" : signIn,
        "homework" : homework,
        "notice" : notice
    });
};