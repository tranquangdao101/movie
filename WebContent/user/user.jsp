<%@page import="java.util.Locale"%>
<%@page import="i18n.UTF8Control"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="dao.UserDAO"%>
<%@page import="model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<!--
	Read Only by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>
<title>Trang người dùng</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
<link rel="stylesheet" href="assets/css/main.css" />
<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
</head>
<body>
	<%
		Locale locale = request.getLocale();
		if (((Locale) session.getAttribute("locale")) == null) {
			if (!locale.getLanguage().equals("vi"))
				locale = Locale.ENGLISH;
			session.setAttribute("locale", locale);
		} else {
			locale = (Locale) session.getAttribute("locale");
		}

		if (((String) session.getAttribute("language")) != null) {
			String language = (String) session.getAttribute("language");
			if (language.equals("vietnamese")) {
				locale = new Locale("vi", "VN");
			} else if (language.equals("english")) {
				locale = Locale.ENGLISH;
			}
		}

		UTF8Control utf8control = new UTF8Control();
		ResourceBundle bundle = ResourceBundle.getBundle("i18n.lang", locale, utf8control);
		session = request.getSession();
		User user = (User) session.getAttribute("user");
		UserDAO uDAO = new UserDAO();
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/index.jsp");
			return;
		}
		request.setCharacterEncoding("utf-8");
		boolean isFacebookAccount = false;
		boolean isGoogleAccount = false;
		if (user.getFacebookID() != null) {
			isFacebookAccount = true;
		} else if (user.getGoogleID() != null) {
			isGoogleAccount = true;
		}
		if (isFacebookAccount) {
			user = uDAO.getUserByFacebookID(user.getFacebookID());
		} else if (isGoogleAccount) {
			user = uDAO.getUserByGoogleID(user.getGoogleID());
		} else {
			user = uDAO.getUserByID(user.getUserID());
		}
	%>
	<jsp:include page='includes/rightsidebar.jsp'>
		<jsp:param name="activepage" value="userpage" />
		<jsp:param name="isFacebookAccount" value="<%=isFacebookAccount%>" />
		<jsp:param name="isGoogleAccount" value="<%=isGoogleAccount%>" />
		<jsp:param name="avatar" value="<%=user.getAvatar()%>" />
		<jsp:param name="fullName" value="<%=user.getFullName()%>" />
	</jsp:include>
	<!-- Wrapper -->
	<div id="wrapper">

		<!-- Main -->
		<div id="main">

			<!-- One -->
			<section id="one">
				<div class="container">
					<header class="major">
						<h2><%=bundle.getString("userinfo")%></h2>
						<!-- <p>Just an incredibly simple responsive site<br />
										template freebie by <a href="http://html5up.net">HTML5 UP</a>.</p> -->
					</header>
					<!-- <p>Faucibus sed lobortis aliquam lorem blandit. Lorem eu nunc metus col. Commodo id in arcu ante lorem ipsum sed accumsan erat praesent faucibus commodo ac mi lacus. Adipiscing mi ac commodo. Vis aliquet tortor ultricies non ante erat nunc integer eu ante ornare amet commetus vestibulum blandit integer in curae ac faucibus integer non. Adipiscing cubilia elementum.</p> -->
					<table>
						<%
						if(!isFacebookAccount && !isGoogleAccount || user.getUserName() != null )  {%>
						<tr>
							<th><%=bundle.getString("username")%></th>
							<td><%=user.getUserName() %></td>
						</tr>
						<%} %>
						<tr>
							<th><%=bundle.getString("firstname")%></th>
							<td><%=user.getFullName() %></td>
						</tr>
						<%
						if(!isFacebookAccount && !isGoogleAccount || user.getGender() != null )  {%>
						<tr>
							<th><%=bundle.getString("sex")%></th>
							<td><%=user.getGender() %></td>
						</tr>
						<%} %>
						<%if(!isFacebookAccount && !isGoogleAccount || user.getPassword() != null)  {%>
						<tr>
							<th><%=bundle.getString("password")%></th>
							<td><%for(int i = 0; i< user.getPassword().length();i++){ %>* <%} %></td>
						</tr>
						<%} %>
						<tr>
							<th>Email</th>
							<td><%=user.getEmail() %></td>
						</tr>
						<%if(!isFacebookAccount && !isGoogleAccount || user.getPhone() != null)  {%>
						<tr>
							<th><%=bundle.getString("phone")%></th>
							<td><%=user.getPhone() %></td>
						</tr>
						<%} %>
					</table>
				</div>
			</section>
		</div>

		<!-- Footer -->
		<section id="footer">
			<div class="container">
				<ul class="copyright">
					<li>&copy; Untitled. All rights reserved.</li>
					<li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
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
