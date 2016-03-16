/**
 * Created by hanchong on 16/3/13.
 */

require('./WarnConfig');
var ObjectID = require("mongodb").ObjectID;
var log4js = require('log4js');
var logger = log4js.getLogger('normal');
var UserProvider = require("../modules/dao/UserProvider").UserProvider;
var userProvider = new UserProvider();

exports.login = function(req, callback) {
    var password = req.query.password;
    var num = req.query.num;
    console.log("num--->>>",num);
    userProvider.findOne({"num" : num}, {}, function(err, result){
        console.log("result--->>>",result);
        if (err) {
            // 数据库错误
            logger.warn(global.warnCode.adminDbError,":",req.url,req.body);
            callback(global.warnCode.adminDbError);
        }
        else if (result == null) {
            // 没有找到结果(没有这个学号的人)
            logger.warn(global.warnCode.userNotExistError,":",req.url,req.body);
            callback(global.warnCode.userNotExistError);
        }
        else {
            if (password == result.password) {
                // 密码相同 登录成功
                callback({
                    "code": 0,
                    "user": result
                });
            }
            else {
                // 密码不同 登录失败
                callback({
                    code: 1004,
                    message: "用户名或密码错误"
                });
            }
        }
    });
};
