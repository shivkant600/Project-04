<%@page import="com.rays.pro4.Util.HTMLUtility"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.rays.pro4.Util.ServletUtility"%>
<%@page import="com.rays.pro4.Util.DataUtility"%>
<%@page import="com.rays.pro4.controller.PatientCtl"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<link rel="stylesheet"
		href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	<script>
		$(function() {
			$("#udatee").datepicker({
				changeMonth : true,
				changeYear : true,
				yearRange : '1980:2020',
			});
		});
	</script>
<body>
	<jsp:useBean id="bean" class="com.rays.pro4.Bean.PatientBean"
		scope="request"></jsp:useBean>
	<%@ include file="Header.jsp"%>

	<center>

		<form action="<%=ORSView.PATIENT_CTL%>" method="post">

			<div align="center">
				<h1>

					<%
						if (bean != null && bean.getId() > 0) {
					%>
					<tr>
						<th><font size="5px"> Update Patient </font></th>
					</tr>
					<%
						} else {
					%>
					<tr>
						<th><font size="5px"> Add Patient </font></th>
					</tr>
					<%
						}
					%>
				</h1>

				<h3>
					<font color="red"> <%=ServletUtility.getErrorMessage(request)%></font>
					<font color="green"> <%=ServletUtility.getSuccessMessage(request)%></font>
				</h3>

			</div>

			<input type="hidden" name="id" value="<%=bean.getId()%>">

			<table>
				<tr>
					<th align="left">ProductName <span style="color: red">*</span>
						:
					</th>
					<td><input type="text" name="Name"
						placeholder="Enter Product Name" size="26"
						value="<%=DataUtility.getStringData(bean.getName())%>"></td>
					<td style="position: fixed"><font color="red"><%=ServletUtility.getErrorMessage("Name", request)%></font></td>

				</tr>

				<tr>
					<th align="left">VIsittDate <span style="color: red">*</span>
						:
					</th>
					<td><input type="text" name="VisitDate"
						placeholder="Enter visitdate Date" size="26" readonly="readonly"
						id="udatee"
						value="<%=DataUtility.getDateString(bean.getVisitdate())%>"></td>
					<td style="position: fixed;"><font color="red"> <%=ServletUtility.getErrorMessage("VisitDate", request)%></font></td>
				</tr>


				<tr>
					<th align="left">mobile <span style="color: red">*</span> :
					</th>
					<td><input type="text" name="Mobile"
						placeholder="Enter Product Ammount" size="26"
						value="<%=DataUtility.getStringData(bean.getMobile())%>"></td>
					<td style="position: fixed"><font color="red"> <%=ServletUtility.getErrorMessage("Mobile", request)%></font></td>
				</tr>
				<tr>
				<tr>

					<th style="padding: 3px"></th>
				</tr>
				<tr>
					<th align="left">Decease <span style="color: red">*</span> :
					</th>
					<td>
						<%
							HashMap map = new HashMap();
							map.put("tumer", "tumer");
							map.put("cancer", "caner");

							String hlist = HTMLUtility.getList("Decease", String.valueOf(bean.getDecease()), map);
						%> <%=hlist%>
					<td style="position: fixed"><font color="red"> <%=ServletUtility.getErrorMessage("Decease", request)%></font></td><tr>
					<th></th>
			
						<%
										if (bean.getId() > 0) {
									%>
					<td colspan="2">&nbsp; &emsp; <input type="submit"
						name="operation" value="<%=PatientCtl.OP_UPDATE%>"> &nbsp;
						&nbsp; <input type="submit" name="operation"
						value="<%=PatientCtl.OP_CANCEL%>"></td>

					<%
						} else {
					%>

					<td colspan="2">&nbsp; &emsp; <input type="submit"
						name="operation" value="<%=PatientCtl.OP_SAVE%>"> &nbsp;
						&nbsp; <input type="submit" name="operation"
						value="<%=PatientCtl.OP_RESET%>"></td>

					<%
						}
					%>
				</tr>
			</table>
		</form>
	</center>

	<%@ include file="Footer.jsp"%>

































</body>

</html>