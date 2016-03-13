/**
 * Created by hanchong on 15/4/9.
 */

var DataProvider = require('../DataProvider.js').DataProvider,
    util = require('util');
var UserProvider = function() {
    this.collectionName = 'user'; // 表名
};

util.inherits(UserProvider, DataProvider);
exports.UserProvider = UserProvider;

// 学生和老师表