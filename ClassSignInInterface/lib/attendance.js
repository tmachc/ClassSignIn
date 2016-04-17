/**
 * Created by tmachc on 16/3/18.
 */


require('./WarnConfig');
var ObjectID = require("mongodb").ObjectID;
var log4js = require('log4js');
var logger = log4js.getLogger('normal');
var AttendanceProvider = require("../modules/dao/AttendanceProvider").AttendanceProvider;
var attendanceProvider = new AttendanceProvider();

exports.editAttendance = function(req, callback) {
    // 老师发布考勤
    var classId = req.query.classId;
    var attendanceName = req.query.attendanceName;

    var attendance = {
        _id: new ObjectID(),
        classId: classId,
        attendanceName: attendanceName,
        date: new Date()
    };

    attendanceProvider.insert(attendance, {}, function(err){
        if (err) {
            // 数据库错误
            logger.warn(global.warnCode.adminDbError,":",req.url,req.body);
            callback(global.warnCode.adminDbError);
        }
        else {
            
        }
    });
};

exports.getAttendanceList = function(req, callback) {

};


