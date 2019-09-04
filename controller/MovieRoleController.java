package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MovieRoleDAO;
import model.MovieRole;

/**
 * Servlet implementation class MovieRoleController
 */
@WebServlet("/MovieRoleController")
public class MovieRoleController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	
	MovieRoleDAO mrDAO = new MovieRoleDAO();
	
    public MovieRoleController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String action = request.getParameter("action");
		
		if(action == null) {
			action ="donotthing";
		}
		
		String url = "/admin/index.jsp";
		
		if(action.equals("donotthing")) {
			response.sendRedirect(url);
			return;
		} else if(action.equals("add")) {
			url = add(request);
		} else if(action.equals("edit")) {
			url = edit(request);
		} else if(action.equals("delete")) {
			url = delete(request);
		}
		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

	private String delete(HttpServletRequest request) {
		long movieRoleID = Long.parseLong(request.getParameter("movieRoleID"));
		String url = "/admin/movieRole/movie_role.jsp";
		MovieRole mr = new MovieRole();
		mr.setMovieRoleID(movieRoleID);
		mrDAO.delete(mr);
		return url;
	}

	private String edit(HttpServletRequest request) {
		long movieRoleID = Long.parseLong(request.getParameter("movieRoleID"));
		String movieRoleName = request.getParameter("movieRoleName");
		boolean isError = false;
		String url = "/admin/movieRole/movie_role.jsp";
		String errMovieRoleName ="";
		if(movieRoleName == null || movieRoleName.trim().isEmpty()) {
			errMovieRoleName ="Bạn phải nhập tên thể loại";
			isError = true;
		} else if(mrDAO.checkMovieRoleName(movieRoleName)) {
			isError =true;
			errMovieRoleName ="Thể loại phim này đã có";
		}
		if(!isError) {
			MovieRole mr = new MovieRole();
			mr.setMovieRoleName(movieRoleName);
			mr.setMovieRoleID(movieRoleID);
			mrDAO.update(mr);
		} else {
			request.setAttribute("errorCategoryName", errMovieRoleName);
		}
		return url;
	}

	private String add(HttpServletRequest request) {
		String movieRoleName = request.getParameter("movieRoleName");
		boolean isError = false;
		String url = "/admin/movieRole/movie_role.jsp";
		String errMovieRoleName ="";
		if(movieRoleName == null || movieRoleName.trim().isEmpty()) {
			errMovieRoleName ="Bạn phải nhập tên thể loại";
			isError = true;
		} else if(mrDAO.checkMovieRoleName(movieRoleName)) {
			isError =true;
			errMovieRoleName ="Thể loại phim này đã có";
		}
		if(!isError) {
			MovieRole mr = new MovieRole();
			mr.setMovieRoleName(movieRoleName);
			mrDAO.add(mr);
		} else {
			request.setAttribute("errorCategoryName", errMovieRoleName);
		}
		return url;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
