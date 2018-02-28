/**
 * Created by ccwonline on 17/3/7.
 */

var log4js = require('log4js');
var logger = log4js.getLogger('normal');

var express = require('express');
var router = express.Router();

/* GET home page. */
router.all('/', function(req, res, next) {
//首先获取到命令]
    if (req.method == "POST") {
        var html = req.body.h;
        logger.debug("req.body:",req.body);
        logger.debug("req.query:",req.query);
        logger.debug("req.files:",req.files);
    }
    else {
        var html = req.query.h;
        logger.debug("req.query -->>> :",req.query);
    }
    logger.debug("html:",html);
    sendRes(html,res);
    // if (command == null) {
    //     this.sendRes({code:'10000',message:"参数错误"},res);
    // } else {
    // }
});

module.exports = router;

//发送数据
var sendRes = function(sendResponse,res){
    logger.debug('result -->>',sendResponse);
    logger.debug('sendFile -->>' + "/Users/ccwonline/svn/LoadMaster/" + sendResponse);
    res.sendFile("/Users/ccwonline/svn/LoadMaster/" + sendResponse);
};