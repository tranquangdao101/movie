<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class="body-full-height">
<head>
<!-- META SECTION -->
<title>Movie Pro Admin</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1" />

<link rel="icon" href="favicon.ico" type="image/x-icon" />
<!-- END META SECTION -->

<!-- CSS INCLUDE -->
<link rel="stylesheet" type="text/css" id="theme"
	href="<%=request.getContextPath()%>/admin/css/theme-default.css" />
<!-- EOF CSS INCLUDE -->

</head>
<body>

	<div class="login-container">

		<div class="login-box animated fadeInDown">
			<div class="login-logo"></div>
			<div class="login-body">
				<div class="login-title">
					<strong>Welcome</strong>, Please login
				</div>
				<form action="<%=request.getContextPath()%>/UserController"
					class="form-horizontal" method="post">
					<input type="hidden" name="action" value="login" /> <input
						type="hidden" name="from" value="admin" />
					<div class="form-group">
						<div class="col-md-12">
							<input type="text" class="form-control" name="userName"
								placeholder="Tài khoản mặc định: admin" />
						</div>
					</div>
					<div class="form-group">
						<div class="col-md-12">
							<input type="password" class="form-control" name="password"
								placeholder="Mật khẩu mặc định: admin" />
						</div>
					</div>
					<div class="form-group">
						<div class="col-md-6">
							<a href="#" class="btn btn-link btn-block">Forgot your
								password?</a>
						</div>
						<div class="col-md-6">
							<button class="btn btn-info btn-block">Log In</button>
						</div>
					</div>
				</form>
			</div>
			<div class="login-footer">
				<div class="pull-left">&copy; 2017 Movie Pro</div>
				<div class="pull-right">
					<a href="#">About</a> | <a href="#">Privacy</a> | <a href="#">Contact
						Us</a>
				</div>
			</div>
		</div>

	</div>

</body>
</html>
