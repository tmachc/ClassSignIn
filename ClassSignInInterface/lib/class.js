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
    var teacherId = req.query.teacherId;
    var teacherName = req.query.teacherName;
    if (classId == null || classId == undefined || classId == "") {
        // 没传id 代表新建一个课程
        // 先看看有没有重的
        classProvider.findOne({className: className, teacherId: new ObjectID(teacherId)}, {}, function(err, result) {
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
                    "teacherId" : new ObjectID(teacherId),
                    "className" : className,
                    "teacherName" : teacherName,
                    "classMate" : [],
                    createTime: new Date(),
                    updateTime: new Date()
                };
                classProvider.count({}, function(err, result) {
                    theClass.classNum = "FQ" + getNewClassNum(result + 1, 4);
                    console.log("result --->>>", theClass.classNum);
                    classProvider.insert(theClass, {}, function(err) {
                        if (err) {
                            // 数据库错误
                            logger.warn(global.warnCode.adminDbError,":",req.url,req.body);
                            callback(global.warnCode.adminDbError);
                        }
                        else {
                            callback({code: 0, theClass: theClass});
                        }
                    });
                });
            }
        });
    }
    else {
        // 更新课程信息
        classProvider.findOne({"classId": new ObjectID(classId)}, {}, function(err, result) {
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
                    "teacherId" : new ObjectID(teacherId),
                    "teacherName" : teacherName,
                    updateTime : new Date()
                };
                classProvider.update({"classId": new ObjectID(classId)}, {"$set": json}, function(err) {
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
        classProvider.find({teacherId: new ObjectID(userId)}, {}, function(err, result) {
            if (err || result == null) {
                // 数据库错误
                logger.warn(global.warnCode.adminDbError,":",req.url,req.body);
                callback(global.warnCode.adminDbError);
            }
            else {
                var list = [];
                for (var i = 0; i < result.length; i ++) {
                    var json = {
                        classId : result[i]._id,
                        teacherId : result[i].teacherId,
                        teacherName : result[i].teacherName,
                        classNum : result[i].classNum,
                        className : result[i].className
                        //createTime : format(result[i].createTime, "yyyy-MM-dd hh:mm:ss"),
                        //updateTime : format(result[i].updateTime, "yyyy-MM-dd hh:mm:ss")
                    };
                    list.push(json)
                }
                callback({code: 0, list: list});
            }
        });
    }
    else {

    }
};



//时间格式转换
function format(d, format) {
//        {date} d
//        日期
//        {string} format
//        日期格式：yyyy-MM-dd w hh:mm:ss
//        yyyy/yy 表示年份
//        MM/M 月份
//        w 星期
//        dd/d 日
//        hh/h 小时
//        mm/m 分
//        ss/s 秒

    var str = format;
    var Week = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];
    var month = d.getMonth() + 1;

    str = str.replace(/yyyy/, d.getFullYear());
    str = str.replace(/yy/, (d.getYear() % 100) > 9 ? (d.getYear() % 100).toString() : '0' + (d.getYear() % 100));
    str = str.replace(/MM/, month > 9 ? month.toString() : '0' + month);
    str = str.replace(/M/g, month);
    str = str.replace(/dd/, d.getDate() > 9 ? d.getDate().toString() : '0' + d.getDate());
    str = str.replace(/d/g, d.getDate());

    str = str.replace(/w/g, Week[d.getDay()]);

    str = str.replace(/hh/, d.getHours() > 9 ? d.getHours().toString() : '0' + d.getHours());
    str = str.replace(/h/g, d.getHours());
    str = str.replace(/mm/, d.getMinutes() > 9 ? d.getMinutes().toString() : '0' + d.getMinutes());
    str = str.replace(/m/g, d.getMinutes());
    str = str.replace(/ss/, d.getSeconds() > 9 ? d.getSeconds().toString() : '0' + d.getSeconds());
    str = str.replace(/s/g, d.getSeconds());
    console.log("format --->>> ",str);
    return str;
}
