<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="active" value="publish" scope="request"></c:set>
<c:set var="title" value="保存文章" scope="request"></c:set>
<c:import url="/WEB-INF/templates/admin/header.jsp"></c:import>
<link href="/Blog/resources/static/admin/plugins/tagsinput/jquery.tagsinput.css" rel="stylesheet">
<link href="/Blog/resources/static/admin/plugins/select2/dist/css/select2-bootstrap.css" rel="stylesheet">
<link href="/Blog/resources/static/admin/plugins/toggles/toggles.css" rel="stylesheet">
		<link href="/Blog/resources/static/admin/plugins/multi-select/0.9.12/css/multi-select.min.css" rel="stylesheet"/>
        <link href="/Blog/resources/static/admin/plugins/select2/3.4.8/select2.min.css" rel="stylesheet"/>
        <link href="/Blog/resources/static/admin/plugins/mditor/css/mditor.min.css" rel="stylesheet"/>
        <link href="/Blog/resources/static/admin/plugins/summernote/0.8.2/summernote.css" rel="stylesheet">
        <link href="/Blog/resources/static/admin/plugins/dropzone/4.3.0/min/dropzone.min.css" rel="stylesheet">
<style rel="stylesheet">
    #tags_tagsinput {
        background-color: #fafafa;
        border: 1px solid #eeeeee;
    }

    #tags_addTag input {
        width: 100%;
    }

    #tags_addTag {
        margin-top: -5px;
    }

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

    #articleForm #dropzone {
        min-height: 200px;
        background-color: #dbdde0;
        line-height:200px;
        margin-bottom: 10px;
    }
    #articleForm .dropzone {
        border: 1px dashed #8662c6;
        border-radius: 5px;
        background: white;
    }
    #articleForm .dropzone .dz-message {
        font-weight: 400;
    }
    #articleForm .dropzone .dz-message .note {
        font-size: 0.8em;
        font-weight: 200;
        display: block;
        margin-top: 1.4rem;
    }
</style>
<div class="row">
    <div class="col-sm-12">
        <h4 class="page-title">
            <c:if test="${contents != null }">
            	编辑文章
            </c:if>
            <c:if test="${contents == null }">
            	发布文章
            </c:if>
        </h4>
    </div>
    <div class="col-md-12">

        <input type="hidden" id="attach_url" value="${attach_url}" />

        <form id="articleForm">
        	<!-- 下面填写的内容,下面这些input标签中,在通过这些input标签提交 -->
            <input type="hidden" name="categories" id="categories"/>
            <input type="hidden" name="cid" value="${contents != null ? contents.cid : ''}" id="cid"/>
            <input type="hidden" name="status" value="${contents.status != null ?contents.status : 'draft'}" id="status"/>
            <input type="hidden" name="allowComment" value="${contents.allowComment != null ? contents.allowComment : true}" id="allowComment"/>
            <input type="hidden" name="allowPing" value="${contents.allowPing != null ? contents.allowPing : true}" id="allowPing"/>
            <input type="hidden" name="allowFeed" value="${contents.allowFeed != null ? contents.allowFeed : true}" id="allowFeed"/>
            <input type="hidden" name="content" id="content-editor"/>
            <input type="hidden" name="fmtType" id="fmtType" value="${contents.fmtType != null ? contents.fmtType : 'markdown'}"/>
			<!-- 文章标题 -->
            <div class="form-group col-md-6" style="padding: 0 10px 0 0;">
                <input class="form-control" placeholder="请输入文章标题（必须）" name="title" required
                       value="${contents.title != null ?contents.title: ''}"/>
            </div>
			<!-- (自定义)访问路径 -->
            <div class="form-group col-md-6" style="padding: 0 0 0 10px;">
                <input class="form-control" placeholder="自定义访问路径，如：my-first-article  默认为文章id" name="slug"
                       value="${contents.slug != null ?contents.slug : ''}"/>
            </div>
			<!-- 文章标签 -->
            <div class="form-group col-md-6" style="padding: 0 10px 0 0;">
                <input name="tags" id="tags" type="text" class="form-control" placeholder="请填写文章标签"
                       value="${contents.tags != null ?contents.tags :''}"/>
            </div>
			<!-- 文章分类(类型),每一个类型就是一个metas -->
            <div class="form-group col-md-6">
                <select id="multiple-sel" class="select2 form-control" multiple="multiple" data-placeholder="请选择分类...">
                    <c:if test="${categories == null || categories.size() == 0 || contents.categories == null}">
                    	<option value="默认分类" selected>默认分类</option>
                    </c:if>
					<c:if test="${categories != null}">
						<c:forEach items="${categories}" var="c">
							<!-- 修改下面的表达(原始表达#if(null !=contents && exist_cat(c, contents.categories)) selected #end) -->
							<option value="${c.name}"  <c:if test="${contents != null && contents.categories != null && contents.categories.contains(c.name)}">selected</c:if> >
                        ${c.name}
                    </option>	
						</c:forEach>
					</c:if>
                </select>
            </div>
            <div class="clearfix"></div>
			<!-- 文本编辑器选择 -->
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
			<!-- 文本输入 -->
            <div id="md-container" class="form-group col-md-12">
            	<!-- #if(null != contents && contents.fmtType != 'html') hide #end -->
                <textarea id="md-editor" class="<c:if test="${contents != null && contents.fmtType == 'markdown'}">hiden</c:if>">${contents.content != null ? contents.content : ''}</textarea>
            </div>
            <!-- 文本显示 -->
            <div id="html-container" class="form-group col-md-12">
                <div class="summernote">
                	<c:if test="${contents != null && contents.fmtType == 'html'}">
                		${contents.content != null ? contents.content : ''}
                	</c:if>
                </div>
            </div>
			<!-- 一下为一些选择框体 -->
            <div class="form-group col-md-3 col-sm-4">
                <label class="col-sm-4">开启评论</label>
                <div class="col-sm-8">
                    <div class="toggle toggle-success allow-${contents.allowComment !=null ?contents.allowComment : true}"
                         onclick="allow_comment(this);" on="${contents.allowComment !=null ?contents.allowComment : true}"></div>
                </div>
            </div>

            <div class="form-group col-md-3 col-sm-4">
                <label class="col-sm-4">允许Ping</label>
                <div class="col-sm-8">
                    <div class="toggle toggle-success allow-${contents.allowPing != null?contemts.allowPing : true}"
                         onclick="allow_ping(this);" on="${contents.allowPing != null?contemts.allowPing : true}"></div>
                </div>
            </div>

            <div class="form-group col-md-3 col-sm-4">
                <label class="col-sm-4">允许订阅</label>
                <div class="col-sm-8">
                    <div class="toggle toggle-success allow-${contents.allowFeed != null ?contents.allowFeed : true}"
                         onclick="allow_feed(this);" on="${contents.allowFeed != null ? contents.allowFeed : true}"></div>
                </div>
            </div>

            <div class="form-group col-md-3">
                <label class="col-sm-5">添加缩略图</label>
                <div class="col-sm-7">
                    <div id="thumb-toggle" class="toggle toggle-success" on="false" thumb_url="${contents.thumbImg != null ?contents.thumbImg : ''}" onclick="add_thumbimg(this);"></div>
                </div>
            </div>

            <div id="dropzone-container" class="form-group col-md-12 hide">
                <div class="dropzone dropzone-previews" id="dropzone">
                    <div class="dz-message">
                        <p>可以为你的文章添加一张缩略图 ;)</p>
                    </div>
                </div>
                <input type="hidden" name="thumbImg" id="thumbImg"/>
            </div>

            <div class="clearfix"></div>

            <div class="text-right">
                <a class="btn btn-default waves-effect waves-light" href="/admin/article">返回列表</a>
                <button type="button" class="btn btn-primary waves-effect waves-light" onclick="subArticle('publish');">
                    保存文章
                </button>
                <button type="button" class="btn btn-warning waves-effect waves-light" onclick="subArticle('draft');">
                    存为草稿
                </button>
            </div>
        </form>
    </div>
</div>
<c:import url="/WEB-INF/templates/admin/footer.jsp"></c:import>

<script src="/Blog/resources/static/admin/plugins/tagsinput/jquery.tagsinput.min.js"></script>
<script src="/Blog/resources/static/admin/plugins/jquery-multi-select/jquery.quicksearch.js"></script>
		<script src="/Blog/resources/static/admin/plugins/tagsinput/jquery.tagsinput.min.js"></script>
		<script src="/Blog/resources/static/admin/plugins/jquery-multi-select/jquery.quicksearch.js"></script>
        <script src="/Blog/resources/static/admin/plugins/mditor/js/mditor.min.js"></script>
        <script src="/Blog/resources/static/admin/plugins/wysihtml5/0.3.0/wysihtml5.min.js"></script>
        <script src="/Blog/resources/static/admin/plugins/summernote/0.8.2/summernote.min.js"></script>
        <script src="/Blog/resources/static/admin/plugins/summernote/0.8.2/lang/summernote-zh-CN.min.js"></script>
        <script src="/Blog/resources/static/admin/plugins/multi-select/0.9.12/js/jquery.multi-select.min.js"></script>
        <script src="/Blog/resources/static/admin/plugins/select2/3.4.8/select2.min.js"></script>
        <script src="/Blog/resources/static/admin/plugins/jquery-toggles/2.0.4/toggles.min.js"></script>
        <script src="/Blog/resources/static/admin/plugins/dropzone/4.3.0/min/dropzone.min.js"></script>
        <script src="/Blog/resources/static/admin/plugins/to-markdown/3.1.0/to-markdown.min.js"></script>
<script src="/Blog/resources/static/admin/js/article.js" type="text/javascript"></script>
</body>
</html>