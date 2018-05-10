<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<title>项目管理</title>
		<script type="text/javascript">
			mxBasePath = '${root.contextPath}/static/mxgraph/src';
		</script>
		<script src="${root.contextPath}/static/mxgraph/src/js/mxClient.js" type="text/javascript" charset="utf-8"></script>
		<style type="text/css">
			#graph {
				height: 700px;
				border: solid 1px #EEEEEE;
				background: url(${root.contextPath}/static/mxgraph/grid.gif);
			}
			
			#toolbar hr {
				margin: 0;
			}
		</style>

		<script type="text/javascript">
			$(function() {
				// Checks if the browser is supported
				if(!mxClient.isBrowserSupported()) {
					// Displays an error message if the browser is not supported.
					mxUtils.error('Browser is not supported!', 200, false);
				}
				mxGraphHandler.prototype.guidesEnabled = true;

				var config = mxUtils.load('${root.contextPath}/static/mxgraph/templates/model-editor.xml').getDocumentElement();
				var editor = new mxEditor(config);
				editor.urlPost = "${root.contextPath}/Model/SaveModel?id=$request.getParameter('Id')";
				mxEvent.addMouseWheelListener(function(evt, up) {
					if(!mxEvent.isConsumed(evt)) {
						if(up) {
							editor.execute('zoomIn');
						} else {
							editor.execute('zoomOut');
						}

						mxEvent.consume(evt);
					}
				});
				try {
					var doc = mxUtils.parseXml('${model.body}');
					var codec = new mxCodec(doc);
					codec.decode(doc.documentElement, editor.graph.getModel());
				} catch(e) {
					//TODO handle the exception
				}

				$("#toolbar").find("hr").replaceWith('<span> | </span>');
			});
		</script>
	</head>

	<body>
		<div id="toolbar">

		</div>
		<div id="graph">

		</div>
		<div id="status">

		</div>
	</body>

</html>