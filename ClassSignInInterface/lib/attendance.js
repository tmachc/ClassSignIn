/**
 * Created by tmachc on 16/3/18.
 */


require('./WarnConfig');
var ObjectID = require("mongodb").ObjectID;
var log4js = require('log4js');
var logger = log4js.getLogger('normal');
var AttendanceProvider = require("../modules/dao/AttendanceProvider").AttendanceProvider;
var attendanceProvider = new AttendanceProvider();
var ClassProvider = require("../modules/dao/ClassProvider").ClassProvider;
var classProvider = new ClassProvider();

exports.editAttendance = function(req, callback) {
    // 老师发布考勤
    var classId = req.query.classId;
    var attendanceName = req.query.attendanceName;

    classProvider.findOne({_id: new ObjectID(classId)}, {}, function(err, result){
        if (err || result == null) {
            // 数据库错误
            logger.warn(global.warnCode.adminDbError,":",req.url,req.body);
            callback(global.warnCode.adminDbError);
        }
        else {
            var attendance = {
                _id: new ObjectID(),
                classId: classId,
                attendanceName: attendanceName,
                attendanceState: "start",   // 正在签到 结束签到
                attendanceDate: new Date(),
                classMate: []
            };
            for (var i = 0; i < result.classMate.length; i ++){
                var classMate = result.classMate[i];
                classMate.attendanceState = "1";
                attendance.classMate.push(classMate);
            }
            attendanceProvider.insert(attendance, {}, function(err){
                if (err) {
                    // 数据库错误
                    logger.warn(global.warnCode.adminDbError,":",req.url,req.body);
                    callback(global.warnCode.adminDbError);
                }
                else {
                    callback({code: 0, attendance: attendance});
                }
            });
        }
    });
};

exports.getAttendanceList = function(req, callback) {
    var userId = req.query.userId;
    var classId = req.query.classId;
    var type = req.query.type;
    if (type == "teacher") {
        // 老师的是这节课所有的考勤
        attendanceProvider.find({"classId": classId}, {}, function(err, result){
            if (err) {
                // 数据库错误
                logger.warn(global.warnCode.adminDbError,":",req.url,req.body);
                callback(global.warnCode.adminDbError);
            }
            else {
                var list = [];
                for (var i = 0; i < result.length; i ++) {
                    var attendance = {
                        attendanceId: result[i]._id,
                        classId: result[i].classId,
                        attendanceName: result[i].attendanceName,
                        attendanceState: result[i].attendanceState,   // 正在签到 结束签到
                        attendanceDate: format(result[i].attendanceDate, "yyyy-MM-dd hh:mm:ss"),
                        classMate: result[i].classMate
                    };
                    list.push(attendance);
                }
                callback({code: 0, list: list});
            }
        });
    }
    else {
        // 学生的是跟个人有关的 所有考勤
        attendanceProvider.find({"classId": classId, "classMate.studentId": userId}, {"classMate":{"$slice":1}}, function(err, result){
            if (err) {
                // 数据库错误
                logger.warn(global.warnCode.adminDbError,":",req.url,req.body);
                callback(global.warnCode.adminDbError);
            }
            else {
                console.log("aaaaaaaaaaaaaaaaa", result);
                var list = [];
                for (var i = 0; i < result.length; i ++) {
                    var attendance = {
                        attendanceId: result[i]._id,
                        classId: result[i].classId,
                        attendanceName: result[i].attendanceName,
                        attendanceState: result[i].attendanceState,   // 正在签到 结束签到
                        attendanceDate: format(result[i].attendanceDate, "yyyy-MM-dd hh:mm:ss"),
                        classMate: result[i].classMate
                    };
                    list.push(attendance);
                }
                callback({code: 0, list: list});
            }
        });
    }
};

exports.getOneAttendanceData = function(req, callback) {
    var attendanceId = req.query.attendanceId;
    attendanceProvider.findOne({_id: new ObjectID(attendanceId)}, {}, function(err, result){
        if (err || result == null) {
            // 数据库错误
            logger.warn(global.warnCode.adminDbError,":",req.url,req.body);
            callback(global.warnCode.adminDbError);
        }
        else {
            var attendance = {
                attendanceId: result._id,
                classId: result.classId,
                attendanceName: result.attendanceName,
                attendanceState: result.attendanceState,
                attendanceDate: format(result.attendanceDate, "yyyy-MM-dd hh:mm:ss"),
                classMate: result.classMate
            };
            callback({code: 0, attendance: attendance});
        }
    });
};

exports.endSignIn = function(req, callback) {
    var attendanceId = req.query.attendanceId;
    attendanceProvider.findOne({_id: new ObjectID(attendanceId)}, {}, function(err, result){
        if (err || result == null) {
            // 数据库错误
            logger.warn(global.warnCode.adminDbError,":",req.url,req.body);
            callback(global.warnCode.adminDbError);
        }
        else {
            attendanceProvider.update({_id: new ObjectID(attendanceId)},{"$set":{"attendanceState": "end"}}, function(err, result){
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
};

exports.stuSignIn = function(req, callback) {
    var attendanceId = req.query.attendanceId;
    var studentId = req.query.studentId;
    var state = req.query.state;
    attendanceProvider.findOne({_id: new ObjectID(attendanceId), "classMate.studentId": studentId}, {}, function(err, result){
        if (err || result == null) {
            // 数据库错误
            logger.warn(global.warnCode.adminDbError,":",req.url,req.body);
            callback(global.warnCode.adminDbError);
        }
        else {
            console.log(result);
            attendanceProvider.update({_id: new ObjectID(attendanceId), "classMate.studentId": studentId},
                {"$set":{"classMate.$.attendanceState": state}}, function(err, result){
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
