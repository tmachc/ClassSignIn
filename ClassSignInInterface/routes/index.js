
var log4js = require('log4js');
var logger = log4js.getLogger('normal');

var express = require('express');
var router = express.Router();

var test = require('../lib/test');
var user = require('../lib/user');
var theClass = require('../lib/class');
var notice = require('../lib/notice');
var homework = require('../lib/homework');
var attendance = require('../lib/attendance');
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


testBaidu = function(req,callback){
  test.testBaidu(req,function(sendRes){
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
register = function(req, callback) {
  user.register(req, function(sendRes) {
    callback(sendRes);
  });
};

// 修改信息
editMy = function(req, callback) {
  user.editMy(req, function(sendRes) {
    callback(sendRes);
  });
};

// ************************ 课程部分
// 添加,修改课程
editClass = function(req, callback) {
  theClass.editClass(req, function(sendRes) {
    callback(sendRes);
  });
};

// 获取课程列表
getClassList = function(req, callback) {
  theClass.getClassList(req, function(sendRes) {
    callback(sendRes);
  });
};

// 学生 加入课程
addToClass = function(req, callback) {
  theClass.addToClass(req, function(sendRes) {
    callback(sendRes);
  });
};

// ************************ 作业部分
// 添加,修改作业
editHomework = function(req, callback) {
  homework.editHomework(req, function(sendRes) {
    callback(sendRes);
  });
};

// 获取作业列表
getHomeworkList = function(req, callback) {
  homework.getHomeworkList(req, function(sendRes) {
    callback(sendRes);
  });
};

// 查看作业

// ************************ 通知部分
// 添加,修改通知
editNotice = function(req, callback) {
  notice.editNotice(req, function(sendRes) {
    callback(sendRes);
  });
};

// 获取通知列表
getNoticeList = function(req, callback) {
  notice.getNoticeList(req, function(sendRes) {
    callback(sendRes);
  });
};

// 查看通知

// ************************ 考勤部分
// 添加,修改考勤
editAttendance = function(req, callback) {
  attendance.editAttendance(req, function(sendRes) {
    callback(sendRes);
  });
};

// 考勤列表
getAttendanceList = function(req, callback) {
  attendance.getAttendanceList(req, function(sendRes) {
    callback(sendRes);
  });
};

// 老师 一次考勤详情
getOneAttendanceData = function(req, callback) {
  attendance.getOneAttendanceData(req, function(sendRes) {
    callback(sendRes);
  });
};

// 老师 结束考勤
endSignIn = function(req, callback) {
  attendance.endSignIn(req, function(sendRes) {
    callback(sendRes);
  });
};

// 学生 签到
stuSignIn = function(req, callback) {
  attendance.stuSignIn(req, function(sendRes) {
    callback(sendRes);
  });
};

// 老师 查看考勤(客户端点名)
