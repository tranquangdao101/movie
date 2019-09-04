package controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CrewDAO;
import model.Crew;

/**
 * Servlet implementation class CrewController
 */
@WebServlet("/CrewController")
public class CrewController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	CrewDAO crewDAO = new CrewDAO();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CrewController() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
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
		String url = "/admin/crew/crew.jsp";
		long crewID = -1;
		try {
		 crewID = Long.parseLong(request.getParameter("crewID"));
		} catch(NumberFormatException e) {
			return url;
		}
		if(crewID <0) {
			return url;
		}
		Crew crew = new Crew();
		crew.setCrewID(crewID);
		crewDAO.delete(crew);
		return url;
	}

	private String edit(HttpServletRequest request) {
		String url = "/admin/crew/crew.jsp";
		boolean isError = false;
		long crewID = -1;
		try {
		 crewID = Long.parseLong(request.getParameter("crewID"));
		} catch(NumberFormatException e) {
			return url;
		}
		if(crewID <0) {
			return url;
		}
		Crew crew = crewDAO.getCrew(crewID);
		String crewFirstName = request.getParameter("crewFirstName");
		String crewLastName = request.getParameter("crewLastName");
		DateFormat df = new SimpleDateFormat("YYYY-MM-DD");
		String errCrewBirthday = "";
		Date crewBirthday = null;
		try {
			crewBirthday = df.parse(request.getParameter("crewBirthday"));
		} catch (ParseException e) {
			e.printStackTrace();
			isError = true;
			errCrewBirthday = "Sai định dạng ngày tháng";
		}
		String crewNationality = request.getParameter("crewNationality");
		String crewInfo = request.getParameter("crewInfo");
		String crewGender = request.getParameter("crewGender");
		String errCrewGender = "";
		String errCrewFistName = "";
		String errCrewLastName = "";

		String errCrewNationality = "";
		String errCrewInfo = "";

		if (crewGender == null || crewGender.trim().isEmpty()) {
			isError = true;
			errCrewGender = "Không được bỏ trống giới tính";
		}

		if (crewFirstName == null || crewFirstName.trim().isEmpty()) {
			isError = true;
			errCrewFistName = "Tên không được để trống";
		}
		if (crewLastName == null || crewLastName.trim().isEmpty()) {
			isError = true;
			errCrewLastName = "Họ không được để trống";
		}
		if (crewNationality == null || crewNationality.trim().isEmpty()) {
			isError = true;
			errCrewNationality = "Quốc tịch không được để trống";
		}
		if (crewInfo == null || crewInfo.trim().isEmpty()) {
			isError = true;
			errCrewInfo = "Thông tin không được phép để trống";
		}

		if (!isError) {
			crew.setCrewFirstName(crewFirstName);
			crew.setCrewLastName(crewLastName);
			crew.setCrewBirthday(crewBirthday);
			crew.setCrewGender(crewGender);
			crew.setCrewInfo(crewInfo);
			crew.setCrewNationality(crewNationality);
			crewDAO.update(crew);
			url = "/admin/crew/crew.jsp";
		} else {
			url = "/admin/crew/add.jsp";
			request.setAttribute("errCrewGender", errCrewGender);
			request.setAttribute("errCrewBirthday", errCrewBirthday);
			request.setAttribute("errCrewFistName", errCrewFistName);
			request.setAttribute("errCrewLastName", errCrewLastName);
			request.setAttribute("errCrewNationality", errCrewNationality);
			request.setAttribute("errCrewInfo", errCrewInfo);
		}
		return url;
	}

	private String add(HttpServletRequest request) {
		String url = "/admin/crew/crew.jsp";
		boolean isError = false;
		String crewFirstName = request.getParameter("crewFirstName");
		String crewLastName = request.getParameter("crewLastName");
		DateFormat df = new SimpleDateFormat("YYYY-MM-DD");
		String errCrewBirthday = "";
		Date crewBirthday = null;
		try {
			crewBirthday = df.parse(request.getParameter("crewBirthday"));
		} catch (ParseException e) {
			e.printStackTrace();
			isError = true;
			errCrewBirthday = "Sai định dạng ngày tháng";
		}
		String crewNationality = request.getParameter("crewNationality");
		String crewInfo = request.getParameter("crewInfo");
		String crewGender = request.getParameter("crewGender");
		String errCrewGender = "";
		String errCrewFistName = "";
		String errCrewLastName = "";

		String errCrewNationality = "";
		String errCrewInfo = "";

		if (crewGender == null || crewGender.trim().isEmpty()) {
			isError = true;
			errCrewGender = "Không được bỏ trống giới tính";
		}

		if (crewFirstName == null || crewFirstName.trim().isEmpty()) {
			isError = true;
			errCrewFistName = "Tên không được để trống";
		}
		if (crewLastName == null || crewLastName.trim().isEmpty()) {
			isError = true;
			errCrewLastName = "Họ không được để trống";
		}
		if (crewNationality == null || crewNationality.trim().isEmpty()) {
			isError = true;
			errCrewNationality = "Quốc tịch không được để trống";
		}
		if (crewInfo == null || crewInfo.trim().isEmpty()) {
			isError = true;
			errCrewInfo = "Thông tin không được phép để trống";
		}

		if (!isError) {
			Crew crew = new Crew();
			crew.setCrewFirstName(crewFirstName);
			crew.setCrewLastName(crewLastName);
			crew.setCrewBirthday(crewBirthday);
			crew.setCrewGender(crewGender);
			crew.setCrewInfo(crewInfo);
			crew.setCrewNationality(crewNationality);
			crewDAO.add(crew);
			url = "/admin/crew/crew.jsp";
		} else {
			url = "/admin/crew/add.jsp";
			request.setAttribute("errCrewGender", errCrewGender);
			request.setAttribute("errCrewBirthday", errCrewBirthday);
			request.setAttribute("errCrewFistName", errCrewFistName);
			request.setAttribute("errCrewLastName", errCrewLastName);
			request.setAttribute("errCrewNationality", errCrewNationality);
			request.setAttribute("errCrewInfo", errCrewInfo);
		}
		return url;
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
