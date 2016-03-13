/**
 * Created by hanchong on 15/4/9.
 */

var DataProvider = require('../DataProvider.js').DataProvider,
    util = require('util');
var HomeworkProvider = function() {
    this.collectionName = 'homework'; // 表名
};

util.inherits(HomeworkProvider, DataProvider);
exports.HomeworkProvider = HomeworkProvider;

// 作业表