package com.hybrid.filter;

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

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Servlet Filter implementation class LoginFilter
 */
/*@WebFilter("/LoginFilter")*/		/*web.xml에 설정 하닌깐 필요 없음.*/
public class LoginFilter implements Filter {
	
	static Log log = LogFactory.getLog(LoginFilter.class);

    /**
     * Default constructor. 
     */
    public LoginFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		log.info("destroy()...");
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		log.info("dofilter()...");
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse res = (HttpServletResponse)response;
//		다운 케스팅
		HttpSession session = req.getSession();
		Boolean login =  (Boolean) session.getAttribute("login"); 
		/*넘어오는 값이 null으로 올수 있으니 boolean으로 받는다.*/
		if (login != null && login == true){
			chain.doFilter(request, response);			
		}else{		//login false
			String context = req.getContextPath();
			res.sendRedirect(context + "/user/login.html");
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		log.info("init()...");
		// TODO Auto-generated method stub
	}

}
