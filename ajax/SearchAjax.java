package ajax;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.MovieDAO;
import model.Movie;

/**
 * Servlet implementation class SearchAjax
 */
@WebServlet("/SearchAjax")
public class SearchAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
    MovieDAO mDAO;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchAjax() {
        super();
        mDAO = new MovieDAO();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		if(title == null)
			title ="";
		List<Movie> list = mDAO.getMovieByStr(title);
		String json = new Gson().toJson(list);
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(json);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
