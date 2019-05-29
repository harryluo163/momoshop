$(document).ready(function(){
    $("#goodsNum").data("oldVal",1);
    //Add
    $(".quantity-add").click(function(e){
        //Vars
        var count = 1;
        var newcount = 0;
        var count = $("#goodsNum").val();
        var newcount = parseInt(count) + 1;
        $("#goodsNum").val(newcount);
        $("#goodsNum").data("oldVal",newcount);
        goods_num=newcount;
        if(goods_single_price){
            $('#payValue').val(goods_single_price*goods_num);
        }
    });

    //Remove
    $(".quantity-remove").click(function(e){
        //Vars
        var count = 1;
        var newcount = 0;
        var count = $("#goodsNum").val();
        var newcount = parseInt(count) - 1;
        if(newcount>0){
            $("#goodsNum").val(newcount);
            $("#goodsNum").data("oldVal",newcount);
            goods_num=newcount;
            if(goods_single_price){
                $('#payValue').val(goods_single_price*goods_num);
            }
        }
    });
});
