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
		<!-- import Vue.js -->
<script src="//vuejs.org/js/vue.min.js"></script>
<!-- import stylesheet -->
<link rel="stylesheet" href="//unpkg.com/iview/dist/styles/iview.css">
<!-- import iView -->
<script src="//unpkg.com/iview/dist/iview.min.js"></script>
		${head}
        <style type="text/css">
        	.margin-top{
        		margin-top: 60px;
        	}
        </style>
	</head>

	<body>
		<#include "header.ftl">
        <div class="container margin-top">
        	${body}
        </div>
		
	</body>

</html>