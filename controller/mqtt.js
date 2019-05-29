var mqtt = require('mqtt');
var msg = require('./msg');
var opt = {
    port:1883,
    clientId: 'nodejs'
};
var io = require("socket.io");

var client  = mqtt.connect('tcp://192.168.1.5');

client.on('connect', function () {
    console.log('已連接至MQTT伺服器');
    client.subscribe("momo/manager");
});

client.on('message', function (topic, msg) {
    console.log('收到 ' + topic + ' 主題，訊息：' + msg.toString());
});

exports.sendAddOrder =function (momoId) {
    var info = msg.encodeNodeJS({"type":0, "id":momoId});
    client.publish("momo/server", info, {qos:1});
};

exports.sendDeleteOrder =function (orderId) {
    var info = msg.encodeNodeJS({"type":1, "id":orderId});
    client.publish("momo/server", info, {qos:1});
};

