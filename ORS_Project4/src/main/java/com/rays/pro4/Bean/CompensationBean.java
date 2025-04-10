package com.rays.pro4.Bean;

import java.util.Date;

public class CompensationBean extends BaseBean {
	private String staffmember;
	private String paymentamount;
	private Date Dateapplied;
	private String State;

	public String getStaffmember() {
		return staffmember;
	}

	public void setStaffmember(String staffmember) {
		this.staffmember = staffmember;
	}

	public String getPaymentamount() {
		return paymentamount;
	}

	public void setPaymentamount(String paymentamount) {
		this.paymentamount = paymentamount;
	}

	public Date getDateapplied() {
		return Dateapplied;
	}

	public void setDateapplied(Date dateapplied) {
		Dateapplied = dateapplied;
	}

	public String getState() {
		return State;
	}

	public void setState(String state) {
		State = state;
	}

	@Override
	public String getkey() {
		// TODO Auto-generated method stub
		return id + "";
	}

	@Override
	public String getValue() {
		String name;
		// TODO Auto-generated method stub
		return staffmember;
	}

}
