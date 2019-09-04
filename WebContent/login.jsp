<%@page import="utilities.FacebookOAuth"%>
<%@page import="utilities.GoogleOAuth"%>
<%@page import="i18n.UTF8Control"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="java.util.Locale"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
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
<head>
<title>Movies Pro an Entertainment</title>
<style>
</style>

<!-- for-mobile-apps -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords"
	content="Movies Pro Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
<script type="application/x-javascript">
	 addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
		function hideURLbar(){ window.scrollTo(0,1); } 
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
<!-- reCAPTCHA with Vietnamese language -->
<script src='https://www.google.com/recaptcha/api.js?hl=vi'></script>

</head>



<jsp:include page="includes/header.jsp"></jsp:include>
<jsp:include page="includes/header_bottom.jsp"></jsp:include>
<!-- breadcrumb -->
<div class="w3_breadcrumb">
	<div class="breadcrumb-inner">
		<ul>
			<li><a href="index.html"><%=bundle.getString("home")%></a><i>//</i></li>
			<li><%=bundle.getString("login")%></li>
		</ul>
	</div>
</div>
<!-- //breadcrumb -->
<div class="w3_content_agilleinfo_inner">
	<div class="agile_featured_movies">
		<div class="inner-agile-w3l-part-head">
			<h3 class="w3l-inner-h-title"><%=bundle.getString("login")%></h3>
			<p class="w3ls_head_para"><%=bundle.getString("feature")%></p>
		</div>
		<div class="typo-grid">
			<div class="typo-1">
				<div class="grid_3 grid_5">
					<div class="tab-content">
						<div class="tab-pane active" id="horizontal-form">
							<form id="loginform"
								action="<%=request.getContextPath()%>/UserController"
								class="form-horizontal" method="post">
								<input type="hidden" name="action" value="login" />
								<div class="row text-center">
									<div class="col-md-4 col-md-offset-1 col-sm-12">
										<a href="<%=FacebookOAuth.getDialogLink()%>">
											<button type="button" class=" form-control btn btn-primary ">Facebook</button>
										</a>
									</div>
									<!-- <div class="col-md-4 col-sm-12">
            <button type="button" class="btn btn-info btn-block">Twitter</button>
        </div> -->
									<div class="col-md-4 col-sm-12">
									<a href="<%=GoogleOAuth.getDialogLink()%>">
										<button type="button" class="btn btn-danger btn-block">Google+</button>
										</a>
									</div>
									<br />
								</div>
								<br/>
								<div class="form-group">
									<label for="focusedinput" class="col-sm-2 control-label"><%=bundle.getString("username")%></label>
									<div class="col-sm-8">
										<input type="text" name="userName" class="form-control1"
											id="focusedinput" placeholder="<%=bundle.getString("enterusername")%>">
									</div>
									<div class="col-sm-2 jlkdfj1">
										<p class="help-block">${errorLogin}</p>
									</div>
								</div>
								<div class="form-group">
									<label for="focusedinput" class="col-sm-2 control-label"><%=bundle.getString("password")%></label>
									<div class="col-sm-8">
										<input type="password" name="password" class="form-control1"
											id="focusedinput" placeholder="<%=bundle.getString("enterpassword")%>">
									</div>
									<div class="col-sm-2 jlkdfj1">
										<p class="help-block">${errorLogin}</p>
									</div>
								</div>
								<div class="form-group">
									<label for="focusedinput" class="col-sm-2 control-label"><%=bundle.getString("captcha")%></label>
									<div class="col-sm-8">
										<div class="g-recaptcha"
						data-sitekey="6LfdYSQUAAAAAPNWKIlQZ-jIL-og752DvTsKzh53"></div>
									</div>
									<div class="col-sm-2 jlkdfj1">
										<p class="help-block">${errCaptcha}</p>
									</div>
								</div>
										<div class="form-group">
									<div class="col-md-offset-2 col-sm-8">
										<a data-toggle="modal"
						data-target="#forgotModal" href="#forgotModal"><%=bundle.getString("forgotPassword")%></a>
									</div>
									<div class="col-sm-2 jlkdfj1">
										<p class="help-block"></p>
									</div>
								</div>
								<div class="form-group ">
									<div class="col-md-offset-2 col-sm-8">
										<input type="submit" value="<%=bundle.getString("login")%>">
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

<%-- <div class="container">
	<div class="col-md-8">
		<h1 class="col-md-offset-4">Login</h1>
		<br>
		<div class="row text-center">
			<div class="col-md-4 col-md-offset-1 col-sm-12">
				<a href="<%=APIWrapper.getDialogLink()%>">
					<button type="button" class=" form-control btn btn-primary ">Facebook</button>
				</a>
			</div>
			<!-- <div class="col-md-4 col-sm-12">
            <button type="button" class="btn btn-info btn-block">Twitter</button>
        </div> -->
			<div class="col-md-4 col-sm-12">
				<button type="button" class="btn btn-danger btn-block">Google+</button>
			</div>
			<br />
		</div>
		<br />
		<form class="form-horizontal"
			action="<%=request.getContextPath()%>/UserController" method="post">
			<input type="hidden" name="action" value="login" />
			<div class="form-group">
				<label class="control-label col-sm-3" for="userName">User
					name:</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="userName"
						name="userName" placeholder="Enter user name">
				</div>
				<div class="col-sm-4">
					<p>${errorLogin}</p>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-3" for="passsword">Password:</label>
				<div class="col-sm-5">
					<input type="password" class="form-control" id="password"
						name="password" placeholder="Enter password">
					<!-- reCAPTCHA -->
				</div>
				<div class="col-sm-4">
					<p>${errorLogin}</p>
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2">
					<div class="g-recaptcha"
						data-sitekey="6LfdYSQUAAAAAPNWKIlQZ-jIL-og752DvTsKzh53"></div>
					<p>${errCaptcha}</p>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-5" for="pwd"> <input
					type="submit" class="login" value="Login" /></label> <label
					class="control-label col-sm-2S" for="pwd"> <input
					type="checkbox" checked="checked"> Remember me
				</label>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-5" for="psw"> <span
					class="psw"><a data-toggle="modal"
						data-target="#forgotModal" href="#forgotModal">Forgot
							password?</a></span> ${errorForgotPass}
				</label>
			</div>
		</form>

	</div>

	

</div> --%>
<!-- Modal -->

<script type="text/javascript">

	$(document).ready(function() {
		
		//Khi bàn phím được nhấn và thả ra thì sẽ chạy phương thức này
		$("#loginform").validate({
					rules: {
						userName: "required",
						password: "required",
					},
					messages: {
						userName: "Vui lòng nhập tài khoản",
						password: "Vui lòng nhập mật khẩu",
					}
				});
	});
	</script>

	<div class="modal fade" id="forgotModal" role="dialog">
		<div class="modal-dialog modal-lg">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Quên mật khẩu?</h4>
				</div>
				<div class="modal-body">
					<p>Hãy nhập email lúc tạo tài khoản để chúng tôi có thể gửi cho
						bạn mật khẩu. Sau khi submit hãy đăng nhập vào email để lấy lại
						mật khẩu (có hiệu quả trong 24h)</p>
					<div style="width: 50%; margin: 0 auto">
						<form
							action="<%=request.getContextPath()%>/ForgotPasswordController"
							method="post">
							<input type="hidden" name="action" value="forgotPassword" /> <input
								type="email" name="email" placeholder="Enter your email...."
								required> <input type="submit" value="Gửi">

						</form>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>

		</div>
	</div>
<br />


<jsp:include page="includes/footer.jsp"></jsp:include>




<a href="#home" id="toTop" class="scroll" style="display: block;"> <span
	id="toTopHover" style="opacity: 1;"> </span>
</a>

<script src="js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>

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