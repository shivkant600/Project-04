<%@page import="java.util.HashMap"%>
<%@page import="com.rays.pro4.controller.CompensationListCtl"%>
<%@page import="com.rays.pro4.Bean.CompensationBean"%>
<%@page import="com.rays.pro4.controller.ProductListCtl"%>
<%@page import="com.rays.pro4.Bean.ProductBean"%>
<%@page import="com.rays.pro4.Util.HTMLUtility"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.rays.pro4.Util.DataUtility"%>
<%@page import="com.rays.pro4.Util.ServletUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
<link rel="icon" type="image/png"
	href="<%=ORSView.APP_CONTEXT%>/img/logo.png" sizes="16*16" />

<title>Product List</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">


<script src="<%=ORSView.APP_CONTEXT%>/js/jquery.min.js"></script>
<script src="<%=ORSView.APP_CONTEXT%>/js/Checkbox11.js"></script>

<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	$(function() {
		$("#udate").datepicker({
			changeMonth : true,
			changeYear : true,
			yearRange : '1980:2002',
		//  mindefaultDate : "01-01-1962"
		});
	});
</script>

</head>
<body>
	<jsp:useBean id="bean" class="com.rays.pro4.Bean.CompensationBean"
		scope="request"></jsp:useBean>
	<%@include file="Header.jsp"%>


	<form action="<%=ORSView.COMPENSATION_LIST_CTL%>" method="post">

		<center>

			<div align="center">
				<h1>Compensation List</h1>
				<h3>
					<font color="red"><%=ServletUtility.getErrorMessage(request)%></font>
					<font color="green"><%=ServletUtility.getSuccessMessage(request)%></font>
				</h3>

			</div>

			<%
				int next = DataUtility.getInt(request.getAttribute("nextlist").toString());
				List proList = (List) request.getAttribute("proList");
			%>


			<%
				int pageNo = ServletUtility.getPageNo(request);
				int pageSize = ServletUtility.getPageSize(request);
				int index = ((pageNo - 1) * pageSize) + 1;

				List list = ServletUtility.getList(request);
				Iterator<CompensationBean> it = list.iterator();

				if (list.size() != 0) {
			%>
			<table width="100%" align="center">
				<tr>
					<th></th>
					<td align="center"><label>State</font> :
					</label> <input type="text" name="state" placeholder="Enter State Name"
						value="<%=ServletUtility.getParameter("State", request)%>">
						&emsp;<label>dob</font> :
					</label><input type="text" name="dateApplied" id="udate"
						readonly="readonly" size="25" placeholder="Enter Dob "
						value="<%=ServletUtility.getParameter("dateApplied", request)%>">&emsp;
						<label>Staffmember</font> : <!-- <th align="left">Staffmember <span style="color: red">*</span>
						:
					</th>
					<td> --> <%
 	HashMap map = new HashMap();
 		map.put("docter", "docter");
 		map.put("nurse", "nurse");
 		map.put("surgen", "surgen");

 		String hlist = HTMLUtility.getList("staffMember", String.valueOf(bean.getStaffmember()), map);
 %> <%=hlist%></td>
					<td style="position: fixed"><font color="red"> <%=ServletUtility.getErrorMessage("staffMember", request)%></font></td>
				</tr>
				&nbsp;
				<input type="submit" name="operation"
					value="<%=CompensationListCtl.OP_SEARCH%>"> &nbsp;
				<input type="submit" name="operation"
					value="<%=CompensationListCtl.OP_RESET%>">
				</td>
				</tr>
			</table>
			<br>

			<table border="1" width="100%" align="center" cellpadding=6px
				cellspacing=".2">
				<tr style="background: skyblue">
					<th><input type="checkbox" id="select_all" name="select">Select
						All</th>

					<th>S.No.</th>
					<th>SgtaffMember</th>
					<th>PaymentAmount</th>
					<th>Date</th>
					<th>State</th>
					<th>Edit</th>
				</tr>

				<%
					while (it.hasNext()) {
							bean = it.next();
				%>


				<tr align="center">
					<td><input type="checkbox" class="checkbox" name="ids"
						value="<%=bean.getId()%>"></td>
					<td><%=index++%></td>
					<td><%=bean.getStaffmember()%></td>
					<td><%=bean.getPaymentamount()%></td>
					<td><%=bean.getDateapplied()%></td>
					<td><%=bean.getState()%></td>
					<td><a href="ProductCtl?id=<%=bean.getId()%>">Edit</a></td>
				</tr>
				<%
					}
				%>
			</table>

			<table width="100%">
				<tr>
					<th></th>
					<%
						if (pageNo == 1) {
					%>
					<td><input type="submit" name="operation" disabled="disabled"
						value="<%=CompensationListCtl.OP_PREVIOUS%>"></td>
					<%
						} else {
					%>
					<td><input type="submit" name="operation"
						value="<%=CompensationListCtl.OP_PREVIOUS%>"></td>
					<%
						}
					%>

					<td><input type="submit" name="operation"
						value="<%=CompensationListCtl.OP_DELETE%>"></td>
					<td><input type="submit" name="operation"
						value="<%=CompensationListCtl.OP_NEW%>"></td>
					<td align="right"><input type="submit" name="operation"
						value="<%=CompensationListCtl.OP_NEXT%>"
						<%=(list.size() < pageSize || next == 0) ? "disabled" : ""%>></td>



				</tr>
			</table>
			<%
				}
				if (list.size() == 0) {
			%>
			<td align="center"><input type="submit" name="operation"
				value="<%=CompensationListCtl.OP_BACK%>"></td>
			<%
				}
			%>

			<input type="hidden" name="pageNo" value="<%=pageNo%>"> <input
				type="hidden" name="pageSize" value="<%=pageSize%>">
	</form>
	</br>
	</br>
	</br>
	</br>
	</br>
	</br>
	</br>

	</center>

	<%@include file="Footer.jsp"%>
</body>
</html>
