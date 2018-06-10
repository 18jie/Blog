<%--
  Created by IntelliJ IDEA.
  User: jiege
  Date: 18-6-6
  Time: 上午9:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--#include('./partial/header.html',{home_page:1})--%>
<!-- 进入主页面默认第一个页面 -->
<c:import url="./partial/header.jsp"></c:import>
<div class="main-content index-page clearfix">
    <div class="post-lists">
        <div class="post-lists-body">
            <c:forEach var="article" items="${articles}">
            <div class="post-list-item">
                <div class="post-list-item-container">
                    <!-- 这个地址不一定能行,EL表达式不能使用余数符号 -->
                    <div class="item-thumb bg-deepgrey" style="background-image:url(/Blog/resources/static/templates/img/rand/${article.cid%20+1}.jpg);"></div>
                    <a href="/Blog/article/${article.cid}">
                        <div class="item-desc">
                            <p>${fn:substring(article.content,0 ,75 )}...</p>
                        </div>
                    </a>
                    <div class="item-slant reverse-slant bg-deepgrey"></div>
                    <div class="item-slant"></div>
                    <div class="item-label">
                        <div class="item-title"><a href="/Blog/article/${article.cid}">${article.title}</a>
                        </div>
                        <div class="item-meta clearfix">
                            <div class="item-meta-ico bg-ico-${icons[article.cid%8]}"
                                 style="background: url(/Blog/resources/static/templates/img/bg-ico.png) no-repeat;background-size: 40px auto;"></div>
                            <div class="item-meta-cat">
                                <a href="/Blog/category/${article.categories}">${article.categories}</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </c:forEach>
        </div>
    </div>
    <div class="lists-navigator clearfix">
       <%-- #call pageNav(articles(12),'←','→','page')--%>
        <ol class="page-navigator">
            <c:if test="${page.present > 1}">
                <li class="prev"><a href="/Blog/page/${page.present - 1}">←</a></li>
            </c:if>
            <c:forEach begin="${page.begin}" end="${page.end}" var="num" step="1">
                <li class="<c:if test='${page.present == num}'>current</c:if>"><a href="/Blog/page/${num}">${num}</a></li>
            </c:forEach>
            <c:if test="${page.present < page.end}">
                <li class="next"><a href="/Blog/page/${page.present + 1}">→</a></li>
            </c:if>
        </ol>
    </div>
</div>
<c:import url="./partial/footer.jsp"></c:import>
