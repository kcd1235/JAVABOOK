<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
<title>JSP Board</title>
</head>
<body>

<jsp:useBean id="bMgr" class="board.BoardMgr" scope="page" />
<%@page import="board.*,java.util.*" %>

<%	
	  request.setCharacterEncoding("UTF-8");
	  
      int totalRecord=0; 			// 전체레코드수
	  int numPerPage=10; 		// 페이지당 레코드 수(화면에 표시될 개수 )
	  int pagePerBlock=15; 		// 블럭당 페이지수 
	  
	  int totalPage=0; 			// 전체 페이지 수
	  int totalBlock=0;  		// 전체 블럭수 

	  int nowPage=1; 			// 현재페이지
	  int nowBlock=1;  			// 현재블럭
	  
	  int start=0; 			// 디비의 select 시작번호
	  int end=10; 			// 시작번호로 부터 가져올 select 갯수
	  
	  int listSize=0; 		// 현재 읽어온 게시물의 수
	  
	  if(request.getParameter("nowPage")!=null)
	  {
			nowPage=Integer.parseInt(request.getParameter("nowPage"));
	  }
		start=(nowPage * numPerPage) - numPerPage;
		end=numPerPage;
		
		
		totalRecord=bMgr.getTotalCount(); 			
		totalPage= (int)Math.ceil((double)totalRecord/ numPerPage);	
		totalBlock=(int)Math.ceil((double)totalPage/pagePerBlock);	
		nowBlock=(int)Math.ceil((double)nowPage/pagePerBlock); 
		
		Vector<BoardBean> blist=bMgr.getBoardList(start, end);
%>



<script type="text/javascript">	
	function pageing(page) {
		 document.readFrm.nowPage.value=page;
		 document.readFrm.submit();
	}
	function block(value){
		 document.readFrm.nowPage.value=<%=pagePerBlock%>*(value-1)+1;
		 document.readFrm.submit();
	} 
	function list() {
		 document.listFrm.action="list.jsp";
		 document.listFrm.submit();
	}
	function read(num){
		 document.readFrm.num.value=num;
		 document.readFrm.action="read.jsp"
		 document.readFrm.submit();
		 
	}
	 
</script>

<div align="center">
	<br/>
	<h2>JSPBoard</h2>
	<br/>
	<table align="center" width="1000">
		<tr >
			<td>Total : <%=totalPage %>(<font color=red><%=nowPage %></font>/<font color=red><%=totalPage %><font>)</td>
		</tr>
	</table>
	<!-- 본문테이블  -->
	<table align="center" width="1000" cellpadding="3">
		<tr>
			<td align="center" colspan="2">
				  <table width="100%" cellpadding="2" cellspacing="0">
					<tr align="center" bgcolor="#D0D0D0" height="120%">
						<td>번 호</td>
						<td>제 목</td>
						<td>이 름</td>
						<td>날 짜</td>
						<td>조회수</td>
					</tr>		 
					<tr><!-- 게시물 리스트 출력 부분  -->
					<%
						listSize=blist.size();
						if(blist.isEmpty()){
							out.println("등록된 게시물이 없습니다.");
						}
						else{
							for(int i=0;i<numPerPage;i++){
								if(i==listSize)
									break;
								
								BoardBean bean=blist.get(i);
								%>
								<td><%=bean.getNum() %></td>
								<td><a href="javascript:read('<%=bean.getNum()%>')"><%=bean.getSubject() %></a></td>
								<td><%=bean.getName() %></td>
								<td><%=bean.getRegdate() %></td>
								<td><%=bean.getCount() %></td>
							<tr>
							<%
							}
						}
						%>
					
						
				</table> 
			</td>
		</tr>

		<tr>
			<td colspan="2"><br /><br /></td>
		</tr>
		<tr>
			<td>
			<%
				int pageStart=(nowBlock -1)*pagePerBlock + 1;
				int pageEnd=((pageStart + pagePerBlock)<=totalPage)?(pageStart+pagePerBlock) :totalPage+1;
				
				if(totalPage!=0)
				{
					if(nowBlock>1)
					{
						%>
						<a href="javascript:block('<%=nowBlock-1%>')">[이전으로]</a>
						<%
					}
					for(;pageStart<pageEnd;pageStart++)
					{
						%>
						<a href="javascript:pageing('<%=pageStart%>')">[<%=pageStart %>]</a>
						<%
					}
					if(totalBlock>nowBlock)
					{
						%>
						<a href="javascript:block('<%=nowBlock+1%>')">[다음으로]</a>
						<%
					}
				}
			%>
			
			</td>
			<td align="right">
					<a href="post.jsp">[글쓰기]</a> 
					<a href="javascript:list()">[처음으로]</a>
			</td>
		</tr>
	</table>
	
	<form name="readFrm" method="get">
		<input type="hidden" name="num"> 
		<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
	</form>
	
	<form name="listFrm" method="post">
		<input type="hidden" name="reload" value="true"> 
		<input type="hidden" name="nowPage" value="1">
	</form>	
	
</div>	
</body>
</html>