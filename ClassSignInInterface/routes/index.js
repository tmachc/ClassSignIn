
var log4js = require('log4js');
var logger = log4js.getLogger('normal');

var express = require('express');
var router = express.Router();

var test = require('../lib/test');

/* GET home page. */
router.all('/', function(req, res, next) {
//首先获取到命令]
  if (req.method == "POST") {
    var command = req.body.command;
    logger.debug("req.body:",req.body);
    logger.debug("req.query:",req.query);
    logger.debug("req.files:",req.files);
  }
  else {
    var command = req.query.command;
    logger.debug("req.query:",req.query);
  }
  logger.debug("command:",command);
  if (command == null) {
    this.sendRes({code:'10000',message:"参数错误"},res);
  } else {
    if (this[command] == null) {
      logger.warn({code:2000,message:'命令不存在'}+":"+req.url+":"+req.query);
      sendRes({code:2000,message:'命令不存在'},res);
    } else {
      this[command](req, function(sendResponse){
        sendRes(sendResponse,res);
      });
    }
  }
});

module.exports = router;

//发送数据
var sendRes = function(sendResponse,res){
  logger.debug('result -->>',sendResponse);
  res.send(sendResponse);
};


// *************** 测试
initData = function(req,callback){
  test.initData(req,function(sendRes){
    callback(sendRes);
  });
};



// ************************ 用户部分
// 登录
login = function(req, callback) {
  user.login(req, function(sendRes) {
    callback(sendRes);
  });
};

// 注册

// 找回密码

// 修改密码

// ************************ 课程部分
// 添加,修改课程

// ************************ 作业部分
// 添加,修改作业

// 查看作业

// ************************ 通知部分
// 添加,修改通知

// 查看通知

// ************************ 考勤部分
// 添加,修改考勤

// 学生 签到

// 老师 查看考勤
