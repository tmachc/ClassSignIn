/**
 * Created by hanchong on 15/5/26.
 */

var DataProvider = require('../DataProvider.js').DataProvider,
    util = require('util');
var ClassProvider = function() {
    this.collectionName = 'class'; // 表名
};

util.inherits(ClassProvider, DataProvider);
exports.ClassProvider = ClassProvider;

// 课程表