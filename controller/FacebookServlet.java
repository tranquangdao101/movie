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
import utilities.FacebookOAuth;

/**
 * Servlet implementation class FacebookServlet
 */
@WebServlet("/FacebookServlet")
public class FacebookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    UserDAO userDAO = new  UserDAO();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FacebookServlet() {
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
		FacebookOAuth wrapper = new FacebookOAuth();
		String accessToken = wrapper.getAccessToken(code);
		wrapper.setAccessToken(accessToken);
		
		User user = wrapper.getUserInfo();
		boolean userExist = userDAO.checkLogin(user.getFacebookID()) != null;
		if(!userExist) {
			userDAO.register(user);
		}
		user = userDAO.getUserByFacebookID(user.getFacebookID());
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
