<%--
  Created by IntelliJ IDEA.
  User: jiege
  Date: 18-6-5
  Time: 下午10:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="dataValue" class="java.util.Date"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${article != null}">
<!-- 此页面处理评论相关内容 -->
<div id="${article.cid == null ? 0 : article.cid}" class="comment-container">
    <div id="comments" class="clearfix">
        <c:if test="${article.allowComment}">
        <span class="response"> <c:if test="${null != user}"> Hi，<a href="${user.homeUrl == null ? '/Blog':user.homeUrl}" data-no-instant>${user.username}</a>
            如果你想 <a href="/logout" title="注销" data-no-instant>注销</a> ? </c:if></span>

        <form method="post" id="comment-form" class="comment-form" onsubmit="return TaleComment.subComment();">
            <input type="hidden" name="coid" id="coid"/>
            <input type="hidden" name="cid" id="cid" value="${article.cid}"/>
            <%--<input type="hidden" name="csrf_token" value="${csrf_token}"/>--%>
            <input name="author" maxlength="12" id="author" class="form-control input-control clearfix"
                   placeholder="姓名 (*)" value="${user != null? user.username : ''}" required/>
            <input type="email" name="mail" id="mail" class="form-control input-control clearfix" placeholder="邮箱 (*)"
                   value="${user != null ? user.email : ''}" required/>
            <input type="url" name="url" id="url" class="form-control input-control clearfix" placeholder="网址 (http://)"
                   value="${user != null ? user.homeUrl : ''}"/>
            <textarea name="content" id="textarea" class="form-control" placeholder="大佬，留下你的评论." required minlength="5" maxlength="2000"></textarea>
            <button class="submit" id="misubmit">提交</button>
        </form>
        </c:if>
        <c:if test="${!article.allowComment}">
        <span class="response">评论已关闭.</span>
        </c:if>


        <c:if test="${comments != null && !comments.isEmpty()}">
        <ol class="comment-list">
            <c:forEach var="comment" items="${comments}">
            <li id="li-comment-${comment.coid}" class="comment-body comment-parent comment-odd">
                <div id="comment-${comment.coid}">
                    <div class="comment-view" onclick="">
                        <div class="comment-header">
                            <img class="avatar" src="${gravatar(comment.mail)}?s=80&r=G&d=" title="${comment.author}"
                                 width="80" height="80">
                            <span class="comment-author">
                                <a href="${comment.url}" target="_blank" rel="external nofollow">${comment.author}</a>
                            </span>
                        </div>
                        <div class="comment-content">
                            <span class="comment-author-at"></span>
                            <p>${article(comment.content)}</p>
                        </div>
                        <div class="comment-meta">
                            <time class="comment-time">${fmtdate(comment.created)}</time>
                            <span class="comment-reply">
                                <a rel="nofollow" onclick="TaleComment.reply('${comment.coid}');">回复</a>
                            </span>
                        </div>
                    </div>
                </div>
                <c:if test="${comment.levels > 0}">
                <div class="comment-children">
                    <ol class="comment-list">
                        <c:forEach var="comment" items="${comments}">
                        <li id="li-comment-${comment.coid}"
                            class="comment-body comment-child comment-level-odd comment-odd">
                            <div id="comment-${comment.coid}">
                                <div class="comment-view">
                                    <div class="comment-header">
                                        <img class="avatar" src="${comment.email}?s=80&r=G&d=" title="${comment.author}" width="80" height="80">
                                        <span class="comment-author comment-by-author">
                                            <a href="${comment.url}" target="_blank" rel="external nofollow">${comment.author}</a>
                                        </span>
                                    </div>
                                    <div class="comment-content">
                                        <%--<span class="comment-author-at">
                                            ${comment_at(comment.parent)}
                                        </span>--%>
                                        <p>${article(comment.content)}</p>
                                    </div>
                                    <div class="comment-meta">
                                        <jsp:setProperty name="dataValue" property="time" value="${comment.created}"/>
                                        <time class="comment-time"><fmt:formatDate value="${dataValue}" pattern="yyyy-MM-dd"/></time>
                                        <span class="comment-reply">
                                            <a rel="nofollow" onclick="TaleComment.reply('${comment.coid}');">回复</a>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </li>
                        </c:forEach>
                    </ol>
                </div>
                </c:if>
            </li>
            </c:forEach>
        </ol>
        <div class="lists-navigator clearfix">
            <ol class="page-navigator">
                <c:if test="${page.present > 1}">
                <li class="prev"><a href="?present=${page.present - 1}">←</a></li>
                </c:if>
                <c:forEach var="navIndex" begin="${page.begin}" end="${page.end}" step="1">
                <li <c:if test="${page.present == navIndex}"> class="current" </c:if>><a href="?present=${navIndex}">${navIndex}</a></li>
                </c:forEach>
                <c:if test="${page.present < page.end}">
                <li class="next"><a href="?present=${page.present + 1}">→</a></li>
                </c:if>
            </ol>
        </div>
        </c:if>
    </div>
</div>
</c:if>
<script type="text/javascript">
    (function () {
        window.TaleComment = {
            reply: function (coid) {
                $('#comment-form input[name=coid]').val(coid);
                $("html,body").animate({scrollTop: $('div.comment-container').offset().top}, 500);
                $('#comment-form #textarea').focus();
            },
            subComment: function () {
                $.ajax({
                    type: 'post',
                    url: '/Blog/comment',
                    data: $('#comment-form').serialize(),
                    async: false,
                    dataType: 'json',
                    success: function (result) {
                        $('#comment-form input[name=coid]').val('');
                        if (result && result.success) {
                            window.location.reload();
                        } else {
                            if (result.msg) {
                                alert(result.msg);
                                window.location.reload();
                            }
                        }
                    }
                });
                return false;
            }
        };
    })();

    function getCommentCookie(name) {
        var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
        if (arr = document.cookie.match(reg))
            return unescape(decodeURI(arr[2]));
        else
            return null;
    }

    function addCommentInputValue() {
        document.getElementById('author').value = getCommentCookie('tale_remember_author');
        document.getElementById('mail').value = getCommentCookie('tale_remember_mail');
        document.getElementById('url').value = getCommentCookie('tale_remember_url');
    }

    addCommentInputValue();
</script>
