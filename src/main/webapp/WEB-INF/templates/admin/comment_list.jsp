<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="dateValue" class="java.util.Date"></jsp:useBean>
<c:set var="active" value="comments" scope="request"></c:set>
<c:set var="title" value="评论管理" scope="request"></c:set>
<c:set var="has_sub" value="other" scope="request"></c:set>
<c:import url="/WEB-INF/templates/admin/header.jsp"></c:import>
<div class="row">
	<div class="col-sm-12">
		<h4 class="page-title">评论管理</h4>
	</div>
	<div class="col-md-12">
		<table class="table table-striped table-bordered">
			<thead>
				<tr>
					<th>评论内容</th>
					<th>评论人</th>
					<th>评论时间</th>
					<th>评论人邮箱</th>
					<th>评论人网址</th>
					<th>评论状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${comments}" var="comment">
					<tr cid="${comment.coid}">
						<!-- 下面a标签的地址连接到用户主界面暂时没有$--{site_url('/article/')}${comment.cid} -->
						<td><a href="/Blog/article/${comment.cid}"
							target="_blank">${fn:substring(comment.content,0 ,20 )}</a></td>
						<td>${comment.author}</td>
						<jsp:setProperty property="time" name="dateValue" value="${comment.created}"/>
						<td>
							<fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
						<td>${comment.mail}</td>
						<td><a href="${comment.url}" target="_blank">${comment.url}</a></td>
						<td><c:if test="${comment.status == 'approved'}">
								<span class="label label-success">审核通过</span>
							</c:if> <c:if test="${comment.status == 'not_audit'}">
								<span class="label label-default">未审核</span>
							</c:if></td>
						<td><a href="javascript:void(0)"
							onclick="reply('${comment.coid}');"
							class="btn btn-primary btn-sm waves-effect waves-light m-b-5"><i
								class="fa fa-edit"></i> <span>回复</span></a> <c:if
								test="${comment.status == 'not_audit'}">
								<a href="javascript:void(0)"
									onclick="updateStatus('${comment.coid}', 'approved');"
									class="btn btn-danger btn-sm waves-effect waves-light m-b-5"><i
									class="fa fa-trash-o"></i> <span>通过</span></a>
							</c:if> <a href="javascript:void(0)"
							onclick="delComment(${comment.coid});"
							class="btn btn-danger btn-sm waves-effect waves-light m-b-5"><i
								class="fa fa-trash-o"></i> <span>删除</span></a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="clearfix"></div>
		<ul class="pagination m-b-5 pull-right">
			<c:if test="${page.present > 1}">
				<li><a href="?page=${page.present - 1}" aria-label="Previous">
						<i class="fa fa-angle-left"></i>&nbsp;上一页
				</a></li>
			</c:if>
			<c:forEach begin="${page.begin}" end="${page.end}" var="num" step="1">
				<li class="<c:if test="${page.present == num}">active</c:if>"><a
					href="?page=${num}">${num}</a>
			</c:forEach>
			<c:if test="${page.present < page.end}">
				<li><a href="?page=${page.present + 1}" aria-label="Next">
						下一页&nbsp;<i class="fa fa-angle-right"></i>
				</a></li>
			</c:if>
			<li><span>共${page.end}页</span></li>
		</ul>
	</div>
</div>
<c:import url="/WEB-INF/templates/admin/footer.jsp"></c:import>
<script type="text/javascript">

    var tale = new $.tale();
    function reply(cid) {
        swal({
            title: "回复评论",
            text: "请输入你要回复的内容:",
            input: 'text',
            showCancelButton: true,
            confirmButtonText: '回复',
            cancelButtonText: '取消',
            showLoaderOnConfirm: true,
            preConfirm: function (comment) {
                return new Promise(function (resolve, reject) {
                    tale.post({
                        url : '/Blog/admin/comments',
                        data: {cid: cid, content: comment},
                        success: function (result) {
                            if(result && result.success){
                                tale.alertOk('已回复');
                            } else {
                                tale.alertError(result.msg || '回复失败');
                            }
                        }
                    });
                })
            },
            allowOutsideClick: false
        });
    }

    function delComment(coid) {
        tale.alertConfirm({
            title:'确定删除该评论吗?',
            then: function () {
                tale.post({
                    url : '/Blog/admin/comments/delete',
                    data: {coid: coid},
                    success: function (result) {
                        if(result && result.success){
                            tale.alertOkAndReload('评论删除成功');
                        } else {
                            tale.alertError(result.msg || '评论删除失败');
                        }
                    }
                });
            }
        });
    }

    function updateStatus(coid, status) {
        tale.post({
            url : '/Blog/admin/comments/status',
            data: {coid: coid, status: status},
            success: function (result) {
                if(result && result.success){
                    tale.alertOkAndReload('评论状态设置成功');
                } else {
                    tale.alertError(result.msg || '评论设置失败');
                }
            }
        });
    }
</script>

</body>
</html>