<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String res = request.getParameter("res");
	if (res == null) {
		res = "";
	}

	String cValue = "";
	Cookie[] cookies = request.getCookies();

	if (cookies != null) {
		for (int i = 0; i < cookies.length; i++) {
			Cookie co = cookies[i];
			// 저장된 쿠키 이름을 가져온다
			String cName = co.getName();
			if (cName.equals("idSave")) {
				// 쿠키값을 가져온다
				cValue = co.getValue();
			}
		}
	}
%>

<!DOCTYPE html>
<html>
<head>
<% String Flag = request.getParameter("Flag"); %>
<meta charset="UTF-8">
<title>LOGIN</title>
<meta name="google-signin-scope" content="profile email">
<meta name="google-signin-client_id"
	content="236084628267-j6u2itovr6ocvop0ae5jk52536vf2joq.apps.googleusercontent.com">
<link href="css/login.css" rel="stylesheet" type="text/css">
<link rel="icon" type="image/png" sizes="32x32" href="image/favicon-32x32.png">
<style>
	.abcRioButtonBlue {
		height:45px !important;
		width: 122px !important;
	}
	.abcRioButtonIcon{
	    padding: 12.5px !important;
	}
	.abcRioButtonContents{
		    font-size: 13px !important;
   	 		line-height: 44px !important;
   			 font-weight: bold !important;
	}
	.foot_area_wrap{
	 position: relative;
   	 top: 170px;
	}
</style>
<script type="text/javascript" src="js/jquery-3.4.1.js"></script>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"
	charset="utf-8"></script>
<script type="text/javascript">
		//아이디 검사 ---------------------------------------------------------------------------
		//1. ID : 4~12자 이내의 영어와 숫자로 입력
		//2. 첫문자는 숫자로 시작할 수 없음.
		//3. Password : 4~12자 이내며, 입력 필수.
		function check() {
			if(fr.id.value == "") { // 아이디 안적음
				$("#idCheck").text("아이디를 입력해주세요");
				$("#idCheck").css("display", "");
				fr.id.focus(); // 아이디 입력 상자에 포커스
				return false;
			} else if(fr.id.value.length < 4 || fr.id.value.length > 12){ // 아이디 4~12자리로 제한
				$("#idCheck").text("아이디는 4~12자 이내로 입력 가능합니다!");
				$("#idCheck").css("display", "");  
				fr.id.focus(); // 아이디 입력 상자에 포커스
				return false;
			} else if(!isNaN(fr.id.value.substr(0,1))) { // 아이디 시작을 숫자로 할 경우
				$("#idCheck").text("아이디는 숫자로 시작할 수 없습니다!");
				$("#idCheck").css("display", "");  
				fr.id.focus(); // 아이디 입력 상자에 포커스
				return false;
			} else if(fr.pw.value == "") { // 비밀번호 미입력
				$("#pwCheck").text("비밀번호를 입력해주세요");
				$("#pwCheck").css("display", "");
				fr.pw.focus();
				return false;
			}else if(fr.pw.value.length < 4 || fr.pw.value.length > 12){ // 비밀번호 4~12자리로 제한
				$("#pwCheck").text("비밀번호는 4~12자리이상 작성해주세요");
				$("#pwCheck").css("display", "");
				fr.pw.focus();
				return false;
			}

			if($("input:checkbox[name='id_save']").is(":checked") == true) {
				$("input[name='hidden_chk']").val("Y");
			} else {
				$("input[name='hidden_chk']").val("N");
			}
		}  

		// check() 함수에서 실행된 빨간 글자를 아이디/비밀번호 입력 시작시 다시 지움
		function checkData(flag){
			// 아이디 입력시
			if(flag == "id") {
				var id = $("input[name=id]");
				if(id.val().trim() != "") {
					$("#idCheck").css("display", "none");
				}
			} else {
			// 비밀번호 입력시
				var pw = $("input[name=pw]");
				if(pw.val().trim() != ""){
					$("#pwCheck").css("display","none");
				}
			}
			// 아이디와 비밀번호를 확인해주세요 글자 삭제
			$("#resultText").css("display","none");
		}
		function onSignIn(googleUser) {
	          var profile = googleUser.getBasicProfile();
	          var snsId = profile.getId();
	          var snsEmail = profile.getEmail();
	          location.href="login.do?command=snslogin&opt_id="+snsId+"&opt_email="+snsEmail +"&Flag="+<%=Flag%>;

	        }
		function kLogin(){
		    Kakao.init('20c730ea6463b1ab9c0f8ef78e9ed232');
		    Kakao.Auth.loginForm({
		      success: function(authObj) {
		        Kakao.API.request({
		          url: '/v2/user/me',
		          success: function(res) {
		            JSON.stringify(res);
		            var snsId = res.id;
		            var snsEmail = res.kakao_account.email;
		            Kakao.Auth.logout(
		            	function(){
			            	 location.href="login.do?command=snslogin&opt_id="+snsId+"&opt_email="+snsEmail +"&Flag="+<%=Flag%>;
		            })
		          },
		          fail: function(error) {
		            alert(JSON.stringify(error));
		          }
		        });
		      },
		      fail: function(err) {
		        alert(JSON.stringify(err));
		      }
		    })
		}
		function findID(){
			cw = screen.availWidth;
			ch = screen.availHeight;
				
			sw=300;    //띄울 창의 넓이
			sh=380;    //띄울 창의 높이

			ml = (cw - sw) / 2;
			mt = (ch - sh) / 2;

			var url = encodeURI("findid.jsp");
			window.open(url, '아이디 찾기', 'width=' + sw + ',height=' + sh + ',top=' + mt + ',left=' + ml);
		  }
		function findPW(){
			cw = screen.availWidth;
			ch = screen.availHeight;
				
			sw=300;    //띄울 창의 넓이
			sh=380;    //띄울 창의 높이

			ml = (cw - sw) / 2;
			mt = (ch - sh) / 2;

			var url = encodeURI("findpassword.jsp");
			window.open(url, '비밀번호 찾기', 'width=' + sw + ',height=' + sh + ',top=' + mt + ',left=' + ml);
		  }
		
 		$(function(){
 	 		var naverLogin = new naver.LoginWithNaverId(
 	 				{
 	 					clientId: "lcTrrWMiQvKel6vICKwB",
 	 					callbackUrl: "http://192.168.10.33:8787/OPT222/login.jsp?Flag=0",
 	 					isPopup: false, 
 	 					loginButton: {color: "green", type: 2, height: 47} 
 	 				}
 	 			);
 	 			
 	 			naverLogin.init();
 	 			
 	 			naverLogin.getLoginStatus(function (status) {
 	 				if (status) {
 	 					var snsEmail  = naverLogin.user.getEmail();
 	 					var snsId = naverLogin.user.getId();
 	 		       	 location.href="login.do?command=snslogin&opt_id="+snsId+"&opt_email="+snsEmail +"&Flag="+<%=Flag%>;

 	 				} else {
 	 					console.log("AccessToken이 올바르지 않습니다.");
 	 				}
 	 			});
 	 			
 	 			window.fbAsyncInit = function() {
 	 				FB.init({
 	 					appId : '2428130137468919',
 	 					cookie : false,
 	 					xfbml : true,
 	 					version : 'v4.0'
 	 				});
 	 			};
 	 			(function(d, s, id) {
 	 				var js, fjs = d.getElementsByTagName(s)[0];
 	 				if (d.getElementById(id))
 	 					return;
 	 				js = d.createElement(s);
 	 				js.id = id;
 	 				js.src = "//connect.facebook.net/ko_KR/sdk.js";
 	 				fjs.parentNode.insertBefore(js, fjs);
 	 			}(document, 'script', 'facebook-jssdk')); 
 	 			
 	 			
 		})

</script>
</head>
<body>

 	<jsp:include page="header.jsp"></jsp:include>
	<div class="login_content">
		<fieldset class="login_form" style="border: 0px;">
			<legend class="blind">로그인</legend>
			<form action="login.do" method="post" onsubmit="return check()"
				name="fr">
				<input type="hidden" name="command" value="login" /> <input
					type="hidden" name="Flag" value="<%=Flag%>"> <input
					type="hidden" name="hidden_chk" value="" />
				<%
					if (Flag.equals("2")) {
						int itemNo = Integer.parseInt(request.getParameter("itemno"));
						int itemEa = Integer.parseInt(request.getParameter("itemea"));
				%>
				<input type="hidden" name="no" value="<%=itemNo%>" /> <input
					type="hidden" name="ea" value="<%=itemEa%>" />
				<%
					} else if (Flag.equals("3")) {
						int itemNo = Integer.parseInt(request.getParameter("itemno"));
						int itemPage = Integer.parseInt(request.getParameter("itempage"));
				%>
				<input type="hidden" name="itemNo" value="<%=itemNo%>" /> <input
					type="hidden" name="itemPage" value="<%=itemPage%>" />
				<%
					}
				%>

 
				<div class=id_area>
					<span class="input_box"> <input type="text"
						placeholder="아이디" name="id" id="userId" onkeyup="checkData('id');"
						class="id_pw" value=<%=cValue%>> <span id="idCheck"
						style="display: none" class="idchk_span"></span>
					</span>
				</div>
				<div class="pw_area">
					<input type="password" placeholder="비밀번호" name="pw"
						onkeyup="checkData('pw');" class="id_pw"> <span
						id="pwCheck" style="display: none" class="idchk_span"></span>
				</div>

				<%
					if (res.equals("fail")) {
				%>
				<span id="resultText" class="idchk_span">아이디와 비밀번호를 확인해주세요</span>
				<%
					}
				%>

				<div class="checks etrans">
					<%
						if (cValue == "" || cValue == null) {
					%>
					<input type="checkbox" id="ex_chk3" name="id_save" /> 
					<label for="ex_chk3">아이디저장</label>
					<%
						} else {
					%>
					<input type="checkbox" id="ex_chk3" name="id_save" checked="checked" /> <label for="ex_chk3">아이디저장</label>
					<%
						}
					%>
				</div>
				<input type="submit" value="로그인" class="login_btn" />
				 <input type="button" value="회원가입" onclick="location.href='register.jsp'" class="regist_btn" />
			</form>
			
			<div class="search_idpw_area">
				<a onclick="findID()">아이디찾기</a>
				<span class="bar" aria-hidden="true">|</span>
				<a onclick="findPW()">비밀번호찾기</a>
			</div>
			<div class="sns_login_area">
			<div id="naverIdLogin" ></div>
			<div class="kakao_login">
			<img alt="" src="./image/kakaobtn.png" onclick="kLogin()" style="cursor: pointer;" >
			</div>
			<div class="g-signin2" data-onsuccess="onSignIn" data-theme="dark" style="padding-top: 6px;"></div>
			</div> 
		</fieldset>
	</div>
	
	<div class="foot_area_wrap">
	<jsp:include page="footer.jsp"></jsp:include>
	</div>

	
</body>
</html>