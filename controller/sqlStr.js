
module.exports={
    goodsType:'select type from goodstype',
    exist:'select count(id) as userNumber from user where username=?',
    login:'select * from user where username=? and password=?',
    register:'insert into user(id,username,password,coin,role)values(?,?,?,?,"user")',
    userPage:'select count(id) as total from user; select * from user limit ?,?',
    goodsPage:'select count(*) as total from goodsvalue; ' +
    'select goodsvalue.id, goods.name as goodsName,goodstype.type as goodsType,goodsvalue.value as goodsValue from goods,goodstype,goodsvalue ' +
    'where goodsvalue.goodsId=goods.id and goodsvalue.goodsTypeId=goodstype.id limit ?,?',
    buyGoods:'select goodsvalue.id as id,goods.name as goodsName,goodstype.type as goodsType,goodsvalue.value as goodsValue from goods,goodstype,goodsvalue ' +
    'where goodsvalue.goodsId=goods.id and goodsvalue.goodsTypeId=goodstype.id;',
    addTransactionRecord:'insert into orders(id,room,goods,num,price,createBy,createAt,endDate,coin)values(?,?,?,?,?,?,?,?,?);',
    userGetTransactionRecord:'select count(*) as total from orders where createBy=?;select orders.id, orders.status, orders.remark,user.username,orders.room,orders.goods,orders.num,orders.price,orders.createAt,orders.endDate' +
    ' from orders,user where user.id=orders.createBy and orders.createBy=? ORDER BY createAt DESC limit ?,?',
    userGetTransactionRecordBySearchText:'select count(*) as total ' +
    ' from orders,user where user.id=orders.createBy and orders.createBy=   ?  ? ;select orders.id,user.username,orders.room,orders.goods,orders.num,orders.price,orders.createAt,orders.endDate' +
    ' from orders,user where user.id=orders.createBy and orders.createBy=? ? ORDER BY createAt DESC limit ?,?',
    adminGetTransactionRecord:'select count(*) as total from orders;select orders.id,user.username,orders.room,orders.goods,orders.num,orders.price,orders.createAt,orders.endDate' +
    ' from orders,user where user.id=orders.createBy ORDER BY orders.createAt DESC limit ?,?',
    adminGetTransactionRecordBySearchText:'select count(*) as total from orders WHERE orders.room LIKE ? ;select orders.id,user.username,orders.room,orders.goods,orders.num,orders.price,orders.createAt,orders.endDate' +
    ' from orders,user where user.id=orders.createBy and orders.room LIKE ? ORDER BY orders.createAt limit ?,?',
    getCoin:'select coin from user where username=?',
    getCoinById:'select coin from user where id=?',
    chargeCoin:'update user set coin=? where username=?',
    subTractCoinById:'update user set coin=? where id=?',
    deleteUser:'delete from user where id=?',
    deleteGoodsValue:'delete from goodsvalue where id=?',
    deleteGoodsName:'delete from goods where id=?',
    deleteGoodsType:'delete from goodstype where id=?',
    goodsName:'select id,name as goodsName from goods',
    goodsType:'select id, type as goodsType from goodstype',
    modifyGName:'update goods set name=? where id=?',
    modifyGType:'update goodstype set type=? where id=?',
    modifyGCoin:'update goodsvalue set value=? where id=?',
    orderById:'select * from orders where id=?',
    deleteOrder:'delete from order where id=?',
    cancelOrder:'INSERT INTO orders_delete(SELECT * FROM orders WHERE orders.id = ?);' +
    'update user set coin=? where id=?;update orders set status =2 where id=?',
    goodsValue:'select goods.name as gName, goodstype.type as gType,goodsvalue.value as gValue from goods, goodsvalue,goodstype ' +
    'where goodsvalue.id=? and goodsvalue.goodsTypeId=goodstype.id and goodsvalue.goodsId=goods.id',
    substractUserCoin:'update user set coin=(if(coin>=?,coin-?,coin)) where id=?'
};
