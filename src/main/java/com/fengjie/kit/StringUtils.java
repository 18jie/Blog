package com.fengjie.kit;


public class StringUtils {
	
	public static boolean hasLength(String inStr) {
		return   inStr != null && !"".equals(inStr.trim());
	}
	
	public static boolean isValidEmail(String email) {
		return !isStartWithSpecialChar(email) && email.endsWith(".com") && email.contains("@") && !email.contains(" ");
	}
	
	public static boolean isStartWithSpecialChar(String inStr) {
		int ascii = (int)inStr.charAt(0);
		if((48 <= ascii && ascii <= 57) || (97 <= ascii && ascii <= 122) || (65 <= ascii && ascii <= 90)) {
			return false;
		}
		return true;
	}
	
	//判断请求路径是否的请求的静态资源,供interceptor使用
	public static boolean isStaticResources(String uri) {
		if(uri.startsWith("/Blog/resources/static")) {
			return true;
		}
		if(uri.startsWith("/resources/static")) {
			return true;
		}
		return false;
	}
	
	
}
