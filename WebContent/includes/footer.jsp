<%@page import="listener.MovieProListener"%>
<%@page import="i18n.UTF8Control"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="java.util.Locale"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!--/footer-bottom-->
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
	<div class="contact-w3ls" id="contact">
		<div class="col-md-12">
			<h4 class="b-log">
						<a href="index.jsp" style="text-decoration:none;"><span>M</span>ovies <span>P</span>ro</a>
					<form action="" method="post">
					<select  name="language" id="" class="" style="color:#000" onchange="this.form.submit();">
											<option value="-1"><%=bundle.getString("chooseLanguage")%></option>
											<option value="vietnamese"><%=bundle.getString("vietnamese")%></option>
											<option value="english"><%=bundle.getString("english")%></option>
										</select>
										</form>
					</h4>
					
			<h4 class="b-log"><%=bundle.getString("online")%>:<%=MovieProListener.getOnlineTotal()%> (<%=MovieProListener.getOnlineLogin() %> <%=bundle.getString("logged")%> )</h4>
			</div>
		<div class="footer-w3lagile-inner">
			<h2>
				<span><%=bundle.getString("newsletter")%></span>
			</h2>
			<p class="para"><%=bundle.getString("thankyou")%></p>
			<div class="footer-contact">
				<form action="#" method="post">
					<input type="email" name="Email" placeholder="<%=bundle.getString("enterEmail")%>..."
						required> <input type="submit" value="<%=bundle.getString("subcribe")%>">
				</form>
			</div>
		
			<h3 class="text-center follow">
				<a href="contact.jsp" style="color: #fe423f"><span><%=bundle.getString("connectUs")%></span></a>
			</h3>
			<ul class="social-icons1 agileinfo">
				<li><a href="#"><i class="fa fa-facebook"></i></a></li>
				<li><a href="#"><i class="fa fa-twitter"></i></a></li>
				<li><a href="#"><i class="fa fa-linkedin"></i></a></li>
				<li><a href="#"><i class="fa fa-youtube"></i></a></li>
				<li><a href="#"><i class="fa fa-google-plus"></i></a></li>
			</ul>

		</div>

	</div>
	<div class="w3agile_footer_copy">
		<p>
			© 2017 Movies Pro. Web Programming
		</p>
	</div>