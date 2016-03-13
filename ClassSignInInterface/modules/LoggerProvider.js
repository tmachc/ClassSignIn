/**
 * Created with JetBrains WebStorm.
 * User: witmob
 * Date: 13-7-25
 * Time: 下午2:30
 * To change this template use File | Settings | File Templates.
 */
var DataProvider = require('./DataProvider.js').DataProvider,
    util = require('util');

var LoggerProvider = function() {
    this.collectionName = 'http_logger';
};

util.inherits(LoggerProvider, DataProvider);

exports.LoggerProvider = LoggerProvider;