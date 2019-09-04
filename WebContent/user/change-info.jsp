<%@page import="java.util.Locale"%>
<%@page import="i18n.UTF8Control"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="model.User"%>
<%@page import="dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<title>Trang người dùng</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->

	<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/user/assets/css/main.css" />
</head>
<body>
	<%
	Locale locale = request.getLocale();
	if(((Locale)session.getAttribute("locale")) == null) {
		if(!locale.getLanguage().equals("vi"))
			locale = Locale.ENGLISH;
		session.setAttribute("locale", locale);
	} else {
		locale =(Locale) session.getAttribute("locale");
	}
	
	if(((String)session.getAttribute("language"))!= null) {
		String language = (String)session.getAttribute("language");
		if(language.equals("vietnamese")) {
			locale = new Locale("vi","VN");
		} else if(language.equals("english")) {
			locale = Locale.ENGLISH;
		}
	}
	
	UTF8Control utf8control = new UTF8Control();
	ResourceBundle bundle = ResourceBundle.getBundle("i18n.lang",locale,utf8control);
	
	session = request.getSession();
	User user =(User) session.getAttribute("user");
	UserDAO uDAO = new UserDAO();
	if(user == null) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	request.setCharacterEncoding("utf-8");
	boolean isFacebookAccount = false;
	boolean isGoogleAccount = false;
	if(user.getFacebookID() != null ) {
		isFacebookAccount = true;
	} else if(user.getGoogleID() != null ) {
		isGoogleAccount = true;
	}
	if(isFacebookAccount) {
		user = uDAO.getUserByFacebookID(user.getFacebookID());
	} else if(isGoogleAccount) {
		user = uDAO.getUserByGoogleID(user.getGoogleID());
	} else {
		user = uDAO.getUserByID(user.getUserID());
	}
	%>
		<jsp:include page='includes/rightsidebar.jsp'>
		<jsp:param name="activepage" value="changeinfopage" />
		<jsp:param name="isFacebookAccount" value="<%=isFacebookAccount %>" />
		<jsp:param name="isGoogleAccount" value="<%=isGoogleAccount%>" />
		<jsp:param name="avatar" value="<%=user.getAvatar() %>" />
		<jsp:param name="fullName" value="<%=user.getFullName() %>" />
	</jsp:include>
		

		<!-- Wrapper -->
		<div id="wrapper">

			<!-- Main -->
			<div id="main">

				<!-- One -->
				<section id="one">
					<div class="container">
						<header class="major">
							<h2>Thay đổi thông tin</h2>
										<!-- <p>Just an incredibly simple responsive site<br />
										template freebie by <a href="http://html5up.net">HTML5 UP</a>.</p> -->
									</header>
									<!-- <p>Faucibus sed lobortis aliquam lorem blandit. Lorem eu nunc metus col. Commodo id in arcu ante lorem ipsum sed accumsan erat praesent faucibus commodo ac mi lacus. Adipiscing mi ac commodo. Vis aliquet tortor ultricies non ante erat nunc integer eu ante ornare amet commetus vestibulum blandit integer in curae ac faucibus integer non. Adipiscing cubilia elementum.</p> -->
									<div>
										<form class="form-horizontal" action="<%=request.getContextPath() %>/UserController" enctype="multipart/form-data" method="post">
											<input type="hidden" name="userID" value="<%=user.getUserID()%>">
											
											<%if(user.getUserName() != null) { %>
											<div class="form-group">
												<label class="control-label col-sm-2" for="userName"><%=bundle.getString("username")%></label>
												<div class="col-sm-10">
													<input type="text" class="form-control" id="userName" name="userName" placeholder="<%=bundle.getString("enterusername")%>" value="<%=user.getUserName() %>" readonly="readonly">
												</div>
											</div>
											<%} else { %>
												<div class="form-group">
												<label class="control-label col-sm-2" for="userName"><%=bundle.getString("username")%></label>
												<div class="col-sm-10">
													<input type="text" class="form-control" id="userName" name="userName" placeholder="<%=bundle.getString("username")%>" value="" >
												</div>
												${errUserName}
											</div>
											<%} %>
											<div class="form-group">
												<label class="control-label col-sm-2" for="lastName"><%=bundle.getString("lastname")%></label>
												<div class="col-sm-10">
													<input type="text" class="form-control" name="lastName" value="<%=user.getLastName() %>" placeholder="<%=bundle.getString("enterlastname")%>">
												</div>
												${errLastName}
											</div>
											<div class="form-group">
												<label class="control-label col-sm-2" for="firstName"><%=bundle.getString("firstname")%>:</label>
												<div class="col-sm-10">
													<input type="text" class="form-control" name="firstName" value=<%=user.getFirstName() %> placeholder="<%=bundle.getString("enterfirstname")%>">
												</div>
												${errFirstName}
											</div>
											<div class="form-group">
												<label class="control-label col-sm-2" for="pwd"><%=bundle.getString("password")%></label>
												<div class="col-sm-10"> 
													<input type="password" class="form-control" id="pwd" value="<%=user.getPassword() %>" name="pwd" placeholder="<%=bundle.getString("enterpassword")%>">
												</div>
												${errPassword}
											</div>
											<div class="form-group">
												<label class="control-label col-sm-2" for="email">Email:</label>
												<div class="col-sm-10">
													<input type="email" class="form-control" id="email" name="email" value="<%=user.getEmail() %>" placeholder="<%=bundle.getString("entermail")%>">
												</div>
												${errEmail}
											</div>
											<div class="form-group">
												<label class="col-xs-2 control-label"><%=bundle.getString("sex")%></label>
												<div class="col-xs-9">
													<label class="radio-inline">
													<%String gender = user.getGender(); %>
														<input type="radio" name="gender" value="Male" <%if(gender.equalsIgnoreCase("Male")) { %>checked <%} %>><%=bundle.getString("male")%>
													</label>
													<label class="radio-inline">
														<input type="radio" name="gender" value="Female"<%if(gender.equalsIgnoreCase("Female")) { %>checked <%} %>><%=bundle.getString("female")%>
													</label>
													<label class="radio-inline">
														<input type="radio" name="gender" value="Other"<%if(gender.equalsIgnoreCase("Other")) { %>checked <%} %>><%=bundle.getString("other")%>
													</label>
												</div>
												${errGender}
											</div>
											<div class="form-group">
												<label class="control-label col-sm-2" for="phoneNumber"><%=bundle.getString("phone")%></label>
												<div class="col-sm-10">
													<input type="text" class="form-control" id="phoneNumber" value="<%=user.getPhone()%>"  name="phoneNumber" placeholder="<%=bundle.getString("enterphone")%>">
												</div>
												${errPhoneNumber}
											</div>
											<div class="form-group">
												<label class="control-label col-sm-2" for="fileImg"><%=bundle.getString("image")%></label>
												<div class="col-sm-10">
													<input type="file" class="" id="img" name="img" placeholder="Enter image">
												</div>
												${errImg}
											</div>
											<div class="form-group"> 
												<div class="col-sm-offset-2 col-sm-10">
													<button type="submit" class="btn btn-default"><%=bundle.getString("submit")%></button>
												</div>
											</div>
										</form>		
									</div>							
								</div>
							</section>
					</div>

					<!-- Footer -->
					<section id="footer">
						<div class="container">
							<ul class="copyright">
								<li>&copy; Untitled. All rights reserved.</li><li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
							</ul>
						</div>
					</section>

				</div>

				<!-- Scripts -->
				<script src="assets/js/jquery.min.js"></script>
				<script src="assets/js/jquery.scrollzer.min.js"></script>
				<script src="assets/js/jquery.scrolly.min.js"></script>
				<script src="assets/js/skel.min.js"></script>
				<script src="assets/js/util.js"></script>
				<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
				<script src="assets/js/main.js"></script>

			</body>
			</html>
