<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:useBean id="dateValue" class="java.util.Date"></jsp:useBean>
<c:set var="active" value="article" scope="request"></c:set>
<c:set var="title" value="文章管理" scope="request"></c:set>
<<c:import url="/WEB-INF/templates/admin/header.jsp"></c:import>
<div class="row">
	<div class="col-sm-12">
		<h4 class="page-title">文章管理</h4>
	</div>
	<div class="col-md-12">
		<table class="table table-striped table-bordered">
			<thead>
				<tr>
					<th width="35%">文章标题</th>
					<th width="15%">发布时间</th>
					<th>浏览量</th>
					<th>所属分类</th>
					<th width="8%">发布状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
            <c:forEach items="${contents}" var="content">
            	<tr cid="${content.cid}">
                <td>
                    <a href="/admin/article/${content.cid}">${content.title}</a>
                </td>
                <td>
                	<jsp:setProperty property="time" name="dateValue" value="${content.created}"/>
                	<fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </td>
                <td>${post.hits}</td>
                <td>${post.categories}</td>
                <td>
                    <c:if test="${content.status == 'publish' }">
                    	 <span class="label label-success">已发布</span>
                    </c:if>
                   
                    <c:if test="${content.status == 'draft' }">
                    	<span class="label label-default">草稿</span>
                    </c:if>
                    
                </td>
                <td>
                    <a href="/admin/article/${content.cid}"
                       class="btn btn-primary btn-sm waves-effect waves-light m-b-5"><i
                            class="fa fa-edit"></i> <span>编辑</span></a>
                    <a href="javascript:void(0)" onclick="delPost(${content.cid});"
                       class="btn btn-danger btn-sm waves-effect waves-light m-b-5"><i
                            class="fa fa-trash-o"></i> <span>删除</span></a>
                    <c:if test="${content.status == 'publish'}">
                    	<a class="btn btn-warning btn-sm waves-effect waves-light m-b-5" href="${permalink(post)}"
                       	target="_blank"><i
                            class="fa fa-rocket"></i> <span>预览</span></a>
                    </c:if>
                </td>
            </tr>
            </c:forEach>
            </tbody>
		</table>
		#call pageAdminNav(articles)
	</div>
</div>
<c:import url="/WEB-INF/templates/admin/footer.jsp"></c:import>

<script type="text/javascript">
    var tale = new $.tale();
    function delPost(cid) {
        tale.alertConfirm({
            title:'确定删除该文章吗?',
            then: function () {
               tale.post({
                   url : '/admin/article/delete',
                   data: {cid: cid},
                   success: function (result) {
                       if(result && result.success){
                           tale.alertOkAndReload('文章删除成功');
                       } else {
                           tale.alertError(result.msg || '文章删除失败');
                       }
                   }
               });
           }
        });
    }
</script>

</body>
</html>