(function($) {

	$.fn.UITree = function(options) {
		var opt = $.extend({
			list: [],
			labelField: "name",
			parentField: "parentId",
			parentValue: 0
		}, options);

		function comboTree(list, labelField, parentField, parentValue) {
			var tree = [];
			$.each(list, function(i, item) {
				if(item[parentField] == parentValue) {
					item.title = item[labelField];
					var childs=comboTree(list, labelField, parentField, item.Id);
					if(childs.length>0)item.childs = childs;
					
					tree.push(item);
				}
			});
			return tree;
		}

		opt.trees = comboTree(opt.list, opt.labelField, opt.parentField, opt.parentValue);
		var tree = $(this).Tree(opt);
		return tree;
	}

})(jQuery)