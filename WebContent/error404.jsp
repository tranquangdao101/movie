<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>404 not found</title>
<style>
body{
background-color: white;
color: red;
text-align: center;
}
input[type=text] {
width: 500px;
height: 50px;
font-size: 25px;
}
img{
width: 500px;
height: 300px;
}

</style>

</head>
<body>
<h1>Xin lỗi,trang bạn tìm không tồn tại!</h1>
<h2>Điều này xảy ra khi bạn nhập không đúng đường dẫn hoặc trang này không tồn tại nữa !</h2>
<img src="<%=request.getContextPath() %>/images/404.png">
<br/>
<h2>Rất tiếc chúng tôi không thể tìm thấy trang bạn đang tìm kiếm,vui lòng bạn <span class="glyphicon glyphicon-arrow-left"></span><a href="index.jsp"> quay trở lại trang chủ</a> và tiếp tục xem phim
</h2>


</body>
</html>