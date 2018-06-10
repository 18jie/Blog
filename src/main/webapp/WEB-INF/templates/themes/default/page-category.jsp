<%--
  Created by IntelliJ IDEA.
  User: jiege
  Date: 18-6-6
  Time: 上午11:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="dateValue" class="java.util.Date"></jsp:useBean>
<c:set var="title" value="${keyword}" scope="request"></c:set>
<c:import url="./partial/header.jsp"></c:import>
<div class="main-content common-page clearfix">
    <div class="categorys-item">
        <div class="common-title">
            ${type}：${keyword}
        </div>
        <c:if test="${null == articles && articles.isEmpty()}">
        <div>
            <p>抱歉，还没有相关文章.</p>
        </div>
        </c:if>
        <c:if test="${null != articles && !articles.isEmpty()}">
        <div class="post-lists">
            <div class="post-lists-body">
                <c:forEach var="article" items="${articles}">
                <div class="post-list-item">
                    <div class="post-list-item-container ">
                        <div class="item-label ">
                            <div class="item-title">
                                <!-- 下面带括号的函数内容没有处理 -->
                                <a href="${site_url}/article/${article.cid}">${article.title}</a>
                            </div>
                            <div class="item-meta clearfix">
                                <div class="item-meta-ico bg-ico-${icons[article.cid%8]}"
                                     style="background: url(/Blog/resources/static/templates/img/bg-ico.png) no-repeat;background-size: 40px auto;"></div>
                                <jsp:setProperty name="dateValue" property="time" value="${article.created}"/>
                                <div class="item-meta-date">发布于 <fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd"/></div>
                            </div>
                        </div>
                    </div>
                </div>
                </c:forEach>
            </div>
        </div>
        </c:if>
    </div>
</div>
<c:import url="./partial/footer.jsp"></c:import>
