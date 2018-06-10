package com.fengjie.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.fengjie.kit.StringUtils;

public class LoginInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		if(StringUtils.isStaticResources(request.getRequestURI())) {
			return true;
		}
		
		if(request.getSession().getAttribute("user") != null) {
			return true;
		}
		System.out.println("经过一次拦截" + request.getRequestURI());
//		request.getRequestDispatcher(request.getContextPath() + "/admin/login").forward(request, response);
		response.sendRedirect(request.getContextPath() + "/admin/login");
		return false;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}

	
	
}
