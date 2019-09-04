<%@page import="com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.CategoryChart"%>
<%@page import="dao.CategoryChartDAO"%>
<%@page import="model.Movie"%>
<%@page import="dao.MovieDAO"%>
<%@page import="dao.CategoryDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.User"%>
<%@page import="dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- META SECTION -->
<title>Movie Pro Admin</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1" />

<link rel="icon" href="favicon.ico" type="image/x-icon" />
<!-- END META SECTION -->
<%
	CategoryChartDAO ccDAO = new CategoryChartDAO();
	ArrayList<CategoryChart> listChart = ccDAO.getListAll();
	String startDate = request.getParameter("startDate");
	String endDate = request.getParameter("endDate");
	if(startDate != null && endDate !=null) {
		SimpleDateFormat sdf = new SimpleDateFormat("MM-dd-yyyy");
		Date start = sdf.parse(startDate);
		Date end = sdf.parse(endDate);
		listChart = ccDAO.getListAll(start, end);
	}
%>


<!-- CSS INCLUDE -->
<link rel="stylesheet" type="text/css" id="theme"
	href="<%=request.getContextPath()%>/admin/css/theme-default.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/admin/css/multiselect/bootstrap-select.css">
<script
	src="<%=request.getContextPath()%>/admin/js/plugins/amcharts/amcharts.js"
	type="text/javascript"></script>
<script
	src="<%=request.getContextPath()%>/admin/js/plugins/amcharts/pie.js"
	type="text/javascript"></script>
<%-- 	 <!-- load Google AJAX API -->
        <script type="text/javascript" src="http://www.google.com/jsapi"></script>
         <script type="text/javascript">
            // Load the Visualization API and the piechart package.
            google.load('visualization', '1', {'packages': ['columnchart']});

            // Set a callback to run when the Google Visualization API is loaded.
            google.setOnLoadCallback(drawChart);

            // Callback that creates and populates a data table,
            // instantiates the pie chart, passes in the data and
            // draws it.
            function drawChart() {

                // Create the data table.    
                var data = google.visualization.arrayToDataTable([
                    ['Thể loại', 'Số lượng phim theo thể loại'],
                    <%for(int i = 0; i< listChart.size();i++){%>
                    ['<%=listChart.get(i).getCategoryName()%>', <%=listChart.get(i).getNumberOfMovieInCategory()%>]
					<%if(i!=listChart.size()-1){%>
					,
					<%}%>
					
                    <%}%>
                ]);
                // Set chart options
                var options = {
                    'title': 'Biểu đồ thể hiện tỉ trọng số lượng phim theo từng thể loại',
                    is3D: true,
                    pieSliceText: 'label',
                    tooltip: {showColorCode: true},
                    'width': 700,
                    'height': 300
                };

                // Instantiate and draw our chart, passing in some options.
                var chart = new google.visualization.PieChart(document.getElementById('Chart2'));
                chart.draw(data, options);
            }
        </script> --%>
<!-- EOF CSS INCLUDE -->
<!-- SHOW MORE -->

<script>
            var chart;
            var legend;

            var chartData = [
				 <%for (int i = 0; i < listChart.size(); i++) {%>
				 {
	                    "Thể loại": "<%=listChart.get(i).getCategoryName()%>",
	                    "Số lượng": <%=listChart.get(i).getNumberOfMovieInCategory()%>
	                }
				 <%if (i != listChart.size() - 1) {%>
				 ,
					<%}%>
				<%}%>
            	
            ];

            AmCharts.ready(function () {
                // PIE CHART
                chart = new AmCharts.AmPieChart();
                chart.dataProvider = chartData;
                chart.titleField = "Thể loại";
                chart.valueField = "Số lượng";
                chart.gradientRatio = [0, 0, 0 ,-0.2, -0.4];
                chart.gradientType = "radial";

                // LEGEND
                legend = new AmCharts.AmLegend();
                legend.align = "center";
                legend.markerType = "circle";
                chart.balloonText = "[[title]]<br><span style='font-size:14px'><b>[[value]]</b> ([[percents]]%)</span>";
                chart.addLegend(legend);

                // WRITE
                chart.write("chartdiv");
            });

            // changes label position (labelRadius)
            function setLabelPosition() {
                if (document.getElementById("rb1").checked) {
                    chart.labelRadius = 30;
                    chart.labelText = "[[title]]: [[value]]";
                } else {
                    chart.labelRadius = -30;
                    chart.labelText = "[[percents]]%";
                }
                chart.validateNow();
            }


            // makes chart 2D/3D
            function set3D() {
                if (document.getElementById("rb3").checked) {
                    chart.depth3D = 10;
                    chart.angle = 10;
                } else {
                    chart.depth3D = 0;
                    chart.angle = 0;
                }
                chart.validateNow();
            }

            // changes switch of the legend (x or v)
            function setSwitch() {
                if (document.getElementById("rb5").checked) {
                    legend.switchType = "x";
                } else {
                    legend.switchType = "v";
                }
                legend.validateNow();
            }
        </script>

<style>
.morecontent span {
	display: none;
}

.morelink {
	display: block;
}
</style>
<!-- END SHOW MORE -->
</head>
<body>
	<%
		if ((User) session.getAttribute("user") == null) {
			response.sendRedirect("login.jsp");
		}
	%>



	<!-- START PAGE CONTAINER -->
	<div class="page-container">
		<!-- START PAGE SIDEBAR -->
		<jsp:include page="include/sidebar.jsp"></jsp:include>
		<!-- END PAGE SIDEBAR -->

		<!-- PAGE CONTENT -->
		<div class="page-content">

			<!-- START X-NAVIGATION VERTICAL -->
			<jsp:include page="include/navigation.jsp"></jsp:include>
			<!-- END X-NAVIGATION VERTICAL -->

			<!-- START BREADCRUMB -->
			<ul class="breadcrumb">
				<li><a href="#">Home</a></li>
				<li class="active">Quản lý phim</li>
			</ul>
			<!-- END BREADCRUMB -->

			<!-- PAGE TITLE -->
			<div class="page-title">
				<h2>
					<span class="fa fa-arrow-circle-o-left"></span> Quản lý phim
				</h2>
			</div>
			<!-- END PAGE TITLE -->

			<!-- PAGE CONTENT WRAPPER -->
			<div class="page-content-wrap">

				<div class="row">
					<div class="col-md-12">

						<!-- START SPARKLINE CHARTS -->
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">Biểu đồ thể hiện tỉ trọng thể loại
									phim</h3>
									<ul class="panel-controls panel-controls-title">                                        
                                        <li>
                                            <div id="reportrange" class="dtrange">                                            
                                                <span></span><b class="caret"></b>
                                            </div>                                     
                                        </li>                                
                                    </ul>                
							</div>
							<div class="panel-body">
								<div class="block-content">
									<div class="col-md-6">
										<table id="" class="table ">
											<thead>
												<tr>
													<th>Tên thể loại</th>
													<th>Số lượng</th>
												</tr>
											</thead>
											<%
												for (int i = 0; i < listChart.size(); i++) {
											%>
											<tr>
												<th><%=listChart.get(i).getCategoryName()%></th>
												<td><%=listChart.get(i).getNumberOfMovieInCategory()%></td>
											</tr>
											<%
												}
											%>
											<tr>
												<th>Tổng cộng</th>
												<td><%=ccDAO.sumAll(listChart)%></td>
											</tr>
										</table>
									</div>
									<div class="row">
										<div class="col-md-6">
											<div id="chartdiv" style="width: 100%; height: 400px;"></div>
										</div>

									</div>
								</div>
							</div>
						</div>
						<!-- END SPARKLINE CHARTS -->


					</div>
				</div>

			</div>
			<!-- END PAGE CONTENT WRAPPER -->
		</div>
		<!-- END PAGE CONTENT -->
	</div>
	<!-- END PAGE CONTAINER -->


	<!-- START SCRIPTS -->
	<!-- START PLUGINS -->
	<script type="text/javascript" src="js/plugins/jquery/jquery.min.js"></script>
	<script type="text/javascript" src="js/plugins/jquery/jquery-ui.min.js"></script>
	<script type="text/javascript"
		src="js/plugins/bootstrap/bootstrap.min.js"></script>
	<script src="js/plugins/multiselect/bootstrap-select.js"></script>
	<!-- END PLUGINS -->
	<!--SHOW MORE -->
	<script>
		$(document)
				.ready(
						function() {
							// Configure/customize these variables.
							var showChar = 100; // How many characters are shown by default
							var ellipsestext = "...";
							var moretext = "nhiều hơn";
							var lesstext = "ít hơn";

							$('.more')
									.each(
											function() {
												var content = $(this).html();

												if (content.length > showChar) {

													var c = content.substr(0,
															showChar);
													var h = content.substr(
															showChar,
															content.length
																	- showChar);

													var html = c
															+ '<span class="moreellipses">'
															+ ellipsestext
															+ '&nbsp;</span><span class="morecontent"><span>'
															+ h
															+ '</span>&nbsp;&nbsp;<a href="" class="morelink">'
															+ moretext
															+ '</a></span>';

													$(this).html(html);
												}

											});

							$(".morelink").click(function() {
								if ($(this).hasClass("less")) {
									$(this).removeClass("less");
									$(this).html(moretext);
								} else {
									$(this).addClass("less");
									$(this).html(lesstext);
								}
								$(this).parent().prev().toggle();
								$(this).prev().toggle();
								return false;
							});
						});
	</script>
	<script>
	$('#reportrange').on('apply.daterangepicker', function(ev, picker) {
		  console.log(picker.startDate.format('YYYY-MM-DD'));
		  console.log('-----');
		  console.log(picker.endDate.format('YYYY-MM-DD')); 
		  location.href = location.href.split('?')[0]+'?startDate='+picker.startDate.format('MM-DD-YYYY')+'&endDate='+picker.endDate.format('MM-DD-YYYY')
		 <%--  $.ajax({
			  url: window.location.pathname,
			  type: "get", //send it through get method
			  data: { 
			  	startDate : picker.startDate.format('MM-DD-YYYY'),
			  	endDate : picker.endDate.format('MM-DD-YYYY')
			  },
			  success: function(response) {
				  <%
				  if(startDate != null && endDate !=null) {
						SimpleDateFormat sdf = new SimpleDateFormat("MM-dd-yyyy");
						Date start = sdf.parse(startDate);
						Date end = sdf.parse(endDate);
						listChart = ccDAO.getListAll(start, end);
						try {
							for (CategoryChart c : listChart) {
								System.out.println(c.getCategoryName());
								System.out.println(c.getNumberOfMovieInCategory());
							}
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				  %>
			  },
			  error: function(xhr) {
			  }
		}); --%>
	});
	</script>
	<!-- END SHOW MORE -->
	<!-- START THIS PAGE PLUGINS-->
	<script type='text/javascript' src='js/plugins/icheck/icheck.min.js'></script>
	<script type="text/javascript"
		src="js/plugins/mcustomscrollbar/jquery.mCustomScrollbar.min.js"></script>
	<!-- END THIS PAGE PLUGINS-->

	<!-- START TEMPLATE -->
	<script type="text/javascript" src="js/settings.js"></script>
	<script type="text/javascript" src="js/plugins.js"></script>
	<script type="text/javascript" src="js/actions.js"></script>
	<!-- END TEMPLATE -->
	<!-- END SCRIPTS -->
	<script type='text/javascript' src='<%=request.getContextPath() %>/admin/js/plugins/bootstrap/bootstrap-datepicker.js'></script>  
	 <script type="text/javascript" src="<%=request.getContextPath() %>/admin/js/plugins/moment.min.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath() %>/admin/js/plugins/daterangepicker/daterangepicker.js"></script>
	 <script type="text/javascript" src="<%=request.getContextPath() %>/admin/js/demo_dashboard.js"></script>
</body>
</html>






