
<%@page import="dao.CountryDAO"%>
<%@page import="model.Category"%>
<%@page import="dao.CategoryDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Movie"%>
<%@page import="dao.MovieDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%
	
	CountryDAO cDAO = new CountryDAO();
	String countryID = request.getParameter("countryID");
	if(countryID == null) {
		response.sendRedirect("index.jsp");
		return;
	}
	
	
	ArrayList<Movie> listByCountry = cDAO.getListMoviesByCountry(countryID);
	int pages = 0,first=0,max=0,total=0;
	if(request.getParameter("pages") != null) {
		pages = Integer.parseInt((String) request.getParameter("pages"));
	} else {
		pages = 1;
	}
	total = cDAO.countMovieByCountry(countryID);
	if(total <= 15) {
		first = 0;
		max = total;
	}else {
		first  = (pages-1)*15;
		max = 15;
	}
	ArrayList<Movie> listMoviePagi = cDAO.getMovieFromeCountry(countryID, first, max);
%>
<!DOCTYPE html>
<html>
<head>
<title><%=cDAO.getCountry(countryID).getCountryName()%></title>
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
<script>
	(function(d, s, id) {
		var js, fjs = d.getElementsByTagName(s)[0];
		if (d.getElementById(id))
			return;
		js = d.createElement(s);
		js.id = id;
		js.src = "//connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v2.8";
		fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));
</script>

</head>


<jsp:include page="includes/header.jsp"></jsp:include>
<jsp:include page="includes/header_bottom.jsp"></jsp:include>

<!-- breadcrumb -->
<div class="w3_breadcrumb">
	<div class="breadcrumb-inner">
		<ul>
			<li><a href="index.jsp">Home</a><i>//</i></li>
			<li><%=cDAO.getCountry(countryID).getCountryName()%></li>
		</ul>
	</div>
</div>
<!-- //breadcrumb -->

<!--/content-inner-section-->
<div class="w3_content_agilleinfo_inner">
	<div class="agile_featured_movies">

		<!--/tv-movies-->
		<h3 class="agile_w3_title hor-t">
			Phim<span><%=cDAO.getCountry(countryID).getCountryName() %></span>
		</h3>
		<div class="wthree_agile-requested-movies tv-movies">
		<% for(Movie list : listMoviePagi) { %>
			<div class="col-md-2 w3l-movie-gride-agile requested-movies">
				<a href="single.jsp?movieID=<%=list.getMovieID()%>" class="hvr-sweep-to-bottom"><img
					src="images/movie/m<%=list.getMovieID() %>.jpg" title="<%=list.getTitle() %>" class="img-responsive"
					alt=" ">
					<div class="w3l-action-icon">
						<i class="fa fa-play-circle-o" aria-hidden="true"></i>
					</div> </a>
				<div class="mid-1 agileits_w3layouts_mid_1_home">
					<div class="w3l-movie-text">
						<h6>
							<a href="single.jsp?movieID=<%=list.getMovieID()%>"><%=list.getTitle() %></a>
						</h6>
					</div>
					<div class="mid-2 agile_mid_2_home">
						<p><%=list.getRelaseYear()%></p>
						<div class="block-stars">
							<ul class="w3l-ratings">
								<li><a href="#"><i class="fa fa-star"
										aria-hidden="true"></i></a></li>
								<li><a href="#"><i class="fa fa-star"
										aria-hidden="true"></i></a></li>
								<li><a href="#"><i class="fa fa-star-half-o"
										aria-hidden="true"></i></a></li>
								<li><a href="#"><i class="fa fa-star-o"
										aria-hidden="true"></i></a></li>
								<li><a href="#"><i class="fa fa-star-o"
										aria-hidden="true"></i></a></li>
							</ul>
						</div>
						<div class="clearfix"></div>
					</div>
				</div>
				<div class="ribben one">
					<p>NEW</p>
				</div>
			</div>

		<%} %>

			<div class="clearfix"></div>
		</div>
		<!--//tv-movies-->

		<div class="blog-pagenat-wthree">
			<ul>
			<%if(pages == 1) { %>
				<li><a class="frist" href="#">Prev</a></li>
				<%} else { %> 
				<li><a class="frist" href="country.jsp?countryID<%=countryID%>&pages=<%=pages-1%>">Prev</a></li>
				<%} %>
				<% double numberOfPages = total/15.0;
					if(numberOfPages - (int) numberOfPages != 0) {
						numberOfPages++;
					}
				%>
				<%for(int i = 1; i<=((int) numberOfPages);i++) { %>
				<li><a href="country.jsp?countryID=<%=countryID%>&pages=<%=i%>"><%=i %></a></li>
			<%} %>
			<%if(pages == (int) numberOfPages)  {%>
				<li><a class="last" href="#">Next</a></li>
				<%} else { %>
					<li><a class="last" href="country.jsp?countryID=<%=countryID%>&pages=<%=pages+1%>">Next</a></li>
				<%} %>
			</ul>


		</div>
	</div>
</div>
<!--//content-inner-section-->
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
<script src="js/bootstrap.js"></script>



</body>
</html>






















