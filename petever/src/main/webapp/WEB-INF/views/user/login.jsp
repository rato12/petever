<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import = "com.kh.petever.user.model.vo.User" %>
<%@ page import = "com.kh.petever.user.model.service.UserService" %>

<%
	//session : 선언없이 사용할 수 있는 jsp내장객체
	User loginUser = (User)session.getAttribute("loginUser");
	//getAttribute의 리턴타입은 오브젝트다. User로 형변환해줌
		
	//쿠키관련
	Cookie[] cookies = request.getCookies();
	boolean saveIdChecked = false;
	String saveIdValue = "";
	
	if(cookies != null) {

		for(Cookie c : cookies){
			String k = c.getName();
			String v = c.getValue();
			
			//saveId 쿠키 존재여부 확인
			if("saveId".equals(k)){
				saveIdChecked = true;
				saveIdValue = v;
			}
		}
	}

%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css">
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
   <section>
        <div class="login">
            <form action="${pageContext.request.contextPath}/user/login.do" 
                  method="POST">
               <div class="login-body">
                <input type="text" name="userId" placeholder="아이디" id="userId" value="<%= saveIdChecked ? saveIdValue : "" %>"/>
                <input type="password" name="userPwd" placeholder="비밀번호">
                <button>로그인</button>
                <br>
 					<div class="check">
		                <input type="checkbox" name="saveId" id="saveId" <%= saveIdChecked ? "checked" : "" %>/>
						<label for="saveId"></label>
						<p>아이디 기억하기</p>
					</div>
  			   </div>
  		   </form>

            <div id="search">
                <a class="find-id" onclick="javascript:findId();">아이디 찾기</a> |
                <a class="find-pwd" onclick="javascript:findPwd();">비밀번호 찾기</a>
            </div>
            <div id="my-signin2" class="g-signin2" data-width="232" data-height="50" data-longtitle="true" data-onsuccess="onSignIn"></div>
            <div id="naver_id_login" style="width:232px;margin:20px auto;"></div>
<!--             <a id="custom-login-btn" style="margin: 0 auto; width: 232px; display: block;" href="https://kauth.kakao.com/oauth/authorize?client_id=94eafcad9cc336603158ae0aa47f30a3&redirect_uri=http://localhost:9090/petever/user/kakaologin.do&response_type=code"> -->
            <a id="custom-login-btn" style="margin: 0 auto; width: 232px; display: block;" href="https://kauth.kakao.com/oauth/authorize?client_id=94eafcad9cc336603158ae0aa47f30a3&redirect_uri=http://15.165.176.151:8080/petever/user/kakaologin.do&response_type=code">
                <img src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg" width="232" />
            </a>
        </div>
    </section>

 
    <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8">
    </script>

 


<script type="text/javascript">
    /* var naver_id_login = new naver_id_login("YOUR_CLIENT_ID", "YOUR_CALLBACK_URL");
    var state = naver_id_login.getUniqState();
    naver_id_login.setButton("white", 3, 50);
    naver_id_login.setDomain("YOUR_SERVICE_URL");
    naver_id_login.setState(state);
    naver_id_login.setPopup();
    naver_id_login.init_naver_id_login(); */
$(function() {
	$("#saveId").change(function() {
	console.log($("#saveId").is(":checked"));
		});
});
function findId() {
	window.open("${pageContext.request.contextPath}/user/findIdFrm.do", "아이디 찾기",
           "width=500, height=390, toolbar=no, menubar=no, scrollbars=no, resizable=yes, top=300, left=500");
}

function findPwd() {
	window.open("${pageContext.request.contextPath}/user/findPwdFrm.do", "비밀번호 찾기",
    "width=500, height=390, toolbar=no, menubar=no, scrollbars=no, resizable=yes, top=300, left=500");
}
</script>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>