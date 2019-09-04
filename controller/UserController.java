package controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import dao.UserDAO;
import model.User;
import utilities.CaptchaUltis;
import utilities.EmailSender;
import utilities.SecurityUtils;

/**
 * Servlet implementation class UserController
 */
@WebServlet("/UserController")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	UserDAO udao = new UserDAO();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserController() {
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);

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
			String url = "/index.jsp";
			String from = request.getParameter("from");
			if (from == null) {
				from = "user";
			}

			if ("admin".equals("from")) {
				url = "/admin/user/user.jsp";
			} else {
				url = "/index.jsp";
			}

			if (action == null) {
				action = "register";
			}
			if (action.equals("logout")) {
				url = logout(request);
			} else if (action.equals("login")) {
				url = login(request);
				
			} else if(action.equals("delete")) {
				url = "/admin/user/user.jsp";
				long userID = Long.parseLong(request.getParameter("userID"));
				User user = new User();
				user.setUserID(userID);
				udao.delete(user);
			}else if (action.equals("addFromAdmin")) {
				url = addFromAdmin(request);
			} else if (action.equals("editFromAdmin")) {
				url = editFromAdmin(request);
			} else if (action.equals("register")) {

				url = reigster(request);
			} else if (action.equals("edit")) {
				url = edit(request);
			} else if (action.equals("forgotPassword")) {
				String toEmail = request.getParameter("email");
				User user = udao.getUserByEmail(toEmail);
				if (user != null) {
					String password = udao.getUserByEmail(toEmail).getPassword();
					String message = "Chào bạn " + user.getFirstName() + "\n"
							+ "Đây là tài khoản và mật khẩu của bạn \n" + "" + user.getUserName() + " --- " + password
							+ "\n" + "Thân ái,\n Movie Pro";
					boolean send = EmailSender.sendMail(toEmail, "Movie Pro : Quên mật khẩu", message);
					if (!send) {
						String errorForgotPass = "Gửi Email không thành công";
						request.setAttribute("errorForgotPass", errorForgotPass);
					} else {
						String errorForgotPass = "Gửi Email thành công";
						request.setAttribute("errorForgotPass", errorForgotPass);
					}
				} else {
					String errorForgotPass = "Email này không có trong hệ thống";
					request.setAttribute("errorForgotPass", errorForgotPass);
				}

				url = "/login.jsp";

			}

			ServletContext sc = getServletContext();
			RequestDispatcher rd = sc.getRequestDispatcher(url);
			rd.forward(request, response);
		} else {
			boolean isError = false;
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			List<FileItem> items = null;
			try {
				items = upload.parseRequest(request);
			} catch (FileUploadException e) {
				e.printStackTrace();
			}
			Iterator<FileItem> iter = items.iterator();
			Hashtable<String, String> params = new Hashtable<>();
			FileItem fileItem = null;
			String fileType = null;
			while (iter.hasNext()) {
				FileItem item = (FileItem) iter.next();
				if (item.isFormField()) {
					params.put(item.getFieldName(), item.getString("utf-8"));
				} else {
					fileItem = item;
				}
			}
			long userID = Long.parseLong((String) params.get("userID"));
			String fileName = fileItem.getName();
			String errImg = "";
			if (fileName != null && !fileName.trim().isEmpty()) {
				String mimeType = getServletContext().getMimeType(fileName);
				fileType = fileName.substring(fileName.lastIndexOf('.'), fileName.length());
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
					if (bimg.getWidth() != bimg.getHeight() || bimg.getWidth() < 200) {
						isError = true;
						errImg = "Ảnh phải có kích thước lớn hơn 200px và là hình vuông";
					}
				}
				if (fileItem.getSize() > 1024000000) {
					isError = true;
					errImg = "Kích thước của ảnh nhiều nhất là 1MB";
				}
			}

			String firstName = (String) params.get("firstName");
			String lastName = (String) params.get("lastName");
			String password = (String) params.get("pwd");
			String email = (String) params.get("email");
			String gender = (String) params.get("gender");
			String phoneNumber = (String) params.get("phoneNumber");
			String userName = (String) params.get("userName");
			User checkUser = udao.getUserByID(userID);

			String errUserName = "";
			String errFirstName = "";
			String errLastName = "";
			String errPassword = "";
			String errGender = "";
			String errPhoneNumber = "";
			String errEmail = "";

			if (checkUser.getUserName() == null) {
				if (udao.checkUserName(userName)) {
					isError = true;
					errUserName = "Tài khoản này đã có trong hệ thống";
				} else if (!udao.isValidUsername(userName)) {
					isError = true;
					errUserName = "Tên tài khoản không hợp lệ";
				} else if (userName == null || userName == "") {
					isError = true;
					errUserName = "Tên tài khoản không hợp lệ";
				}
			}

			if (firstName == null || firstName.trim().isEmpty()) {
				isError = true;
				errFirstName = "Tên không được để trống";
			}
			if (lastName == null || lastName.trim().isEmpty()) {
				isError = true;
				errLastName = "Họ không được để trống";
			}
			if (password == null || password.trim().isEmpty()) {
				isError = true;
				errPassword = "Password không được để trống";
			}
			if(password != null && password.length() <32) {
				password = SecurityUtils.hashMD5(password);
			}
			if (email == null || email.trim().isEmpty()) {
				isError = true;
				errEmail = "Email không được để trống";
			}
			if (gender == null || gender.trim().isEmpty()) {
				isError = true;
				errGender = "Giới tính không được để trống";
			}
			if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
				isError = true;
				errPhoneNumber = "Password không được để trống";
			}
			Long nb = null;
			try {
				nb = Long.parseLong(phoneNumber);
			} catch (Exception e) {
				isError = true;
				errPhoneNumber = "Số điện thoại không được nhập chữ";
			}
			if (nb != null) {
				if (nb.longValue() < 0) {
					isError = true;
					errPhoneNumber = "Số điện thoại không được nhỏ hơn 0";
				}
			}
			if (!isError) {
				try {
					fileItem.write(new File(
							request.getServletContext().getRealPath("/images/user") + "/" + userID + fileType));
				} catch (Exception e) {
					e.printStackTrace();
				}
				User user = udao.getUserByID(userID);
				if (checkUser.getUserName() == null) {
					user.setUserName(userName);
				}
				user.setFirstName(firstName);
				user.setLastName(lastName);
				user.setEmail(email);
				user.setGender(gender);
				user.setPassword(password);
				user.setPhone(phoneNumber);
				System.out.println(user.getPhone());
				if (fileName != null && !fileName.trim().isEmpty()) {
					user.setAvatar(userID + fileType);
				}
				udao.update(user);

			} else {

				request.setAttribute("errUserName", errUserName);
				request.setAttribute("errEmail", errEmail);
				request.setAttribute("errFirstName", errFirstName);
				request.setAttribute("errLastName", errLastName);
				request.setAttribute("errPassword", errPassword);
				request.setAttribute("errGender", errGender);
				request.setAttribute("errImg", errImg);
				request.setAttribute("errPhoneNumber", errPhoneNumber);

			}
			getServletContext().getRequestDispatcher("/user/change-info.jsp").forward(request, response);
		}
	}

	private String editFromAdmin(HttpServletRequest request) {
		String url = "/admin/user/user.jsp";
		boolean isError = false;
		long userID = Long.parseLong(request.getParameter("userID"));
		String userName = request.getParameter("userName");
		String firstName = request.getParameter("userFirstName");
		String lastName = request.getParameter("userLastName");
		String password = request.getParameter("userPassword");
		String phone = request.getParameter("userPhone");
		String email = request.getParameter("userEmail");

		User user = udao.getUserByID(userID);
		if (userName == null || userName.trim().isEmpty()) {
			isError = true;
		}
		if (firstName == null || firstName.trim().isEmpty()) {
			isError = true;
		}
		if (lastName == null || lastName.trim().isEmpty()) {
			isError = true;
		}
		if (password == null || password.trim().isEmpty()) {
			isError = true;
		}

		if (password.length() >= 32) {

		} else {
			password = SecurityUtils.hashMD5(password);
		}

		long userPhone = -1;
		try {
			userPhone = Long.parseLong(phone);
		} catch (NumberFormatException e) {
			isError = true;
		}
		if (userPhone == -1) {
			isError = true;
		}

		if (email == null || email.trim().isEmpty()) {
			isError = true;
		} else if (!user.getEmail().equals(email)) {
			if (udao.checkEmail(email)) {
				isError = true;
			}
		}

		if (isError) {
			url = "/admin/user/edit.jsp";
		} else {
			user.setPhone(phone);
			user.setUserName(userName);
			user.setFirstName(firstName);
			user.setLastName(lastName);
			user.setPassword(password);
			user.setEmail(email);
			udao.update(user);
		}

		return url;
	}

	private String addFromAdmin(HttpServletRequest request) {
		String url = "/admin/user/user.jsp";
		boolean isError = false;
		String userName = request.getParameter("userName");
		String firstName = request.getParameter("userFirstName");
		String lastName = request.getParameter("userLastName");
		String password = request.getParameter("userPassword");
		String phone = request.getParameter("userPhone");
		String email = request.getParameter("userEmail");

		if (userName == null || userName.trim().isEmpty()) {
			isError = true;
		}

		if (firstName == null || firstName.trim().isEmpty()) {
			isError = true;
		}

		if (lastName == null || lastName.trim().isEmpty()) {
			isError = true;
		}

		if (password == null || password.trim().isEmpty()) {
			isError = true;
		}

		long userPhone = -1;
		try {
			userPhone = Long.parseLong(phone);

		} catch (NumberFormatException e) {
			isError = true;
		}

		if (userPhone == -1) {
			isError = true;
		}

		if (email == null || email.trim().isEmpty()) {
			isError = true;
		} else if (udao.checkEmail(email)) {
			isError = true;
		}

		if (isError) {
			url = "/admin/user/add.jsp";
		} else {
			User u = new User();
			u.setPhone(phone);
			u.setUserName(userName);
			u.setFirstName(firstName);
			u.setLastName(lastName);
			u.setPassword(SecurityUtils.hashMD5(password));
			u.setEmail(email);
			udao.add(u);
		}

		return url;
	}

	private String edit(HttpServletRequest request) {
		String url;
		url = "/register.jsp";
		boolean isError = false;
		String userName = request.getParameter("userName");
		String userEmail = request.getParameter("userEmail");
		String password = request.getParameter("password");
		String lastName = request.getParameter("lastName");
		String firstName = request.getParameter("firstName");
		String userPhone = request.getParameter("userPhone");
		String checkPolicy = request.getParameter("checkPolicy");
		String gender = request.getParameter("gender");
		if (lastName == null || lastName.trim().isEmpty()) {
			lastName = "";
		}
		if (firstName == null || firstName.trim().isEmpty()) {
			firstName = "";
		}
		if (userPhone == null || userPhone.trim().isEmpty()) {
			userPhone = "";
		}

		String errUserName = "";
		String errUserEmail = "";
		String errPassword = "";
		String errPhoneNumber = "";
		String errGender = "";
		// if (userName == null || userEmail == null ||
		// userName.trim().equals("") || udao.checkUserName(userName)
		// || udao.checkEmail(userEmail) || userEmail.trim().equals("") ||
		// password == null
		// || password.trim().equals("") || password.trim().length() < 8 ||
		// ) {
		url = "/register.jsp";
		if (userName == null || userName.trim().equals("")) {
			isError = true;
			errUserName = "User name không được để trống";
		} else if (udao.checkUserName(userName)) {
			isError = true;
			errUserName = "Tài khoản này đã có người sử dụng";
		} else if (userName.contains(" ")) {
			isError = true;
			errUserName = "Tên tài khoản không được chứa khoảng trắng";
		} else if (!udao.isValidUsername(userName)) {
			isError = true;
			errUserName = "Tên tài khoản không được chứa kí tự đặc biệt";
		}
		if (userEmail == null || userEmail.trim().equals("")) {
			errUserEmail = "Email không được để trống";
			isError = true;
		} else if (udao.checkEmail(userEmail)) {
			isError = true;
			errUserEmail = "Email này đã có người sử dụng";
		} else if (!udao.isValidEmailAddress(userEmail)) {
			isError = true;
			errUserEmail = "Email này không hợp lệ";
		}
		if (password == null || password.trim().equals("")) {
			isError = true;
			errPassword = "Password không được để trống";
		} else if (password.trim().length() < 8) {
			errPassword = "Password phải có độ dài ít nhất là 8 kí tự";
			isError = true;
		}
		if (!userPhone.isEmpty()) {
			try {
				Long.parseLong(userPhone);
			} catch (NumberFormatException ex) {
				errPhoneNumber = "Bạn phải nhập số";
				userPhone = "";
				isError = true;
			}
		}

		if (gender == null) {
			errGender = "Bạn phải chọn giới tính";
			isError = true;
		}

		request.setAttribute("errUserName", errUserName);
		request.setAttribute("errUserEmail", errUserEmail);
		request.setAttribute("errPassword", errPassword);
		request.setAttribute("errPhoneNumber", errPhoneNumber);
		request.setAttribute("errGender", errGender);

		request.setAttribute("userName", userName);
		request.setAttribute("userEmail", userEmail);
		request.setAttribute("password", password);
		request.setAttribute("lastName", lastName);
		request.setAttribute("firstName", firstName);
		request.setAttribute("userPhone", userPhone);
		request.setAttribute("gender", gender);

		if (!isError && checkPolicy != null) {
			url = "/index.jsp";
			User newU = new User();
			newU.setEmail(userEmail);
			newU.setPassword(password);
			newU.setUserName(userName);
			newU.setPhone(userPhone);
			newU.setFirstName(firstName);
			newU.setLastName(lastName);
			newU.setGender(gender);
			udao.add(newU);
			// HttpSession session = request.getSession();
			// session.setAttribute("user", newU);
		} else {
			url = "/register.jsp";
		}
		return url;
	}

	private String logout(HttpServletRequest request) {
		String url;
		HttpSession session = request.getSession();
		session.invalidate();
		url = "/index.jsp";
		return url;
	}

	private String login(HttpServletRequest request) {
		String url;
		url = "/index.jsp";
		String from = request.getParameter("from");
		boolean isError = false;
		if (from == null) {
			from = "user";
		}
		if (from.equals("admin")) {
			url = "/admin/index.jsp";
		}
		String userName = request.getParameter("userName");
		String password = SecurityUtils.hashMD5(request.getParameter("password"));
		User u = udao.login(userName, password);
		String errorLogin = "";

		if (u == null) {
			isError = true;
			errorLogin = "Tài khoản hoặc mật khẩu không đúng";
		}
		if (userName == null || userName.trim().isEmpty() || password == null || password.trim().isEmpty()) {
			isError = true;
			errorLogin = "Bạn phải điền tài khoản hoặc mật khẩu";
		}
		String errCaptcha = "";
		if (from.equals("user")) {
			String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
			boolean valid = CaptchaUltis.verify(gRecaptchaResponse);
			if (!valid) {
				isError = true;
				errCaptcha = "Captcha invalid";
			}
		}

		if (!isError) {
			HttpSession session = request.getSession();
			session.setAttribute("user", u);
			if (from.equals("admin")) {
				url = "/admin/index.jsp";
			} else
				url = "/index.jsp";
		} else {
			request.setAttribute("errorLogin", errorLogin);
			request.setAttribute("errCaptcha", errCaptcha);
			if (from.equals("admin")) {
				url = "/admin/login.jsp";
			} else
				url = "/login.jsp";
		}

		// if (userName.trim().isEmpty() || password.trim().isEmpty()) {
		// url = "/login.jsp";
		// request.setAttribute("errorLogin", errorLogin);
		// } else if (u == null) {
		// String errorLogin = "Tài khoản hoặc mật khẩu không đúng";
		// request.setAttribute("errorLogin", errorLogin);
		// url = "/login.jsp";
		// } else {
		// HttpSession session = request.getSession();
		// session.setAttribute("user", u);
		// }
		return url;
	}

	private String reigster(HttpServletRequest request) {
		String url;
		url = "/register.jsp";
		boolean isError = false;
		String userName = request.getParameter("userName");
		String userEmail = request.getParameter("userEmail");
		String password =request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");
		String lastName = request.getParameter("lastName");
		String firstName = request.getParameter("firstName");
		String userPhone = request.getParameter("userPhone");
		String checkPolicy = request.getParameter("checkPolicy");
		String gender = request.getParameter("gender");
		if (lastName == null || lastName.trim().isEmpty()) {
			lastName = "";
		}
		if (firstName == null || firstName.trim().isEmpty()) {
			firstName = "";
		}
		if (userPhone == null || userPhone.trim().isEmpty()) {
			userPhone = "";
		}

		String errUserName = "";
		String errUserEmail = "";
		String errPassword = "";
		String errPhoneNumber = "";
		String errGender = "";
		// if (userName == null || userEmail == null ||
		// userName.trim().equals("") || udao.checkUserName(userName)
		// || udao.checkEmail(userEmail) || userEmail.trim().equals("") ||
		// password == null
		// || password.trim().equals("") || password.trim().length() < 8 ||
		// ) {
		url = "/register.jsp";
		if (userName == null || userName.trim().equals("")) {
			isError = true;
			errUserName = "User name không được để trống";
		} else if (udao.checkUserName(userName)) {
			isError = true;
			errUserName = "Tài khoản này đã có người sử dụng";
		} else if (userName.contains(" ")) {
			isError = true;
			errUserName = "Tên tài khoản không được chứa khoảng trắng";
		} else if (!udao.isValidUsername(userName)) {
			isError = true;
			errUserName = "Tên tài khoản không được chứa kí tự đặc biệt";
		}
		if (userEmail == null || userEmail.trim().equals("")) {
			errUserEmail = "Email không được để trống";
			isError = true;
		} else if (udao.checkEmail(userEmail)) {
			isError = true;
			errUserEmail = "Email này đã có người sử dụng";
		} else if (!udao.isValidEmailAddress(userEmail)) {
			isError = true;
			errUserEmail = "Email này không hợp lệ";
		}
		if (password == null || password.trim().equals("")) {
			isError = true;
			errPassword = "Password không được để trống";
		} else if (!password.equals(confirmPassword)) {
			errPassword = "Mật khẩu và xác nhận mật khẩu phải trùng khớp";
			password = "";
			isError = true;
			confirmPassword = "";
		} else if (password.trim().length() < 8) {
			errPassword = "Password phải có độ dài ít nhất là 8 kí tự";
			isError = true;
		}
		if (!userPhone.isEmpty()) {
			try {
				Long.parseLong(userPhone);
			} catch (NumberFormatException ex) {
				errPhoneNumber = "Bạn phải nhập số";
				userPhone = "";
				isError = true;
			}
		}

		if (gender == null) {
			errGender = "Bạn phải chọn giới tính";
			isError = true;
		}

		request.setAttribute("errUserName", errUserName);
		request.setAttribute("errUserEmail", errUserEmail);
		request.setAttribute("errPassword", errPassword);
		request.setAttribute("errPhoneNumber", errPhoneNumber);
		request.setAttribute("errGender", errGender);

		request.setAttribute("userName", userName);
		request.setAttribute("userEmail", userEmail);
		request.setAttribute("password", password);
		request.setAttribute("confirmPassword", confirmPassword);
		request.setAttribute("lastName", lastName);
		request.setAttribute("firstName", firstName);
		request.setAttribute("userPhone", userPhone);
		request.setAttribute("gender", gender);

		if (!isError && checkPolicy != null) {
			url = "/index.jsp";
			User newU = new User();
			newU.setEmail(userEmail);
			newU.setPassword( SecurityUtils.hashMD5(password));
			newU.setUserName(userName);
			newU.setPhone(userPhone);
			newU.setFirstName(firstName);
			newU.setLastName(lastName);
			newU.setGender(gender);
			udao.add(newU);
			// HttpSession session = request.getSession();
			// session.setAttribute("user", newU);
		} else {
			url = "/register.jsp";
		}
		return url;
	}

}
