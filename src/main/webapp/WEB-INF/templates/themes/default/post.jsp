<%--
  Created by IntelliJ IDEA.
  User: jiege
  Date: 18-6-6
  Time: 上午11:20
  To change this template use File | Settings | File Templates.
  下面页面中，有很多东西没有处理，不能直接使用
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="dateValue" class="java.util.Date"></jsp:useBean>
<c:set var="title" value="${article.title}"></c:set>
<c:set var="keywords" value="${article.tags}"></c:set>
<c:import url="./partial/header.jsp"></c:import>
<article class="main-content page-page" itemscope itemtype="http://schema.org/Article">
    <div class="post-header">
        <h1 class="post-title" itemprop="name headline">
            <!-- 所有带括号的函数都没有处理 -->
            <a href="${site_url}/article/${article.cid}">${article.title}</a>
        </h1>
        <div class="post-data">
            <!-- 时间函数同样没有处理 -->
            <jsp:setProperty name="dateValue" property="time" value="${article.created}"/>
            <time datetime="<fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd"/>" itemprop="datePublished">发布于 <fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd"/></time>
            / ${article.categories} / <a href="#comments">${article.commentsNum == null ? "没有" : article.commentsNum}评论</a> /
            ${article.hits}浏览
        </div>
    </div>
    <div id="post-content" class="post-content" itemprop="articleBody">
        <p class="post-tags">
            <c:set var="tags" value="${fn:split(article.tags,',')}"/>
            <c:forEach items="${tags}" var="tag">
                <a href="/Blog/tag/${tag}">${tag}</a>
            </c:forEach>
        </p>
        <div id="content">${article.content}</div>
        <p class="post-info">
            本文由 <a href="">${options.writer == null ?'fengjie': options.writer}</a> 创作，采用 <a href="https://creativecommons.org/licenses/by/4.0/" target="_blank" rel="external nofollow">知识共享署名4.0</a> 国际许可协议进行许可<br>本站文章除注明转载/出处外，均为本站原创或翻译，转载前请务必署名<br>最后编辑时间为:
            <c:if test="${article.modified != null}">
                <jsp:setProperty name="dateValue" property="time" value="${article.modified}"/>
                <fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd hh:mm:ss"/>
            </c:if>
            <c:if test="${article.modified == null}">
                <fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd hh:mm:ss"/>
            </c:if>
        </p>
    </div>
</article>
<div id="post-bottom-bar" class="post-bottom-bar">
    <div class="bottom-bar-inner">
        <div class="bottom-bar-items social-share left">
            <span class="bottom-bar-item">Share : </span>
            <span class="bottom-bar-item bottom-bar-facebook"><a href="https://www.facebook.com/sharer/sharer.php?u=${site_url}/article/${article.cid}" target="_blank" title="${article.title}" rel="nofollow">facebook</a></span>
            <span class="bottom-bar-item bottom-bar-twitter"><a href="https://twitter.com/intent/tweet?url=${site_url}/article/${article.cid}&text=${article.title}" target="_blank" title="${article.title}" rel="nofollow">Twitter</a></span>
            <span class="bottom-bar-item bottom-bar-weibo"><a href="http://service.weibo.com/share/share.php?url=${site_url}/article/${article.cid}&amp;title=${article.title}" target="_blank" title="${article.title}" rel="nofollow">Weibo</a></span>
            <span class="bottom-bar-item bottom-bar-qrcode"><a href="//pan.baidu.com/share/qrcode?w=300&amp;h=300&amp;url=${site_url}/article/${article.cid}" target="_blank" rel="nofollow">QRcode</a></span>
        </div>
        <div class="bottom-bar-items right">
            <%--<span class="bottom-bar-item">${thePrev('→')}</span>
            <span class="bottom-bar-item">${theNext('←')}</span>--%>
            <span class="bottom-bar-item"><a href="#footer">↓</a></span>
            <span class="bottom-bar-item"><a href="#">↑</a></span>
        </div>
    </div>
</div>
<c:import url="./partial/comments.jsp"></c:import>
<c:import url="./partial/footer.jsp"></c:import>
