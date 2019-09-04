
<%@page import="com.sun.org.apache.bcel.internal.generic.LMUL"%>
<%@page import="model.Movie"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.MovieDAO"%>
<%@page import="i18n.UTF8Control"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="java.util.Locale"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	MovieDAO mDAO = new MovieDAO();
	ArrayList<Movie> listAllMovie = mDAO.getListMovies();
	ArrayList<Movie> latestMovie = mDAO.getTenLatest();
	ArrayList<Movie> mostviewedMovie = mDAO.getTenMostViewed();
%>
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
<!--/content-inner-section-->
<div class="w3_content_agilleinfo_inner">
	<div class="agile_featured_movies">
		<!--/agileinfo_tabs-->
		<div class="agileinfo_tabs">
			<!--/tab-section-->
			<div id="horizontalTab">
				<ul class="resp-tabs-list">
					<li><%=bundle.getString("recent")%></li>
					<li><%=bundle.getString("popularity")%></li>
					<li><%=bundle.getString("topRating")%></li>

				</ul>
				<div class="resp-tabs-container">
					<div class="tab1">
						<div class="tab_movies_agileinfo">
							<div class="w3_agile_featured_movies">
								<div class="col-md-5 video_agile_player">
									<div class="video-grid-single-page-agileits">
										<div data-video="<%=latestMovie.get(0).getLink()%>" id="video">
											<img src="<%=latestMovie.get(0).getMovieImage()%>" alt="" class="img-responsive" />
										</div>
									</div>



									<div class="player-text">
										<p class="fexi_header"><%=latestMovie.get(0).getTitle()%></p>
										<p class="fexi_header_para">
											<span class="conjuring_w3"><%=bundle.getString("storyLine")%><label>:</label></span><%=latestMovie.get(0).getMovieDescription()%></p>
										<p class="fexi_header_para">
											<span><%=bundle.getString("releaseOn")%><label>:</label></span><%=latestMovie.get(0).getRelaseYear()%>
										</p>
										<p class="fexi_header_para">
											<span><%=bundle.getString("genres")%><label>:</label>
											</span> <a href="genre.html">Drama</a> | <a href="genre.html">Adventure</a>
											| <a href="genre.html">Family</a>
										</p>
										<p class="fexi_header_para fexi_header_para1">
											<span><%=bundle.getString("starRating")%><label>:</label></span> <a href="#"><i
												class="fa fa-star" aria-hidden="true"></i></a> <a href="#"><i
												class="fa fa-star" aria-hidden="true"></i></a> <a href="#"><i
												class="fa fa-star-half-o" aria-hidden="true"></i></a> <a
												href="#"><i class="fa fa-star-o" aria-hidden="true"></i></a>
											<a href="#"><i class="fa fa-star-o" aria-hidden="true"></i></a>
										</p>
									</div>
								</div>
								<div class="col-md-7 wthree_agile-movies_list">

									<%
										for (int i = 0; i < latestMovie.size() - 2; i++) {
									%>
									<%
										Movie m = latestMovie.get(i);
									%>
									<div class="w3l-movie-gride-agile">
										<a href="single.jsp?movieID=<%=m.getMovieID()%>"
											class="hvr-sweep-to-bottom"><img
											src="images/movie/m<%=m.getMovieID()%>.jpg"
											title="Movies Pro" class="img-responsive" alt=" ">
											<div class="w3l-action-icon">
												<i class="fa fa-play-circle-o" aria-hidden="true"></i>
											</div> </a>
										<div class="mid-1 agileits_w3layouts_mid_1_home">
											<div class="w3l-movie-text">
												<h6>
													<a href="single.jsp?movieID=<%=m.getMovieID()%>"><%=m.getTitle()%></a>
												</h6>
											</div>
											<div class="mid-2 agile_mid_2_home">
												<p><%=m.getRelaseYear()%></p>
												<div class="block-stars">
													<ul class="w3l-ratings">
														<li><a href="#"><i class="fa fa-star"
																aria-hidden="true"></i></a></li>
														<li><a href="#"><i class="fa fa-star"
																aria-hidden="true"></i></a></li>
														<li><a href="#"><i class="fa fa-star-o"
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
										<div class="ribben">
											<p><%=bundle.getString("new")%></p>
										</div>
									</div>

									<%
										}
									%>

								</div>
								<div class="clearfix"></div>
							</div>
							<div class="cleafix"></div>
						</div>
					</div>
					<div class="tab2">
						<div class="tab_movies_agileinfo">
							<div class="w3_agile_featured_movies">
								<div class="col-md-5 video_agile_player">
									<div class="video-grid-single-page-agileits">
										<div data-video="<%=mostviewedMovie.get(0).getLink()%>" id="video1">
											<img src="<%=mostviewedMovie.get(0).getMovieImage()%>" alt=""
												class="img-responsive" />
										</div>
									</div>



									<div class="player-text">
										<p class="fexi_header"><%=mostviewedMovie.get(0).getTitle()%></p>
										<p class="fexi_header_para">
											<span class="conjuring_w3"><%=bundle.getString("storyLine")%><label>:</label></span><%=mostviewedMovie.get(0).getMovieDescription()%></p>
										<p class="fexi_header_para">
											<span><%=bundle.getString("releaseOn")%><label>:</label></span><%=mostviewedMovie.get(0).getRelaseYear()%>
										</p>
										<p class="fexi_header_para">
											<span><%=bundle.getString("genres")%><label>:</label>
											</span> <a href="genre.html">Drama</a> | <a href="genre.html">Adventure</a>
											| <a href="genre.html">Family</a>
										</p>
										<p class="fexi_header_para fexi_header_para1">
											<span><%=bundle.getString("starRating")%><label>:</label></span> <a href="#"><i
												class="fa fa-star" aria-hidden="true"></i></a> <a href="#"><i
												class="fa fa-star" aria-hidden="true"></i></a> <a href="#"><i
												class="fa fa-star-half-o" aria-hidden="true"></i></a> <a
												href="#"><i class="fa fa-star-o" aria-hidden="true"></i></a>
											<a href="#"><i class="fa fa-star-o" aria-hidden="true"></i></a>
										</p>
									</div>
								</div>
								<div class="col-md-7 wthree_agile-movies_list">


									<%
										for (int i = 0; i < mostviewedMovie.size() - 2; i++) {
									%>
									<%
										Movie m = mostviewedMovie.get(i);
									%>
									<div class="w3l-movie-gride-agile">
										<a href="single.jsp?movieID=<%=m.getMovieID()%>"
											class="hvr-sweep-to-bottom"><img
											src="images/movie/m<%=m.getMovieID()%>.jpg"
											title="Movies Pro" class="img-responsive" alt=" ">
											<div class="w3l-action-icon">
												<i class="fa fa-play-circle-o" aria-hidden="true"></i>
											</div> </a>
										<div class="mid-1 agileits_w3layouts_mid_1_home">
											<div class="w3l-movie-text">
												<h6>
													<a href="single.jsp?movieID=<%=m.getMovieID()%>"><%=m.getTitle()%></a>
												</h6>
											</div>
											<div class="mid-2 agile_mid_2_home">
												<p><%=m.getRelaseYear()%></p>
												<div class="block-stars">
													<ul class="w3l-ratings">
														<li><a href="#"><i class="fa fa-star"
																aria-hidden="true"></i></a></li>
														<li><a href="#"><i class="fa fa-star"
																aria-hidden="true"></i></a></li>
														<li><a href="#"><i class="fa fa-star-o"
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
										<div class="ribben">
											<p><%=bundle.getString("new")%></p>
										</div>
									</div>

									<%
										}
									%>

								</div>
								<div class="clearfix"></div>
							</div>
							<div class="cleafix"></div>
						</div>
					</div>
					<div class="tab3">
						<div class="tab_movies_agileinfo">
							<div class="w3_agile_featured_movies">
								<div class="col-md-5 video_agile_player">
									<div class="video-grid-single-page-agileits">
										<div data-video="<%=listAllMovie.get(0).getLink()%>" id="video2">
											<img src="<%=listAllMovie.get(0).getMovieImage()%>" alt="" class="img-responsive" />
										</div>
									</div>



									<div class="player-text">
										<p class="fexi_header"><%=listAllMovie.get(0).getTitle()%></p>
										<p class="fexi_header_para">
											<span class="conjuring_w3"><%=bundle.getString("storyLine")%><label>:</label></span><%=listAllMovie.get(0).getMovieDescription()%></p>
										<p class="fexi_header_para">
											<span><%=bundle.getString("releaseOn")%><label>:</label></span><%=listAllMovie.get(0).getRelaseYear()%>
										</p>
										<p class="fexi_header_para">
											<span><%=bundle.getString("genres")%><label>:</label>
											</span> <a href="genre.html">Drama</a> | <a href="genre.html">Adventure</a>
											| <a href="genre.html">Family</a>
										</p>
										<p class="fexi_header_para fexi_header_para1">
											<span><%=bundle.getString("starRating")%><label>:</label></span> <a href="#"><i
												class="fa fa-star" aria-hidden="true"></i></a> <a href="#"><i
												class="fa fa-star" aria-hidden="true"></i></a> <a href="#"><i
												class="fa fa-star-half-o" aria-hidden="true"></i></a> <a
												href="#"><i class="fa fa-star-o" aria-hidden="true"></i></a>
											<a href="#"><i class="fa fa-star-o" aria-hidden="true"></i></a>
										</p>
									</div>
								</div>
								<div class="col-md-7 wthree_agile-movies_list">

									<%
										for (int i = 2; i < 10; i++) {
									%>
									<%
										Movie m = listAllMovie.get(i);
									%>
									<div class="w3l-movie-gride-agile">
										<a href="single.jsp?movieID=<%=m.getMovieID()%>"
											class="hvr-sweep-to-bottom"><img
											src="images/movie/m<%=m.getMovieID()%>.jpg"
											title="Movies Pro" class="img-responsive" alt=" ">
											<div class="w3l-action-icon">
												<i class="fa fa-play-circle-o" aria-hidden="true"></i>
											</div> </a>
										<div class="mid-1 agileits_w3layouts_mid_1_home">
											<div class="w3l-movie-text">
												<h6>
													<a href="single.jsp?movieID=<%=m.getMovieID()%>"><%=m.getTitle()%></a>
												</h6>
											</div>
											<div class="mid-2 agile_mid_2_home">
												<p><%=m.getRelaseYear()%></p>
												<div class="block-stars">
													<ul class="w3l-ratings">
														<li><a href="#"><i class="fa fa-star"
																aria-hidden="true"></i></a></li>
														<li><a href="#"><i class="fa fa-star"
																aria-hidden="true"></i></a></li>
														<li><a href="#"><i class="fa fa-star-o"
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
										<div class="ribben">
											<p><%=bundle.getString("new")%></p>
										</div>
									</div>

									<%
										}
									%>




								</div>
								<div class="clearfix"></div>
							</div>
							<div class="cleafix"></div>
						</div>
					</div>
				</div>
			</div>

		</div>
		<!--//tab-section-->
		<h3 class="agile_w3_title">
			 <span><%=bundle.getString("latestMovies")%></span>
		</h3>
		<!--/movies-->
		<div class="w3_agile_latest_movies">


			<div id="owl-demo" class="owl-carousel owl-theme">
				<%
					for (Movie lmL : mDAO.getTenLatest()) {
				%>

				<div class="item">
					<div class="w3l-movie-gride-agile w3l-movie-gride-slider ">
						<a href="single.jsp?movieID=<%=lmL.getMovieID()%>"
							class="hvr-sweep-to-bottom"><img
							src="images/movie/m<%=lmL.getMovieID()%>.jpg" title="Movies Pro"
							class="img-responsive" alt=" " />
							<div class="w3l-action-icon">
								<i class="fa fa-play-circle-o" aria-hidden="true"></i>
							</div> </a>
						<div class="mid-1 agileits_w3layouts_mid_1_home">
							<div class="w3l-movie-text">
								<h6>
									<a href="single.jsp?movieID=<%=lmL.getMovieID()%>"><%=lmL.getTitle()%></a>
								</h6>
							</div>
							<div class="mid-2 agile_mid_2_home">
								<p><%=lmL.getRelaseYear()%></p>
								<div class="block-stars">
									<ul class="w3l-ratings">
										<li><a href="#"><i class="fa fa-star"
												aria-hidden="true"></i></a></li>
										<li><a href="#"><i class="fa fa-star"
												aria-hidden="true"></i></a></li>
										<li><a href="#"><i class="fa fa-star"
												aria-hidden="true"></i></a></li>
										<li><a href="#"><i class="fa fa-star"
												aria-hidden="true"></i></a></li>
										<li><a href="#"><i class="fa fa-star-half-o"
												aria-hidden="true"></i></a></li>
									</ul>
								</div>
								<div class="clearfix"></div>
							</div>
						</div>
						<div class="ribben one">
							<p><%=bundle.getString("new")%></p>
						</div>
					</div>
				</div>
				<%
					}
				%>

			</div>
		</div>
		<!--//movies-->
		<h3 class="agile_w3_title">
		<span>	<%=bundle.getString("mostViewedMovies")%></span>
		</h3>
		<!--/requested-movies-->
		<div class="wthree_agile-requested-movies">

			<%
				for (Movie mvL : mDAO.getTenMostViewed()) {
			%>
			<div class="col-md-2 w3l-movie-gride-agile requested-movies">
				<a href="single.jsp?movieID=<%=mvL.getMovieID()%>"
					class="hvr-sweep-to-bottom"><img
					src="images/movie/m<%=mvL.getMovieID()%>.jpg" title="Movies Pro"
					class="img-responsive" alt=" ">
					<div class="w3l-action-icon">
						<i class="fa fa-play-circle-o" aria-hidden="true"></i>
					</div> </a>
				<div class="mid-1 agileits_w3layouts_mid_1_home">
					<div class="w3l-movie-text">
						<h6>
							<a href="single.jsp?movieID=<%=mvL.getMovieID()%>"><%=mvL.getTitle()%></a>
						</h6>
					</div>
					<div class="mid-2 agile_mid_2_home">
						<p><%=mvL.getRelaseYear()%></p>
						<div class="block-stars">
							<ul class="w3l-ratings">
								<li><a href="#"><i class="fa fa-star"
										aria-hidden="true"></i></a></li>
								<li><a href="#"><i class="fa fa-star"
										aria-hidden="true"></i></a></li>
								<li><a href="#"><i class="fa fa-star-o"
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
					<p><%=bundle.getString("new")%></p>
				</div>
			</div>
			<%
				}
			%>

			<div class="clearfix"></div>
		</div>
		<!--//requested-movies-->
		<!--/top-movies-->
		<h3 class="agile_w3_title">
			<span><%=bundle.getString("topMovies")%></span>
		</h3>
		<div class="top_movies">
			<div class="tab_movies_agileinfo">
				<div class="w3_agile_featured_movies two">

					<div class="col-md-7 wthree_agile-movies_list second-top">
						<%
							ArrayList<Movie> listTopMovie = mDAO.getTenMostViewed();
							for (int i = 1; i < listTopMovie.size() - 1; i++) {
								Movie m = listTopMovie.get(i);
						%>
						<div class="w3l-movie-gride-agile">
							<a href="single.jsp?movieID=<%=m.getMovieID()%>"
								class="hvr-sweep-to-bottom"><img
								src="images/movie/m<%=m.getMovieID()%>.jpg" title="Movies Pro"
								class="img-responsive" alt=" ">
								<div class="w3l-action-icon">
									<i class="fa fa-play-circle-o" aria-hidden="true"></i>
								</div> </a>
							<div class="mid-1 agileits_w3layouts_mid_1_home">
								<div class="w3l-movie-text">
									<h6>
										<a href="single.jsp?movieID=<%=m.getMovieID()%>"><%=m.getTitle()%></a>
									</h6>
								</div>
								<div class="mid-2 agile_mid_2_home">
									<p><%=m.getRelaseYear()%></p>
									<div class="block-stars">
										<ul class="w3l-ratings">
											<li><a href="#"><i class="fa fa-star"
													aria-hidden="true"></i></a></li>
											<li><a href="#"><i class="fa fa-star"
													aria-hidden="true"></i></a></li>
											<li><a href="#"><i class="fa fa-star-o"
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
							<div class="ribben">
								<p><%=bundle.getString("new")%></p>
							</div>
						</div>
						<%
							}
						%>
					</div>
					<div class="col-md-5 video_agile_player second-top">
						<div class="video-grid-single-page-agileits">
							<div data-video="<%=listTopMovie.get(0).getLink()%>" id="video3">
								<img src="<%=listTopMovie.get(0).getMovieImage()%>" alt=""
									class="img-responsive" />
							</div>
						</div>

						<div class="player-text two">
							<p class="fexi_header"><%=listTopMovie.get(0).getTitle()%>
							</p>
							<p class="fexi_header_para">
								<span class="conjuring_w3"><%=bundle.getString("storyLine")%><label>:</label></span><%=listTopMovie.get(0).getMovieDescription()%>
							</p>
							<p class="fexi_header_para">
								<span><%=bundle.getString("releaseOn")%><label>:</label></span><%=listTopMovie.get(0).getRelaseYear()%>
							</p>

							<p class="fexi_header_para">
								<span><%=bundle.getString("genres")%><label>:</label>
								</span> <a href="genre.html">Drama</a> | <a href="genre.html">Adventure</a>
								| <a href="genre.html">Family</a>
							</p>
							<p class="fexi_header_para fexi_header_para1">
								<span><%=bundle.getString("starRating")%><label>:</label></span> <a href="#"><i
									class="fa fa-star" aria-hidden="true"></i></a> <a href="#"><i
									class="fa fa-star" aria-hidden="true"></i></a> <a href="#"><i
									class="fa fa-star-half-o" aria-hidden="true"></i></a> <a href="#"><i
									class="fa fa-star-o" aria-hidden="true"></i></a> <a href="#"><i
									class="fa fa-star-o" aria-hidden="true"></i></a>
							</p>
						</div>

					</div>
					<div class="clearfix"></div>
				</div>
				<div class="cleafix"></div>
			</div>
		</div>

		<!--//top-movies-->
	</div>
</div>
<!--//content-inner-section-->
