<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="css/bootstrap.min.css"></link>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Success</title>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-6">
				<div class="panel panel-success">
					<div class="panel-heading">
						<h3>Success</h3>
					</div>
					<div class="panel-body">
						<h4>
							<%
								try {
									String msg = request.getAttribute("successmsg").toString();
									msg = msg.equals(null)?"No success for you":msg;
									out.print(msg);
								}
								catch(Exception e) {
									out.print("No success for you");
									e.printStackTrace();
								}
							%>
						</h4>
					</div>
				</div>
			</div>
			<div class="col-sm-3"></div>
		</div>
	</div>
</body>
</html>