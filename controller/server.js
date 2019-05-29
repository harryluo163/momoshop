let request = require('request');
let dbFunc =require('./dbFunc');

exports.serverStatus = function (req,res) {

    let url = "http://localhost:9527/server/status";
    request({
        url: url,
        qs: req.query
    }, function (error, response, body){
        if (error) {
            res.json({total:0,rows:[]});
            return;
        }

        try {
            let servers = JSON.parse(body);
            res.json({total:servers.total,rows:servers.rows});
        } catch (e) {
            res.json({total:0,rows:[]});
        }
    });
};

exports.serverDetail = function(req, res) {

    dbFunc.connectPool("SELECT COUNT(*) FROM client_order_info WHERE client_order_info.addr = ?;" +
        "SELECT orders.id, orders.room, client_order_info.num FROM client_order_info,orders WHERE client_order_info.orderId = orders.id AND client_order_info.addr = ?;",
        [req.query.addr, req.query.addr],
        function (err, rows) {

            if (err) {
                res.json({})
                return;
            }

            res.json({total:rows[0][0].total,rows:rows[1]});
        })
};
exports.userStatus = function (req,res) {
   let url = "http://localhost:9527/users/status";
    request({
        url: url,
        method: "get",
    }, function (error, response, body){
        if (error) {
            res.json({total:0,rows:[]});
            return;
        }

        try {
            let json = JSON.parse(body);
            res.json(json);
        } catch (e) {
            res.json({total:'--', used:'--'});
        }
    });
};