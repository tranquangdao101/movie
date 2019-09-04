<%@page import="dao.CountryDAO"%>
<%@page import="model.Country"%>
<%@page import="i18n.UTF8Control"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="java.util.Locale"%>
<%@page import="model.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.CategoryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
						String flanguage = request.getParameter("language");
						if(flanguage != null)
							session.setAttribute("language", flanguage);
					%>
<%
	CategoryDAO cDAO = new CategoryDAO();
	ArrayList<Category> cList = cDAO.getListCategory();
	double maxItemInOneLine = cList.size() / 3.0;
	int maxI;
	maxI = (int) maxItemInOneLine;
	if (maxItemInOneLine - ((int) maxItemInOneLine) != 0) {
		maxI++;
	}
	CountryDAO countryDAO = new CountryDAO();
	ArrayList<Country> countryList = countryDAO.getListCountry();
	double maxItemInOneLineCountryList = countryList.size() / 3.0;
	int maxICountry = (int) maxItemInOneLine;
	if(maxItemInOneLine - ((int) maxItemInOneLine) != 0) {
		maxICountry++;
	}
	//System.out.print(locale.getISO3Language());
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
	
	//System.out.print(locale.getISO3Language());
	UTF8Control utf8control = new UTF8Control();
	ResourceBundle bundle = ResourceBundle.getBundle("i18n.lang",locale,utf8control);
%>
<script src="js/jquery-1.11.1.min.js"></script>
<!--/header-w3l-->
<div class="header-w3-agileits" id="home">
	<div class="inner-header-agile part2">
		<nav class="navbar navbar-default">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<h1>
					<a href="index.jsp"><span>M</span>ovies <span>P</span>ro</a>
				</h1>
			</div>
			<!-- navbar-header -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li><a href="index.jsp"><%=bundle.getString("home")%></a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown"><%=bundle.getString("genre") %> <b class="caret"></b></a>
						<ul class="dropdown-menu multi-column columns-3">
							<li>
							<%
							int i = 0;
							for(Category list :cList) { %>
								
								<%if(i%maxI ==0)  {%>
								<div class="col-sm-4">
									<ul class="multi-column-dropdown">
								<%} %>
								
										<li><a href="genre.jsp?categoryID=<%=cList.get(i).getId()%>&pages=1"><%=cList.get(i).getName() %></a></li>
								
								<%if((i+1)%maxI==0 || i == cList.size()-1) { %>	
									</ul>
								</div>
								<% } %>
								
								<%i++;} %>
								<div class="clearfix"></div>
							</li>
						</ul></li>
						<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown"><%=bundle.getString("country") %> <b class="caret"></b></a>
						<ul class="dropdown-menu multi-column columns-3">
							<li>
							<%
							int j = 0;
							for(Country list :countryList) { %>
								
								<%if(j%maxICountry ==0)  {%>
								<div class="col-sm-4">
									<ul class="multi-column-dropdown">
								<%} %>
								
										<li><a href="country.jsp?countryID=<%=countryList.get(j).getCountryID()%>&pages=1"><%=countryList.get(j).getCountryName() %></a></li>
								
								<%if((j+1)%maxICountry==0 || j == countryList.size()-1) { %>	
									</ul>
								</div>
								<% } %>
								
								<%j++;} %>
								<div class="clearfix"></div>
							</li>
						</ul></li>
			<%-- 		<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown"><%=bundle.getString("country") %> <b class="caret"></b></a>
						<ul class="dropdown-menu multi-column columns-3">
							<li>
								<div class="col-sm-4">
									<ul class="multi-column-dropdown">
										<li><a href="genre.jsp"><%=bundle.getString("asia") %></a></li>
										<li><a href="genre.jsp"><%=bundle.getString("france") %></a></li>
										<li><a href="genre.jsp"><%=bundle.getString("taiwan") %></a></li>
										<li><a href="genre.jsp"><%=bundle.getString("US") %></a></li>
									</ul>
								</div>
								<div class="col-sm-4">
									<ul class="multi-column-dropdown">
										<li><a href="genre.jsp"><%=bundle.getString("china")%></a></li>
										<li><a href="genre.jsp"><%=bundle.getString("HongCong")%></a></li>
										<li><a href="genre.jsp"><%=bundle.getString("japan")%></a></li>
										<li><a href="genre.jsp"><%=bundle.getString("thailand")%></a></li>
									</ul>
								</div>
								<div class="col-sm-4">
									<ul class="multi-column-dropdown">
										<li><a href="genre.jsp"><%=bundle.getString("euro")%></a></li>
										<li><a href="genre.jsp"><%=bundle.getString("idian")%></a></li>
										<li><a href="genre.jsp"><%=bundle.getString("korea")%></a></li>
										<li><a href="genre.jsp"><%=bundle.getString("UK")%></a></li>
									</ul>
								</div>
								<div class="clearfix"></div>
							</li>
						</ul></li> --%>
					<li><a href="list.jsp"><%=bundle.getString("azList") %></a></li>
					<%-- <li><a href="contact.jsp"><%=bundle.getString("contact") %></a></li> --%>
					<li><a href="groupdiary.jsp"><%=bundle.getString("groupDiary") %></a></li>
					<li><a href="<%=request.getContextPath()%>/adminlogin">Admin</a></li>
				</ul>

			</div>
			<div class="clearfix"></div>
		</nav>
		<div class="w3ls_search">
			<div class="cd-main-header">
				<ul class="cd-header-buttons">
					<li><a class="cd-search-trigger" href="#cd-search"> <span></span></a></li>
				</ul>
				<!-- cd-header-buttons -->
			</div>
			<div id="cd-search" class="cd-search">
				<form action="#" method="post">
					<input id="inputSearch" name="Search" type="search" placeholder="<%=bundle.getString("search")%>..." autocomplete="off">
					<input type="hidden" id="contextPath" value="<%=request.getContextPath()%>">
				</form>
				<ul id="ul-search" style="list-style:none outside none;width:100%;background-color:rgba(0, 0, 0, 0.75);    padding: 1em 2em; letter-spacing: 1px; color: #fff;  font-size: 1.2em;">
					
				</ul>
			</div>
		</div>
	</div>
</div>
<script>
	$(document).ready(function() {
		$('#inputSearch').keyup(function() {	
			$.ajax({
				  url: "<%=request.getContextPath()%>/SearchAjax",
				  type: "get", //send it through get method
				  data: { 
				  	title: $('#inputSearch').val()
				  },
				  success: function(response) {
					  $('#ul-search').empty();
					  var $contextPath = $('#contextPath').val();
					  $.each(response,function(index,item){
						  $('<li>').append("<a href='"+$contextPath+"/single.jsp?movieID="+item.movieID+"'"+">"+item.title+"</a>").appendTo($('#ul-search'));
						});
				  },
				  error: function(xhr) {
				    //Do Something to handle error
				  }
			});
		});
	});
</script>

<!--//header-w3l-->