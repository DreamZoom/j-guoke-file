<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<title>项目管理</title>
		<style type="text/css">
			.tools{
				padding: 10px 0px;
			}
		</style>
	</head>

	<body>
		<div id="app">
			<div class="tools">
				<button-group>
					<i-button type="ghost" @click="create">创建</i-button>
					<i-button type="ghost" @click="onBatchDelete">删除</i-button>
					<i-button type="ghost" @click="requestList()">刷新</i-button>
				</button-group>
			</div>

			<i-table  border :columns="columns" :data="list" @on-selection-change="onSelectionChange"></i-table>
			<div>
				<br />
				<Page :current="page" :page-size="pagesize" :total="total" show-sizer show-total @on-change="onPageChange"></Page>
			</div>
			
			<Modal v-model="visible" title="编辑" @on-ok="onSave">
				<i-form :model="model" :label-width="80">
			        <#list  metadata  as  item> 
                       <#if item.requireMode("edit")>
                       		<form-item label="${item.display}">
                       			<@editor.edit metadata=item />						       
					        </form-item>
                       </#if>
                    </#list>
				</i-form>
			</Modal>

		</div>
		<script type="application/javascript">
			var CURRENT_PAGE_PATH = "${root.contextPath}/${controller}";
			var app = new Vue({
				el: '#app',
				data: {
					page: 1,
					pagesize: 20,
					total: 100,
					columns: [ 
					    {
	                        type: 'selection',
	                        width: 60,
	                        align: 'center'
	                    },
					    <#list metadata as item>
						<#if item.requireMode("list")> 
						{
							title: '${item.display}',
							key: '${item.name}'
						}, 
						</#if> 
						</#list> 
	                    {
	                        title: '操作',
	                        key: 'action',
	                        width: 150,
	                        align: 'center',
	                        render: (h, params)=>{
	                            return h('div', [
	                                h('Button', {
	                                    props: {
	                                        type: 'primary',
	                                        size: 'small'
	                                    },
	                                    style: {
	                                        marginRight: '5px'
	                                    },
	                                    on: {
	                                        click: () => {
	                                            app.edit(params);
	                                        }
	                                    }
	                                }, '编辑'),
	                                h('Button', {
	                                    props: {
	                                        type: 'error',
	                                        size: 'small'
	                                    },
	                                    on: {
	                                        click: () => {
	                                            app.remove(params)
	                                        }
	                                    }
	                                }, '删除')
	                            ]);
	                        }
	                    }
					],
					list: [],
					visible:false,
					model:{},
					selections:[]
				},
				mounted: function() {
					this.requestList();
					this.$Message.config({
					    top: 60,
					    duration: 3
					});
				},
				methods: {
					requestList: function() {
						var context = this;
						$.ajax({
							type: "get",
							url: CURRENT_PAGE_PATH + "/List",
							data: {
								page: context.page,
								limit:context.pagesize
							},
							success: function(response) {
								context.list = response.data;
								context.total=response.count; 
								console.log(response);
							}

						});
					},
					apiRequest:function(api, data, successfun, errorfun){
						var context = this;
						$.ajax({
							type: "post",
							url: CURRENT_PAGE_PATH + api,
							data: data,
							success: function(response) {
								if(successfun) successfun(response);
								if(response.result){
									context.$Message.success(response.message);
									context.requestList();
								}
								else{
									context.$Message.error(response.message);
								}
							}
						});
					},
					onPageChange: function(page) {
						this.page = page;
					},
					onPageSizeChange: function(pagesize) {
						this.pagesize = pagesize;
					},
					onSelectionChange:function(selection){
						this.selections=selection;
						console.log(selection);
					},
					create:function(){
						this.visible=true;
						this.model={};
					},
					edit:function(params){
						this.visible=true;
						this.model=params.row;
					},
					remove:function(params){
						var context = this;
						var id = params.row.Id;
						this.$Modal.confirm({
							title:"警告",
							content:"确定要删除么?",
							onOk:function(){
								context.apiRequest("/Delete", { id: id });
							}
						});
					},
					onSave:function(){
						var context = this;
						var data=$.extend(true,{Id:0,remark:""},context.model)
						var action = data.Id==0?"/Create":"/Update";
						this.apiRequest(action,data,function(){

						});
					},
					onBatchDelete:function(){
						var context = this;
						var keys=[];
						$.each(this.selections, function(i,item) {    
							keys.push(item['Id']);                                                    
						});
						if(keys.length==0){
							context.$Message.error("请选择你想删除的数据!");
							return;
						};
						this.$Modal.confirm({
							title:"警告",
							content:"确定要删除么?",
							onOk:function(){
								context.apiRequest("/BatchDelete", { keys: keys.join(',') });
							}
						});
					}
				}
			})
		</script>
	</body>

</html>