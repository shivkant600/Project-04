<%@page import="com.rays.pro4.controller.CompensationCtl"%>
<%@page import="com.rays.pro4.controller.ProductCtl"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.rays.pro4.Util.HTMLUtility"%>
<%@page import="com.rays.pro4.Util.DataUtility"%>
<%@page import="com.rays.pro4.Util.ServletUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<html>
<head>
<link rel="icon" type="image/png"
	href="<%=ORSView.APP_CONTEXT%>/img/logo.png" sizes="16*16" />
<title>User Page</title>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
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
	<jsp:useBean id="bean" class="com.rays.pro4.Bean.CompensationBean"
		scope="request"></jsp:useBean>
	<%@ include file="Header.jsp"%>

	<center>

		<form action="<%=ORSView.COMPENSATION_CTL%>" method="post">

			<div align="center">
				<h1>

					<%
						if (bean != null && bean.getId() > 0) {
					%>
					<tr>
						<th><font size="5px"> Update Compensation </font></th>
					</tr>
					<%
						} else {
					%>
					<tr>
						<th><font size="5px"> Add Compensation </font></th>
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
					<th style="padding: 3px"></th>
				</tr>

				<tr>
					<th align="left">Staffmember <span style="color: red">*</span>
						:
					</th>
					<td>
						<%
							HashMap map = new HashMap();
							map.put("docter", "docter");
							map.put("nurse", "nurse");
							map.put("surgen", "surgen");

							String hlist = HTMLUtility.getList("staffMember", String.valueOf(bean.getStaffmember()), map);
						%> <%=hlist%>
					</td>
					<td style="position: fixed"><font color="red"> <%=ServletUtility.getErrorMessage("staffMember", request)%></font></td>
				</tr>

				<tr>
					<th align="left">PaymentAmount <span style="color: red">*</span>
						:
					</th>
					<td><input type="text" name="paymentAmount"
						placeholder="Enter Product Ammount" size="26"
						value="<%=DataUtility.getStringData(bean.getPaymentamount())%>"></td>
					<td style="position: fixed"><font color="red"> <%=ServletUtility.getErrorMessage("paymentAmount", request)%></font></td>
				</tr>
				<tr>
					<th align="left">DateApplied <span style="color: red">*</span>
						:
					</th>
					<td><input type="text" name="dateApplied"
						placeholder="Enter Purchase Date" size="26" readonly="readonly"
						id="udatee"
						value="<%=DataUtility.getDateString(bean.getDateapplied())%>"></td>
					<td style="position: fixed;"><font color="red"> <%=ServletUtility.getErrorMessage("dateApplied", request)%></font></td>
				</tr>

				<tr>
					<th align="left">state<span style="color: red">*</span> :
					</th>
					<td><input type="text" name="state"
						placeholder="Enter Product Ammount" size="26"
						value="<%=DataUtility.getStringData(bean.getState())%>"></td>
					<td style="position: fixed"><font color="red"> <%=ServletUtility.getErrorMessage("state", request)%></font></td>
				</tr>
				<tr>
					<th style="padding: 3px"></th>
				</tr>

				<tr>
					<th></th>
					<%
						if (bean.getId() > 0) {
					%>
					<td colspan="2">&nbsp; &emsp; <input type="submit"
						name="operation" value="<%=CompensationCtl.OP_UPDATE%>"> &nbsp;
						&nbsp; <input type="submit" name="operation"
						value="<%=CompensationCtl.OP_CANCEL%>"></td>

					<%
						} else {
					%>

					<td colspan="2">&nbsp; &emsp; <input type="submit"
						name="operation" value="<%=CompensationCtl.OP_SAVE%>">
						&nbsp; &nbsp; <input type="submit" name="operation"
						value="<%=CompensationCtl.OP_RESET%>"></td>

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