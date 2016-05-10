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
    userProvider.findOne({"num" : num}, {}, function(err, result){
        if (err) {
            // 数据库错误
            logger.warn(global.warnCode.adminDbError,":",req.url,req.query);
            callback(global.warnCode.adminDbError);
        }
        else if (result == null) {
            // 没有找到结果(没有这个学号的人)
            logger.warn(global.warnCode.userNotExistError,":",req.url,req.query);
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

exports.register = function(req, callback){
    var num = req.query.num;
    var password = req.query.password;
    var name= req.query.name;
    userProvider.findOne({num: num}, {}, function(err, result){
        if (err) {
            // 数据库错误
            logger.warn(global.warnCode.adminDbError,":",req.url,req.query);
            callback(global.warnCode.adminDbError);
        }
        else if (result != null) {
            logger.warn(global.warnCode.userHaveBeenExistError,":",req.url,req.query);
            callback(global.warnCode.userHaveBeenExistError);
        }
        else {
            var user = {
                "_id" : new ObjectID(),
                "password" : password,
                "name" : name,
                "num" : num,
                "sex" : "",
                "age" : ""
            };
            if (num.length == 6) {
                user.type = "teacher";
            }
            else if (num.length == 10) {
                user.type = "student"
            }
            else {
                callback({code: 1005, message:"学号或教职工号不正确"});
                return;
            }
            userProvider.insert(user, {}, function(err){
                if (err) {
                    // 数据库错误
                    logger.warn(global.warnCode.adminDbError,":",req.url,req.query);
                    callback(global.warnCode.adminDbError);
                }
                else {
                    callback({code: 0, user: user});
                }
            });
        }
    });
};

exports.editMy = function(req, callback){
    var userId = req.query.userId;
    var name = req.query.name;
    var num = req.query.num;
    var sex = req.query.sex;
    var age = req.query.age;
    userProvider.findOne({_id: new ObjectID(userId)}, {}, function(err, result){
        if (err) {
            // 数据库错误
            logger.warn(global.warnCode.adminDbError,":",req.url,req.query);
            callback(global.warnCode.adminDbError);
        }
        else if (result == null) {
            logger.warn(global.warnCode.userNotExistError,":",req.url,req.query);
            callback(global.warnCode.userNotExistError);
        }
        else {
            var user = {};
            if (name != null && name != "" && name != undefined) {
                user.name = name;
            }
            if (num != null && num != "" && num != undefined) {
                user.num = num;
            }
            if (sex != null && sex != "" && sex != undefined) {
                user.sex = sex;
            }
            if (age != null && age != "" && age != undefined) {
                user.age = age;
            }
            userProvider.update({_id: new ObjectID(userId)}, {"$set": user}, function(err){
                if (err) {
                    // 数据库错误
                    logger.warn(global.warnCode.adminDbError,":",req.url,req.query);
                    callback(global.warnCode.adminDbError);
                }
                else {
                    // 修改 class 里面的数据
                    callback({code: 0, user: user});
                }
            });
        }
    });
};