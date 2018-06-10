<%--
  Created by IntelliJ IDEA.
  User: jiege
  Date: 18-6-5
  Time: 下午10:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="social-list">
    <c:if test="${options.weibo != null && options.weibo.length() > 0}">
    <a class="social weibo" target="blank" href="http://weibo.com/${options.weibo}">微博</a>
    </c:if>

    <c:if test="${options.zhihu != null && options.zhihu.length() > 0}">
    <a class="social zhihu" target="blank"
       href="https://www.zhihu.com/people/${options.zhihu}">知乎</a>
    </c:if>

    <a class="social rss" target="blank" href="/feed">RSS</a>

    <c:if test="${options.github != null && options.github.length() > 0}">
    <a class="social github" target="blank"
       href="https://github.com/${options.github}">Github</a>
    </c:if>

    <c:if test="${options.twitter != null && options.twitter.length() > 0}">
    <a class="social twitter" target="blank" href="https://twitter.com/${options.twitter}">Twitter</a>
    </c:if>
</div>
