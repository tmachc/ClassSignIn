/**
 * Created by hanchong on 15/5/26.
 */

var DataProvider = require('../DataProvider.js').DataProvider,
    util = require('util');
var NoticeProvider = function() {
    this.collectionName = 'notice'; // 表名
};

util.inherits(NoticeProvider, DataProvider);
exports.NoticeProvider = NoticeProvider;

// 通知表