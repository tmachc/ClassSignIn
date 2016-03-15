/**
 * Created by hanchong on 15/5/1.
 */

var DataProvider = require('../DataProvider.js').DataProvider,
    util = require('util');
var AttendanceProvider = function() {
    this.collectionName = 'attendance'; // 表名
};

util.inherits(AttendanceProvider, DataProvider);
exports.AttendanceProvider = AttendanceProvider;

// 签到表