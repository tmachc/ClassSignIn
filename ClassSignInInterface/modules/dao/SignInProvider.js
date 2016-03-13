/**
 * Created by hanchong on 15/5/1.
 */

var DataProvider = require('../DataProvider.js').DataProvider,
    util = require('util');
var SignInProvider = function() {
    this.collectionName = 'signIn'; // 表名
};

util.inherits(SignInProvider, DataProvider);
exports.SignInProvider = SignInProvider;

// 签到表