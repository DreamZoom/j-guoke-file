<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<title>项目管理</title>
		<script type="text/javascript">
			$(function() {

				var CURRENT_PAGE_PATH = "${root.contextPath}/${controller}";

				function editModalTemplate(initForm, okFunc) {
					var template = $("#edit-template").html();
					var modal = $(template).appendTo(document.body).modal("show");
					if(initForm) $(modal).find("form").loadForm(initForm);
					modal.on("click", "#btn-save", function() {
						var form = $(modal).find("form").serializeForm();
						if(okFunc) okFunc(form, modal);
					}).on("hidden.bs.modal", function() {
						modal.remove();
					});
				}

				function apiRequest(api, data, successfun, errorfun) {
					$.ajax({
						type: "post",
						url: CURRENT_PAGE_PATH + api,
						data: data,
						success: function(response) {
							if(successfun) successfun(response);
							if(response.result || response.code == 0) {
								$.Toast().success(response.message);
							} else {
								$.Toast().error(response.message);
							}

						}
					});
				}

				apiRequest("/List", {
					page: 1,
					limit: 10000,
					projectId:"${RequestParameters.projectId!}"
				}, function(response) {

					var list = response.data;
					var tree = $("#table").UITree({
						list: list,
						labelField: "name",
						showLine: true,
						defaultExpandAll: true,
						onSelect: function(selectedKeys, e) {
							if(e.selected) {
								$("#table").data("selected", e.node.props.Id);
								$("#table").data("selectedData", e.node.props);
							} else {
								$("#table").data("selected", 0);
								$("#table").data("selectedData", null);
							}

						}
					});
				});

				$(document).on("click", "[data-command]", function() {
					var command = $(this).data("command");
					var context = this;
					switch(command) {
						case "create":
							(function() {
								editModalTemplate({
									parentId: $("#table").data("selected") || 0
								}, function(form, modal) {

									apiRequest("/Create", form, function() {
										window.location.reload();
										modal.modal("hide");
									});
								});
							})();

							break;
						case "update":
							(function() {
								var id = $("#table").data("selected") || 0
								var row = $("#table").data("selectedData");
								editModalTemplate(row, function(form, modal) {
									apiRequest("/Update", form, function() {
										window.location.reload();
										modal.modal("hide");
									});
								});
							})();
							break;
						case "delete":
							(function() {
								var id = $("#table").data("selected");
								if(!id) {
									$.Message().confirm({
										title: "警告",
										content: "请选择数据",
										onOk: function() {}
									});
									return;
								}
								$.Message().confirm({
									title: "警告",
									content: "确定要删除么?",
									onOk: function() {
										apiRequest("/Delete", {
											id: id
										}, function() {
											window.location.reload();
										});
									}
								});
							})();
							break;

						case "reload":
							(function() {
								window.location.reload();
							})();
							break;
					}
				});

				$("#fmenu").Menu({
					current: "http://www.baidu.com",
					mode:"horizontal",
					onClick: function(item) {
						console.log(item);
					},
					menus: [{
						"text": "活动图",
						"url": "http://www.baidu.com"
					}, {
						"text": "数据流图",
						"url": "http://www.baidu.com2"
					}]
				});

			});
		</script>
	</head>

	<body>
		<div class="row">
			<div class="col-md-4">
				<div class="actions">
					<div class="btn-group" role="group">
						<button type="button" class="btn btn-default" data-command="create">创建</button>
						<button type="button" class="btn btn-default" data-command="update">编辑</button>
						<button type="button" class="btn btn-default" data-command="delete">删除</button>
						<button type="button" class="btn btn-default" data-command="reload">刷新</button>
					</div>
				</div>
			</div>
			<div class="col-md-4">

			</div>
			<div class="col-md-4">

			</div>
		</div>

		<div class="row">
			<div class="col-md-4">
				<div id="table"></div>
			</div>
			<div class="col-md-8">
				<div id="fmenu"></div>
			</div>
		</div>

		<script type="text/template" id="edit-template">
			<div class="modal fade" tabindex="-1" role="dialog" id="edit-modal">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							<h4 class="modal-title">编辑</h4>
						</div>
						<div class="modal-body">

							<form id="model-form">
								<input type="hidden" name="Id" value="0" />
								<input type="hidden" name="remark" value="" />
								<input type="hidden" name="parentId" value="0" />
								<#list metadata as item>
									<#if item.requireMode( "edit")>
										<div class="form-group">
											<label for="projectName">${item.display}</label>
											<@editor.edit metadata=item />
										</div>
									</#if>
								</#list>

							</form>

						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
							<button type="button" class="btn btn-primary" id="btn-save">保存</button>
						</div>
					</div>
				</div>
			</div>
		</script>

	</body>

</html>