<%--
  Created by IntelliJ IDEA.
  User: jiege
  Date: 18-6-6
  Time: 上午9:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="dataValue" class="java.util.Date"></jsp:useBean>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="title" value="文章归档" scope="request"></c:set>
<c:import url="./partial/header.jsp"></c:import>
<div class="main-content archive-page clearfix">
    <div class="categorys-item">
        <c:forEach items="${archives}" var="archive">
        <div class="categorys-title">${archive.date_str}</div>
        <div class="post-lists">
            <div class="post-lists-body">
                #for(article : archive.articles)
                <c:forEach items="${archive.articles}" var="article">
                <div class="post-list-item">
                    <div class="post-list-item-container">
                        <div class="item-label">
                            <div class="item-title">
                                <a href="${(permalink())}">${title()}</a>
                            </div>
                            <div class="item-meta clearfix">
                                <!-- 获取创建的时间 -->
                                <jsp:setProperty name="dataValue" property="time" value="${article.created}"></jsp:setProperty>
                                <%--<div class="item-meta-date">发布于 ${created('yyyy-MM-dd')}</div>--%>
                                <div class="item-meta-date">发布于 <fmt:formatDate value="${dataValue}" pattern="yyyy-MM-dd"></fmt:formatDate> </div>
                            </div>
                        </div>
                    </div>
                </div>
                </c:forEach>
            </div>
        </div>
        </c:forEach>
    </div>
</div>
<c:import url="./partial/footer.jsp"></c:import>
