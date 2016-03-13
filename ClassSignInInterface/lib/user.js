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
    var teacher = {
        "_id" : new ObjectID(),
        "phone" : "15010243108",
        "password" : "123",
        "name" : "韩冲",
        "num" : "2010011182",
        "sex" : "男",
        "age" : 24,
        "type" : "teacher"
    };
    var phone = req.query.phone;
    var password = req.query.password;
    var name = req.query.name;
    var num = req.query.num;
    var sex = req.query.sex;
    var age = req.query.age;
    var type = req.query.type;
    var user = {
        "_id" : new ObjectID(),
        "phone" : phone,
        "password" : password,
        "name" : name,
        "num" : num,
        "sex" : sex,
        "age" : age,
        "type" : type
    };
    userProvider.findOne({"num" : num}, {}, function(err, result){
        console.log("phone--->>>",num);
        console.log("result--->>>",result);
        if (err) {
            // 数据库错误
            logger.warn(global.warnCode.userNotExistError,":",req.url,req.body);
            callback(global.warnCode.userNotExistError);
        }
        else if (result == null) {
            // 没有找到结果(没有这个学号的人)
        }
        else {
            if (password == result.password) {
                // 密码相同 登录成功
            }
            else {
                // 密码不同 登录失败
            }
        }
    });
};
