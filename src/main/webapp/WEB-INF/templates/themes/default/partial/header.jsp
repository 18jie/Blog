<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String site_url = request.getServletContext().getContextPath();
    request.setAttribute("site_url",site_url);
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="Cache-Control" content="no-transform"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <meta name="keywords" content="博客系统,Fengjie"/>
    <meta name="description" content="博客系统,Fengjie"/>
    <link rel="shortcut icon" href="/Blog/resources/static/templates/img/favicon.png"/>
    <link rel="apple-touch-icon" href="/Blog/resources/static/templates/img/apple-touch-icon.png"/>
    <title>${options.writer}-${title != null ? title : ""}</title>
    <link href="/Blog/resources/static/templates/css/xcode.min.css" rel="stylesheet">
    <link href="/Blog/resources/static/templates/css/style.min.css" rel="stylesheet">
    <script src="/Blog/resources/static/admin/plugins/jquery/3.2.1/jquery.min.js"></script>
    <script src="/Blog/resources/static/templates/js/strapdown.js"></script>


    <!--[if lt IE 9]>
    <script src="//cdn.bootcss.com/html5shiv/r29/html5.min.js"></script>
    <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body  class="bg-grey"  gtools_scp_screen_capture_injected="true">
<!--[if lt IE 8]>
<div class="browsehappy" role="dialog">
    当前网页 <strong>不支持</strong> 你正在使用的浏览器. 为了正常的访问, 请 <a href="http://browsehappy.com/" target="_blank">升级你的浏览器</a>。
</div>
<![endif]-->
<header id="header" class="header bg-white">
    <div class="navbar-container">
        <a href="/Blog" class="navbar-logo">
            <img src="${site_url}/resources/static/templates/img/favicon.png" alt="${options.writer}"/>${options.writer}
        </a>
        <div class="navbar-menu">
            <a href="${site_url}/archives">归档</a>
            <a href="${site_url}/links">友链</a>
            <a href="${site_url}/about">关于</a>
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
                <li><a href="${site_url}/archives">归档</a></li>
                <li><a href="${site_url}/links">友链</a></li>
                <li><a href="${site_url}/about">关于</a></li>
            </ul>
        </div>
    </div>
</header>