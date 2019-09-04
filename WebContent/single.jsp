
<%@page import="dao.CrewDAO"%>
<%@page import="model.Cast"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.CastDAO"%>
<%@page import="model.Crew"%>
<%@page import="model.User"%>
<%@page import="model.Category"%>
<%@page import="model.Movie"%>
<%@page import="dao.MovieDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	MovieDAO movieDAO = new MovieDAO();
	String movieID = request.getParameter("movieID");
	if (movieID == null) {
%>
<jsp:forward page="index.jsp"></jsp:forward>
<%
	}
%>
<%
	long idMovie =0;
	try {
		idMovie = Long.parseLong(movieID);
	} catch (NumberFormatException e) {
%>
<jsp:forward page="index.jsp"></jsp:forward>
<%
	}
%>

<%

	Movie movie = movieDAO.getMovie(idMovie);
	movieDAO.increaseCountView(idMovie);
	User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
<title><%=movie.getTitle() %></title>
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
			<li><%=movie.getTitle() %></li>
		</ul>
	</div>
</div>
<!-- //breadcrumb -->
<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v2.9&appId=1889957587913297";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>
<!--/content-inner-section-->
<div class="w3_content_agilleinfo_inner">
	<div class="agile_featured_movies">
		<!-- 		<div class="inner-agile-w3l-part-head">
			<h3 class="w3l-inner-h-title">Single Page</h3>
			<p class="w3ls_head_para">Add short Description</p>
		</div>
 -->
		<div class="latest-news-agile-info">
			<div class="col-md-12 latest-news-agile-left-content">
				<div class="single video_agile_player">
					<div class="video-grid-single-page-agileits">
						<div data-video="<%=movie.getLink()%>" id="video">
							<img style="width:100%; height:500px" src="<%=movie.getMovieImage()%>" alt=""
								class="img-responsive" />
						</div>
					</div>
				</div>
				<br/>
				<br/>
				<div class="container ">
				<br/>
				<div class="row">
				
					<%if(user != null) {%>
					<div class="col-md-2">
					<button id="faviButton" style="    outline: none;
    background: #fe423f;
    color: #fff;
    font-size: 0.9em;
    border: none; margin-top:15px"><i class="fa fa-heart" aria-hidden="true"></i> Yêu thích</button> </div><%} %>
   
    <div class = "col-md-2">
    <div class="fb-share-button" data-href="http://2017-nhom006.azurewebsites.net/single.jsp?movieID=<%=movieID %>" data-layout="button_count" data-size="small" data-mobile-iframe="true"><a class="fb-xfbml-parse-ignore" target="_blank" href="https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Fdevelopers.facebook.com%2Fdocs%2Fplugins%2F&amp;src=sdkpreparse">Chia sẻ</a></div>
    </div>
    </div>
				</div>
				<div class="col-md-4 latest-news-agile-left-content">
					<br />
					<div class="video_agile_player sidebar-player">
						<div class="player-text side-bar-info">
							<p class="fexi_header"><%=movie.getTitle()%></p>
							<p class="fexi_header_para">
								<span class="conjuring_w3">Story Line </span><%=movie.getMovieDescription()%>
							</p>
							<p class="fexi_header_para">
								<span>Release On</span><%=movie.getRelaseYear()%>
							</p>
							<p class="fexi_header_para">
								<span>Genres </span> 
								<%int k = 0;
								for(Category cList :movie.getCategory())  {%>
								<a href="genre.jsp?categoryID=<%=cList.getId()%>&pages=1"><%=cList.getName() %></a> 
								<%if(k !=movie.getCategory().size()-1 )  {%>
								| 
								<%} %>
								<%k++;} %>
							</p>
							<p class="fexi_header_para">
								<span>Diễn viên</span><%
								CastDAO castDAO = new CastDAO();
								CrewDAO crewDAO = new CrewDAO();
								ArrayList<Cast> listCasts = castDAO.getListCastByMovie(idMovie);
								for(int z = 0; z < listCasts.size(); z++ )  {%>
								<%=crewDAO.getCrew(listCasts.get(z).getCrew().getCrewID()).getCrewFirstName() + " " +crewDAO.getCrew(listCasts.get(z).getCrew().getCrewID()).getCrewLastName() %>
								<%if(z !=movie.getCategory().size()-1 )  {%>
								| 
								<%} %>
								<%} %>
							</p>
							<p class="fexi_header_para">
								<span>Lượt xem</span><%=movie.getCountView()%>
							</p>
							<p class="fexi_header_para">
								<span>Rating </span><%=movie.getRating()%>
							</p>
							<p class="fexi_header_para fexi_header_para1">
								<span>Star Rating</span> <a href="#"><i class="fa fa-star"
									aria-hidden="true"></i></a> <a href="#"><i class="fa fa-star"
									aria-hidden="true"></i></a> <a href="#"><i
									class="fa fa-star-half-o" aria-hidden="true"></i></a> <a href="#"><i
									class="fa fa-star-o" aria-hidden="true"></i></a> <a href="#"><i
									class="fa fa-star-o" aria-hidden="true"></i></a>
							</p>
						</div>

					</div>
				</div>

				<div class="col-md-8 latest-news-agile-right-content">
					<br />
					<div class="fb-comments"
						data-href="http://2017-nhom006.azurewebsites.net/single.jsp?movieID=<%=movie.getMovieID() %>"
						data-numposts="5"></div>
				</div>
			</div>



		</div>
		<div class="clearfix"></div>
	</div>

</div>
<!--//content-inner-section-->
<jsp:include page="includes/footer.jsp"></jsp:include>





<a href="#home" id="toTop" class="scroll" style="display: block;"> <span
	id="toTopHover" style="opacity: 1;"> </span>
</a>

<script src="js/jquery-1.11.1.min.js"></script>
<%if(user!=null) { %>
<script>
$(document).ready(function() {
	$('#faviButton').click(function() {	
		$.ajax({
			  url: "<%=request.getContextPath()%>/FaviAjax",
			  type: "get", //send it through get method
			  data: { 
			  	action:'add', 
				movieID:<%=movieID%>,
			  	userID:<%=user.getUserID()%>
			  },
			  success: function(response) {
			  },
			  error: function(xhr) {
			    //Do Something to handle error
			  }
		});
		 $("#faviButton").hide("slow", function(){
	            $(this).show("slow")
	        });
	});
});
</script>
<%} %> 
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






















