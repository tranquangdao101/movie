<%@page import="model.Category"%>
<%@page import="model.Movie"%>
<%@page import="dao.MovieDAO"%>
<%@page import="dao.CategoryDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.User"%>
<%@page import="dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
table {
	border: solid black 3px;
}

.search-form .form-group {
	float: right !important;
	transition: all 0.35s, border-radius 0s;
	width: 32px;
	height: 32px;
	background-color: #fff;
	box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset;
	border-radius: 25px;
	border: 1px solid #ccc;
}

.search-form .form-group input.form-control {
	padding-right: 20px;
	border: 0 none;
	background: transparent;
	box-shadow: none;
	display: block;
}

.search-form .form-group input.form-control::-webkit-input-placeholder {
	display: none;
}

.search-form .form-group input.form-control:-moz-placeholder {
	display: none;
}

.search-form .form-group input.form-control::-moz-placeholder {
	display: none;
}

.search-form .form-group input.form-control:-ms-input-placeholder {
	display: none;
}

.search-form .form-group:hover, .search-form .form-group.hover {
	width: 100%;
	border-radius: 4px 25px 25px 4px;
}

.search-form .form-group span.form-control-feedback {
	position: absolute;
	top: -1px;
	right: -2px;
	z-index: 2;
	display: block;
	width: 34px;
	height: 34px;
	line-height: 34px;
	text-align: center;
	color: #3596e0;
	left: initial;
	font-size: 14px;
}
</style>
<jsp:include page="includes/heading.jsp"></jsp:include>



<jsp:include page="includes/navbar.jsp"></jsp:include>
<div id="page-wrapper">
	<h1 align="center">
		<b>Danh sách thể loại</b>
	</h1>
	<div class="row">
		<div class="col-md-5 col-md-offset-4">
			<div class="form-group has-feedback">
				<label for="search" class="sr-only">Search</label> <input
					type="text" class="form-control" name="search" id="search"
					placeholder="search"> <span
					class="glyphicon glyphicon-search form-control-feedback"></span>
			</div>
		</div>
		<div class="col-md-2">
			<button type="button" class="btn btn-success" data-toggle="modal"
				data-target="#modaladd">
				<span class="glyphicon glyphicon-plus"></span> Thêm thể loại phim
			</button>
		</div>
	</div>
	<table class="table table-hover" id="mytable">
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
						data-toggle="modal" data-target="#detail<%=i%>">Chi tiết</button>
					<button type="button" class="btn btn-warning" data-toggle="modal"
						data-target="#edit<%=i%>">Sửa thông tin</button> <a
					class="btn btn-danger"
					href="MovieCotroller?action=delete&cateID=<%=listCategory.get(i).getId()%>">Xóa
						thể loại này</a></td>

				<%-- <button type="button" class="btn btn-danger" data-toogle="modal"
						data-target="#delete<%=i%>">Xóa tài khoản</button></td> --%>
			</tr>
			<%
				}
			%>
		</tbody>
	</table>
</div>

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
						value="<%=listCategory.get(i).getName()%>">
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
		<form action="UserController" method="post">
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
							name="addUserName" placeholder="Tên thể loại">
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


<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>


<script>
	// Write on keyup event of keyword input element
	$(document).ready(
			function() {
				$("#search").keyup(
						function() {
							_this = this;
							// Show only matching TR, hide rest of them
							$.each($("#mytable tbody tr"), function() {
								if ($(this).text().toLowerCase().indexOf(
										$(_this).val().toLowerCase()) === -1)
									$(this).hide();
								else
									$(this).show();
							});
						});
			});
</script>
<jsp:include page="includes/footer.jsp"></jsp:include>
