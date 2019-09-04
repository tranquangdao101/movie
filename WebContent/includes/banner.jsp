<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="i18n.UTF8Control"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="java.util.Locale"%>
<!--/main-header-->
<!--/banner-section-->
<div id="demo-1"
	data-zs-src='["images/2.jpg", "images/1.jpg", "images/3.jpg","images/4.jpg"]'
	data-zs-overlay="dots">
	<div class="demo-inner-content">
	<jsp:include page="navbar.jsp"></jsp:include>
		<!--/banner-info-->
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
		<div class="baner-info">
			<h3>
				<span><%=bundle.getString("bannerText")%></span>
			</h3>
			<h4><%=bundle.getString("banner")%></h4>
			<a class="w3_play_icon1" href="#small-dialog1"><%=bundle.getString("watchTrailer")%></a>
		</div>
		<!--/banner-ingo-->
	</div>
</div>
<!--/banner-section-->
<!--//main-header-->

<!-- Modal1 -->
<div class="modal fade" id="groupDiary" tabindex="-1" role="dialog">
	<div class="modal-dialog">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4>Group Diary</h4>
				<table class="table">
					<tr>
						<th colspan="5" style="text-align: center">Nhật ký tuần 7</th>

					</tr>
					<tr>
						<th>STT</th>
						<th>Thành viên</th>
						<th>Chức năng</th>
						<th>File code</th>
						<th>Mức độ hoàn thành(%)</th>
					</tr>

					<tr>
						<td>01</td>
						<td>Nguyễn Công Trí</td>
						<td>Register</td>
						<td>register.jsp,UserController.java</td>
						<td>100</td>
					</tr>
					<tr>
						<td>02</td>
						<td>Nguyễn Quốc Vũ</td>
						<td>Login</td>
						<td>login.jsp,UserController.java</td>
						<td>100</td>
					</tr>
					<tr>
						<td>03</td>
						<td>Phạm Anh Nhật</td>
						<td>Logout</td>
						<td>UserController.java</td>
						<td>100</td>
					</tr>
					<tr>
						<td>04</td>
						<td>Trần Quang Đạo</td>
						<td>Group Diary</td>
						<td>modal Diary (banner.jsp)</td>
						<td>100</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
<!-- //Modal1 -->