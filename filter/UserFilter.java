package filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.User;

/**
 * Servlet Filter implementation class UserFilter
 */
@WebFilter({ "/UserFilter", "/admin/*" })
public class UserFilter implements Filter {

    /**
     * Default constructor. 
     */
    public UserFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res =  (HttpServletResponse) response ;
		
		HttpSession session = req.getSession();
		
		String path = ((HttpServletRequest) request).getRequestURI();
		User user = (User) session.getAttribute("user");
		
		response.setContentType("text/html");
		res.setContentType("text/html");
		if(user!=null && user.isValid()) {
			chain.doFilter(request, response);
		}  else if(path.startsWith(req.getContextPath()+"/admin/css/")){
			chain.doFilter(request, response);
		}
		else {
			res.sendRedirect(req.getContextPath()+"/index.jsp");
			return;
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
