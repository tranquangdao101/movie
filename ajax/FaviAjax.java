package ajax;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.FavoriteMovieDAO;
import model.FavoriteMovie;

/**
 * Servlet implementation class FaviAjax
 */
@WebServlet("/FaviAjax")
public class FaviAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
    FavoriteMovieDAO fmDAO = new FavoriteMovieDAO();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FaviAjax() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		if(action== null) {
			action = "home";
		}
		
		if(action.equals("add")) {			
			long movieID = Long.parseLong((String)request.getParameter("movieID"));
			long userID = Long.parseLong((String)request.getParameter("userID"));
			fmDAO.add(new FavoriteMovie(movieID, userID));
		} else if(action.equals("delete")) {
			long movieID = Long.parseLong((String)request.getParameter("movieID"));
			long userID = Long.parseLong((String)request.getParameter("userID"));
			fmDAO.remove(userID,movieID);
			response.sendRedirect(request.getContextPath()+ "/user/favorite.jsp");
		} else if(action.equals("home")) {
			response.sendRedirect("/index.jsp");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
