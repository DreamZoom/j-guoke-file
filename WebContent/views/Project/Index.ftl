<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<title>项目管理</title>
		<script type="text/javascript">
			$(function() {
				
				var CURRENT_PAGE_PATH = "${root.contextPath}/${controller}";
				
			

				var table = $("#table").Table({
					columns: [
						<#list  metadata  as  item> 
                           <#if item.requireMode("list")>
                                {
									title: '${item.display}',
									dataIndex: '${item.name}'
								},
                           </#if>
                        </#list>
					    {
						title: '操作',
						render: function(item, record) {
							var actions = [];
							actions.push('<a data-command="update" data-id="' + record.Id + '" class="label label-primary">编辑</a>');
							actions.push('<a data-command="link" data-id="' + record.Id + '" data-link="/Requirement" class="label label-primary">需求管理</a>');
							actions.push('<a data-command="link" data-id="' + record.Id + '" data-link="/Word" class="label label-primary">词汇表</a>');
							actions.push('<a data-command="link" data-id="' + record.Id + '" data-link="/Model" class="label label-primary">模型管理</a>');
							actions.push('<a data-command="link" data-id="' + record.Id + '" data-link="/Feature" class="label label-primary">功能管理</a>');
							actions.push('<a data-command="delete" data-id="' + record.Id + '" class="label label-danger">删除</a>');
							return $.toStaticHTML(actions.join(' '));
						}
					}],
					url: CURRENT_PAGE_PATH + "/List",
					pageSize: 15,
					keyField: "Id",
					rowSelection: {
						onChange: function(selectedRowKeys, selectedRows) {
							console.log(selectedRows);
						}
					}
				});

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
							if(response.result){
								$.Toast().success(response.message);
							}
							else{
								$.Toast().error(response.message);
							}
							table.reload();
						}
					});
				}
				$(document).on("click", "[data-command]", function() {
					var command = $(this).data("command");
					var context = this;
					switch(command) {
						case "create":
							(function() {
								editModalTemplate(null, function(form, modal) {
									apiRequest("/Create", form, function() {
										modal.modal("hide");
									});
								});
							})();

							break;
						case "update":
							(function() {
								var id = $(context).data("id");
								var row = table.getRow(id);
								editModalTemplate(row, function(form, modal) {
									apiRequest("/Update", form, function() {
										modal.modal("hide");
									});
								});
							})();
							break;
						case "link":
							(function() {
								var id = $(context).data("id");
								var link = $(context).data("link");
								window.location.href="${root.contextPath}/"+link+"/Index?projectId="+id;								
							})();
							break;
						case "delete":
							(function() {
								var id = $(context).data("id");
								$.Message().confirm({
									title:"警告",
									content:"确定要删除么?",
									onOk:function(){
										apiRequest("/Delete", { id: id });
									}
								});
							})();
							break;
						case "batch-delete":
							(function() {
								var rows = table.getSelecteds();
								var keys=[];
								$.each(rows, function(i,item) {    
									keys.push(item['Id']);                                                    
								});
								if(keys.length==0){
									alert("请选择你想删除的数据!");
									return;
								}
								$.Message().confirm({
									title:"警告",
									content:"确定要删除么?",
									onOk:function(){
										apiRequest("/BatchDelete", { keys: keys.join(',') });
									}
								});
								
								console.log(keys);
							})();
							break;
						case "reload":
							(function() {
								table.reload();
							})();
							break;
					}
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
						<button type="button" class="btn btn-default" data-command="batch-delete">批量删除</button>
						<button type="button" class="btn btn-default" data-command="reload">刷新</button>
					</div>
				</div>
			</div>
			<div class="col-md-4">

			</div>
			<div class="col-md-4">

			</div>
		</div>
		<div id="table">

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
								<#list  metadata  as  item> 
		                           <#if item.requireMode("edit")>
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