var express = require('express');
var router = express.Router();
var user = require('../controller/momouser');
/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});

router.post('/momo/new', function(req, res, next) {
    user.addUser(req, res, next);
});

module.exports = router;
