<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:useBean id="dateValue" class="java.util.Date"></jsp:useBean>
<c:set var="active" value="page" scope="request"></c:set>
<c:set var="title" value="页面管理" scope="request"></c:set>
<c:import url="/WEB-INF/templates/admin/header.jsp"></c:import>
<div class="row">
	<div class="col-sm-12">
		<h4 class="page-title">文章管理</h4>
	</div>
	<div class="col-md-12">
		<div class="pull-right">
			<a href="/Blog/admin/page/new"
				class="btn btn-success waves-effect waves-light m-b-5">添加新页面</a>
		</div>
		<table class="table table-striped table-bordered">
			<thead>
				<tr>
					<th>页面名称</th>
					<th>页面路径</th>
					<th width="20%">发布时间</th>
					<th width="12%">发布状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${articles}" var="article">
					<tr cid="${article.cid}">
						<td>${article.title}</td>
						<td>${article.slug != null ? article.slug : ''}</td>
						<td>
							<jsp:setProperty property="time" name="dateValue" value="${article.created}"/>
                			<fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd HH:mm:ss"/>
                		</td>
						<td><c:if test="${article.status == 'publish'}">
                    	已发布
                    </c:if> <c:if test="${article.status == 'draft'}">
                    	 草稿
                    </c:if></td>
						<td><a href="/Blog/admin/page/${article.cid}"
							class="btn btn-primary btn-sm waves-effect waves-light m-b-5"><i
								class="fa fa-edit"></i> <span>编辑</span></a> <a
							href="javascript:void(0)" onclick="delPost(${article.cid});"
							class="btn btn-danger btn-sm waves-effect waves-light m-b-5"><i
								class="fa fa-trash-o"></i> <span>删除</span></a> <!-- 由于主页还没做,所以没有预览网址 -->
							<a class="btn btn-warning btn-sm waves-effect waves-light m-b-5"
							href="#" target="_blank"><i class="fa fa-rocket"></i> <span>预览</span></a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
<c:import url="/WEB-INF/templates/admin/footer.jsp"></c:import>

<script type="text/javascript">
    var tale = new $.tale();
    function delPost(cid) {
        tale.alertConfirm({
            title:'确定删除这个页面吗?',
            then: function () {
                tale.post({
                    url : '/Blog/admin/page/delete',
                    data: {cid: cid},
                    success: function (result) {
                        if(result && result.success){
                            tale.alertOkAndReload('页面删除成功');
                        } else {
                            tale.alertError(result.msg || '页面删除失败');
                        }
                    }
                });
            }
        });
    }
</script>
</body>
</html>