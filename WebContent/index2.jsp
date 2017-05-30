<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	String email="",name="";
	try {
		email = request.getSession().getAttribute("email").toString();
		name = request.getSession().getAttribute("name").toString();
		if(email.isEmpty()){
			request.setAttribute("errormsg","Unauthorized Access");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}
	catch(Exception e){
		e.printStackTrace();
		request.setAttribute("errormsg","Unknown Error");
		request.getRequestDispatcher("error.jsp").forward(request, response);
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/bootstrap.min.css" />
<title>Welcome, <%=name %>
</title>
</head>
<body>
	<nav class="navbar navbar-green">
		<div class="container-fluid">
			<div class="navbar-header">
				<div class="navbar-brand">Results & Qualification Submission</div>
			</div>
			<ul class="nav navbar-nav pull-right">
					<li class="active usrtxt">Hi, <%=name %></li>
			</ul>
		</div>
	</nav>
	
	<div class="ccontainer-fluid">
		<div class="row">
			<div class="col-sm-2"></div>
			<div class="col-sm-8">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3>Primary Info</h3>
					</div>
					<div class="panel-body">
						<form class="form" action="<%=request.getContextPath() %>/action?actionid=3" method="POST">
							<input class="hidden" name="name" value="<%=name %>>">
							<div class="form-group">
								<h5>Your E-mail ID: 
									<input class="btn btn-success" name="email" readonly value = "<%=email%>"/>
									<a class="btn btn-warning" href="<%=request.getContextPath() %>/action?actionid=6">Logout</a>
								</h5>
							</div>
							<div class="form-group">
								<h4>Father's Name:</h4>
								<input class="form-control" type="text" name="fathers_name"></input>
							</div>
							<div class="form-group">
								<h4>Mother's Name:</h4>
								<input class="form-control" type="text" name="mothers_name"></input>
							</div>
							<div class="form-group">
								<h4>Father's Occupation:</h4>
								<input class="form-control" type="text" name="fathers_occ"></input>
							</div>
							<div class="form-group">
								<h4>Mother's Occupation:</h4>
								<input class="form-control" type="text" name="mothers_occ"></input>
							</div>
							<div class="form-group">
								<h4>Current Address:</h4>
								<textarea class="form-control" name="curr_addr"></textarea>
							</div>
							<div class="form-group">
								<h4>Permanent Address:</h4>
								<textarea class="form-control" name="perm_addr"></textarea>
							</div>
							<div class="form-group">
								<h4>Mobile No.</h4>
								<input class="form-control" type="text" name="mobile_no"></input>
							</div>
							<div class="form-group">
								<h4>Guardian's Name</h4>
								<input class="form-control" type="text" name="guardians_name"></input>
							</div>
							<div class="form-group">
								<h4>Parent's/Guardian's Mobile No.</h4>
								<input class="form-control" type="text" name="pmobile_no"></input>
							</div>
							
							<button class="form-control btn btn-success" type="submit">Submit</button>
						</form>
					</div>
				</div>
			</div>
			<div class="col-sm-2"></div>
		</div>
	</div>
	
</body>
</html>