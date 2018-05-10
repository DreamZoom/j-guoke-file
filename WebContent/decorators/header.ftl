<!DOCTYPE html>
<html>

	<head>

	</head>

	<body>
		<nav class="navbar navbar-inverse navbar-fixed-top">
			<div class="container">
				<!-- Brand and toggle get grouped for better mobile display -->
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
				        <span class="sr-only">Toggle navigation</span>
				        <span class="icon-bar"></span>
				        <span class="icon-bar"></span>
				        <span class="icon-bar"></span>
				    </button>
					<a class="navbar-brand" href="#"><span class="glyphicon glyphicon-link"></span> PM Tool</a>
				</div>

				<!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav">
						<li class="active">
							<a href="${root.contextPath}/Project/Index">项目管理</a>
						</li>
						<li>
							<a href="${root.contextPath}/Bug/Index">bug管理</a>
						</li>
						
					</ul>

					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">${account!} <span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li>
									<a href="#">我的消息</a>
								</li>
								<li>
									<a href="#">修改密码</a>
								</li>
								<li role="separator" class="divider"></li>
								<li>
									<a href="#">注销</a>
								</li>
							</ul>
						</li>
					</ul>
				</div>
				<!-- /.navbar-collapse -->
			</div>
			<!-- /.container-fluid -->
		</nav>

	</body>

</html>