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

    var attendance = {
        _id: new ObjectID(),
        classId: classId,
        attendanceName: attendanceName,
        attendanceState: attendanceState,   // 正在签到 结束签到
        date: new Date(),
        classMate: []
    };
    classProvider.findOne({_id: new ObjectID(classId)}, {}, function(err, result){
        if (err || result == null) {
            // 数据库错误
            logger.warn(global.warnCode.adminDbError,":",req.url,req.body);
            callback(global.warnCode.adminDbError);
        }
        else {
            for (var i = 0; i < result.classMate.length; i ++){
                var classMate = result.classMate[i];
                classMate.attendanceState = 1;
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

};


