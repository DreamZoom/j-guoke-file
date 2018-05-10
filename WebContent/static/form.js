(function($) {

	$.fn.extend({
        //表单加载json对象数据
        loadForm: function (jsonValue) {
            var obj = this;
            $.each(jsonValue, function (name, ival) {
                var $oinput = obj.find("input[name=" + name + "]");
                if ($oinput.attr("type") == "checkbox") {
                    if (ival !== null) {
                        var checkboxObj = $("[name=" + name + "]");
                        var checkArray = ival.split(";");
                        for (var i = 0; i < checkboxObj.length; i++) {
                            for (var j = 0; j < checkArray.length; j++) {
                                if (checkboxObj[i].value == checkArray[j]) {
                                    checkboxObj[i].click();
                                }
                            }
                        }
                    }
                }
                else if ($oinput.attr("type") == "radio") {
                    $oinput.each(function () {
                        var radioObj = $("[name=" + name + "]");
                        for (var i = 0; i < radioObj.length; i++) {
                            if (radioObj[i].value == ival) {
                                radioObj[i].click();
                            }
                        }
                    });
                }
                else if ($oinput.attr("type") == "textarea") {
                    obj.find("[name=" + name + "]").html(ival);
                }
                else {
                    obj.find("[name=" + name + "]").val(ival);
                }
            });
        },
        clearForm:function(){
        	return $(this).each(function(i,item){
        		$(item).find('input,textarea')
					.not('button, submit, reset')
					.val('')
					.removeAttr('checked')
					.removeAttr('selected');
        	});
        },
        resetForm:function(defaultValue){
        	$(this).clearForm().loadForm(defaultValue);
        },
        serializeForm:function(){
        	var list = $(this).serializeArray();
        	var form={};
        	$.each(list, function(i,item) {    
        		form[item.name]=item.value;                                                    
        	});
        	return form;
        },
        initEditor:function(){
        	$(this).find("[editor]").each(function(i,e){
        		var editor=$(this).attr("editor");
        	});
        }
    });

})(jQuery)