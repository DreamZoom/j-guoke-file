<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<title>
			${title}
		</title>

		<link href="${root.contextPath}/static/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css" />
		<link href="${root.contextPath}/static/antd/antd.css" rel="stylesheet" type="text/css" />

		<script src="${root.contextPath}/static/jquery-2.1.0.js" type="text/javascript" charset="utf-8"></script>
		<script src="${root.contextPath}/static/form.js" type="text/javascript" charset="utf-8"></script>
		<script src="${root.contextPath}/static/bootstrap/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="${root.contextPath}/static/antd/common.js" type="text/javascript" charset="utf-8"></script>
		<script src="${root.contextPath}/static/antd/antd.js" type="text/javascript" charset="utf-8"></script>
		<script src="${root.contextPath}/static/ui-components.js" type="text/javascript" charset="utf-8"></script>
		${head}
		<style type="text/css">
			.margin-top {
				margin-top: 60px;
			}
			
			.padding {
				padding: 10px;
			}
		</style>
		
        <#assign projectId = RequestParameters.projectId! /><br>
		<script type="text/javascript">
			$(function() {
				var mode = $("#project_menu").parent().parent().width() - $("#project_menu").parent().width() < 100 ? "horizontal" : "inline";
				var menu = $("#project_menu").Menu({
					current: "${root.contextPath}/${controller}/",
					mode: mode,
					onClick: function(item) {
						if(item.url) {
							window.location.href = item.url + "Index?projectId=${projectId!}";
						}
					},
					menus: [{
						"text": "需求列表",
						"url": "${root.contextPath}/Requirement/"
					}, {
						"text": "词汇表",
						"url": "${root.contextPath}/Word/"
					}, {
						"text": "领域模型",
						"url": "${root.contextPath}/Model/"
					}, {
						"text": "功能树",
						"url": "${root.contextPath}/Feature/"
					}]
				});
				$(window).resize(function() {
					var mode = $("#project_menu").parent().parent().width() - $("#project_menu").parent().width() < 100 ? "horizontal" : "inline";
					menu.reload({
						mode: mode
					});
				})

			})
		</script>
	</head>

	<body>
		<#include "header.ftl" />
		<div class="container margin-top">
			<div class="row">
				<div class="col-md-2 padding">
					<div id="project_menu"></div>
				</div>
				<div class="col-md-10 padding">
					${body}
				</div>
			</div>
		</div>

	</body>

</html>