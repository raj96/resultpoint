<!DOCTYPE html>
<html>
<%
	String email="";
	try{
		Object oemail = request.getSession().getAttribute("email");
		email = (oemail==null)?"":oemail.toString();
		Object oname = request.getSession().getAttribute("name");
		if(oemail!=null && oname!=null) {
			request.getSession().setAttribute("email",email);
			request.getSession().setAttribute("name",oname.toString());
			request.getRequestDispatcher("dashboard.jsp").forward(request,response);
		}
	}
	catch(Exception e){}
%>
<head>
<meta charset="UTF-8">
<title>ResultPoint</title>
<link rel="stylesheet" href="css/bootstrap.min.css" />
<link rel="stylesheet" href="css/bootstrap.css" />
<link rel="stylesheet" href="css/mystyle.css" />
</head>
<style>
	.bg{
		background: url('background.jpg') no-repeat center center fixed;
		background-size: cover;
	}
</style>
<body class="bg">
	<nav class="navbar navbar-fixed navbar-custom">
		<div class="container-fluid">
			<div class="row"></div>
			<div class="row">
				<div class="col-sm-5">
					<div class="navbar-header">
						<div class="navbar-brand">ResultPoint</div>
					</div>
				</div>
				<div class="col-sm-7">
					<div class="navbar-header margintop">
						<form class="form-inline" action="<%=request.getContextPath()%>/action?actionid=2" method="POST" id="loginform">
							<div class="form-group">
								<label for="email">Email address:</label>
						    	<input id="email" name="email" value="<%=email%>" class="form-control">
							</div>
							<div class="form-group">
								<label for="pwd">Password:</label>
								<input id="pwd" type="password" name="password" class="form-control" >
							</div>
							<div class="form-group">
								<button type="submit" class=" form-control btn btn-success">Login</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<div class="col-sm-5"></div>
			<div class="col-sm-2"></div>
			<div class="col-sm-5">
				<form id="reg_form" action="<%=request.getContextPath()%>/action?actionid=1" method="POST" class="panel panel-primary">
					<div class="panel-heading below-border">
						<h2>Register</h2>
					</div>
					<div class="panel-body">
						<div class="form-group">
							<h4>Name:</h4>
							<input type="text" name="name" class="form-control" />
						</div>
						<div class="form-group">
							<h4>Email:</h4> <input type="text" name="email" class="form-control" />
						</div>
						<div class="form-group">
							<h4>Password:</h4> <input type="password" id="password" name="password" class="form-control" />
						</div>
						<div class="form-group">
							<h4>Re-enter Password:</h4>
							<input type="password" name="repassword" class="form-control" />
						</div>
						<div class="form-group">
							<h4>Gender:</h4> <select name="gender" class="form-control">
								<option value="male" class="form-control">Male</option>
								<option value="female" class="form-control">Female</option>
							</select>
						</div>
						<div class="form-group">
							<h4>Birth Date:</h4>
							<input placeholder="dd/mm/yyyy" type="text" name="birth_date" class="form-control" />
						</div>
						<div class="form-group">
							<h4>College Name:</h4>
							<select name="college_name" class="form-control">
								<option value="sit" class="form-control">Siliguri Institute of Technology</option>
							</select>
						</div>
						<div class="form-group">
							<h4>Degree Name:</h4>
							<select name="degree_name" class="form-control">
								<option value="btech" class="form-control">B.Tech.</option>
								<option value="btech" class="form-control">B.C.A.</option>
								<option value="btech" class="form-control">M.Tech.</option>
								<option value="btech" class="form-control">M.C.A.</option>
							</select>
						</div>
						<div class="form-group">
							<h4>Department Name:</h4>
							<select name="dept_name" class="form-control">
								<option value="cse" class="form-control">Computer Science & Engineering</option>
								<option value="ece" class="form-control">Electronics & Engineering</option>
							</select>
						</div>
						<div class="form-group">
							<h4>Semester:</h4>
							<input name="semester" type="number" min=1 max=8 class="form-control" />
						</div>
						<div  class="form-group">
							<h4>Roll No. :</h4>
							<input name="rollno" type="text" class="form-control" />
						</div>
					</div>
					<div class="panel-footer above-border">
						<div class="form-group">
							<button class="form-control btn-primary	" type="submit">Register</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script src="js/jquery.min.js"></script>
	<script src="js/jquery.validate.min.js"></script>
	<script>
		$("#loginform").validate({
			rules: {
				email: {
					required: true,
					email: true
				},
				password: {
					required: true,
					minlength: 8
				}				
			}
		});
		$("#reg_form").validate({
			rules: {
				name: {
					required: true,
					minlength: 3
				},
				email: {
					required: true,
					email: true
				},
				password: {
					required: true,
					minlength: 8
				},
				repassword: {
					required:true,
					equalTo: "#password"
				},
				birth_date: {
					required: true,
					date: true
				},
				semester: {
					required: true,
					maxlength: 1,
					digits: true
				},
				roll_no: {
					required: true
				}
			}
		});
	</script>
</body>
</html>