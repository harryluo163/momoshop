
let sqlStr = require('./sqlStr');
let dbFunc =require('./dbFunc');
let utils=require('./utils');
let request = require('request');
let async = require('async');
let mqtt = require('./mqtt')

exports.checkUser = function (req,res,next) {
    let sqlParams=[req.body.username,req.body.password];
    dbFunc.connectPool(sqlStr.login,sqlParams,(err,rows)=>{
        if(err){
            res.json({status:err});
            return;
        }
        if(rows.length<=0){
            res.json({status:'不存在该用户'});
            return;
        }
        req.session.user={id:rows[0].id,username:req.body.username,password:req.body.password,role:rows[0].role};
        res.json({status:err,role:rows[0].role=='admin'?'1':'2',id:rows[0].id,coin:rows[0].coin});
    });
};

exports.registerUser=function (req,res,next) {
    let sqlParams=[req.body.id,req.body.username,req.body.password,0];
    dbFunc.connectPool(sqlStr.exist,[req.body.username],(err,rows)=>{
        if(err){
            res.json({status:err});
            return;
        }
        if(rows[0].userNumber>0){
            res.json({status:'用户名已存在'})
        }else{
            dbFunc.connectPool(sqlStr.register,sqlParams,(err,rows)=>{
                if(err){
                    res.json({status:err});
                    return;
                }
                req.session.user={id:req.body.id,username:req.body.username,password:req.body.password,role:'user'};
                res.json({status:err,role:'2',id:req.body.id,coin:0});
            });
        }
    });
};

exports.getUsers=function (req,res) {
    let offset=parseInt(req.query.offset),limit=parseInt(req.query.limit);
    let sqlParams=[offset,limit];
    dbFunc.connectPool(sqlStr.userPage,sqlParams,(err,rows)=>{
        if(err){
            res.json({});
            return;
        }
        res.json({total:rows[0][0].total,rows:rows[1]});
    });
};

exports.getGoods=function (req,res) {
    let offset=parseInt(req.query.offset),limit=parseInt(req.query.limit);
    let sqlParams=[offset,limit];
    dbFunc.connectPool(sqlStr.goodsPage,sqlParams,(err,rows)=>{
        if(err){
            res.json({});
            return;
        }
        res.json({total:rows[0][0].total,rows:rows[1]});
    });
};
exports.getGoodsName=function (req,res) {
    dbFunc.connectPool(sqlStr.goodsName,(err,rows)=>{
        if(err){
            res.json({});
            return;
        }
        res.json({rows:rows});
    });
};
exports.getGoodsType=function (req,res) {
    dbFunc.connectPool(sqlStr.goodsType,(err,rows)=>{
        if(err){
            res.json({});
            return;
        }
        res.json({rows:rows});
    });
};

exports.buyGoods=function (req,res) {
    dbFunc.connectPool(sqlStr.buyGoods,(err,rows)=>{
        if(err){
            res.json({});
            return;
        }
        dbFunc.connectPool("select coin from user where id ='"+req.session.user.id+"'",(err,rows2)=>{
            res.json({
                rows:rows,
                coin:rows2[0].coin
            });
        })

    });
};

exports.addTransactionRecord=function (req,res) {
    let id=req.body.id,roomId=req.body.roomId;
    let url =req.body.roomId;
    let createBy=req.body.userId,num=parseInt(req.body.num),gvId=parseInt(req.body.gvId);
    let createAt=utils.fortimestamp(new Date(), 'yyyy-MM-dd hh:mm:ss');
    let endDate=undefined;
    let timeType,singlePrice,goodName;
    let type=req.body.type;
    roomId=roomId.replace("https://","").replace(".html","")
        .replace("https://","")
        .replace("m.immomo.com/s/moment/new-share-v2/","")
        .replace("m.immomo.com","");
    dbFunc.connectPool(sqlStr.goodsValue,[gvId],(err,rows)=>{
        if(err){
            res.json({error:err});
            return;
        }
        if(rows.length==0){
            res.json({error:'error'});
            return;
        }
        timeType=rows[0].gType;singlePrice=parseInt(rows[0].gValue);goodName=rows[0].gName;
        if(timeType=='单次'){
            let curDate=new Date();
            curDate.setUTCHours(curDate.getUTCHours()+6);
            endDate=utils.fortimestamp(curDate, 'yyyy-MM-dd hh:mm:ss')
        } else if(timeType=='包天'){
            let curDate=new Date();
            curDate.setUTCDate(curDate.getUTCDate()+1);
            endDate=utils.fortimestamp(curDate, 'yyyy-MM-dd hh:mm:ss')
        }else if(timeType=='包周'){
            let curDate=new Date();
            curDate.setUTCDate(curDate.getUTCDate()+7);
            endDate=utils.fortimestamp(curDate, 'yyyy-MM-dd hh:mm:ss')
        }else if(timeType=='半月'){
            let curDate=new Date();
            curDate.setUTCDate(curDate.getUTCDate()+15);
            endDate=utils.fortimestamp(curDate, 'yyyy-MM-dd hh:mm:ss')
        }else{
            let curDate=new Date();
            curDate.setUTCMonth(curDate.getUTCMonth()+1);
            endDate=utils.fortimestamp(curDate, 'yyyy-MM-dd hh:mm:ss')
        }
        dbFunc.getConnection(function (err, conn) {
            if (err) {
                res.json({error:'购买错误'});
                return;
            }

            conn.beginTransaction(function(err) {
                if (err) {
                    res.json({error:'购买错误'});
                    conn.rollback(function () { });
                    return;
                }

                conn.query(sqlStr.substractUserCoin,[num*singlePrice,num*singlePrice,createBy],(err,rows)=> {
                    if (err) {
                        conn.rollback(function () { });
                        res.json({error: err});
                        return;
                    }

                    if (rows.changedRows === 0) {
                        conn.rollback(function () { });
                        res.json({error: '购买错误'});
                        return;
                    }

                    conn.query("select coin,username from user where id = '"+createBy+"'",(err,rows)=> {
                        let coin_my=rows[0].coin
                        let goodstr=goodName+' '+timeType+' '+singlePrice+'积分';
                        let sqlParams=[id,roomId,goodstr,num,num*singlePrice,createBy,createAt,endDate,coin_my,rows[0].username,url];
                        var type=""
                        if(goodName.indexOf("陌陌直播")>=0){
                            type="momozhibo"
                        }else  if(goodName.indexOf("陌陌派对")>=0){
                            type="momopaidui"
                        }else  if(goodName.indexOf("聊天室")>=0){
                            type="liaotianshi"
                        }else  if(goodName.indexOf("狼人圈")>=0){
                            type="langrenquan"
                        }else  if(goodName.indexOf("关注")>=0||goodName.indexOf("点赞")>=0||goodName.indexOf("播放量")>=0){
                            type="gzdzbfl"
                        }

                        dbFunc.connectPoolOther(sqlStr.addTransactionRecord,sqlParams,type,(err,rows)=>{
                            if(err){
                                conn.rollback(function () { });
                                res.json({error:err});
                                return;
                            }

                            conn.commit(function(err) {
                                if (err) {
                                    conn.rollback(function () { });
                                    res.json({error: '购买错误'});
                                } else {
                                    mqtt.sendAddOrder(req.body.roomId);
                                    res.json({error:null});
                                }
                            });

                        });

                    })

                })
            })

        });
    });
    // dbFunc.connectPool(sqlStr.getCoinById,[createBy],(err,rows)=>{
    //     if(err){
    //         res.json({error:err});
    //         return;
    //     }
    //     let totalCoin=parseInt(rows[0].coin);
    //     if(totalCoin<num*single_price){
    //         res.json({error:"购买错误"});
    //         return;
    //     }
    //     let curCoin=parseInt(rows[0].coin)-num*single_price;
    //     dbFunc.connectPool(sqlStr.subTractCoinById,[curCoin,createBy],(err,rows)=>{
    //         if(err){
    //             res.json({error:err});
    //             return;
    //         }
    //         let sqlParams=[id,roomId,goods,num,num*singlePrice,createBy,createAt,endDate];
    //         dbFunc.connectPool(sqlStr.addTransactionRecord,sqlParams,(err,rows)=>{
    //             if(err){
    //                 res.json({error:err});
    //                 return;
    //             }
    //             res.json({error:null,coin:curCoin});
    //         });
    //     });
    // });
};

exports.userGetTransactionRecord=function (req,res) {
    let offset=parseInt(req.query.offset==undefined?0:req.query.offset),limit=parseInt(req.query.limit==undefined?10:req.query.limit),userId=req.query.id,select=req.query.select,eDate=req.query.eDate;
    var sqlParams2="  1=1 "

    if(userId!=""&&userId!=undefined){
        sqlParams2+=" and orders.createBy= '"+userId+"' "
    }
    if(select!=""&&select!=undefined){
        sqlParams2+=" and ( goods like '%"+select+"%' )"
    }
    if(eDate!=""&&eDate!=undefined){

        sqlParams2+=" and endDate <'"+Date.parse(eDate +' 23:59:59')+"' and endDate >'"+Date.parse(eDate +' 00:00:00')+"'";
    }

    if(req.query.roomId!=""&&req.query.roomId!=undefined){
        sqlParams2+=" and ( room like '%"+req.query.roomId+"%' or remark like '%"+req.query.roomId+"%') "
    }
    if(req.query.select_status!=""&&req.query.select_status!=undefined){
        sqlParams2+=" and orders.status= '"+req.query.select_status+"' "
    }
    let sqlParams=[offset,limit];
    var sql ='select count(*) as total ' +
    ' from orders where    '+sqlParams2+' ;select orders.id,orders.status,orders.remark, orders.coin,createByUser username,orders.room,orders.goods,orders.num,orders.price,orders.createAt,orders.endDate' +
    ' from orders where    '+sqlParams2+' ORDER BY createAt DESC limit ?,?'


    dbFunc.connectPoolOther(sql, sqlParams,req.query.type, (err, rows) => {

        if (err) {
            res.json({});
            return;
        }
        res.json({total: rows[0][0].total, rows: rows[1]});
    });
};

exports.userGetTransactionRecord_change=function (req,res) {
    roomId =req.query.room;
    roomId=roomId.replace("https://","").replace(".html","")
        .replace("https://","")
        .replace("m.immomo.com/s/moment/new-share-v2/","")
        .replace("m.immomo.com","");
    dbFunc.connectPoolOther("update orders set status =?,remark=?,room=? where id=?",[req.query.status,req.query.remark,roomId,req.query.Id],req.query.type,(err,rows)=>{
        if(err){
            res.json({msg:"err"});
            return;
        }
        if(req.query.status==2){
            CancelOrder(req.query.Id,req,res)
        }else{
            res.json({msg:"ok"});
        }

    });
}
exports.userGetTransactionRecord_changeid=function (req,res) {
    dbFunc.connectPool("update orders set status=2 where id=?",[req.query.Id],(err,rows)=>{
        if(err){
            res.json({msg:"err"});
            return;
        }
        res.json({msg:"ok"});
    });
}
exports.adminGetTransactionRecord=function (req,res) {
    let offset=parseInt(req.query.offset),limit=parseInt(req.query.limit);
    let sqlParams=[offset,limit];
    if(req.query.search){
        let searchText = '%' + req.query.search + '%';
        dbFunc.connectPool(sqlStr.adminGetTransactionRecordBySearchText,[searchText,searchText,offset,limit],(err,rows)=>{
            if(err){
                res.json({});
                return;
            }
            res.json({total:rows[0][0].total,rows:rows[1]});
        });
    }else{
        dbFunc.connectPool(sqlStr.adminGetTransactionRecord, sqlParams,(err,rows)=>{
            if(err){
                res.json({});
                return;
            }
            res.json({total:rows[0][0].total,rows:rows[1]});
        });
    }
};

exports.adminCharge=function (req,res) {
    let username=req.body.username,coin=parseInt(req.body.coin);
    dbFunc.connectPool(sqlStr.getCoin,[username],(err,rows)=>{
        if(err){
            res.json({status:'error'});
            return;
        }
        let totalCoin=coin+parseInt(rows[0].coin);
        dbFunc.connectPool(sqlStr.chargeCoin,[totalCoin,username],(err,rows)=>{
            if(err){
                res.json({status:'error'});
                return;
            }
            res.json({status:null});
        });
    });
};

exports.adminDeleteUser=function (req,res) {
    let id=req.body.id;
    dbFunc.connectPool(sqlStr.deleteUser,[id],(err,rows)=>{
        if(err){
            res.json({status:'error'});
            return;
        }
        res.json({status:null});
    });
};

exports.adminDeleteGoodsValue=function (req,res) {
    let id=req.body.id;
    dbFunc.connectPool(sqlStr.deleteGoodsValue,[id],(err,rows)=>{
        if(err){
            res.json({status:'error'});
            return;
        }
        res.json({status:null});
    });
};

exports.adminDeleteGoodsName=function (req,res) {
    let id=req.body.id;
    dbFunc.connectPool(sqlStr.deleteGoodsName,[id],(err,rows)=>{
        if(err){
            res.json({status:'error'});
            return;
        }
        res.json({status:null});
    });
};

exports.adminDeleteGoodsType=function (req,res) {
    let id=req.body.id;
    dbFunc.connectPool(sqlStr.deleteGoodsType,[id],(err,rows)=>{
        if(err){
            res.json({status:'error'});
            return;
        }
        res.json({status:null});
    });
};

exports.adminModifyGoodsName=function (req,res) {
    let id=req.body.id,name=req.body.name;
    dbFunc.connectPool(sqlStr.modifyGName,[name,id],(err,rows)=>{
        if(err){
            res.json({status:'error'});
            return;
        }
        res.json({status:null});
    });
};
exports.adminModifyGoodsType=function (req,res) {
    let id=req.body.id,name=req.body.type;
    dbFunc.connectPool(sqlStr.modifyGType,[type,id],(err,rows)=>{
        if(err){
            res.json({status:'error'});
            return;
        }
        res.json({status:null});
    });
};

exports.adminModifyGoodsCoin=function (req,res) {
    let id=req.body.id,coin=req.body.coin;
    dbFunc.connectPool(sqlStr.modifyGCoin,[coin,id],(err,rows)=>{
        if(err){
            res.json({status:'error'});
            return;
        }
        res.json({status:null});
    });
};

exports.adminCancelOrder=function (req,res) {
    let orderId = req.body.orderId;
    CancelOrder(orderId,req,res)

};

function CancelOrder(orderId,req,res) {
    dbFunc.connectPool(sqlStr.orderById, [orderId], (err, rows) => {
        if (err) {
            res.json({error: '取消错误'});
            return;
        }
        let coin = rows[0].price;
        let userId = rows[0].createBy;
        dbFunc.connectPool(sqlStr.getCoinById, [userId], (err, rows) => {
            if (err) {
                res.json({error: '取消错误'});
                return;
            }
            let curCoin = rows[0].coin + coin;
            dbFunc.connectPool(sqlStr.getCoinById, [userId], (err, rows) => {
                if (err) {
                    res.json({error: '取消错误'});
                    return;
                }
                let curCoin = rows[0].coin + coin;
                dbFunc.getConnection(function (err, connection) {
                    if (err) {
                        res.json({error: '购买错误'});
                        return;
                    }

                    let items = [];

                    let tasks = [function (callback) {
                        // 开启事务
                        connection.beginTransaction(function (err) {
                            callback(err);
                        });
                    }, function (callback) {
                        connection.query(sqlStr.cancelOrder, [orderId, curCoin, userId, orderId], (err, rows) => {
                            callback(err)
                        })
                    }, function (callback) {
                        // 提交事务
                        connection.commit(function (err) {
                            callback(err);
                        });
                    }];

                    try {
                        async.series(tasks, function (err, results) {
                            if (err) {
                                res.json({error: '取消错误'});
                                console.log(err);
                                connection.rollback(); // 发生错误事务回滚
                                return;
                            }
                            res.json({});
                            mqtt.sendDeleteOrder(orderId);
                        });

                    } catch (e) {
                        console.log(e);
                    }

                });
            });

        });
    });
}