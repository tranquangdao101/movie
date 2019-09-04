package controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import dao.CategoryDAO;
import dao.MovieDAO;
import model.Category;
import model.Country;
import model.Movie;

/**
 * Servlet implementation class MovieController
 */
@WebServlet("/MovieController")
public class MovieController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CategoryDAO cDAO = new CategoryDAO();
	MovieDAO mDAO = new MovieDAO();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MovieController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	private String add(HttpServletRequest request) {
		String url = "/admin/movie/movie.jsp";
		String title = request.getParameter("title");
		String releaseYear = request.getParameter("releaseYear");
		String[] genres = request.getParameterValues("genres");
		String countryID = request.getParameter("countryID");
		String movieLink = request.getParameter("movieLink");
		int movieLength = Integer.parseInt(request.getParameter("movieLength"));
		int view = Integer.parseInt(request.getParameter("view"));
		String description = request.getParameter("description");
		boolean isError = false;
		String errorTitle = "";
		String errorReleaseYear = "";
		String errorGenres = "";
		String errorMovieLink = "";
		String errorMovieLength = "";
		String errorView = "";
		String errorImageLink = "";
		String errorDescription = "";
		if (title == null || title.trim().isEmpty()) {
			isError = true;
			errorTitle = "Bạn phải nhập tên phim";
		}
		try {
			Integer.parseInt(releaseYear);
		} catch (NumberFormatException e) {
			isError = true;
			errorReleaseYear = "Năm sản xuất phải là 1 số";
		}
		int intReleaseYear = Integer.parseInt(releaseYear);

		if (genres == null) {
			isError = true;
			errorGenres = "Bạn phải chọn ít nhất 1 thể loại phim";
		}
		if (movieLink == null || movieLink.trim().isEmpty()) {
			isError = true;
			errorMovieLink = "Bạn phải nhập đường dẫn phim";
		}
		try {
			Integer.parseInt(request.getParameter("movieLength"));
		} catch (NumberFormatException e) {
			isError = true;
			errorMovieLength = "Bạn phải nhập thời lượng phim theo dạng phút";
		}
		try {
			Integer.parseInt(request.getParameter("view"));
		} catch (NumberFormatException e) {
			isError = true;
			errorView = "Số lượng xem phải là 1 con số";
		}


		if (description == null || description.trim().isEmpty()) {
			isError = true;
			errorDescription = "Mô tả không được để trống";
		}

		if (!isError) {
			Movie m = new Movie();
			m.setTitle(title);
			m.setRelaseYear(intReleaseYear);
			ArrayList<Category> cates = new ArrayList<>();
			for (String category : genres) {
				cates.add(cDAO.getCategoryByID(Long.parseLong(category)));
			}
			m.setCategory(cates);
			m.setLink(movieLink);
			m.setMovieLength(movieLength);
			m.setCountView(view);
			m.setMovieDescription(description);
			Country country = new Country();
			country.setCountryID(countryID);
			m.setCountry(country);
			mDAO.add(m);
		} else {
			request.setAttribute("title", title);
			request.setAttribute("releaseYear", releaseYear);
			request.setAttribute("genres", genres);
			request.setAttribute("movieLink", movieLink);
			request.setAttribute("movieLength", movieLength);
			request.setAttribute("view", view);
			request.setAttribute("description", description);

			request.setAttribute("errorTitle", errorTitle);
			request.setAttribute("errorReleaseYear", errorReleaseYear);
			request.setAttribute("errorGenres", errorGenres);
			request.setAttribute("errorMovieLink", errorMovieLink);
			request.setAttribute("errorMovieLength", errorMovieLength);
			request.setAttribute("errorView", errorView);
			request.setAttribute("errorImageLink", errorImageLink);
			request.setAttribute("errorDescription", errorDescription);
		}

		return url;
	}

	private String delete(HttpServletRequest request) {
		String url = "/admin/movie/movie.jsp";
		long movieID = Long.parseLong(request.getParameter("movieID"));
		Movie m = new Movie();
		m.setMovieID(movieID);
		mDAO.delete(m);
		return url;
	}

	private String edit(HttpServletRequest request) {
		String url = "/admin/movie/movie.jsp";
		long movieID = Long.parseLong(request.getParameter("movieID"));
		String title = request.getParameter("title");
		String releaseYear = request.getParameter("releaseYear");
		String[] genres = request.getParameterValues("genres");
		String countryID = request.getParameter("countryID");
		String movieLink = request.getParameter("movieLink");
		int movieLength = Integer.parseInt(request.getParameter("movieLength"));
		int view = Integer.parseInt(request.getParameter("view"));
		String description = request.getParameter("description");
		boolean isError = false;
		String errorTitle = "";
		String errorReleaseYear = "";
		String errorGenres = "";
		String errorMovieLink = "";
		String errorMovieLength = "";
		String errorView = "";
		String errorImageLink = "";
		String errorDescription = "";
		if (title == null || title.trim().isEmpty()) {
			isError = true;
			errorTitle = "Bạn phải nhập tên phim";
		}
		try {
			Integer.parseInt(releaseYear);
		} catch (NumberFormatException e) {
			isError = true;
			errorReleaseYear = "Năm sản xuất phải là 1 số";
		}
		int intReleaseYear = Integer.parseInt(releaseYear);

		if (genres == null) {
			isError = true;
			errorGenres = "Bạn phải chọn ít nhất 1 thể loại phim";
		}
		if (movieLink == null || movieLink.trim().isEmpty()) {
			isError = true;
			errorMovieLink = "Bạn phải nhập đường dẫn phim";
		}
		try {
			Integer.parseInt(request.getParameter("movieLength"));
		} catch (NumberFormatException e) {
			isError = true;
			errorMovieLength = "Bạn phải nhập thời lượng phim theo dạng phút";
		}
		try {
			Integer.parseInt(request.getParameter("view"));
		} catch (NumberFormatException e) {
			isError = true;
			errorView = "Số lượng xem phải là 1 con số";
		}
		if (description == null || description.trim().isEmpty()) {
			isError = true;
			errorDescription = "Mô tả không được để trống";
		}

		if (!isError) {
			Movie m = new Movie();
			m.setMovieID(movieID);
			m.setTitle(title);
			m.setRelaseYear(intReleaseYear);
			ArrayList<Category> cates = new ArrayList<>();
			for (String category : genres) {
				cates.add(cDAO.getCategoryByID(Long.parseLong(category)));
			}
			m.setCategory(cates);
			m.setLink(movieLink);
			m.setMovieLength(movieLength);
			m.setCountView(view);
			m.setMovieDescription(description);
			Country country = new Country();
			country.setCountryID(countryID);
			System.out.println(countryID);
			m.setCountry(country);
			mDAO.update(m);
		} else {
			request.setAttribute("title", title);
			request.setAttribute("releaseYear", releaseYear);
			request.setAttribute("genres", genres);
			request.setAttribute("movieLink", movieLink);
			request.setAttribute("movieLength", movieLength);
			request.setAttribute("view", view);
			request.setAttribute("description", description);

			request.setAttribute("errorTitle", errorTitle);
			request.setAttribute("errorReleaseYear", errorReleaseYear);
			request.setAttribute("errorGenres", errorGenres);
			request.setAttribute("errorMovieLink", errorMovieLink);
			request.setAttribute("errorMovieLength", errorMovieLength);
			request.setAttribute("errorView", errorView);
			request.setAttribute("errorImageLink", errorImageLink);
			request.setAttribute("errorDescription", errorDescription);
		}

		return url;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		boolean isMultiPart = ServletFileUpload.isMultipartContent(request);
		request.setCharacterEncoding("utf-8");
		if (!isMultiPart) {
			String action = request.getParameter("action");
			if (action == null) {
				action = "donotthing";
			}
			String url = "/admin/index.jsp";

			if (action.equals("donotthing")) {
				response.sendRedirect(url);
				return;
			} else if (action.equals("add")) {
				url = add(request);
			} else if (action.equals("delete")) {
				url = delete(request);
			} else if (action.equals("edit")) {
				url = edit(request);
			}

			getServletContext().getRequestDispatcher(url).forward(request, response);
		} else {
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			String url = "/admin/movie/movie.jsp";
			List<FileItem> items = null;
			try {
				items = upload.parseRequest(request);
			} catch (FileUploadException e) {
				e.printStackTrace();
			}
			Hashtable<String, String> params = new Hashtable<>();
			Iterator<FileItem> iter = items.iterator();
			FileItem fileItem = null;
			while (iter.hasNext()) {
				FileItem item = (FileItem) iter.next();
				if (item.isFormField()) {
					params.put(item.getFieldName(), item.getString("utf-8"));
				} else {
					fileItem = item;
				}
			}
			String action = params.get("action");
			long movieID = Long.parseLong(params.get("movieID"));
			if(fileItem == null || fileItem.getSize() == 0) {
				response.sendRedirect("admin/movie/edit.jsp?movieID="+movieID);
				return;
			}
			if (action == null) {

			} else if (action.equals("lImage")) {
				boolean isError = false;
				if (fileItem != null) {
					String fileName = fileItem.getName();
					String mimeType = getServletContext().getMimeType(fileName);
					String fileType = fileName.substring(fileName.lastIndexOf('.'), fileName.length());
					String errImg = "";
					if (!mimeType.startsWith("image/")) {
						isError = true;
						errImg = "Đây không phải là định dạng ảnh phù hợp";
					}
					BufferedImage bimg = null;
					try (InputStream input = fileItem.getInputStream()) {
						try {
							bimg = ImageIO.read(input);
						} catch (Exception e) {
							isError = true;
							errImg = "Đây không phải là định dạng ảnh phù hợp";
						}
					}
					if (bimg != null) {
						if (bimg.getWidth() < 1000 || bimg.getHeight() < 500) {
							isError = true;
							errImg = "Ảnh phải có kích thước như quy định";
						}
					}
					if (fileItem.getSize() > 1024000000) {
						isError = true;
						errImg = "Kích thước của ảnh nhiều nhất là 1MB";
					}

					if (!isError) {
						try {
							fileItem.write(new File(request.getServletContext().getRealPath("/images/movie") + "/"
									+ movieID + fileType));
							Movie  movie = mDAO.getMovie(movieID);
							movie.setMovieImage("images/movie/"+movieID+fileType);
							mDAO.update(movie);
						} catch (Exception e) {
							e.printStackTrace();
						}
					} else {
						url = "/admin/movie/edit.jsp?movieID=" + movieID;
						request.setAttribute("errImg", errImg);
					}
				}
			} else if (action.equals("sImage")) {
				boolean isError = false;
				if (fileItem != null) {
					String fileName = fileItem.getName();
					String mimeType = getServletContext().getMimeType(fileName);
					String fileType = fileName.substring(fileName.lastIndexOf('.'), fileName.length());
					String errImg = "";
					if (!mimeType.startsWith("image/")) {
						isError = true;
						errImg = "Đây không phải là định dạng ảnh phù hợp";
						BufferedImage bimg = null;
						try (InputStream input = fileItem.getInputStream()) {
							try {
								bimg = ImageIO.read(input);
							} catch (Exception e) {
								isError = true;
								errImg = "Đây không phải là định dạng ảnh phù hợp";
							}
						}
						if (bimg != null) {
							if (bimg.getWidth() != 250 && bimg.getHeight() != 300) {
								isError = true;
								errImg = "Ảnh phải có kích thước như quy định";
							}
						}
						if (fileItem.getSize() > 1024000000) {
							isError = true;
							errImg = "Kích thước của ảnh nhiều nhất là 1MB";
						}
					}

					if (!isError) {
						try {
							fileItem.write(new File(request.getServletContext().getRealPath("/images/movie") + "/m"
									+ movieID + fileType));
							Movie  movie = mDAO.getMovie(movieID);
							movie.setMovieImage("images/movie/m"+movieID+fileType);
							mDAO.update(movie);
						} catch (Exception e) {
							e.printStackTrace();
						}
					} else {
						url = "/admin/movie/edit.jsp?movieID=" + movieID;
						request.setAttribute("errImg", errImg);
					}
				}
			}
			getServletContext().getRequestDispatcher(url).forward(request, response);
		}
	}

}
