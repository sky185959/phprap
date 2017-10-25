$(function() {

    $('#side-menu').metisMenu();

    // 吐司提示
    $('[data-toggle="tooltip"]').tooltip();

    $(window).bind("load resize", function() {
        topOffset = 50;
        width = (this.window.innerWidth > 0) ? this.window.innerWidth : this.screen.width;
        if (width < 768) {
            $('div.navbar-collapse').addClass('collapse');
            topOffset = 100; // 2-row-menu
        } else {
            $('div.navbar-collapse').removeClass('collapse');
        }

        height = ((this.window.innerHeight > 0) ? this.window.innerHeight : this.screen.height) - 1;
        height = height - topOffset;
        if (height < 1) height = 1;
        if (height > topOffset) {
            $("#page-wrapper").css("min-height", (height) + "px");
        }
    });

    var url = window.location;
    var element = $('ul.nav a').filter(function() {
        return this.href == url || url.href.indexOf(this.href) == 0;
    }).addClass('active').parent().parent().addClass('in').parent();
    if (element.is('li')) {
        element.addClass('active');
    }

});

/**
 * 优化的弹出框
 * @param msg 弹出信息
 * @param time 自动关闭时间
 * @param callback 关闭后回调函数
 */
function alert(msg, time, callback) {
    var d = dialog({
        zIndex: 9999,
        fixed: true,
        quickClose: true,
        content: msg
    });
    d.show();
    if(time){
        setTimeout(function () {

            if(callback){
                callback();
            }

            d.close().remove();
        }, time);
    }

    return false;
}

/**
 * 优化的确认框
 * @param msg 确认框消息
 * @param ok 确认回调函数
 * @param cancel 取消回调函数
 */
function confirm(msg, ok) {
    var d = dialog({
        fixed: true,
        width: '280',
        title: '温馨提示',
        content: msg,
        okValue: '确定',
        ok: ok,
        cancelValue: '取消',
        cancel: function () {
            d.close().remove();
            return false;
        }
    });
    d.show();
    return false;

}

/**
 * 表单验证
 */
(function($){
    $.fn.validateForm = function(options){

    var defaults = {
        submitBtn: '.js_submit',
        before: '', //上传成功时的回调函数
        success: '', //上传成功时的回调函数
        error: '' //上传失败时的回调函数

    };

    var thisObj = $(this);
    var config  = $.extend(defaults, options);
    var before  = config.before;
    var success = config.success;
    var error   = config.error;
    var submitBtn = config.submitBtn;

    thisObj.Validform({

        tiptype:function(msg,o,cssctl){

            if(!o.obj.is("form")){

                var objtip=o.obj.siblings(".Validform_checktip");

                cssctl(objtip,o.type);

                objtip.text(msg);

            }

        },

        label:"label",

        ajaxPost:true,

        btnSubmit: submitBtn,

        beforeSubmit: function () {

            if(before && before() === false){

                return false;
            }

            $(submitBtn).attr("disabled", "disabled").text('提交中..');
        },
        callback:function(json){

            if(json.code == 200){

                $(submitBtn).attr("disabled", "disabled").text('提交成功');

                alert(json.msg, 1000, function () {

                    if(success){

                        success();

                    }else{

                        window.location.reload();

                    }
                });

            }else{

                error && error();

                alert(json.msg, 3000);

                $(submitBtn).text('重新提交').removeAttr("disabled");

            }

        }

    });

};
})(jQuery);

/**
 * iframe模态框
 */
(function($){
    $.fn.iframeModal = function(options){

        var defaults = {
            modalItem: '', //点击展示modal的元素
            iframeItem: '', //点击展示modal的元素
            submitBtn: '', //提交按钮
            clickBtn: '', //提交按钮
        };

        var config  = $.extend(defaults, options);

        var modalItem  = config.modalItem;
        var iframeItem = config.iframeItem;
        var submitBtn  = config.submitBtn;
        var clickBtn   = config.clickBtn;

        var frameSrc   = $(iframeItem).attr('src');

        var thisObj = $(this);

        var modalShow = function (event) {
            // 阻止事件冒泡
            event.stopPropagation();

            var id    = $(this).data('id');
            var title = $(this).data('title');
            var src   = frameSrc;

            if(id){

                src = frameSrc + "?id=" + id;

            }

            if(title){

                $(modalItem).find('.modal-title').text(title);

            }

            $(modalItem).find('iframe').attr('src', src);

            setTimeout(function () {
                $(modalItem).modal('show');
            }, 500);

        };

        if(clickBtn){
            $(document).on('click', clickBtn, modalShow);

        }else{
            thisObj.on('click', modalShow);
        }

        $(document).delegate(submitBtn, 'click',function(event){

            event.stopPropagation();

            $(iframeItem).contents().find("#js_submit").trigger('click');

        });


    };
})(jQuery);

/**
 * enter键提交
 */
(function($){
    $.fn.enterSubmit = function(callback){

    var callback = callback ? callback: '';
    var thisObj = $(this);

    $('body').bind('keypress',function(event){

        if(event.keyCode == "13") {

            callback && callback();

            thisObj.trigger('submit');

        }

    });

};
})(jQuery);