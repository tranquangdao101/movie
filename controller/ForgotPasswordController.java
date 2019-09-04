package controller;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ForgotPasswordDAO;
import dao.UserDAO;
import model.ForgotPassword;
import model.User;
import utilities.EmailSender;
import utilities.SecurityUtils;

/**
 * Servlet implementation class ForgotPasswordController
 */
@WebServlet("/ForgotPasswordController")
public class ForgotPasswordController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ForgotPasswordController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");

		if (action.equals("recover")) {
			String password = request.getParameter("password");
			UserDAO userDAO = new UserDAO();
			User user = userDAO.getUserByID(Long.parseLong(request.getParameter("userID")));
			user.setPassword(SecurityUtils.hashMD5(password));
			userDAO.update(user);
			ForgotPasswordDAO forgotPasswordDAO = new ForgotPasswordDAO();
			long forgetID = Long.parseLong(request.getParameter("forgotID"));
			forgotPasswordDAO.delete(forgetID);
			response.sendRedirect("index.jsp");
			return;
		} else if (action.equals("forgotPassword")) {
			UserDAO userDAO = new UserDAO();
			String email = request.getParameter("email");
			Date date = new Date();
			User user = userDAO.getUserByEmail(email);
			if(user == null) {
				response.sendRedirect("index.jsp");
				return;
			}
			ForgotPasswordDAO forgotPasswordDAO = new ForgotPasswordDAO();
			ForgotPassword forgotPassword = new ForgotPassword();
			forgotPassword.setDatetime(date);
			forgotPassword.setUser(user);
			forgotPasswordDAO.add(forgotPassword);
			String to = email;
			String subject = "MoviePro: Quên mật khẩu";
			String text = "Chào Bạn, "+user.getUserName()+" \n"
					+ "Đây là đường link để lấy lại mật khẩu \n"
					+ "http://2017-nhom006.azurewebsites.net/forgotPassword.jsp?forgetID="+forgotPasswordDAO.getForgetIDByUser(user.getUserID())+"";
//			String text = "Chào Bạn, "+user.getUserName()+" \n"
//					+ "Đây là đường link để lấy lại mật khẩu \n"
//					+ "http://localhost:8080/Movie/forgotPassword.jsp?forgetID="+forgotPasswordDAO.getForgetIDByUser(user.getUserID())+"";
			EmailSender.sendMail(to, subject, text);
			response.sendRedirect("index.jsp");
			return;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
