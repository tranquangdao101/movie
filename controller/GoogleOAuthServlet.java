package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDAO;
import model.User;
import utilities.GoogleOAuth;

/**
 * Servlet implementation class FacebookServlet
 */
@WebServlet("/GoogleOAuthServlet")
public class GoogleOAuthServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    UserDAO userDAO = new  UserDAO();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GoogleOAuthServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		String code = request.getParameter("code");
		if(code == null) {
			response.sendRedirect("index.jsp");
		}
		GoogleOAuth googleOAuth = new GoogleOAuth();
		String accessToken = googleOAuth.getAccessToken(code);
		googleOAuth.setAccessToken(accessToken);
		
		User user = googleOAuth.getUserInfo();
		boolean userExist = userDAO.checkLoginGoogle(user.getGoogleID()) != null;
		if(!userExist) {
			userDAO.registerGoogle(user);
		}
		user = userDAO.getUserByGoogleID(user.getGoogleID());
		HttpSession session = request.getSession();
		session.setAttribute("user", user);
		response.sendRedirect("index.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
