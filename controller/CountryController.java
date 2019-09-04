package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CountryDAO;
import model.Country;

/**
 * Servlet implementation class CategoryController
 */
@WebServlet("/CountryController")
public class CountryController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	CountryDAO countryDAO = new CountryDAO();

	public CountryController() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		String action = request.getParameter("action");

		if (action == null) {
			action = "donotthing";
		}

		String url = "/admin/index.jsp";

		if (action.equals("donotthing")) {
			response.sendRedirect("admin/index.jsp");
			return;
		} else if (action.equals("add")) {
			url = add(request);
		} else if (action.equals("edit")) {
			url = edit(request);
		} else if (action.equals("delete")) {
			url = delete(request);
		}
		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

	private String delete(HttpServletRequest request) {
		String countryID = request.getParameter("countryID");
		String url = "/admin/country/country.jsp";
		Country c = new Country();
		c.setCountryID(countryID);
		countryDAO.delete(c);
		return url;
	}

	private String add(HttpServletRequest request) {
		String countryID = request.getParameter("countryID");
		String countryName = request.getParameter("countryName");
		String countryNameVN = request.getParameter("countryNameVN");
		String url = "/admin/country/country.jsp";
		if (countryDAO.checkCountryID(countryID)) {
			boolean isError = false;
			String errorCountryName = "";
			String errorCountryID = "";
			if (countryName == null || countryName.trim().isEmpty()) {
				errorCountryName = "Bạn phải nhập tên nước";
				isError = true;
			} else if (countryDAO.checkCountryName(countryName)) {
				isError = true;
				errorCountryName = "Nước này đã có";
			}
			if (countryID == null || countryID.trim().isEmpty()) {
				errorCountryID = "Bạn phải nhập mã nước theo chuẩn ISO";
				isError = true;
			} else if (countryDAO.checkCountryID(countryID)) {
				isError = true;
				errorCountryID = "Mã nước này đã có";
			}
			if (!isError) {
				Country country = new Country();
				country.setCountryID(countryID);
				country.setCountryName(countryName);
				countryDAO.update(new Country(countryID, countryName, countryNameVN));
			} else {
				request.setAttribute("errorCountryName", errorCountryName);
				request.setAttribute("errorCountryID", errorCountryID);
			}
		} else {
			boolean isError = false;
			String errorCountryName = "";
			String errorCountryID = "";
			if (countryName == null || countryName.trim().isEmpty()) {
				errorCountryName = "Bạn phải nhập tên nước";
				isError = true;
			} else if (countryDAO.checkCountryName(countryName)) {
				isError = true;
				errorCountryName = "Nước này đã có";
			}
			if (countryID == null || countryID.trim().isEmpty()) {
				errorCountryID = "Bạn phải nhập mã nước theo chuẩn ISO";
				isError = true;
			} else if (countryDAO.checkCountryID(countryID)) {
				isError = true;
				errorCountryID = "Mã nước này đã có";
			}
			if (!isError) {
				Country country = new Country();
				country.setCountryID(countryID);
				country.setCountryName(countryName);
				country.setCountryNameVN(countryNameVN);
				countryDAO.add(country);
			} else {
				request.setAttribute("errorCountryName", errorCountryName);
				request.setAttribute("errorCountryID", errorCountryID);
			}
		}
		return url;
	}

	private String edit(HttpServletRequest request) {
		String countryID = request.getParameter("countryID");
		String countryName = request.getParameter("countryName");
		String countryNameVN = request.getParameter("countryNameVN");
		boolean isError = false;
		String url = "/admin/country/country.jsp";
		String errorCountryName = "";
		String errorCountryNameVN = "";
		if (countryName == null || countryName.trim().isEmpty()) {
			errorCountryName = "Bạn phải nhập tên nước";
			isError = true;
		} 
		
		if(countryNameVN == null || countryNameVN.trim().isEmpty()) {
			isError = true;
			errorCountryNameVN="Bạn phải nhập tên nước";
		}
		if (!isError) {
			Country country = new Country();
			country.setCountryID(countryID);
			country.setCountryName(countryName);
			country.setCountryNameVN(countryNameVN);
			countryDAO.update(country);
			System.out.println("adssdsd");
		} else {
			request.setAttribute("errorCountryName", errorCountryName);
			request.setAttribute("errorCountryNameVN", errorCountryNameVN);
		}
		return url;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
