var Provider = require('./Provider').Provider,
    util = require('util');

var DataProvider = function () {
};

util.inherits(DataProvider, Provider);

DataProvider.prototype.getCollection = function (callback) {            //创建一个getcollection方法
    this.db.collection(this.collectionName, function (err, collection) {    //返回这个 数据库的表
        if (err) callback(err);
        else callback(err, collection);
    });
};

DataProvider.prototype.update = function (selector, document, options, callback) {
    if ('function' === typeof options) {
        callback = options;
        options = {upsert: true, multi: true, w: 1};   //更新这个数据的对象内容
    }
    this.getCollection(function (err, collection) {       //方法
        if (err) callback(err);
        else {
            collection.update(selector, document, options, function (err, result) {
                callback(err, result);
            });
        }
    });
};
DataProvider.prototype.find = function (selector, options, callback) {
    this.getCollection(function (err, collection) {
        if (err) callback(err);
        else {
            collection.find(selector, options).toArray(function (err, result) {
                if(result){
                    callback(err, result);
                }else {
                    callback(err, []);
                }
            });
        }
    });
};

DataProvider.prototype.findOne = function (selector, options, callback) {
    this.getCollection(function (err, collection) {
        if (err) callback(err);
        else {
            collection.findOne(selector, options, function (err, result) {
                callback(err, result);
            });
        }
    });
};
DataProvider.prototype.findAndModify=function(query, sort, options, callback){
    this.getCollection(function(err,collection){
        if(err)callback(err);
        else{
            collection.findAndModify(query,sort,options,function(err,result){
                callback(err,result);
            })
        }
    })
};
DataProvider.prototype.count=function(selector, callback){
    this.getCollection(function (err, collection) {
        if (err) callback(err);
        else {
            collection.count(selector,function (err, count) {
                callback(err, count);
            });
        }
    });
}
DataProvider.prototype.findAndSort = function (selector, options, sort, callback) {
    this.getCollection(function (err, collection) {
        if (err) callback(err);
        else {
            collection.find(selector, options).sort(sort).toArray(function (err, result) {
                if(result){
                    callback(err, result);
                }else {
                    callback(err, []);
                }
            });
        }
    });
};
DataProvider.prototype.insert = function (docs, options, callback) {
    this.getCollection(function (err, collection) {
        if (err) callback(err);
        else {
            collection.insert(docs, options, function (err, result) {
                callback(err, result);
            });
        }
    });
};

DataProvider.prototype.remove = function (selector, options, callback) {
    this.getCollection(function (err, collection) {
        if (err) callback(err);
        else {
            collection.remove(selector, options, function (err, result) {
                callback(err, result);
            });
        }
    });
};

DataProvider.prototype.findAndRemove = function (query, options, callback) {
    this.getCollection(function (err, collection) {
        if (err) callback(err);
        else {
            collection.findAndRemove(query, options, function (err, result) {
                callback(err, result);
            });
        }
    });
};
DataProvider.prototype.ensureIndex = function (fieldOrSpec, options, callback) {
    this.getCollection(function (err, collection) {
        if (err) callback(err);
        else {
            collection.ensureIndex(fieldOrSpec, options, function (err, result) {
                callback(err, result);
            });
        }
    });
};
DataProvider.prototype.geoNear = function (x, y, options, callback) {
    this.getCollection(function (err, collection) {
        if (err) callback(err);
        else {
            collection.geoNear(x, y, options, function (err, result) {
                callback(err, result);
            });
        }
    });
};
DataProvider.prototype.pagination=function(pageination, callback){
    this.getCollection(function (err, collection) {
        if (err) callback(err);
        else {
            var options={};
            options.limit=parseInt(pageination.pageNumber)+1;
            options.skip=pageination.begin;
            if(pageination.sort){
                options.sort=pageination.sort;
            }
            collection.find(pageination.query, options).toArray(function (err, resultarray) {
                if(resultarray){
                    var result={};
                    if(resultarray.length==options.limit){
                        result.more=true;//有下一页
//                        result.pageIndex=pageination.pageIndex+2;
                        resultarray.splice(pageination.pageNumber,1);
                    }else{
//                        result.pageIndex=pageination.pageIndex+1;
                        result.more=false;//有下一页
                    }
                    if(pageination.pageIndex==0){
                        result.previous=false;
                    }else{
                        result.previous=true;
                    }
                    result.array=resultarray;
                    callback(err, result);
                }else {
                    callback(err, []);
                }
            });
        }
    });
};
DataProvider.prototype.mapReduce = function (map, reduce, options, callback) {
    this.getCollection(function (err, collection) {
        if (err) callback(err);
        else {
            if(options.verbose){
                collection.mapReduce(map, reduce, options, function(err, collection,stats) {
                    callback(err,collection,stats);
                });
            }else{
                collection.mapReduce(map, reduce, options, function(err, collection) {
                    callback(err,collection);
                });
            }


        }
    });
};
exports.DataProvider = DataProvider;