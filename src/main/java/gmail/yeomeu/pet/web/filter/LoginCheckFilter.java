package gmail.yeomeu.pet.web.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import gmail.yeomeu.pet.dto.User;

/**
 * Servlet Filter implementation class LoginCheckFilter
 */
public class LoginCheckFilter implements Filter {

	/*
	 * 1. (자료구조) 로그인이 필요한 URI들을 모아놓음!
	 */
	List<String> loginURIs = new ArrayList<>();
    public LoginCheckFilter() {
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		System.out.println("[BEFORE] " + req.getRequestURI());
		String uri = stripeUri ( req ); // "/board/write"
		System.out.println("[uri] " + uri);
		
		if (loginURIs.contains(uri) || partialEqials(uri)) {
			
			System.out.println("[CONTANIS] " + uri);
			
			HttpSession session = req.getSession();
			User loginUser = (User) session.getAttribute("loginUser");
			if (loginUser == null) {
				// session에다 이 사람이 원래 가려고 했던 경로를 담아둡니다.
				session.setAttribute("nextUrl", uri); // "/memo/write/232"
				res.sendRedirect( req.getContextPath() + "/login");
				return ;
			}
		}
		// uri가 로그인 확인이 필요한 uri인지 확인함!
		// pass the request along the filter chain
		chain.doFilter(request, response);
		System.out.println("[AFTER ] " + req.getRequestURI());
	}

	private boolean partialEqials(String uri) {
		for ( int i = 0 ; i < loginURIs.size() ; i ++ ) {
			String each = loginURIs.get(i);
			
			if (uri.startsWith(each)){
				return true;
			}
		}
		return false;
	}

	private String stripeUri(HttpServletRequest req) {
		String fullUri = req.getRequestURI() ; // "/webboard/board/write
		String ctxpath = req.getContextPath(); // "/pet"
		return fullUri.substring(ctxpath.length());
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	// 웹 컨테이너가 초기화된 후에 이 메소드를 한 번 호출해주기로 약속했씁니다.
	public void init(FilterConfig fConfig) throws ServletException {
		// loginURIs.add("/pet");
		// loginURIs.add("/pet/join");
		// loginURIs.add("/pet/login");
		loginURIs.add("/myinfo");
	}
}