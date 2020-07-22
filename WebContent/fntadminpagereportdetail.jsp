<%@page import="com.fnt.model.dto.ReportDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FNT(Feel New Item)신고상세보기</title>
<link href="css/section.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<%
	ReportDto dto = (ReportDto)request.getAttribute("reportdto");
%>
	<%@ include file="./form/header.jsp" %>
	<%@ include file="./form/aside.jsp" %>
	<section>
		<h1>신고 상세보기</h1>
		<table border="1">
			<tr>
				<th>신고번호</th>
				<td><%=dto.getReportno() %></td>
			</tr>
			<tr>
				<th>신고자 닉네임</th>
				<td><%=dto.getSendnickname() %></td>
			</tr>
			<tr>
				<th>신고사유</th>
				<td><%=dto.getReporttitle() %></td>
			</tr>
			<tr>
				<th>신고내용</th>
				<td>
					<textarea cols="60" rows="10"><%=dto.getReportcontent() %></textarea>
				</td>
			</tr>
			<tr>
				<th>신고받는 닉네임</th>
				<td><%=dto.getReceivenickname() %></td>
			</tr>
			<tr>
				<th>신고 날짜</th>
				<td><%=dto.getReportregdate() %></td>
			</tr>
		</table>
	</section>
	<%@ include file="./form/footer.jsp" %>
</body>
</html>