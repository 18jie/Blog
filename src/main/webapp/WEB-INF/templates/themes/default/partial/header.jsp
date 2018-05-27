<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<meta name="renderer" content="webkit">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta http-equiv="Cache-Control" content="no-transform" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<meta name="keywords" content="博客系统,ssm框架" />
<meta name="description" content="博客系统,ssm框架" />
<link rel="shortcut icon" href="/Blog/WEB-INF/templates/themes/default/static/img/favicon.png" />
<link rel="apple-touch-icon" href="/Blog/WEB-INF/templates/themes/default/static/img/apple-touch-icon.png"/>
    <title>${head_title}</title>
    <link href="/Blog/WEB-INF/templates/themes/default/static/css/xcode.min.css" rel="stylesheet">
    <link href="/Blog/WEB-INF/templates/themes/default/static/css/style.min.css" rel="stylesheet">
            <script src="/Bolg/resources/static/admin/plugins/jquery/3.2.1/jquery-3.2.1.js"></script>

<!--[if lt IE 9]>
    <script src="//cdn.bootcss.com/html5shiv/r29/html5.min.js"></script>
    <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<!-- #if(!is_post) class="bg-grey" #end -->
<body <c:if test="${!is_post}">class="bg-grey"</c:if>  gtools_scp_screen_capture_injected="true">
<!--[if lt IE 8]>
<div class="browsehappy" role="dialog">
    当前网页 <strong>不支持</strong> 你正在使用的浏览器. 为了正常的访问, 请 <a href="http://browsehappy.com/" target="_blank">升级你的浏览器</a>。
</div>
<![endif]-->
<header id="header" class="header bg-white">
    <div class="navbar-container">
        <a href="${site_url()}" class="navbar-logo">
        	<c:if test="${logo_url == ''}">
        		<img src="${theme_url('/static/img/logo.png')}" alt="${site_title()}"/>
        	</c:if>
            <c:if test="${logo_url != ''}">
            	<img src="${theme_option('logo_url')}" alt="${site_title()}"/>
            </c:if>
        </a>
        <div class="navbar-menu">
        	<!-- 各个地址的链接 -->
            <a href="${site_url('/archives')}">归档</a>
            <a href="${site_url('/links')}">友链</a>
            <a href="${site_url('/about')}">关于</a>
        </div>
        <div class="navbar-search" onclick="">
            <span class="icon-search"></span>
            <form role="search" onsubmit="return false;">
                <span class="search-box">
                    <input type="text" id="search-inp" class="input" placeholder="搜索..." maxlength="30"
                           autocomplete="off">
                </span>
            </form>
        </div>
        <div class="navbar-mobile-menu" onclick="">
            <span class="icon-menu cross"><span class="middle"></span></span>
            <ul>
                <li><a href="${site_url('/archives')}">归档</a></li>
                <li><a href="${site_url('/links')}">友链</a></li>
                <li><a href="${site_url('/about')}">关于</a></li>
            </ul>
        </div>
    </div>
</header>