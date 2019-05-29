
let dbFunc =require('./dbFunc');
let utils=require('./utils');
let request = require('request');
let async = require('async');

exports.addUser = function (req,res,next) {
    var sql = "INSERT INTO `nmmdb`.`account`(`momoId`, `phone`, `password`, `session`, `idfa`) VALUES (?, ?, ?, ?, ?);";
    let sqlParams=[req.body.momoId,req.body.phone, req.body.password, req.body.session, req.body.idfa];
    dbFunc.connectPool(sql,sqlParams,(err,rows)=>{
        if(err){
            res.json({status:err});
            return;
        }
        if(rows.length<=0){
            res.json({status:'不存在该用户'});
            return;
        }
        res.json({status:err});
    });
};