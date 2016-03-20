/**
 * Created by tmachc on 16/3/18.
 */


require('./WarnConfig');
var ObjectID = require("mongodb").ObjectID;
var log4js = require('log4js');
var logger = log4js.getLogger('normal');
var NoticeProvider = require("../modules/dao/NoticeProvider").NoticeProvider;
var noticeProvider = new NoticeProvider();

exports.editNotice = function(req, callback) {

};

exports.getNoticeList = function(req, callback) {
    var classId = req.query.classId;
    noticeProvider.find({"classId": classId}, {}, function(err, result) {
        if (err) {
            // 数据库错误
            logger.warn(global.warnCode.adminDbError,":",req.url,req.query);
            callback(global.warnCode.adminDbError);
        }
        else {
            // result 为数组 没有结果的时候 是空数组[]
            /*

             */
            callback({code: 0, list: result});
        }
    });
};

