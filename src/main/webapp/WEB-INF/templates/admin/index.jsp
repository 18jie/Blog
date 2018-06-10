<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="dataValue" class="java.util.Date"></jsp:useBean>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="active" value="home" scope="request"></c:set>
<c:set var="title" value="管理中心" scope="request"></c:set>
<c:import url="/WEB-INF/templates/admin/header.jsp"></c:import>
<div class="row">
	<div class="col-sm-12">
		<h4 class="page-title">Tale仪表盘</h4>
	</div>

	<div class="row">
		<div class="col-sm-6 col-lg-3">
			<div class="mini-stat clearfix bx-shadow bg-info">
				<span class="mini-stat-icon"><i class="fa fa-quote-right"
					aria-hidden="true"></i></span>
				<div class="mini-stat-info text-right">
					发表了<span class="counter">${statistics.articles}</span>篇文章
				</div>
			</div>
		</div>
		<div class="col-sm-6 col-lg-3">
			<div class="mini-stat clearfix bg-purple bx-shadow">
				<span class="mini-stat-icon"><i class="fa fa-comments-o"
					aria-hidden="true"></i></span>
				<div class="mini-stat-info text-right">
					收到了<span class="counter">${statistics.comments}</span>条留言
				</div>
			</div>
		</div>

		<div class="col-sm-6 col-lg-3">
			<div class="mini-stat clearfix bg-success bx-shadow">
				<span class="mini-stat-icon"><i class="fa fa-cloud-upload"
					aria-hidden="true"></i></span>
				<div class="mini-stat-info text-right">
					上传了<span class="counter">${statistics.attachs}</span>个附件
				</div>
			</div>
		</div>

	</div>

	<div class="row">
		<div class="col-md-4">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h4 class="panel-title">最新文章</h4>
				</div>
				<div class="panel-body">
					<c:if test="${aritcles.size() == 0 || articles == null}">
						<div class="alert alert-warning">你还没有发表文章.</div>
					</c:if>
					<ul class="list-group">
						<c:forEach items="${articles}" var="article">
							<li class="list-group-item"><span
								class="badge badge-primary" title="${article.hits == null ? 0 : article.hits}次浏览">${article.hits == null ? 0 : article.hits}</span>
								<a target="_blank"
								href="${pageContext.request.contextPath}/article/${article.cid}">${article.title}</a>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
		<div class="col-md-4">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h4 class="panel-title">最新留言</h4>
				</div>
				<div class="panel-body">
					<c:if test="${comments==null || comments.size() == 0}">
						<div class="alert alert-warning">还没有收到留言.</div>
					</c:if>
					<c:if test="${comments!=null}">
						<ul class="list-group">
							<c:forEach items="${comments}" var="comment">
								<li class="list-group-item"><c:if
										test="${comment.url!=null && comment.url != ''}">
										<a href="${comment.url}" target="_blank">${comment.author}</a>
									</c:if> <c:if test="${comment.url==null || comment.url == '' }">
                        	${comment.author}
                        	<jsp:setProperty property="time"
											name="dataValue" value="${comment.created}" />
									</c:if> 于<fmt:formatDate value="${dataValue}" pattern="MM月dd日HH:mm" />
									：<a href="${site_url('/article/')}${comment.cid}#comments"
									target="_blank">${article(comment.content)}</a></li>
							</c:forEach>
						</ul>
					</c:if>
				</div>
			</div>
		</div>
		<div class="col-md-4">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h4 class="panel-title">系统日志</h4>
				</div>
				<div class="panel-body">
					<ul class="list-group">
						<c:if test="${logs!=null}">
							<c:forEach items="${logs}" var="log">
								<jsp:setProperty property="time" name="dataValue"
									value="#{log.created}" />
								<li class="list-group-item"><span><fmt:formatDate
											value="${dataValue}" pattern="yyyy-MM-dd HH:mm:ss" /> =>
										${log.action}</span></li>
							</c:forEach>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<c:import url="/WEB-INF/templates/admin/footer.jsp"></c:import>
</body>
</html>