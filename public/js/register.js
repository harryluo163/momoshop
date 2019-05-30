$(function() {
    // Waves初始化
    Waves.displayEffect();
    // 输入框获取焦点后出现下划线
    $('.form-control').focus(function() {
        $(this).parent().addClass('fg-toggled');
    }).blur(function() {
        $(this).parent().removeClass('fg-toggled');
    });
});
$(function() {
    // 点击登录按钮
    $('#register-bt').click(function() {
        register();
    });
    // 回车事件
    $('#username, #password').keypress(function (event) {
        if (13 == event.keyCode) {
            register();
        }
    });
});
// 注册
function register() {
    $.ajax({
        url: '/register',
        type: 'POST',
        data: {
            id:RandomWord('abcdefghijklmnopqrstuvwxyz1234567890').random(16),
            username: $('#username').val(),
            password:  $.md5($('#password').val()),
        },
        beforeSend: function() {
        },
        success: function(json){
            if(json.status){
                $('#username').focus();
            }else{
                localStorage.setItem("id",json.id);
                localStorage.setItem("username",$('#username').val());
                localStorage.setItem("role",json.role);
                localStorage.setItem("coin",json.coin);
                location.href = '/';
            }
        },
        error: function(error){
            console.log(error);
        }
    });
}