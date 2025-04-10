package com.rays.pro4.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.rays.pro4.Bean.BaseBean;
import com.rays.pro4.Bean.CompensationBean;
import com.rays.pro4.Model.CompensationModel;
import com.rays.pro4.Util.DataUtility;
import com.rays.pro4.Util.DataValidator;
import com.rays.pro4.Util.PropertyReader;
import com.rays.pro4.Util.ServletUtility;

@WebServlet(name = "CompensationCtl", urlPatterns = { "/ctl/CompensationCtl" })
public class CompensationCtl extends BaseCtl {

	protected boolean validate(HttpServletRequest request) {
		System.out.println("uctl Validate");

		boolean pass = true;

		if (DataValidator.isNull(request.getParameter("staffMember"))) {
			request.setAttribute("staffMember", PropertyReader.getValue("error.require", "staffMember"));
			pass = false;
		}
		if (DataValidator.isNull(request.getParameter("paymentAmount"))) {
			request.setAttribute("paymentAmount", PropertyReader.getValue("error.require", "paymentAmount"));
			pass = false;
		}
		if (DataValidator.isNull(request.getParameter("dateApplied"))) {
			request.setAttribute("dateApplied", PropertyReader.getValue("error.require", "dateApplied"));
			pass = false;
		}
		if (DataValidator.isNull(request.getParameter("state"))) {
			request.setAttribute("state", PropertyReader.getValue("error.require", "state"));
			pass = false;
		}

		return pass;

	}

	@Override
	protected BaseBean populateBean(HttpServletRequest request) {

		CompensationBean bean = new CompensationBean();

		bean.setId(DataUtility.getLong(request.getParameter("id")));

		bean.setStaffmember(DataUtility.getString(request.getParameter("staffMember")));

		bean.setPaymentamount(DataUtility.getString(request.getParameter("paymentAmount")));

		bean.setDateapplied(DataUtility.getDate(request.getParameter("dateApplied")));

		bean.setState(DataUtility.getString(request.getParameter("state")));

		return bean;

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String op = DataUtility.getString(request.getParameter("operation"));

		CompensationModel model = new CompensationModel();

		long id = DataUtility.getLong(request.getParameter("id"));

		System.out.println("product Edit Id >= " + id);

		if (id != 0 && id > 0) {

			System.out.println("in id > 0  condition " + id);
			CompensationBean bean;

			try {
				bean = model.findByPK(id);
				ServletUtility.setBean(bean, request);

			} catch (Exception e) {

				e.printStackTrace();
			}
		}

		ServletUtility.forward(getView(), request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("uctl Do Post");

		String op = DataUtility.getString(request.getParameter("operation"));

		long id = DataUtility.getLong(request.getParameter("id"));

		System.out.println(">>>><<<<>><<><<><<><>**********" + id + op);

		CompensationModel model = new CompensationModel();

		if (OP_SAVE.equalsIgnoreCase(op) || OP_UPDATE.equalsIgnoreCase(op)) {

			CompensationBean bean = (CompensationBean) populateBean(request);

			if (id > 0) {

				try {
					model.update(bean);
					ServletUtility.setBean(bean, request);
					ServletUtility.setSuccessMessage("compensation is successfully Updated", request);
				} catch (Exception e) {
					System.out.println("compensation not update");
					e.printStackTrace();
				}

			} else {

				try {
					long pk = model.add(bean);
					ServletUtility.setBean(bean, request);
					ServletUtility.setSuccessMessage("compensation is successfully Added", request);
					bean.setId(pk);
				} catch (Exception e) {
					System.out.println("compensation not added");
					e.printStackTrace();
				}

			}

		}
		ServletUtility.forward(getView(), request, response);

	}

	@Override
	protected String getView() {
		// TODO Auto-generated method stub
		return ORSView.COMPENSATION_VIEW;
	}

}
