<%@page import="model.User"%>
<%@page import="i18n.UTF8Control"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="java.util.Locale"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!--/banner-bottom-->


<%
	User user = (User) session.getAttribute("user");
%>
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
		%>

<div class="w3_agilits_banner_bootm">
	<div class="w3_agilits_inner_bottom">
		<div class="col-md-6 wthree_agile_login">
			<ul>
				<%--<li><i class="fa fa-phone" aria-hidden="true"></i> (+84) 090
					255 3475</li> --%>
				<%
					if (user != null) {
				%>
				<li><p><a href="<%=request.getContextPath()%>/user/user.jsp"><%=bundle.getString("hello")%>, ${user.getEmail()}</a></p></li>
				<li><a href="UserController?action=logout" class="login" 
					><%=bundle.getString("logout")%></a></li>
				<%
					} else {
				%>
				<li><a href="<%=request.getContextPath()%>/login.jsp" class="login" ><%=bundle.getString("login")%></a></li>
				<li><a href="<%=request.getContextPath()%>/register.jsp" class="login reg" ><%=bundle.getString("register")%></a></li>
				<%
					}
				%>
			</ul>
		</div>
	</div>
</div>
<!--//banner-bottom-->

<!-- Modal1 -->
<div class="modal fade" id="myModal4" tabindex="-1" role="dialog">
	<div class="modal-dialog">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4>Login</h4>
				<div class="login-form">
					<form action="#" method="post">
						<input type="email" name="email" placeholder="E-mail" required>
						<input type="password" name="password" placeholder="Password"
							required>
						<div class="tp">
							<input type="submit" value="LOGIN NOW">
						</div>
						<div class="forgot-grid">
							<div class="log-check">
								<label class="checkbox"><input type="checkbox"
									name="checkbox">Remember me</label>
							</div>
							<div class="forgot">
								<a href="#" data-toggle="modal" data-target="#myModal2">Forgot
									Password?</a>
							</div>
							<div class="clearfix"></div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- //Modal1 -->

<!-- Modal1 -->
<div class="modal fade" id="myModal5" tabindex="-1" role="dialog">

	<div class="modal-dialog">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4>Register</h4>
				<div class="login-form">
					<form action="#" method="post">
						<input type="text" name="name" placeholder="Name" required>
						<input type="email" name="email" placeholder="E-mail" required>
						<input type="password" name="password" placeholder="Password"
							required> <input type="password" name="conform password"
							placeholder="Confirm Password" required>
						<div class="signin-rit">
							<span class="agree-checkbox"> <label class="checkbox"><input
									type="checkbox" name="checkbox">I agree to your <a
									class="w3layouts-t" href="#" target="_blank">Terms of Use</a>
									and <a class="w3layouts-t" href="#" target="_blank">Privacy
										Policy</a></label>
							</span>
						</div>
						<div class="tp">
							<input type="submit" value="REGISTER NOW">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- //Modal1 -->