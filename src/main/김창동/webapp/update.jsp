<%@ page contentType="text/html; charset=UTF-8" %>

<%@ page import="board.BoardBean"%>



<html>
<head>
<title>JSP Board</title>

<link href="style.css" rel="stylesheet" type="text/css">
<%
	BoardBean bean=(BoardBean)session.getAttribute("bean");
	int nowPage=Integer.parseInt(request.getParameter("nowPage"));

	int num=bean.getNum();
	String name=bean.getName();
	String subject=bean.getSubject();
	String content=bean.getContent();
	String regdate=bean.getRegdate();
	String ip=bean.getIp();
	session.setAttribute("bean", bean);

%>
<script>
	function check() {
		if(document.updateFrm.pass.value==""||document.updateFrm.pass.value!==('<%=bean.getPass()%>')){
			alert("비밀번호가 다릅니다.");
			document.updateFrm.pass.focus();
			return false;
		}
		document.updateFrm.submit();
	}
</script>
</head>
<body>

<div align="center"><br/><br/>
<table width="600" cellpadding="3">
  <tr>
   <td bgcolor="#FF9018"  height="21" align="center">수정하기</td>
  </tr>
</table>

<form name="updateFrm" method="post" action="/JAVABOOK/C04boardUpdate">
<table width="600" cellpadding="7">
 <tr>
  <td>
   <table>
    <tr>
     <td width="20%">성 명</td>
     <td width="80%">
	  <input name="name" value= <%=name %> size="30" maxlength="20">
	 </td>
	</tr>
	<tr>
     <td>제 목</td>
     <td>
	  <input name="subject" size="50" value=<%=subject %> maxlength="50">
	 </td>
    <tr>
     <td>내 용</td>
     <td>
	  <textarea name="content" rows="10" cols="50"><%=content %></textarea>
	 </td>
    </tr>
	<tr>
     <td>비밀 번호</td> 
     <td><input type="password" name="pass" size="15" maxlength="15">
      수정 시에는 비밀번호가 필요합니다.</td>
    </tr>
	<tr>
     <td colspan="2" height="5"><hr/></td>
    </tr>
	<tr>
     <td colspan="2">
	  <input type="button" value="수정완료" onClick="check()">
      <input type="reset" value="다시수정"> 
      <input type="button" value="뒤로" onClick="history.go(-1)">
	 </td>
    </tr> 
   </table>
  </td>
 </tr>
</table>
 <input type="hidden" name="nowPage" value="<%=nowPage %>">
 <input type='hidden' name="num" value="<%=num%>">
</form> 
</div>
</body>
</html>