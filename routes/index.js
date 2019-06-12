const express = require('express');
const router = express.Router();
const admin=require('../controller/admin');
const server=require('../controller/server');

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});
router.get('/admin', function(req, res, next) {
    res.render('index', { title: 'Express' });
});
router.get('/user', function(req, res, next) {
    res.render('index', { title: 'Express' });
});
router.get('/login',function (req,res,next) {
    res.render('login');
});
router.get('/register',function (req,res,next) {
    res.render('register');
});
router.get('/admin/manageUser',function (req,res,next) {
    res.render('admin/manageUser');
});
router.get('/admin/get/user',function (req,res,next) {
    admin.getUsers(req,res);
});
router.get('/admin/get/goods',function (req,res,next) {
    admin.getGoods(req,res)
});
router.get('/admin/get/goodsName',function (req,res,next) {
    admin.getGoodsName(req,res)
});
router.get('/admin/get/goodsType',function (req,res,next) {
    admin.getGoodsType(req,res)
});
router.get('/user/all/goods',function (req,res,next) {
    admin.buyGoods(req,res);
});
router.get('/user/get/transactionRecord',function (req,res,next) {
    admin.userGetTransactionRecord(req,res);
});
router.get('/user/get/transactionRecord_change',function (req,res,next) {
    admin.userGetTransactionRecord_change(req,res);
});
router.get('/admin/get/transactionRecord_changeid',function (req,res,next) {
    admin.userGetTransactionRecord_changeid(req,res);
});
router.get('/admin/get/transactionRecord',function (req,res,next) {
    admin.adminGetTransactionRecord(req,res);
});

router.post('/login',function (req,res,next) {
   admin.checkUser(req,res,next);
});
router.post('/logout',function (req,res,next) {
    res.json({status:null});
});
router.post('/register',function (req,res,next) {
    admin.registerUser(req,res,next)
});

router.post('/user/buy/goods',function (req,res,next) {
    admin.addTransactionRecord(req,res);
});

router.post('/admin/charge',function (req,res,next) {
    admin.adminCharge(req,res);
});

router.post('/admin/delete/user',function (req,res,next) {
    admin.adminDeleteUser(req,res);
});

router.post('/admin/delete/goodsvalue',function (req,res,next) {
    admin.adminDeleteGoodsValue(req,res);
});

router.post('/admin/delete/goodsName',function (req,res,next) {
    admin.adminDeleteGoodsName(req,res);
});

router.post('/admin/delete/goodsType',function (req,res,next) {
    admin.adminDeleteGoodsType(req,res);
});

router.post('/admin/modify/goodsName',function (req,res,next) {
    admin.adminModifyGoodsName(req,res);
});

router.post('/admin/modify/goodsType',function (req,res,next) {
    admin.adminModifyGoodsType(req,res);
});

router.post('/admin/modify/goodsCoin',function (req,res,next) {
    admin.adminModifyGoodsCoin(req,res);
});

router.post('/admin/cancel/order',function (req,res,next) {
    admin.adminCancelOrder(req,res);
});

router.get('/server/status', function (req, res) {
    server.serverStatus(req,res);
});

router.get('/server/detail', function (req, res) {
    server.serverDetail(req,res);
});


router.get('/server/users/status', function (req, res) {
    server.userStatus(req,res);
});

module.exports = router;
