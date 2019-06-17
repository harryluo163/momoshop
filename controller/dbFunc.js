let mysql = require('mysql');
let db = require('./db');


module.exports={
    connectPool(sql,val,cb){
        // if (val && Object.prototype.toString.call(val)=== '[object Function]') {
        //     pool.query(sql,(err,rows)=>{
        //         val(err, rows);
        //     });
        //     return;
        // }
        //
        // if (cb && Object.prototype.toString.call(cb)=== '[object Function]') {
        //
        //     pool.query(sql,val,(err,rows)=>{
        //         cb(err, rows);
        //     });
        // }
        var pool=mysql.createPool(db.db);
        // /*
        pool.getConnection((err,conn)=>{

            if (val && Object.prototype.toString.call(val)=== '[object Function]') {

                if (err) {
                    console.log("获取MySql 连接错误: " + err);
                    val(err, []);
                    return;
                }

                conn.query(sql,(err,rows)=>{
                    val(err, rows);
                });
            } else
            if (cb && Object.prototype.toString.call(cb)=== '[object Function]') {

                if (err) {
                    console.log("获取MySql 连接错误: " + err);
                    cb(err, []);
                    return;
                }

                conn.query(sql,val,(err,rows)=>{
                    cb(err, rows);
                });
            }
            conn.release();
        })
         // */
    },
    getConnection(callback) {
        var pool=mysql.createPool(db.db);
        pool.getConnection((err,conn)=> {
            if (err) {
                console.log("获取MySql 连接错误: " + err);
                callback(err, conn);
                return;
            }
            callback(err, conn);
            conn.release();
        })
    },
    connectPoolOther(sql,val,type,cb){
        // if (val && Object.prototype.toString.call(val)=== '[object Function]') {
        //     pool.query(sql,(err,rows)=>{
        //         val(err, rows);
        //     });
        //     return;
        // }
        //
        // if (cb && Object.prototype.toString.call(cb)=== '[object Function]') {
        //
        //     pool.query(sql,val,(err,rows)=>{
        //         cb(err, rows);
        //     });
        // }

        // /*
        var pool=mysql.createPool(db[type]);
        pool.getConnection((err,conn)=>{

            if (val && Object.prototype.toString.call(val)=== '[object Function]') {

                if (err) {
                    console.log("获取MySql 连接错误: " + err);
                    val(err, []);
                    return;
                }

                conn.query(sql,(err,rows)=>{
                    val(err, rows);
                });
            } else
            if (cb && Object.prototype.toString.call(cb)=== '[object Function]') {

                if (err) {
                    console.log("获取MySql 连接错误: " + err);
                    cb(err, []);
                    return;
                }

                conn.query(sql,val,(err,rows)=>{
                    cb(err, rows);
                });
            }
            conn.release();
        })
        // */
    },
};
