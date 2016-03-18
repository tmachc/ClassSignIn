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

};

exports.getAttendanceList = function(req, callback) {

};


