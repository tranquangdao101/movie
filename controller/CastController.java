package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CastDAO;

/**
 * Servlet implementation class CastController
 */
@WebServlet("/CastController")
public class CastController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	
	CastDAO castDAO = new CastDAO();
    public CastController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String action = request.getParameter("action");
		
		if(action == null) {
			response.sendRedirect("admin/cast/cast.jsp");
			return;
		}else if(action.equals("edit")) {
			long movieID = Long.parseLong(request.getParameter("movieID"));
			String crewIDs[] = request.getParameterValues("crew[]");
			long[] crewID = new long[crewIDs.length];
			for(int i = 0; i <crewIDs.length;i++) {
				crewID[i] = Long.parseLong(crewIDs[i]);
			}
			
			castDAO.updateActor(movieID, crewID);
			response.sendRedirect("admin/cast/cast.jsp");
			return;
		} else {
			response.sendRedirect("admin/cast/cast.jsp");
			return;
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
