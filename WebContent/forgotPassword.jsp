<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.ForgotPassword"%>
<%@page import="dao.ForgotPasswordDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
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
			<li><a href="index.html">Home</a><i>//</i></li>
			<li>Login</li>
		</ul>
	</div>
</div>
<!-- //breadcrumb -->
<%
	long forgetID = -1;
	try {
		forgetID = Long.parseLong(request.getParameter("forgetID"));
	} catch (NumberFormatException e) {
		response.sendRedirect("index.jsp");
		return;
	}
	if(request.getParameter("forgetID") == null) {
		response.sendRedirect("index.jsp");
		return;
	}
	if(forgetID == -1) {
		response.sendRedirect("index.jsp");
		return;
	}
	ForgotPasswordDAO forgotPasswordDAO = new ForgotPasswordDAO();
	if(!forgotPasswordDAO.checkID(forgetID)) {
		response.sendRedirect("index.jsp");
		return;
	}
	
	ForgotPassword forgotPassword = forgotPasswordDAO.getForgotPasswordByID(forgetID);
	long MILLIS_PER_DAY = 24 * 60 * 60 * 1000L;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Date dateOne = new Date();
	Date dateTwo = forgotPassword.getDatetime();	
	boolean moreThanDay = Math.abs(dateOne.getTime() - dateTwo.getTime()) > MILLIS_PER_DAY;
	if(moreThanDay) {
		forgotPasswordDAO.delete(forgetID);
		response.sendRedirect("index.jsp");
		return;
	}
	
%>

<div class="w3_content_agilleinfo_inner">
	<div class="agile_featured_movies">
		<div class="inner-agile-w3l-part-head">
			<h3 class="w3l-inner-h-title">Quên mật khẩu !!!</h3>
			<p class="w3ls_head_para">Khôi phục mật khẩu</p>
		</div>
		<div class="typo-grid">
			<div class="typo-1">
				<div class="grid_3 grid_5">
					<div class="tab-content">
						<div class="tab-pane active" id="horizontal-form">
							<p>Xin chào <%=forgotPassword.getUser().getFullName() %>. Hãy nhập mật khẩu mới</p>
							<form action="<%=request.getContextPath() %>/ForgotPasswordController" class="form-horizontal">
								<input type="hidden" name="userID" value="<%=forgotPassword.getUser().getUserID()%>"/>
								<input type="hidden" name="forgotID" value="<%=forgotPassword.getForgetID()%>"/>
								<input type="hidden" name="action" value="recover"/>
								<div class="form-group">
									<label for="focusedinput" class="col-sm-2 control-label">Nhập
										mật khẩu</label>
									<div class="col-sm-8">
										<input type="password" name="password" class="form-control1" id="focusedinput"
											placeholder="Default Input">
									</div>
									<div class="col-sm-2 jlkdfj1">
										<p class="help-block">Your help text!</p>
									</div>
								</div>
									<div class="form-group ">
									<div class="col-md-offset-2 col-sm-8">
										<input type="submit" value="Submit">
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


<br />


<jsp:include page="includes/footer.jsp"></jsp:include>




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