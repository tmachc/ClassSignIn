require('./Config');
var Db = require('mongodb').Db,
    Server = require('mongodb').Server;

var Provider = function () {
};

Provider.prototype.db = new Db(global.mongodbDB, new Server(global.mongodbHost, global.mongodbPort, {auto_reconnect: true, poolSize: 5}),{safe:false},{w: 0, native_parser: false});

(function () {
    Provider.prototype.db.open(function(err, db) {
        if (err) {
            throw err;
        }
        Provider.prototype.db = db;
    });
})();
exports.Provider = Provider;