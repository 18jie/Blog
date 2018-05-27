<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="active" value="page" scope="request"></c:set>
<c:set var="title" value="保存页面" scope="request"></c:set>
<c:import url="/WEB-INF/templates/admin/header.jsp"></c:import>
<!-- #include('./header.html',{has_sub:'other', active:'page', title:'保存页面'}) -->
<link href="/Blog/resources/static/admin/plugins/toggles/toggles.css" rel="stylesheet">
<link href="/Blog/resources/static/admin/plugins/multi-select/0.9.12/css/multi-select.min.css" rel="stylesheet"/>
        <link href="/Blog/resources/static/admin/plugins/select2/3.4.8/select2.min.css" rel="stylesheet"/>
        <link href="/Blog/resources/static/admin/plugins/mditor/css/mditor.min.css" rel="stylesheet"/>
        <link href="/Blog/resources/static/admin/plugins/summernote/0.8.2/summernote.css" rel="stylesheet">
        <link href="/Blog/resources/static/admin/plugins/dropzone/4.3.0/min/dropzone.min.css" rel="stylesheet">
<style rel="stylesheet">
    .mditor .editor{
        font-size: 14px;
        font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
    }
    .mditor .backdrop, .mditor .textarea, .mditor .viewer{
        font-size: 14px;
    }
    .markdown-body{
        font-size: 14px;
    }
    .note-toolbar {
        text-align: center;
    }
    .note-editor.note-frame {
        border: none;
    }
    .note-editor .note-toolbar {
        background-color: #f5f5f5;
        padding-bottom: 10px;
    }
    .note-toolbar .note-btn-group {
        margin: 0;
    }
    .note-toolbar .note-btn {
        border: none;
    }
</style>
<div class="row">
    <div class="col-sm-12">
        <h4 class="page-title">
            <c:if test="${contents == null}">
            	 编辑页面
            </c:if>
            <c:if test="${contents != null}">
            	  发布新页面
            </c:if>
        </h4>
    </div>
    <div class="col-md-12">

        <input type="hidden" id="attach_url" value="${attach_url}" />

        <form id="articleForm" role="form" novalidate="novalidate">
            <input type="hidden" name="cid" value="${contents.cid  != null ?contents.cid : ''}" id="cid"/>
            <input type="hidden" name="status" value="${contents.status != null ?contents.status : 'draft'}" id="status"/>
            <input type="hidden" name="content" id="content-editor"/>
            <input type="hidden" name="fmtType" id="fmtType" value="${contents.fmtType != null ?contents.fmtType : 'markdown'}"/>
            <input type="hidden" name="allowComment" value="${contents.allowComment != null ?contents.allowComment : true}" id="allowComment"/>

            <div class="form-group">
                <input type="text" class="form-control" placeholder="请输入页面标题" name="title" required
                       aria-required="true" value="${contents.title != null ?contents.title : ''}"/>
            </div>

            <div class="form-group">
                <input type="text" class="form-control" placeholder="请输入页面访问名" name="slug" required
                       aria-required="true" value="${contents.slug != null ?contents.slug : ''}"/>
            </div>

            <div class="form-group col-xs-12">
                <div class="pull-right">
                    <a id="switch-btn" href="javascript:void(0)" class="btn btn-purple btn-sm waves-effect waves-light switch-editor">
                    	<c:if test="${contents != null && contents.fmtType == 'html'}">
                   			切换为Markdown编辑器
                   		</c:if>
                   		<c:if test="${contents == null || contents.fmtType != 'html' }">
                   			切换为富文本编辑器
                   		</c:if>
                       </a>
                </div>
            </div>

            <div id="md-container" class="form-group col-md-12">
                <textarea id="md-editor" class="<c:if test="${contents != null && contents.fmtType == 'markdown'}">hiden</c:if>">${contents.content != null ?contents.content : ''}</textarea>
            </div>
            <div id="html-container" class="form-group col-md-12">
                <div class="summernote">${contents.content != null ?contents.content : ''}</div>
            </div>

            <div class="form-group col-md-3 col-sm-4">
                <label class="col-sm-4">开启评论</label>
                <div class="col-sm-8">
                    <div class="toggle toggle-success allow-${contents.allowComment != null ?contents.allowComment : true}"
                         onclick="allowComment(this);" on="${contents.allowComment != null ?contents.allowComment : true}"></div>
                </div>
            </div>

            <div class="clearfix"></div>

            <div class="text-right">
                <button type="button" class="btn btn-primary waves-effect waves-light" onclick="subArticle('publish');">保存页面</button>
                <button type="button" class="btn btn-warning waves-effect waves-light" onclick="subArticle('draft');">存为草稿</button>
            </div>
        </form>
    </div>

</div>
<c:import url="/WEB-INF/templates/admin/footer.jsp"></c:import>

        <script src="/Blog/resources/static/admin/plugins/mditor/js/mditor.min.js"></script>
        <script src="/Blog/resources/static/admin/plugins/wysihtml5/0.3.0/wysihtml5.min.js"></script>
        <script src="/Blog/resources/static/admin/plugins/summernote/0.8.2/summernote.min.js"></script>
        <script src="/Blog/resources/static/admin/plugins/summernote/0.8.2/lang/summernote-zh-CN.min.js"></script>
        <script src="/Blog/resources/static/admin/plugins/multi-select/0.9.12/js/jquery.multi-select.min.js"></script>
        <script src="/Blog/resources/static/admin/plugins/select2/3.4.8/select2.min.js"></script>
        <script src="/Blog/resources/static/admin/plugins/jquery-toggles/2.0.4/toggles.min.js"></script>
        <script src="/Blog/resources/static/admin/plugins/dropzone/4.3.0/min/dropzone.min.js"></script>
        <script src="/Blog/resources/static/admin/plugins/to-markdown/3.1.0/to-markdown.min.js"></script>
<script type="text/javascript">
    var mditor, htmlEditor;
    var tale = new $.tale();
    var attach_url = $('#attach_url').val();
    // 每60秒自动保存一次草稿
    var refreshIntervalId = setInterval("autoSave()", 60 * 1000);

    $(document).ready(function () {

        mditor = window.mditor = Mditor.fromTextarea(document.getElementById('md-editor'));
        // 富文本编辑器
        htmlEditor = $('.summernote').summernote({
            lang: 'zh-CN',
            height: 340,
            placeholder: '写点儿什么吧...',
            //上传图片的接口
            callbacks:{
                onImageUpload: function(files) {
                    var data=new FormData();
                    data.append('image_up',files[0]);
                    tale.showLoading();
                    $.ajax({
                        url: '/Blog/admin/attach/upload',     //上传图片请求的路径
                        method: 'POST',            //方法
                        data:data,                 //数据
                        processData: false,        //告诉jQuery不要加工数据
                        dataType:'json',
                        contentType: false,        //<code class="javascript comments"> 告诉jQuery,在request head里不要设置Content-Type
                        success: function(result) {
                            tale.hideLoading();
                            if(result && result.success){
                                var url = $('#attach_url').val() + result.payload[0].fkey;
                                console.log('url =>' + url);
                                htmlEditor.summernote('insertImage', url);
                            } else {
                                tale.alertError(result.msg || '图片上传失败');
                            }
                        }
                    });
                }
            }
        });

        var fmtType = $('#fmtType').val();
        // 富文本编辑器
        if (fmtType != 'markdown') {
            var this_ = $('#switch-btn');
            mditor.value = '';
            $('#md-container').hide();
            $('#html-container').show();
            this_.text('切换为Markdown编辑器');
            this_.attr('type', 'texteditor');
        } else {
            var this_ = $('#switch-btn');
            $('#html-container').hide();
            $('#md-container').show();
            $('#fmtType').val('markdown');
            this_.attr('type', 'markdown');
            this_.text('切换为富文本编辑器');
            htmlEditor.summernote("code", "");
        }

        /*
         * 切换编辑器
         * */
        $('#switch-btn').click(function () {
            var type = $('#fmtType').val();
            var this_ = $(this);
            if (type == 'markdown') {
                // 切换为富文本编辑器
                mditor.value = '';
                $('#md-container').hide();
                $('#html-container').show();
                this_.text('切换为Markdown编辑器');
                $('#fmtType').val('html');
            } else {
                // 切换为markdown编辑器
                $('#html-container').hide();
                $('#md-container').show();
                $('#fmtType').val('markdown');
                this_.text('切换为富文本编辑器');
                htmlEditor.summernote("code", "");
            }
        });

        $('.toggle').toggles({
            on: true,
            text: {
                on: '开启',
                off: '关闭'
            }
        });

        $('div.allow-false').toggles({
            off: true,
            text: {
                on: '开启',
                off: '关闭'
            }
        });

    });

    /*
     * 自动保存为草稿
     * */
    function  autoSave() {
        var content = $('#fmtType').val() == 'markdown' ? mditor.value : htmlEditor.summernote('code');
        var title = $('#articleForm input[name=title]').val();
        if (title != '' && content != '') {
            $('#content-editor').val(content);
            $("#articleForm #categories").val($('#multiple-sel').val());
            var params = $("#articleForm").serialize();
            var cid = $('#articleForm #cid').val();
            var url = cid != '' ? '/Blog/admin/page/modify' : '/Blog/admin/page/publish';
            tale.post({
                url: url,
                data: params,
                success: function (result) {
                    if (result && result.success) {
                        if(!cid || cid == ''){
                            $('#articleForm #cid').val(result.payload);
                        }
                    } else {
                        tale.alertError(result.msg || '保存文章失败');
                    }
                }
            });
        }
    }

    /**
     * 保存页面
     * @param status
     */
    function subArticle(status) {
        var content = $('#fmtType').val() == 'markdown' ? mditor.value : htmlEditor.summernote('code');
        var title = $('#articleForm input[name=title]').val();
        if (title == '') {
            tale.alertWarn('请输入页面标题');
            return;
        }
        if (content == '') {
            tale.alertWarn('请输入页面内容');
            return;
        }
        clearInterval(refreshIntervalId);
        $('#content-editor').val(content);
        $("#articleForm #status").val(status);
        var params = $("#articleForm").serialize();
        var url = $('#articleForm #cid').val() != '' ? '/Blog/admin/page/modify' : '/Blog/admin/page/publish';
        tale.post({
            url: url,
            data: params,
            success: function (result) {
                if (result && result.success) {
                    tale.alertOk({
                        text: '页面保存成功',
                        then: function () {
                            setTimeout(function () {
                                window.location.href = '/Blog/admin/page';
                            }, 500);
                        }
                    });
                } else {
                    tale.alertError(result.msg || '页面保存失败');
                }
            }
        });
    }

    function allowComment(obj) {
        var this_ = $(obj);
        var on = this_.attr('on');
        if (on == 'true') {
            this_.attr('on', 'false');
            $('#allowComment').val('false');
        } else {
            this_.attr('on', 'true');
            $('#allowComment').val('true');
        }
    }
</script>
</body>
</html>