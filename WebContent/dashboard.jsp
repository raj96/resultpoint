<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.Connection,logic.OracleConnection,java.sql.PreparedStatement,java.sql.ResultSet,java.io.File"  %>
<%
	String email="",name="";
	PreparedStatement 	acad=null,
						cert=null,
						id=null,
						other=null;
	try{
		email = request.getSession().getAttribute("email").toString();
		name = request.getSession().getAttribute("name").toString();
		
		if(email==null || name==null || email.isEmpty() || name.isEmpty() ){
			response.setContentType("text/html");
			request.setAttribute("errormsg","Please Login first <a href="+request.getContextPath()+">Login</a>");
			request.getRequestDispatcher("error.jsp").forward(request,response);
		}
		
		Connection con = OracleConnection.getConnection();
		
		PreparedStatement pre = con.prepareStatement("SELECT email FROM USER_INFO2 WHERE email=?");
		pre.setString(1,email);
		
		ResultSet rs = pre.executeQuery();
		
		if(!rs.next())
			request.getRequestDispatcher("index2.jsp").forward(request,response);
		
		
		acad = con.prepareStatement("SELECT * FROM RESULT_INFO WHERE EMAIL=? AND (DOCTYPE='10' OR DOCTYPE='12' OR DOCTYPE='ug' OR DOCTYPE='pg')");
		acad.setString(1, email);
		
		cert = con.prepareStatement("SELECT * FROM RESULT_INFO WHERE EMAIL=? AND (DOCTYPE='tc' OR DOCTYPE='ntc' OR DOCTYPE='ecc')");
		cert.setString(1,email);
		
		id = con.prepareStatement("SELECT * FROM RESULT_INFO WHERE EMAIL=? AND (DOCTYPE='idp' OR DOCTYPE='dp' OR DOCTYPE='op')");
		id.setString(1,email);
		
		other = con.prepareStatement("SELECT * FROM RESULT_INFO WHERE EMAIL=? AND DOCTYPE='others'");
		other.setString(1,email);
	}
	catch(Exception e){
		e.printStackTrace();
		request.setAttribute("errormsg","Please <a href="+request.getContextPath()+">Login</a> first");
		request.getRequestDispatcher("error.jsp").forward(request,response);
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
<link rel="stylesheet" href="css/bootstrap.min.css" />
<title>Welcome, <%=name %></title>
</head>
<style>
	@media only screen (max-width: 480px) {
		.docprev {
			height:15vh;
			background-color:#1FF;
			margin:7px;
			margin-left:20px;
			margin-right:20px;
		}
		
		.navbar-nav {
			display:none;
		}
		
	}
	
	* {
		transition: all 0.5s;
	}
	
	.testwidth {
		border:1px solid blue;
	}
	a{
		text-decoration:none;
		cursor:pointer;
	}
	a:hover {
		text-decoration:none;
		cursor:pointer;
	}
	a:visited {
		color:#000;
	}
	.txtright {
		text-align:right;
	}
	.panel-red {
		background-color:#d9534f; !important
		color:#FFF; !important
	}
	h3{color:#FFF; !important}
	.panel-red-border {
		border:1px solid #d9534f;
	}
	.panel-orange {
		background-color:#ff9800; !important
	}
	.panel-orange-border {
		border:1px solid #ff9800; !important
	}
	.docprev {
		height:15vh;
		background-color:#FFF;
		margin:5px;
	}
	.panel-section {
		padding-bottom:10px;
		border-bottom:1px solid #d9534f;
	}
	.navbar-green {
		background-color: #212121; !important
		padding-bottom: 5px; !important
	}
	.navbar-green .navbar-header .navbar-brand {
		color:#DFE;
		font-size:3vw;
	}
	.usrtxt {
		color:#FFF;
		font-size:2vw;
		margin:2px;
	}
	.navbar-nav {
		display:inline-block;
	}
	
</style>
<body>
	<nav class="navbar navbar-green">
		<div class="container-fluid">
			<div class="navbar-header">
				<div class="navbar-brand">ResultPoint</div>
			</div>
			<ul class="nav navbar-nav pull-right">
					<li class="active usrtxt">Hi, <%=name %></li>
			</ul>
		</div>
	</nav>
	
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3><span class="glyphicon glyphicon-cloud-upload"></span>&nbsp;Upload Docs</h3>
					</div>
					<div class="panel-body">
						<div class="form">
							<div class="form-group">
								<a class="form-control btn-success" data-toggle="collapse" data-target="#academics">
									<span class="glyphicon glyphicon-chevron-right"></span>
									Academics
								</a>
							
								<div id="academics" class="collapse">
									<a class="form-control btn-warning txtright" onclick="setUpload('10');" data-toggle="modal" data-target="#ac10">Upload 10th Docs</a>
									<a class="form-control btn-warning txtright" onclick="setUpload('12');" data-toggle="modal" data-target="#ac10">Upload 12th/Diploma Docs</a>
									<a class="form-control btn-warning txtright" onclick="setUpload('ug');" data-toggle="modal" data-target="#ac10">Upload Under Graduate Docs</a>
									<a class="form-control btn-warning txtright" onclick="setUpload('pg');" data-toggle="modal" data-target="#ac10">Upload Post Graduate Docs</a>
								</div>
							</div>
							
							<div class="form-group">
								<a class="form-control btn-success" data-toggle="collapse" data-target="#certificates">
									<span class="glyphicon glyphicon-chevron-right"></span>
									Certificates
								</a>
							
								<div id="certificates" class="collapse">
									<a class="form-control btn-warning txtright" onclick="setUpload('tc');" data-toggle="modal" data-target="#ac10">Technincal Certificates</a>
									<a class="form-control btn-warning txtright" onclick="setUpload('ntc');" data-toggle="modal" data-target="#ac10">Non-Technical Certificates</a>
									<a class="form-control btn-warning txtright" onclick="setUpload('ecc');" data-toggle="modal" data-target="#ac10">Extra Curricular Certificates</a>
								</div>
							</div>
							
							<div class="form-group">
								<a class="form-control btn-success" data-toggle="collapse" data-target="#idproofs">
									<span class="glyphicon glyphicon-chevron-right"></span>
									I.D. Proofs
								</a>
							
								<div id="idproofs" class="collapse">
									<a class="form-control btn-warning txtright" onclick="setUpload('idp');" data-toggle="modal" data-target="#ac10">I.D. Proof</a>
									<a class="form-control btn-warning txtright" onclick="setUpload('dp');" data-toggle="modal" data-target="#ac10">Domicile Proof</a>
									<a class="form-control btn-warning txtright" onclick="setUpload('op');" data-toggle="modal" data-target="#ac10">Other Proof</a>
								</div>
							</div>
							
							<div class="form-group">
								<a class="form-control btn-success" data-toggle="collapse" data-target="#other">
									<span class="glyphicon glyphicon-chevron-right"></span>
									Other
								</a>
							
								<div id="other" class="collapse">
									<a class="form-control btn-warning txtright" onclick="setUpload('others');" data-toggle="modal" data-target="#ac10">Upload(5 remaining)</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-6">
				<div class="panel panel-red-border">
					<div class="panel-heading panel-red">
						<h3><span class="glyphicon glyphicon-folder-open"></span>&nbsp;Your Documents</h3>
					</div>
					<div class="panel-body container-fluid">
						
						<div class="panel-section">
							<div class="row">
								<h4>&nbsp;&nbsp;<span class="glyphicon glyphicon-tag"></span>&nbsp;Academics</h4>
							</div>
							<div class="row">
								<div class="col-sm-1"></div>
								<div class="col-sm-10 form">
									<div class="row form-group">
										<%
											try{
												//<button class="btn btn-default form-control">Test</button>
												ResultSet rs = acad.executeQuery();
												rs.next();
												System.out.println("OK");
												do{
													out.print("<a class='btn btn-default form-control' href='http://localhost"+ File.separator+rs.getString(3)+"' >"+rs.getString(4)+"</a>");
													
												}while(rs.next());
												
											}
											catch(Exception e){
												out.print("<h5>Upload some documents from the panel to your left.</h5>");
												System.out.println("Exception: ACAD");
												e.printStackTrace();
											}
										%>
										
									</div>
								</div>
								<div class="col-sm-1"></div>
							</div>
						</div>
						
						<div class="panel-section">
							<div class="row">
								<h4>&nbsp;&nbsp;<span class="glyphicon glyphicon-tag"></span>&nbsp;Certificates</h4>
							</div>
							<div class="row">
								<div class="col-sm-1"></div>
								<div class="col-sm-10 form">
									<div class="row form-group">
										<%
											try{
												//<button class="btn btn-default form-control">Test</button>
												ResultSet rs = cert.executeQuery();
												rs.next();
												System.out.println("OK");
												do{
													out.print("<a class='btn btn-default form-control' href='http://localhost"+ File.separator+rs.getString(3)+"' >"+rs.getString(4)+"</a>");
													
												}while(rs.next());
												
											}
											catch(Exception e){
												out.print("<h5>Upload some documents from the panel to your left.</h5>");
												System.out.println("Exception: CERT");
												e.printStackTrace();
											}
										%>
										
									</div>
								</div>
								<div class="col-sm-1"></div>
							</div>
						</div>
						
						<div class="panel-section">
							<div class="row">
								<h4>&nbsp;&nbsp;<span class="glyphicon glyphicon-tag"></span>&nbsp;I.D. Proofs</h4>
							</div>
							<div class="row">
								<div class="col-sm-1"></div>
								<div class="col-sm-10 form">
									<div class="row form-group">
										<%
											try{
												//<button class="btn btn-default form-control">Test</button>
												ResultSet rs = id.executeQuery();
												rs.next();
												System.out.println("OK");
												do{
													out.print("<a class='btn btn-default form-control' href='http://localhost"+ File.separator+rs.getString(3)+"' >"+rs.getString(4)+"</a>");
													
												}while(rs.next());
												
											}
											catch(Exception e){
												out.print("<h5>Upload some documents from the panel to your left.</h5>");
												System.out.println("Exception: ID");
												e.printStackTrace();
											}
										%>
										
									</div>
								</div>
								<div class="col-sm-1"></div>
							</div>
						</div>
						
						<div class="panel-section">
							<div class="row">
								<h4>&nbsp;&nbsp;<span class="glyphicon glyphicon-tag"></span>&nbsp;Others</h4>
							</div>
							<div class="row">
								<div class="col-sm-1"></div>
								<div class="col-sm-10 form">
									<div class="row form-group">
										<%
											try{
												//<button class="btn btn-default form-control">Test</button>
												ResultSet rs = other.executeQuery();
												rs.next();
												System.out.println("OK");
												do{
													out.print("<a class='btn btn-default form-control' href='http://localhost"+ File.separator+rs.getString(3)+"' >"+rs.getString(4)+"</a>");
													
												}while(rs.next());
												
											}
											catch(Exception e){
												out.print("<h5>Upload some documents from the panel to your left.</h5>");
												System.out.println("Exception: OTHER");
												e.printStackTrace();
											}
										%>
										
									</div>
								</div>
								<div class="col-sm-1"></div>
							</div>
						</div>
						
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="panel panel-orange-border">
					<div class="panel-heading panel-orange">
						<h3><span class="glyphicon glyphicon-cog"></span>&nbsp;Account Settings</h3>
					</div>
					<div class="panel-body">
						<div class="form">
							<div class="form-group">
								<%--<button class="form-control btn btn-info btn-md">Correct Details(2 remaining)</button>--%>
								<button class="form-control btn btn-info btn-md" data-toggle="modal" data-target="#cpass">Change Password</button>
								<form action="<%=request.getContextPath()%>/action?actionid=6" method="POST">
									<button type="submit" class="form-control btn btn-danger btn-md">Logout</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="cpass" class="modal fade">
		<div class="modal-body container-fluid">
			<div class="row"></div>
			<div class="row">
				<div class="col-sm-4"></div>
				<div class="col-sm-4">
					<div class="panel panel-primary">
						<div class="panel-heading">
							<h3>Change Password</h3>
						</div>
						<div class="panel-body">
							<form class="form" id="change_password" action="<%=request.getContextPath() %>/action?actionid=9" method="POST">
							<div class="form-group">
								<h4>Enter Current Password:</h4>
								<input class="form-control" type="password" name="old_password" />
							</div>
							<div class="form-group">
								<h4>Enter New Password:</h4>
								<input class="form-control" id="npassword" type="password" name="npassword" />
							</div>
							<div class="form-group">
								<h4>Re-enter New Password:</h4>
								<input class="form-control" type="password" name="rnpassword" />
							</div>
							<div class="form-group">
								<input class="btn btn-warning" type="submit" value="Change Password" />
								<input class="btn btn-danger pull-right" data-dismiss="modal" value="Cancel" />
							</div>
							</form>
						</div>
					</div>
				</div>
				<div class="col-sm-4"></div>
			</div>
		</div>
	</div>
	<div id="ac10" class="modal fade">
		<div class="modal-body container-fluid">
			<div class="row"></div>
			<div class="row">
				<div class="col-sm-4"></div>
				<div class="col-sm-4">
					<div class="panel panel-primary">
						<div class="panel-heading">
							<h3>Upload</h3>
						</div>
						<div class="panel-body">
							<form class="form" id="uploadForm" action="<%=request.getContextPath() %>/action?actionid=8" method="POST" enctype="multipart/form-data">
							<div class="form-group">	
								<input class="btn btn-default" type="file" name="file" />
							</div>
							<div class="form-group">
								<h5>Enter Caption:</h5>
								<input class="form-control" type="text" name="caption" />
							</div>
							<div class="form-group">
								<input class="btn btn-warning" type="submit" value="Upload" />
								<input class="btn btn-danger pull-right" data-dismiss="modal" value="Cancel" />
							</div>
							</form>
						</div>
					</div>
				</div>
				<div class="col-sm-4"></div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/jquery.validate.min.js"></script>
	<script>
		$(document).ready(function(){
		    $('[data-toggle="tooltip"]').tooltip();
		});
		
		$("#change_password").validate({
			rules: {
				old_password: {
					required: true,
					minlength:8
				},
				npassword: {
					required: true,
					minlength: 8
				},
				rnpassword: {
					equalTo: "#npassword"
				}
			}
		});
		
		function setUpload(uid) {
			var ajax = new XMLHttpRequest();
			ajax.open("GET","http://localhost:8081<%=request.getContextPath()%>/action?actionid=7&uploadid="+uid,true);
			ajax.send();
		}
	</script>
</body>
</html>