package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CategoryDAO;
import model.Category;

/**
 * Servlet implementation class CategoryController
 */
@WebServlet("/CategoryController")
public class CategoryController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	CategoryDAO cDAO = new CategoryDAO();
    public CategoryController() {
        super();
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
			response.sendRedirect("admin/index.jsp");
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
		long cateID = Long.parseLong(request.getParameter("categoryID"));
		String url ="/admin/category/category.jsp";
		Category c = new Category();
		c.setId(cateID);
		cDAO.delete(c);
		return url;
	}

	private String add(HttpServletRequest request) {
		String categoryName = request.getParameter("categoryName");
		boolean isError = false;
		String url = "/admin/category/category.jsp";
		String errorCategoryName ="";
		if(categoryName == null || categoryName.trim().isEmpty()) {
			errorCategoryName ="Bạn phải nhập tên thể loại";
			isError = true;
		} else if(cDAO.checkCategoryName(categoryName)) {
			isError =true;
			errorCategoryName ="Thể loại phim này đã có";
		}
		if(!isError) {
			Category c = new Category();
			c.setName(categoryName);
			cDAO.add(c);
		} else {
			request.setAttribute("errorCategoryName", errorCategoryName);
		}
		return url;
	}

	private String edit(HttpServletRequest request) {
		long id = Long.parseLong(request.getParameter("categoryID"));
		String categoryName = request.getParameter("categoryName");
		boolean isError = false;
		String url ="/admin/category/category.jsp";
		String errorCategoryName ="";
		if(categoryName == null || categoryName.trim().isEmpty()) {
			isError = true;
			errorCategoryName="Bạn phải nhập tên thể loại";
		} 
		if(!isError) {
			Category c = new Category(id, categoryName);
			cDAO.update(c);
		} else {
			request.setAttribute("errorCategoryName", errorCategoryName);
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
