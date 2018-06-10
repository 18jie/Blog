<%--
  Created by IntelliJ IDEA.
  User: jiege
  Date: 18-6-6
  Time: 上午9:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="dateValue" class="java.util.Date"></jsp:useBean>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="title" value="${article.title}" scope="request"></c:set>
<c:import url="./partial/header.jsp"></c:import>
<article class="main-content page-page">
    <div class="post-header">
        <!-- 标题，暂未处理 -->
        <h1 class="post-title" itemprop="name headline">${article.title}</h1>
        <div class="post-data">
            <!-- 下面的时间现在还没有处理 -->
            <jsp:setProperty name="dateValue" property="time" value="${article.created}"></jsp:setProperty>
            <time datetime="<fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd"/>" itemprop="datePublished">发布于 <fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd"/></time>
        </div>
    </div>
    <div id="post-content" class="post-content">${article.content}</div>
</article>
<c:import url="./partial/comments.jsp"></c:import>
<c:import url="./partial/footer.jsp"></c:import>
