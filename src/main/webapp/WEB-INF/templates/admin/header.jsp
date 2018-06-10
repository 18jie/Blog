<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%--暂时性的修改 --%>
<title>${title == null ?'博客后台' :title}</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta content="biezhi" name="author" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="shortcut icon"
	href="/Blog/resources/static/admin/images/favicon.png" />
<link
	href="/Blog/resources/static/admin/plugins/bootstrap/3.3.7/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="/Blog/resources/static/admin/plugins/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet">
<link
	href="/Blog/resources/static/admin/plugins/limonte-sweetalert2/6.4.1/sweetalert2.min.css"
	rel="stylesheet">

<link href="/Blog/resources/static/admin/css/style.min.css"
	rel="stylesheet" type="text/css">
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
            <script src="/Blog/resources/static/admin/plugins/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="/Blog/resources/static/admin/plugins/respond.js/1.3.0/respond.min.js"></script>

    <![endif]-->
</head>
<!-- 修改静态资源的引用 -->
<!-- 补充实时日志和单元测试 -->
<body class="fixed-left">
	<div id="wrapper">
		<div class="topbar">
			<div class="topbar-left">
				<div class="text-center p-t-10" style="margin: 0 auto;">
					<div class="pull-left" style="padding-left: 10px;">
						<a href="/Blog/admin/index"> <img
							src="/Blog/resources/static/admin/images/unicorn.png" width="50"
							height="50" />
						</a>
					</div>
					<div class="pull-left" style="padding-left: 10px;">
						<span style="font-size: 28px; color: #2f353f; line-height: 50px;">Jie's
							Blog</span>
					</div>
				</div>
			</div>
			<div class="navbar navbar-default" role="navigation">
				<div class="container">
					<div class="">
						<div class="pull-left">
							<button type="button" class="button-menu-mobile open-left">
								<i class="fa fa-bars"></i>
							</button>
							<span class="clearfix"></span>
						</div>

						<ul class="nav navbar-nav navbar-right pull-right">
							<li class="dropdown"><a href="index.html"
								class="dropdown-toggle profile" data-toggle="dropdown"
								aria-expanded="true"> <!--src="$--{gravatar(login_user.email)}"  -->
									<img
									src="https://cn.gravatar.com/avatar/bc4d74ededb30c4ccb5a3e647c7a3163"
									alt="user-img" class="img-circle"></a>
								<ul class="dropdown-menu">
									<!-- 下面的li中填$--{site_url()},发表文章,用来浏览的主页,现在还没做,用# -->
									<li><a href="#" target="_blank"><i class="fa fa-eye"
											aria-hidden="true"></i> 查看网站</a></li>
									<li><a href="/Blog/admin/profile"><i class="fa fa-sun-o"></i>
											个人设置</a></li>
									<!--<li><a href="/admin/reload"><i class="fa fa-sun"></i> 重启系统</a></li>-->
									<!-- 退出登录,退到博客文章主界面 -->
									<li><a href="${pageContext.request.contextPath}/admin/logout"><i
											class="fa fa-sign-out"></i> 注销</a></li>
								</ul></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<div class="left side-menu">
			<div class="sidebar-inner slimscrollleft">
				<div id="sidebar-menu">
					<ul>
						<li <c:if test="${active=='home'}">class="active"</c:if>><a
							href="/Blog/admin/index"
							class="waves-effect <c:if test="${active=='home'}">active</c:if>"><i
								class="fa fa-dashboard" aria-hidden="true"></i><span> 仪表盘
							</span></a></li>
						<li <c:if test="${active=='publish'}">class="active"</c:if>><a
							href="/Blog/admin/article/publish"
							class="waves-effect <c:if test="${active=='publish'}">active</c:if>"><i
								class="fa fa-pencil-square-o" aria-hidden="true"></i><span>
									发布文章 </span></a></li>
						<li <c:if test="${active=='article'}">class="active"</c:if>><a
							href="/Blog/admin/article"
							class="waves-effect <c:if test="${active=='article'}">active</c:if>"><i
								class="fa fa-list" aria-hidden="true"></i><span> 文章管理 </span></a></li>

						<li <c:if test="${active=='page'}">class="active"</c:if>><a
							href="/Blog/admin/page"
							class="waves-effect <c:if test="${active=='page'}">active</c:if>"><i
								class="fa fa-file-text" aria-hidden="true"></i><span>
									页面管理 </span></a></li>

						<li <c:if test="${active=='attach'}">class="active"</c:if>><a
							href="/Blog/admin/attach"
							class="waves-effect <c:if test="${active=='attach'}">active</c:if>"><i
								class="fa fa-cloud-upload" aria-hidden="true"></i><span>
									文件管理 </span></a></li>
						<!-- 此处的has_sub是什么暂时没有.. active subdrop-->
						<li class="has_sub"><a href="javascript:void(0)"
							class="waves-effect <c:if test="${has_sub == 'other'}">active subdrop</c:if>"><i
								class="fa fa-cubes"></i><span> 其他管理 </span><span
								class="pull-right"><i class="fa fa-plus"></i></span></a>
							<ul class="list-unstyled">
								<li <c:if test="${active=='comments'}">class="active"</c:if>><a
									href="/Blog/admin/comments"
									class="waves-effect <c:if test="${active=='comments'}">active</c:if>"><i
										class="fa fa-comments" aria-hidden="true"></i><span>
											评论管理 </span></a></li>
								<li <c:if test="${active=='category'}">class="active"</c:if>><a
									href="/Blog/admin/category"
									class="waves-effect <c:if test="${active=='category'}">active</c:if>"><i
										class="fa fa-tags" aria-hidden="true"></i><span> 分类/标签
									</span></a></li>
								<li <c:if test="${active=='template'}">class="active"</c:if>><a
									href="/Blog/admin/template"
									class="waves-effect <c:if test="${active=='template'}">active</c:if>"><i
										class="fa fa-hashtag"></i><span> 编辑模板 </span></a></li>
							</ul></li>

						<li <c:if test="${active=='themes'}">class="active"</c:if>><a
							href="/Blog/admin/themes"
							class="waves-effect <c:if test="${active=='themes'}">active</c:if>"><i
								class="fa fa-diamond" aria-hidden="true"></i><span> 主题设置
							</span></a></li>

						<li <c:if test="${active=='setting'}">class="active"</c:if>><a
							href="/Blog/admin/setting"
							class="waves-effect <c:if test="${active=='setting'}">active</c:if>"><i
								class="fa fa-gear" aria-hidden="true"></i><span> 系统设置 </span></a></li>
						<c:if test="${pluginMenus != null && pluginMenus.size() != 0}">
							<c:forEach items="${pluginMenus}" var="item">
								<!-- 下面这组标签的class属性有问题,做到后面在修改 -->
								<li <c:if test="${active}==item.slug">class="active"</c:if>><a
									href="/Blog/admin/plugins/${item.slug}"
									class="waves-effect #if(active==item.slug) active #end"><i
										class="${item.icon==null ?item.icon:'fa fa-gear'}"
										aria-hidden="true"></i><span> ${item.name} </span></a></li>
							</c:forEach>
						</c:if>
					</ul>
					<div class="clearfix"></div>
				</div>
				<div class="clearfix"></div>
			</div>
		</div>
		<div class="content-page">
			<div class="content">
				<div class="container">