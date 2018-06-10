<%--
  Created by IntelliJ IDEA.
  User: jiege
  Date: 18-6-6
  Time: 下午1:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="active" value="themes" scope="request"></c:set>
<c:set var="title" value="主题设置" scope="request"></c:set>
<c:import url="/WEB-INF/templates/admin/header.jsp"></c:import>
<div class="row">
    ${bodyContent}
</div>
<c:import url="/WEB-INF/templates/admin/footer.jsp"></c:import>
<c:import url="tale_comment.jsp"></c:import>
<script type="text/javascript">

    var tale = new $.tale();

    /**
     * 保存全局设置
     */
    function saveThemeOptions(formId) {
        var param = $('#' + formId).serialize();
        tale.post({
            url : '/admin/themes/setting',
            data: param,
            type:"post",
            success: function (result) {
                if(result && result.success){
                    tale.alertOk('设置保存成功');
                } else {
                    tale.alertError(result.msg || '设置保存失败');
                }
            }
        });
    }

    /**
     * 保存个性化设置
     */
    function saveIndiviSetting() {
        var param = $('#indivi-form').serialize();
        tale.post({
            url : '/admin/setting',
            data: param,
            type:"post",
            success: function (result) {
                if(result && result.success){
                    tale.alertOk('设置保存成功');
                } else {
                    tale.alertError(result.msg || '设置保存失败');
                }
            }
        });
    }
</script>
</body>
</html>
