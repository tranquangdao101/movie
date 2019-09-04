 <%@page import="model.Category"%>
<%User user = (User) session.getAttribute("user");
    if(user == null) {
    	response.sendRedirect(request.getContextPath()+"/index.jsp");
    }%>
<%@page import="model.Movie"%>
<%@page import="dao.MovieDAO"%>
<%@page import="model.Category"%>
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

<!-- CSS INCLUDE -->
<link rel="stylesheet" type="text/css" id="theme"
	href="css/theme-default.css" />
<!-- EOF CSS INCLUDE -->
<!-- SHOW MORE -->
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
				<li class="active">Quản lý thể loại</li>
			</ul>
			<!-- END BREADCRUMB -->

			<!-- PAGE TITLE -->
			<div class="page-title">
				<h2>
					<span class="fa fa-arrow-circle-o-left"></span> Quản lý thể loại
				</h2>
			</div>
			<!-- END PAGE TITLE -->

			<!-- PAGE CONTENT WRAPPER -->
			<div class="page-content-wrap">

				<div class="row">
					<div class="col-md-12">

						<!-- START DEFAULT DATATABLE -->
						<div class="panel panel-default">
							<div class="panel-heading">
								<div class="btn-group pull-left">
									<button class="btn btn-danger dropdown-toggle"
										data-toggle="dropdown">
										<i class="fa fa-bars"></i> Export Data
									</button>
									<ul class="dropdown-menu">
										<li><a href="#"
											onClick="$('#customers2').tableExport({type:'json',escape:'true',ignoreColumn:'[2]'});"><img
												src='img/icons/json.png' width="24" /> JSON</a></li>
										<li><a href="#"
											onClick="$('#customers2').tableExport({type:'json',escape:'true',ignoreColumn:'[2]'});"><img
												src='img/icons/json.png' width="24" /> JSON (ignoreColumn)</a></li>
										<li><a href="#"
											onClick="$('#customers2').tableExport({type:'json',escape:'true',ignoreColumn:'[2]'});"><img
												src='img/icons/json.png' width="24" /> JSON (with Escape)</a></li>
										<li class="divider"></li>
										<li><a href="#"
											onClick="$('#customers2').tableExport({type:'xml',escape:'true',ignoreColumn:'[2]'});"><img
												src='img/icons/xml.png' width="24" /> XML</a></li>
										<li><a href="#"
											onClick="$('#customers2').tableExport({type:'sql',ignoreColumn:'[6]'});"><img
												src='img/icons/sql.png' width="24" /> SQL</a></li>
										<li class="divider"></li>
										<li><a href="#"
											onClick="$('#customers2').tableExport({type:'csv',escape:'true',ignoreColumn:'[2]'});"><img
												src='img/icons/csv.png' width="24" /> CSV</a></li>
										<li><a href="#"
											onClick="$('#customers2').tableExport({type:'txt',escape:'true',ignoreColumn:'[2]'});"><img
												src='img/icons/txt.png' width="24" /> TXT</a></li>
										<li class="divider"></li>
										<li><a href="#"
											onClick="$('#customers2').tableExport({type:'excel',escape:'true',ignoreColumn:'[2]'});"><img
												src='img/icons/xls.png' width="24" /> XLS</a></li>
										<li><a href="#"
											onClick="$('#customers2').tableExport({type:'doc',escape:'true',ignoreColumn:'[2]'});"><img
												src='img/icons/word.png' width="24" /> Word</a></li>
										<li><a href="#"
											onClick="$('#customers2').tableExport({type:'powerpoint',escape:'true',ignoreColumn:'[2]'});"><img
												src='img/icons/ppt.png' width="24" /> PowerPoint</a></li>
										<li class="divider"></li>
										<li><a href="#"
											onClick="$('#customers2').tableExport({type:'png',escape:'true',ignoreColumn:'[2]'});"><img
												src='img/icons/png.png' width="24" /> PNG</a></li>
										<li><a href="#"
											onClick="$('#customers2').tableExport({type:'pdf',escape:'true',ignoreColumn:'[2]'});"><img
												src='img/icons/pdf.png' width="24" /> PDF</a></li>
									</ul>
								</div>
										<button class="btn btn-primary" data-toggle="modal"
				data-target="#modaladd">
				<span class="glyphicon glyphicon-plus"></span> Thêm thể loại
			</button>
								<ul class="panel-controls">
									<li><a href="#" class="panel-collapse"><span
											class="fa fa-angle-down"></span></a></li>
									<li><a href="#" class="panel-refresh"><span
											class="fa fa-refresh"></span></a></li>
									<li><a href="#" class="panel-remove"><span
											class="fa fa-times"></span></a></li>
								</ul>
							</div>
							<div class="panel-body">
								<table id="customers2" class="table datatable">
									<thead>
										<tr>
											<th>ID</th>
											<th>Tên thể loại</th>
											<th>Thao tác</th>
										</tr>
									</thead>
									<tbody>
										<%
				CategoryDAO cDAO = new CategoryDAO();
				ArrayList<Category> listCategory = new ArrayList<Category>();
				listCategory = cDAO.getListCategory();
				for (int i = 0; i < listCategory.size(); i++) {
			%>
										<tr>
												<td><%=listCategory.get(i).getId()%></td>
				<td><%=listCategory.get(i).getName()%></td>
				<td><button type="button" class="btn btn-primary"
						data-toggle="modal" data-target="#detail<%=i%>"><span class="glyphicon glyphicon-info-sign"></span> Chi
													tiết</button>
					<button type="button" class="btn btn-warning" data-toggle="modal"
						data-target="#edit<%=i%>"><span class="glyphicon glyphicon-edit"></span> Sửa</button> <a
					class="btn btn-danger"
					href="<%=request.getContextPath() %>/CategoryController?action=delete&cateID=<%=listCategory.get(i).getId()%>"><span
													class="glyphicon glyphicon-trash"></span> Xóa</a></td>

										</tr>
										<%
											}
										%>
									</tbody>
								</table>
							</div>
						</div>
						<!-- END DEFAULT DATATABLE -->


					</div>
				</div>

			</div>
			<!-- END PAGE CONTENT WRAPPER -->
		</div>
		<!-- END PAGE CONTENT -->
	</div>
	<!-- END PAGE CONTAINER -->

	<%
	for (int i = 0; i < listCategory.size(); i++) {
%>


<div class="modal fade" id="detail<%=i%>" role="dialog">
	<div class="modal-dialog">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Chi tiết thông tin thể loại</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label for="inputdefault">ID</label> <input
						class="form-control" id="inputdefault" type="text"
						value="<%=listCategory.get(i).getId()%>" readonly="readonly">
				</div>
				<div class="form-group">
					<label for="inputdefault">Tên phim</label> <input
						class="form-control" id="inputdefault" type="text"
						value="<%=listCategory.get(i).getName()%>"
						readonly="readonly">
				</div>
			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
			</div>
		</div>

	</div>
</div>

<div class="modal fade" id="edit<%=i%>" role="dialog">
	<div class="modal-dialog">
		<!-- Modal content-->
		<form action="MovieController" method="get">
			<input type="hidden" name="action" value="edit" />
			<input type="hidden" name="cateID" value="<%=listCategory.get(i).getId()%>" />
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Sửa thông tin thể loại</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
					<label for="inputdefault">ID</label> <input
						class="form-control" id="inputdefault" type="text"
						value="<%=listCategory.get(i).getId()%>" readonly="readonly">
				</div>
				<div class="form-group">
					<label for="inputdefault">Tên phim</label> <input
						class="form-control" id="inputdefault" type="text"
						name="categoryName" value="<%=listCategory.get(i).getName()%>">
				</div>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-default">Xác nhận</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
				</div>
			</div>
		</form>
	</div>
</div>

<%
	}
%>
	<div class="modal fade" id="modaladd" role="dialog">
	<div class="modal-dialog">
		<!-- Modal content-->
		<form action="<%=request.getContextPath()%>/CategoryController" method="post">
			<input type="hidden" name="action" value="add" />
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Thêm thể loại</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="inputdefault">Tên thể loại</label> <input
							class="form-control" id="inputdefault" type="text"
							name="categoryName" placeholder="Tên thể loại">
					</div>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-default">Thêm</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Hủy</button>
				</div>
			</div>
		</form>
	</div>
</div>




	<!-- START SCRIPTS -->
	<!-- START PLUGINS -->
	<script type="text/javascript" src="js/plugins/jquery/jquery.min.js"></script>
	<script type="text/javascript" src="js/plugins/jquery/jquery-ui.min.js"></script>
	<script type="text/javascript"
		src="js/plugins/bootstrap/bootstrap.min.js"></script>
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
	<!-- END SHOW MORE -->
	<!-- START THIS PAGE PLUGINS-->
	<script type='text/javascript' src='js/plugins/icheck/icheck.min.js'></script>
	<script type="text/javascript"
		src="js/plugins/mcustomscrollbar/jquery.mCustomScrollbar.min.js"></script>
	<script type="text/javascript"
		src="js/plugins/datatables/jquery.dataTables.min.js"></script>
	<script type="text/javascript"
		src="js/plugins/tableexport/tableExport.js"></script>
	<script type="text/javascript"
		src="js/plugins/tableexport/jquery.base64.js"></script>
	<script type="text/javascript"
		src="js/plugins/tableexport/html2canvas.js"></script>
	<script type="text/javascript"
		src="js/plugins/tableexport/jspdf/libs/sprintf.js"></script>
	<script type="text/javascript"
		src="js/plugins/tableexport/jspdf/jspdf.js"></script>
	<script type="text/javascript"
		src="js/plugins/tableexport/jspdf/libs/base64.js"></script>
	<!-- END THIS PAGE PLUGINS-->

	<!-- START TEMPLATE -->
	<script type="text/javascript" src="js/settings.js"></script>

	<script type="text/javascript" src="js/plugins.js"></script>
	<script type="text/javascript" src="js/actions.js"></script>
	<!-- END TEMPLATE -->
	<!-- END SCRIPTS -->
</body>
</html>






