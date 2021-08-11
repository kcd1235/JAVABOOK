<!--  
	기본폼 만들기
-->

<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="board.BoardBean"%>

<html>
<head>
<title>JSP Board</title>
<link href="style.css" rel="stylesheet" type="text/css">

<%@page import="board.BoardBean"%>
<jsp:useBean id="bMgr" class="board.BoardMgr" />

<script type="text/javascript">
	function list(){
	    document.listFrm.submit();
	 } 
</script>
</head>
<body>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	String nowPage=request.getParameter("nowPage");
	
	bMgr.upCount(num);
	BoardBean bean=bMgr.getBoard(num);
	String name=bean.getName();
	String subject=bean.getSubject();
	String content=bean.getContent();
	String regdate=bean.getRegdate();
	String ip=bean.getIp();
	session.setAttribute("bean", bean);
	
	
%>
<br/><br/>

<table align="center" width="1000" cellspacing="3">
 <tr>
  <td bgcolor="#9CA2EE" height="25" align="center">글읽기</td>
 </tr>
 
 <tr>
  	<td colspan="2">
   	<table cellpadding="3" cellspacing="0" width="100%"> 
    	<tr> 
  			<td align="center" bgcolor="#DDDDDD" width="10%"> 이 름 </td>
  			<td  > <%=name %></td>
  			<td align="center" bgcolor="#DDDDDD" width="10%"> 등록날짜 </td>
  			<td  ><%=regdate %></td>
 		</tr>
 		<tr>
    		<td align="center" bgcolor="#DDDDDD"> 제 목</td>
    		<td  colspan="3"><%=subject %></td>
  		</tr> 			
  		<tr> 
    		<td colspan="4"><br/><pre> <%=content %> </pre><br/></td>
   		</tr>
   		
   		<tr>
    		<td colspan="4" align="right">
     		<%=ip %> 로 부터 글을 남기셨습니다. /  조회수  <%=bean.getCount() %>
    	</td>
  	 	</tr> 	 	
   </table>
 </td>
 
 </tr>
 
 <tr>
  <td align="center" colspan="2"> 
 <hr/>

 [ <a href="javascript:list()" >리스트</a> | 
 <a href="update.jsp?nowPage=<%=nowPage%>&num=<%=num%>" >수 정</a> |
 <a href="delete.jsp?nowPage=<%=nowPage%>&num=<%=num%>">삭 제</a> ]<br/> 
  </td>
 </tr>
 
</table>


<form name="listFrm" method="post" action="list.jsp">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
</form>


</body>
</html>