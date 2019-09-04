<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="i18n.UTF8Control"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="java.util.Locale"%>
<!DOCTYPE html>
<html>
<head>
<title>Movies Pro an Entertainment</title>
<!-- for-mobile-apps -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords"
	content="Movies Pro Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
<script type="application/x-javascript">
	
	
	
	
	 addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
		function hideURLbar(){ window.scrollTo(0,1);




</script>
<!-- //for-mobile-apps -->
<link href="css/bootstrap.css" rel="stylesheet" type="text/css"
	media="all" />
<!-- pop-up -->
<link href="css/popuo-box.css" rel="stylesheet" type="text/css"
	media="all" />
<!-- //pop-up -->
<link href="css/easy-responsive-tabs.css" rel='stylesheet'
	type='text/css' />
<link rel="stylesheet" type="text/css" href="css/zoomslider.css" />
<link rel="stylesheet" type="text/css" href="css/style.css" />
<link href="css/font-awesome.css" rel="stylesheet">
<script type="text/javascript" src="js/modernizr-2.6.2.min.js"></script>
<!--/web-fonts-->
<link href='//fonts.googleapis.com/css?family=Tangerine:400,700'
	rel='stylesheet' type='text/css'>
<link
	href="//fonts.googleapis.com/css?family=Lato:100,100i,300,300i,400,400i,700,700i,900"
	rel="stylesheet">
<link href='//fonts.googleapis.com/css?family=Montserrat:400,700'
	rel='stylesheet' type='text/css'>
<!--//web-fonts-->
</head>
<%	

		
	/* 	if(((Locale)session.getAttribute("locale")) == null) {
			if(!locale.getLanguage().equals("vi"))
				locale = Locale.ENGLISH;
			session.setAttribute("locale", locale);
		} else {
			locale =(Locale) session.getAttribute("locale");
		} */
		Locale locale = request.getLocale();
		if((Locale) session.getAttribute("locale") == null ){
			if(locale.getLanguage().equals("vi")) {
				locale = new Locale("vi","VN");
			} else if(locale.getLanguage().equals("en")) {
				locale = Locale.ENGLISH;
			} else {
				locale = Locale.ENGLISH;
			}
		} else {
			locale = (Locale) session.getAttribute("locale");
		}
		
		String flanguage = request.getParameter("language");
		if(flanguage != null)
			session.setAttribute("language", flanguage);
		
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


<jsp:include page="includes/header.jsp"></jsp:include>
<jsp:include page="includes/header_bottom.jsp"></jsp:include>
<!-- breadcrumb -->
<div class="w3_breadcrumb">
	<div class="breadcrumb-inner">
		<ul>
			<li><a href="index.html"><%=bundle.getString("home")%></a><i>//</i></li>
			<li><%=bundle.getString("register")%></li>
		</ul>
	</div>
</div>
<!-- //breadcrumb -->

<div class="w3_content_agilleinfo_inner">
	<div class="agile_featured_movies">
		<div class="inner-agile-w3l-part-head">
			<h3 class="w3l-inner-h-title"><%=bundle.getString("register")%></h3>
			<p class="w3ls_head_para"><%=bundle.getString("registerFeature")%></p>
		</div>
		<div class="typo-grid">
			<div class="typo-1">
				<div class="grid_3 grid_5">
					<div class="tab-content">
						<div class="tab-pane active" id="horizontal-form">
							<form action="<%=request.getContextPath()%>/UserController"
								class="form-horizontal" method="post">
								<input type="hidden" name="action" value="register" /> <br />
								<div class="form-group">
									<label for="focusedinput" class="col-sm-2 control-label">Email</label>
									<div class="col-sm-8">
										<input type="email" name=userEmail class="form-control1"
											id="focusedinput" placeholder="<%=bundle.getString("entermail")%>">
									</div>
									<div class="col-sm-2 jlkdfj1">
										<p class="help-block" style="font-family: 'Arial', sans-serif;">${errUserEmail}</p>
									</div>
								</div>
								<div class="form-group">
									<label for="focusedinput" class="col-sm-2 control-label"><%=bundle.getString("username")%></label>
									<div class="col-sm-8">
										<input type="text" name="userName" class="form-control1"
											id="focusedinput" placeholder="<%=bundle.getString("enterusername")%>">
									</div>
									<div class="col-sm-2 jlkdfj1">
										<p class="help-block" style="font-family: 'Arial', sans-serif;">${errUserName}</p>
									</div>
								</div>
								<div class="form-group">
									<label for="focusedinput" class="col-sm-2 control-label"><%=bundle.getString("password")%></label>
									<div class="col-sm-8">
										<input type="password" name="password" class="form-control1"
											id="focusedinput" placeholder="<%=bundle.getString("enterpassword")%>">
									</div>
									<div class="col-sm-2 jlkdfj1">
										<p class="help-block" style="font-family: 'Arial', sans-serif;">${errPassword}</p>
									</div>
								</div>
								<div class="form-group">
									<label for="focusedinput" class="col-sm-2 control-label"><%=bundle.getString("repassword")%></label>
									<div class="col-sm-8">
										<input type="password" name="confirmPassword"
											class="form-control1" id="focusedinput"
											placeholder="<%=bundle.getString("enterrepassword")%>">
									</div>
									<div class="col-sm-2 jlkdfj1">
										<p class="help-block"style="font-family: 'Arial', sans-serif;" >${errPassword}</p>
									</div>
								</div>
								<div class="form-group">
									<label for="focusedinput" class="col-sm-2 control-label"><%=bundle.getString("sex")%></label>
									<div class="col-sm-8">
										<label class="radio-inline"> <%
 	String gender = (String) request.getAttribute("gender");
 %>
											<input type="radio" name="gender" value="Male"
											<%if (gender != null && gender.equals("Male")) {%> checked
											<%}%>><%=bundle.getString("male")%>
										</label> <label class="radio-inline"> <input type="radio"
											name="gender" value="Female"
											<%if (gender != null && gender.equals("Male")) {%> checked
											<%}%>><%=bundle.getString("female")%>
										</label> <label class="radio-inline"> <input type="radio"
											name="gender" value="Other"
											<%if (gender != null && gender.equals("Male")) {%> checked
											<%}%>><%=bundle.getString("other")%>
										</label>
									</div>
									<div class="col-sm-2 jlkdfj1">
										<p class="help-block" style="font-family: 'Arial', sans-serif;">${errGender}</p>
									</div>
								</div>
								<div class="form-group">
									<label for="focusedinput" class="col-sm-2 control-label"><%=bundle.getString("lastname")%></label>
									<div class="col-sm-8">
										<input type="text" name="lastName"
											class="form-control1" id="focusedinput"
											placeholder="<%=bundle.getString("enterlastname")%>">
									</div>
									<div class="col-sm-2 jlkdfj1">
										<p class="help-block"></p>
									</div>
								</div>
								<div class="form-group">
									<label for="focusedinput" class="col-sm-2 control-label"><%=bundle.getString("firstname")%></label>
									<div class="col-sm-8">
										<input type="text" name="firstName"
											class="form-control1" id="focusedinput"
											placeholder="<%=bundle.getString("enterfirstname")%>">
									</div>
									<div class="col-sm-2 jlkdfj1">
										<p class="help-block"></p>
									</div>
								</div>
								<div class="form-group">
									<label for="focusedinput" class="col-sm-2 control-label"><%=bundle.getString("phone")%></label>
									<div class="col-sm-8">
										<input type="number" name="userPhone"
											class="form-control1" id="focusedinput"
											placeholder="<%=bundle.getString("enterphone")%>">
									</div>
									<div class="col-sm-2 jlkdfj1">
										<p class="help-block" style="font-family: 'Arial', sans-serif;">${errPhoneNumber}</p>
									</div>
								</div>
								<div class="form-group">
									<div class="col-md-offset-2 col-sm-8">
										<span class="agree-checkbox"> <label class="checkbox"><input
							type="checkbox" name="checkPolicy"><%=bundle.getString("agree")%><a
							class="w3layouts-t" data-toggle="modal" data-target="#dieuKhoan"><%=bundle.getString("term")%></a> <%=bundle.getString("and")%> <a class="w3layouts-t" data-toggle="modal"
							data-target="#dieuKhoan"><%=bundle.getString("privacy")%></a></label>
					</span>
									</div>
									<div class="col-sm-2 jlkdfj1">
										<p class="help-block"></p>
									</div>
								</div>
								<div class="form-group ">
									<div class="col-md-offset-2 col-sm-8">
										<input type="submit" value="<%=bundle.getString("register")%>">
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%-- 
<div class="container">
	<div class="col-md-8 ">
		<h1 class="col-md-offset-4">Register</h1>
		<br>
		<form class="form-horizontal" action="UserController" method="post">
			<input type="hidden" name="action" value="register" />
			<div class="form-group">
				<label class="control-label col-sm-3" for="userEmail">Email:</label>
				<div class="col-sm-5">
					<input type="email" class="form-control" id="userEmail"
						name="userEmail" placeholder="Enter email" value="${userEmail}">
				</div>
				<div class="col-sm-4">
					<p>${errUserEmail}</p>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-3" for="userName">User
					Name:</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="userName"
						name="userName" placeholder="Enter User Name" value="${userName}">
				</div>
				<div class="col-sm-4">
					<p>${errUserName}</p>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-3" for="password">Password:</label>
				<div class="col-sm-5">
					<input type="password" class="form-control" id="password"
						name="password" placeholder="Enter password" value="${password}">
				</div>
				<div class="col-sm-4">
					<p>${errPassword}</p>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-3" for="confirmPassword">Confirm
					password:</label>
				<div class="col-sm-5">
					<input type="password" class="form-control" id="confirmPassword"
						name="confirmPassword" placeholder="Enter confirm password"
						value="${confirmPassword}">
				</div>
				<div class="col-sm-4">
					<p>${errPassword}</p>
				</div>
			</div>
			<div class="form-group">
				<label class="col-xs-3 control-label">Giới tính</label>
				<%
					String gender = (String) request.getAttribute("gender");
				%>
				<div class="col-xs-5">
					<label class="radio-inline"> <input type="radio"
						name="gender" value="Male"
						<%if (gender != null && gender.equals("Male")) {%> checked <%}%>>Nam
					</label> <label class="radio-inline"> <input type="radio"
						name="gender" value="Female"
						<%if (gender != null && gender.equals("Male")) {%> checked <%}%>>Nữ
					</label> <label class="radio-inline"> <input type="radio"
						name="gender" value="Other"
						<%if (gender != null && gender.equals("Male")) {%> checked <%}%>>Khác
					</label>
				</div>
				<div class="col-sm-4">
					<p>${errGender}</p>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-3" for="lastName">Last
					Name:</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="lastName"
						name="lastName" placeholder="Enter last name" value="${lastName}">
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-3" for="firstName">First
					Name:</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="firstName"
						name="firstName" placeholder="Enter first name"
						value="${firstName}">
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-3" for="userPhone">Phone
					number:</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="userPhone"
						name="userPhone" placeholder="Enter your phone number"
						value="${userPhone}">
				</div>
				<div class="col-sm-4">
					<p>${errPhoneNumber}</p>
				</div>
			</div>
			<div class="form-group">
				<div class="signin-rit col-sm-offset-2 col-sm-10">
					<span class="agree-checkbox"> <label class="checkbox"><input
							type="checkbox" name="checkPolicy">I agree to your <a
							class="w3layouts-t" data-toggle="modal" data-target="#dieuKhoan">Terms
								of Use</a> and <a class="w3layouts-t" data-toggle="modal"
							data-target="#dieuKhoan">Privacy Policy</a></label>
					</span>
				</div>
			</div>
			<br />
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<div class="tp">
						<input type="submit" value="REGISTER NOW">
					</div>
				</div>
			</div>
		</form>
	</div>
</div> --%>
<br />

<jsp:include page="includes/footer.jsp"></jsp:include>
<!-- Modal1 -->
<div class="modal fade" id="dieuKhoan" tabindex="-1" role="dialog">
	<div class="modal-dialog">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4>Điều khoản sử dụng</h4>
				<p>Tạm thời chưa nghĩ ra. Khi nào nghĩ ra rồi thì thôi</p>
			</div>
		</div>
	</div>
</div>
<!-- //Modal1 -->




<a href="#home" id="toTop" class="scroll" style="display: block;"> <span
	id="toTopHover" style="opacity: 1;"> </span>
</a>

<script src="js/jquery-1.11.1.min.js"></script>
<!-- Dropdown-Menu-JavaScript -->
<script>
	$(document).ready(function() {
		$(".dropdown").hover(function() {
			$('.dropdown-menu', this).stop(true, true).slideDown("fast");
			$(this).toggleClass('open');
		}, function() {
			$('.dropdown-menu', this).stop(true, true).slideUp("fast");
			$(this).toggleClass('open');
		});
	});
</script>
<!-- //Dropdown-Menu-JavaScript -->


<script type="text/javascript" src="js/jquery.zoomslider.min.js"></script>
<!-- search-jQuery -->
<script src="js/main.js"></script>
<script src="js/simplePlayer.js"></script>
<script>
	$("document").ready(function() {
		$("#video").simplePlayer();
	});
</script>
<script>
	$("document").ready(function() {
		$("#video1").simplePlayer();
	});
</script>
<script>
	$("document").ready(function() {
		$("#video2").simplePlayer();
	});
</script>
<script>
	$("document").ready(function() {
		$("#video3").simplePlayer();
	});
</script>

<!-- pop-up-box -->
<script src="js/jquery.magnific-popup.js" type="text/javascript"></script>
<!--//pop-up-box -->

<div id="small-dialog1" class="mfp-hide">
	<iframe
		src="https://player.vimeo.com/video/165197924?color=ffffff&title=0&byline=0&portrait=0"></iframe>
</div>
<div id="small-dialog2" class="mfp-hide">
	<iframe
		src="https://player.vimeo.com/video/165197924?color=ffffff&title=0&byline=0&portrait=0"></iframe>
</div>
<script>
	$(document).ready(function() {
		$('.w3_play_icon,.w3_play_icon1,.w3_play_icon2').magnificPopup({
			type : 'inline',
			fixedContentPos : false,
			fixedBgPos : true,
			overflowY : 'auto',
			closeBtnInside : true,
			preloader : false,
			midClick : true,
			removalDelay : 300,
			mainClass : 'my-mfp-zoom-in'
		});

	});
</script>
<script src="js/easy-responsive-tabs.js"></script>
<script>
	$(document).ready(function() {
		$('#horizontalTab').easyResponsiveTabs({
			type : 'default', //Types: default, vertical, accordion           
			width : 'auto', //auto or any width like 600px
			fit : true, // 100% fit in a container
			closed : 'accordion', // Start closed if in accordion view
			activate : function(event) { // Callback function if tab is switched
				var $tab = $(this);
				var $info = $('#tabInfo');
				var $name = $('span', $info);
				$name.text($tab.text());
				$info.show();
			}
		});
		$('#verticalTab').easyResponsiveTabs({
			type : 'vertical',
			width : 'auto',
			fit : true
		});
	});
</script>
<link href="css/owl.carousel.css" rel="stylesheet" type="text/css"
	media="all">
<script src="js/owl.carousel.js"></script>
<script>
	$(document).ready(function() {
		$("#owl-demo").owlCarousel({

			autoPlay : 3000, //Set AutoPlay to 3 seconds
			autoPlay : true,
			navigation : true,

			items : 5,
			itemsDesktop : [ 640, 4 ],
			itemsDesktopSmall : [ 414, 3 ]

		});

	});
</script>

<!--/script-->
<script type="text/javascript" src="js/move-top.js"></script>
<script type="text/javascript" src="js/easing.js"></script>

<script type="text/javascript">
	jQuery(document).ready(function($) {
		$(".scroll").click(function(event) {
			event.preventDefault();
			$('html,body').animate({
				scrollTop : $(this.hash).offset().top
			}, 900);
		});
	});
</script>
<script type="text/javascript">
	$(document).ready(function() {
		/*
		var defaults = {
			containerID: 'toTop', // fading element id
			containerHoverID: 'toTopHover', // fading element hover id
			scrollSpeed: 1200,
			easingType: 'linear' 
		};
		 */

		$().UItoTop({
			easingType : 'easeOutQuart'
		});

	});
</script>
<!--end-smooth-scrolling-->

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var x_timer;
		$("#username").keyup(function(e) {
			clearTimeout(x_timer);
			var user_name = $(this).val();
			x_timer = setTimeout(function() {
				check_username_ajax(user_name);
			}, 1000);
		});

		function check_username_ajax(username) {
			$("#user-result").html('<img src="img/ajax-loader.gif" />');
			$.post('CheckEmailServlet', {
				'username' : username
			}, function(data) {
				$("#user-result").html(data);
			});
		}
	});
</script>
<script src="js/bootstrap.js"></script>



</body>
</html>