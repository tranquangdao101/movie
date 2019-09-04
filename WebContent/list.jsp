<%@page import="model.Category"%>
<%@page import="dao.CategoryDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.MovieDAO"%>
<%@page import="model.Movie"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Movie List</title>
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
<link rel="stylesheet" type="text/css" href="css/table-style.css" />
<link rel="stylesheet" type="text/css" href="css/basictable.css" />
<!-- list-css -->
<link rel="stylesheet" href="css/list.css" type="text/css" media="all" />
<!-- //list-css -->
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
	MovieDAO mDAO = new MovieDAO();
%>


<jsp:include page="includes/header.jsp"></jsp:include>
<jsp:include page="includes/header_bottom.jsp"></jsp:include>
<!-- breadcrumb -->
<div class="w3_breadcrumb">
	<div class="breadcrumb-inner">
		<ul>
			<li><a href="index.jsp">Home</a><i>//</i></li>
			<li>List</li>
		</ul>
	</div>
</div>
<!-- //breadcrumb -->


<!--/content-inner-section-->
<div class="w3_content_agilleinfo_inner">
	<div class="agile_featured_movies">
		<div class="inner-agile-w3l-part-head">
			<h3 class="w3l-inner-h-title">Movie List</h3>
			<p class="w3ls_head_para">Danh sách các bộ phim của trang</p>
		</div>
		<div class="bs-example bs-example-tabs" role="tabpanel"
			data-example-id="togglable-tabs">
			<ul id="myTab" class="nav nav-tabs" role="tablist">
				<li role="presentation" class="active"><a href="javascript:window.location.reload(true)"
					aria-expanded="true">ALL</a></li>
					<!-- id="home-tab" role="tab" data-toggle="tab" aria-controls="home" -->
				<li role="presentation"><a href="#a" role="tab" id="a-tab"
					data-toggle="tab" aria-controls="a">A</a></li>
				<li role="presentation"><a href="#b" role="tab" id="b-tab"
					data-toggle="tab" aria-controls="b">B</a></li>
				<li role="presentation"><a href="#c" role="tab" id="c-tab"
					data-toggle="tab" aria-controls="c">C</a></li>
				<li role="presentation"><a href="#d" role="tab" id="d-tab"
					data-toggle="tab" aria-controls="d">D</a></li>
				<li role="presentation"><a href="#e" role="tab" id="e-tab"
					data-toggle="tab" aria-controls="e">E</a></li>
				<li role="presentation"><a href="#f" role="tab" id="f-tab"
					data-toggle="tab" aria-controls="f">F</a></li>
				<li role="presentation"><a href="#g" role="tab" id="g-tab"
					data-toggle="tab" aria-controls="g">G</a></li>
				<li role="presentation"><a href="#h" role="tab" id="h-tab"
					data-toggle="tab" aria-controls="h">H</a></li>
				<li role="presentation"><a href="#i" role="tab" id="i-tab"
					data-toggle="tab" aria-controls="i">I</a></li>
				<li role="presentation"><a href="#j" role="tab" id="j-tab"
					data-toggle="tab" aria-controls="j">J</a></li>
				<li role="presentation"><a href="#k" role="tab" id="k-tab"
					data-toggle="tab" aria-controls="k">K</a></li>
				<li role="presentation"><a href="#l" role="tab" id="l-tab"
					data-toggle="tab" aria-controls="l">L</a></li>
				<li role="presentation"><a href="#m" role="tab" id="m-tab"
					data-toggle="tab" aria-controls="m">M</a></li>
				<li role="presentation"><a href="#n" role="tab" id="n-tab"
					data-toggle="tab" aria-controls="n">N</a></li>
				<li role="presentation"><a href="#o" role="tab" id="o-tab"
					data-toggle="tab" aria-controls="o">O</a></li>
				<li role="presentation"><a href="#p" role="tab" id="p-tab"
					data-toggle="tab" aria-controls="p">P</a></li>
				<li role="presentation"><a href="#q" role="tab" id="q-tab"
					data-toggle="tab" aria-controls="q">Q</a></li>
				<li role="presentation"><a href="#r" role="tab" id="r-tab"
					data-toggle="tab" aria-controls="r">R</a></li>
				<li role="presentation"><a href="#s" role="tab" id="s-tab"
					data-toggle="tab" aria-controls="s">S</a></li>
				<li role="presentation"><a href="#t" role="tab" id="t-tab"
					data-toggle="tab" aria-controls="t">T</a></li>
				<li role="presentation"><a href="#u" role="tab" id="u-tab"
					data-toggle="tab" aria-controls="u">U</a></li>
				<li role="presentation"><a href="#v" role="tab" id="v-tab"
					data-toggle="tab" aria-controls="v">V</a></li>
				<li role="presentation"><a href="#w" role="tab" id="w-tab"
					data-toggle="tab" aria-controls="w">W</a></li>
				<li role="presentation"><a href="#x" role="tab" id="x-tab"
					data-toggle="tab" aria-controls="x">X</a></li>
				<li role="presentation"><a href="#y" role="tab" id="y-tab"
					data-toggle="tab" aria-controls="y">Y</a></li>
				<li role="presentation"><a href="#z" role="tab" id="z-tab"
					data-toggle="tab" aria-controls="z">Z</a></li>
			</ul>
			<%
				ArrayList<Movie> listAll = mDAO.getListMovies();
			%>
			<div id="myTabContent" class="tab-content">
				<div role="tabpanel" class="tab-pane fade in active" id="home"
					aria-labelledby="home-tab">
					<div class="agile-news-table">
						<div class="w3ls-news-result">
							<h4>
								Search Results : <span><%=listAll.size()%></span>
							</h4>
						</div>
						<table id="table-breakpoint">
							<thead>
								<tr>
									<th>No.</th>
									<th>Movie Name</th>
									<th>Year</th>
									<th>Movie Length</th>
									<th>Genre</th>
									<th>Country</th>
								</tr>
							</thead>
							<tbody>
								<%
									for (int i = 0; i < listAll.size(); i++) {
								%>
								<tr>
									<td><%=i + 1%></td>
									<td class="w3-list-img"><a
										href="single.jsp?movieID=<%=listAll.get(i).getMovieID()%>"><img
											src="images/movie/m<%=listAll.get(i).getMovieID()%>.jpg"
											alt="" /> <span><%=listAll.get(i).getTitle()%></span></a></td>
									<td><%=listAll.get(i).getRelaseYear()%></td>
									<td class="w3-list-info"><a
										href="single.jsp<%=listAll.get(i).getMovieID()%>"><%=listAll.get(i).getMovieLength()%></a></td>
									<td>
									<%
									for(Category category : listAll.get(i).getCategory())
									{
									%>
									<%=category.getName() %>
									
									<%} %>
									
									</td>
									<td><%=listAll.get(i).getCountry().getCountryNameVN() %></td>
								</tr>
								<%
									}
								%>
							</tbody>
						</table>
					</div>
				</div>
				<%
					for (char i = 'a'; i <= 'z'; i++) {
						ArrayList<Movie> list = mDAO.getListMoviesBy(i);
				%>

				<div role="tabpanel" class="tab-pane fade" id="<%=(char) i%>"
					aria-labelledby="<%=(char) i%>-tab">
					<div class="agile-news-table">
						<div class="w3ls-news-result">
							<h4>
								Search Results : <span><%=list.size()%></span>
							</h4>
						</div>
						<table id="table-breakpoint<%=(int) (i - 'a'+1)%>">
							<thead>
								<tr>
									<th>No.</th>
									<th>Movie Name</th>
									<th>Year</th>
									<th>Movie Length</th>
									<th>Genre</th>
									<th>Country</th>
								</tr>
							</thead>
							<tbody>
								<%
									for (int k = 0; k < list.size(); k++) {
								%>
								<%
									Movie m = list.get(k);
								%>
								<tr>
									<td><%=k + 1%></td>
									<td class="w3-list-img"><a
										href="single.jsp?movieID=<%=m.getMovieID()%>"><img
											src="images/movie/m<%=m.getMovieID()%>.jpg" alt="" /> <span><%=m.getTitle()%></span></a></td>
									<td><%=m.getRelaseYear()%></td>
									<td class="w3-list-info"><a
										href="single.jsp<%=m.getMovieID()%>"><%=m.getMovieLength()%></a></td>
										<td>
									<%
									for(Category category : m.getCategory())
									{
									%>
									<%=category.getName() %>
									
									<%} %>
									
									</td>
									<td><%=m.getCountry().getCountryNameVN() %></td>
								</tr>
								<%
									}
								%>
							</tbody>
						</table>
					</div>
				</div>

				<%
					}
				%>
			</div>

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

<!-- tables -->
<script type="text/javascript" src="js/jquery.basictable.min.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		$('#table').basictable();
		$('#table-breakpoint').basictable({
			breakpoint : 768
		});
		$('#table-breakpoint1').basictable({
			breakpoint : 768
		});
		$('#table-breakpoint2').basictable({
			breakpoint : 768
		});
		$('#table-breakpoint3').basictable({
			breakpoint : 768
		});
		$('#table-breakpoint4').basictable({
			breakpoint : 768
		});
		$('#table-breakpoint5').basictable({
			breakpoint : 768
		});
		$('#table-breakpoint6').basictable({
			breakpoint : 768
		});
		$('#table-breakpoint7').basictable({
			breakpoint : 768
		});
		$('#table-breakpoint8').basictable({
			breakpoint : 768
		});
		$('#table-breakpoint9').basictable({
			breakpoint : 768
		});
		$('#table-breakpoint10').basictable({
			breakpoint : 768
		});
		$('#table-breakpoint11').basictable({
			breakpoint : 768
		});
		$('#table-breakpoint12').basictable({
			breakpoint : 768
		});
		$('#table-breakpoint13').basictable({
			breakpoint : 768
		});
		$('#table-breakpoint14').basictable({
			breakpoint : 768
		});
		$('#table-breakpoint15').basictable({
			breakpoint : 768
		});
		$('#table-breakpoint16').basictable({
			breakpoint : 768
		});
		$('#table-breakpoint17').basictable({
			breakpoint : 768
		});
		$('#table-breakpoint18').basictable({
			breakpoint : 768
		});
		$('#table-breakpoint19').basictable({
			breakpoint : 768
		});
		$('#table-breakpoint20').basictable({
			breakpoint : 768
		});
		$('#table-breakpoint21').basictable({
			breakpoint : 768
		});
		$('#table-breakpoint22').basictable({
			breakpoint : 768
		});
		$('#table-breakpoint23').basictable({
			breakpoint : 768
		});
		$('#table-breakpoint24').basictable({
			breakpoint : 768
		});
		$('#table-breakpoint25').basictable({
			breakpoint : 768
		});
		$('#table-breakpoint26').basictable({
			breakpoint : 768
		});
		$('#table-breakpoint27').basictable({
			breakpoint : 768
		});
	});
</script>
<!-- //tables -->


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