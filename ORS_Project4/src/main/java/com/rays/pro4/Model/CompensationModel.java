package com.rays.pro4.Model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.rays.pro4.Bean.CompensationBean;
import com.rays.pro4.Util.JDBCDataSource;

public class CompensationModel {
	public Integer nextPK() throws Exception {

		int pk = 0;

		Connection conn = JDBCDataSource.getConnection();

		PreparedStatement pstmt = conn.prepareStatement("select max(id) from st_compasation");

		ResultSet rs = pstmt.executeQuery();

		while (rs.next()) {
			pk = rs.getInt(1);
		}

		rs.close();

		return pk + 1;
	}

	public long add(CompensationBean bean) throws Exception {

		int pk = 0;

		Connection conn = JDBCDataSource.getConnection();

		pk = nextPK();

		conn.setAutoCommit(false);

		PreparedStatement pstmt = conn.prepareStatement("insert into st_compasation values(?,?,?,?,?)");

		pstmt.setInt(1, pk);
		pstmt.setString(2, bean.getStaffmember());
		pstmt.setString(3, bean.getPaymentamount());
		pstmt.setDate(4, new java.sql.Date(bean.getDateapplied().getTime()));
		pstmt.setString(5, bean.getState());

		int i = pstmt.executeUpdate();
		System.out.println("compensation Add Successfully " + i);
		conn.commit();
		pstmt.close();

		return pk;
	}

	public void delete(CompensationBean bean) throws Exception {

		Connection conn = JDBCDataSource.getConnection();

		conn.setAutoCommit(false);

		PreparedStatement pstmt = conn.prepareStatement("delete from st_compasation where id = ?");

		pstmt.setLong(1, bean.getId());

		int i = pstmt.executeUpdate();
		System.out.println("compensation delete successfully " + i);
		conn.commit();

		pstmt.close();
	}

	public void update(CompensationBean bean) throws Exception {

		Connection conn = JDBCDataSource.getConnection();

		conn.setAutoCommit(false); // Begin transaction

		PreparedStatement pstmt = conn.prepareStatement(
				"update st_compasation set staffmember = ?, paymentamount = ?, date = ?, state = ? where id = ?");

		pstmt.setString(1, bean.getStaffmember());
		pstmt.setString(2, bean.getPaymentamount());
		pstmt.setDate(3, new java.sql.Date(bean.getDateapplied().getTime()));
		pstmt.setString(4, bean.getState());
		pstmt.setLong(5, bean.getId());

		int i = pstmt.executeUpdate();

		System.out.println(" update successfully " + i);

		conn.commit();
		pstmt.close();

	}

	public CompensationBean findByPK(long pk) throws Exception {

		String sql = "select * from st_compasation where id = ?";
		CompensationBean bean = null;

		Connection conn = JDBCDataSource.getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);

		pstmt.setLong(1, pk);

		ResultSet rs = pstmt.executeQuery();

		while (rs.next()) {

			bean = new CompensationBean();
			
			bean.setId(rs.getLong(1));
			bean.setStaffmember(rs.getString(2));
			bean.setPaymentamount(rs.getString(3));
			bean.setDateapplied(rs.getDate(4));
			bean.setState(rs.getString(5));

		}

		rs.close();

		return bean;
	}

	public List search(CompensationBean bean, int pageNo, int pageSize) throws Exception {

		StringBuffer sql = new StringBuffer("select * from st_compasation where 1=1");
		if (bean != null) {

			if (bean.getStaffmember() != null && bean.getStaffmember().length() > 0) {
				sql.append(" AND staffmember like '" + bean.getStaffmember() + "%'");
			}

			if (bean.getState() != null && bean.getState().length() > 0) {
				sql.append(" AND State like '" + bean.getState() + "%'");
			}

			if (bean.getDateapplied() != null && bean.getDateapplied().getTime() > 0) {
				Date d = new Date(bean.getDateapplied().getTime());
				sql.append(" AND appliedDate = '" + d + "'");
				System.out.println("done");
			}

			if (bean.getId() > 0) {
				sql.append(" AND id = " + bean.getId());
			}

		}

		if (pageSize > 0) {

			pageNo = (pageNo - 1) * pageSize;

			sql.append(" Limit " + pageNo + ", " + pageSize);

		}

		System.out.println("sql query search >>= " + sql.toString());
		List list = new ArrayList();

		Connection conn = JDBCDataSource.getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql.toString());

		ResultSet rs = pstmt.executeQuery();

		while (rs.next()) {

			bean = new CompensationBean();
			bean.setId(rs.getLong(1));
			bean.setStaffmember(rs.getString(2));
			bean.setPaymentamount(rs.getString(3));
			bean.setDateapplied(rs.getDate(4));
			bean.setState(rs.getString(5));

			list.add(bean);

		}
		rs.close();

		return list;

	}

	public List list() throws Exception {

		ArrayList list = new ArrayList();

		StringBuffer sql = new StringBuffer("select * from st_compasation");

		Connection conn = JDBCDataSource.getConnection();

		PreparedStatement pstmt = conn.prepareStatement(sql.toString());
		ResultSet rs = pstmt.executeQuery();

		while (rs.next()) {

			CompensationBean bean = new CompensationBean();

			bean.setId(rs.getLong(1));
			bean.setStaffmember(rs.getString(2));
			bean.setPaymentamount(rs.getString(3));
			bean.setDateapplied(rs.getDate(4));
			bean.setState(rs.getString(5));

			list.add(bean);

		}

		rs.close();

		return list;
	}

}
