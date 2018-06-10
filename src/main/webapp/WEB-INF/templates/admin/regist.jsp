<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link rel="shortcut icon" href="/Blob/static/admin/images/favicon.png"/>
    <title>Fengjie'Blob - 用户注册</title>
    <link href="/Blog/resources/static/admin/plugins/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="/Blog/resources/static/admin/plugins/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="/Blog/resources/static/admin/plugins/limonte-sweetalert2/6.4.1/sweetalert2.min.css" rel="stylesheet">
    <!--#call cdn_url('login_head')  -->
    <!--这是原来的链接 <link href="Blob/static/admin/css/style.min.css?v=${version}" rel="stylesheet" type="text/css"> -->
    <link href="/Blog/resources/static/admin/css/style.min.css" rel="stylesheet" type="text/css">
    <style type="text/css">
        body,html {
            background: url("/Blog/resources/static/admin/images/bg/${random}.png") no-repeat;
            background-size: cover;
        }
        .panel-shadow {
            -moz-box-shadow: 0px 0px 10px 0px rgba(39, 49, 65, 0.1);
            -webkit-box-shadow: 0px 0px 10px 0px rgba(39, 49, 65, 0.1);
            box-shadow: 0px 0px 10px 0px rgba(39, 49, 65, 0.1);
        }
        .bg-overlay {
            -moz-border-radius: 6px 6px 0 0;
            -webkit-border-radius: 6px 6px 0 0;
            background-color: rgba(47, 51, 62, 0.3);
            border-radius: 6px 6px 0 0;
            height: 100%;
            left: 0;
            position: absolute;
            top: 0;
            width: 100%;
        }
        .input-border {b1.png
            font-size: 14px;
            width: 100%;
            height: 40px;
            border-radius: 0;
            border: none;
            border-bottom: 1px solid #dadada;
        }

        .bg-img > h3 {
            text-shadow: 0px 2px 3px #555;
            color: #cac9c8;
        }
    </style>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    #call cdn_url('html5_respond')
    <![endif]-->
</head>
<body>
<div style="margin: 0 auto; padding-bottom: 0%; padding-top: 7.5%; width: 380px;">
    <div class="panel panel-color panel-danger panel-pages panel-shadow">
        <div class="panel-heading bg-img">
            <div class="bg-overlay"></div>
            <h3 class="text-center m-t-10"> 注册Blob<br>以下各项均不能有空格</h3>
            </div>

        <div class="panel-body">
        	<!-- onsubmit="return checkForm()" -->
            <form class="form-horizontal m-t-20" method="post" id="loginForm" onsubmit="return checkForm()">

                <div class="form-group">
                    <div class="col-xs-12">
                        <input class=" input-lg input-border" name="sceenName" type="text" required
                               placeholder="注册昵称" onblur="checkSceenName(this.value)">
                    </div>
                </div>
                
                <div class="form-group">
                    <div class="col-xs-12">
                        <input class=" input-lg input-border" name="username" type="text" required
                               placeholder="注册账号" onblur="checkUsername(this.value)">
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-xs-12">
                        <input class=" input-lg input-border" name="password1" type="password" required
                               placeholder="注册密码" id="password1" onblur="checkPassword()">
                    </div>
                </div>
                
                <div class="form-group">
                    <div class="col-xs-12">
                        <input class=" input-lg input-border" name="password2" type="password" required
                               placeholder="确认密码" id="password2" onblur="checkPassword()">
                    </div>
                </div>
                
                <div class="form-group">
                    <div class="col-xs-12">
                        <input class=" input-lg input-border" name="email" type="text" required
                               placeholder="注册邮箱">
                    </div>
                </div>

                <div class="form-group text-center m-t-40">
                    <div class="col-xs-12">
                        <button class="btn btn-danger btn-lg btn-rounded btn-block w-lg waves-effect waves-light" style="box-shadow: 0px 0px 4px #868282;" type="submit">注&nbsp;册
                        </button>
                    </div>
                </div>
            </form>
        </div>

    </div>
</div>
<!-- Main  -->
<script type="text/javascript" src="/Blog/resources/static/admin/plugins/jquery/3.2.1/jquery-3.2.1.js"></script>
<script type="text/javascript" src="/Blog/resources/static/admin/plugins/limonte-sweetalert2/6.4.1/sweetalert2.min.js"></script>
<!-- #call cdn_url('login_foot') -->
<script src="/Blog/resources/static/admin/js/base.js"></script>
<script type="text/javascript">
//每个输入及时检查,更符合习惯
    var tale = new $.tale();
    function checkForm() {
    	alert(1);
        tale.post({
            url: '${pageContext.request.contextPath}/admin/regist',
            data: $("#loginForm").serialize(),
            success: function (result) {
                if (result && result.success) {
                    window.location.href = '${pageContext.request.contextPath}/admin/login';
                } else {
                    tale.alertError(result.msg || '注册失败');
                }
            }
        });
        return false;
    }
    
    function checkSceenName(value){
    	tale.post({
    		url:'${pageContext.request.contextPath}/admin/regist',
    		data:{sceenName:value},
    		success: function(result){
    			//检查用户名是否重复
    			if(!result || !result.success){
    				tale.alertError(result.msg || '输入错误');
    			}
    		}
    	});
    }
    
    function checkUsername(value){
    	//检查账号是否重复
    	tale.post({
    		url:'${pageContext.request.contextPath}/admin/regist',
    		data:{username:value},
    		success: function(result){
    			if(!result || !result.success){
    				tale.alertError(result.msg || '输入错误')
    			}
    		}
    	});
    }
    
    function checkPassword(){
    	var password1 = $("#password1").val();
    	var password2 = $("#password2").val();
    	if(password1.length && password1.indexOf(" ") != -1){
    		tale.alertError('密码中不能有空格' || '输入错误');
    		return;
    	}
    	
    	if(password2.length && password2.indexOf(" ") != -1){
    		tale.alertError('密码中不能有空格' || '输入错误');
    		return;
    	}
    	
    	if(password1.length && password2.length && password1 != password2){
    		tale.alertError('两次输入不一致' || '输入错误');
    		return;
    	}
    	
    }
    
</script>
</body>
</html>