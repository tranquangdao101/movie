package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;

import connect.ConnectionPool;
import model.ForgotPassword;
import model.User;

public class ForgotPasswordDAO {

	Connection conn;
	ConnectionPool pool;

	public ForgotPasswordDAO() {
		conn = null;
		pool = ConnectionPool.getInstance();
	}
	
	public boolean checkID(long id) {
		conn = pool.getConnectionFromPool();
		String sql ="Select * from ForgetPassword where forgetPasswordID = '"+id+"'";
		try {
			PreparedStatement ps = conn.prepareCall(sql);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				pool.returnConnectionToPool(conn);
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return false;
	}
	
	public long getForgetIDByUser(long id) {
		conn = pool.getConnectionFromPool();
		String sql = "Select forgetPasswordID from ForgetPassword";
		try {
			PreparedStatement ps = conn.prepareCall(sql);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				pool.returnConnectionToPool(conn);
				return rs.getLong("forgetPasswordID");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return -1;
	}
	
	public void add(ForgotPassword forgotPassword) {
		conn = pool.getConnectionFromPool();
		String sql = "Insert into ForgetPassword(userID,dateTimeRequest) values(?,?)";
		try {
			PreparedStatement ps = conn.prepareCall(sql);
			ps.setLong(1, forgotPassword.getUser().getUserID());
			ps.setTimestamp(2, new Timestamp(forgotPassword.getDatetime().getTime()));
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
	}
	
	public ForgotPassword getForgotPasswordByID(long id) {
		for (ForgotPassword i : getListForgotPassword()) {
			if(i.getForgetID()==id)
				return i;
		}
		return null;
	}
	
	public void delete(long forgotID) {
		conn = pool.getConnectionFromPool();
		String sql = "Delete ForgetPassword where forgetPasswordID ='"+forgotID+"'";
		try {
			PreparedStatement ps = conn.prepareCall(sql);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
	}

	public ArrayList<ForgotPassword> getListForgotPassword() {
		conn = pool.getConnectionFromPool();
		ArrayList<ForgotPassword> result = new ArrayList<>();
		String sql = "Select * from ForgetPassword f join Users u on f.userID = u.userID";
		try {
			PreparedStatement ps = conn.prepareCall(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				User user = new User();
				user.setUserID(rs.getLong("userID"));
				user.setUserName(rs.getString("userName"));
				user.setFirstName(rs.getNString("userFirstName"));
				user.setLastName(rs.getNString("userLastName"));
				user.setPassword(rs.getString("userPass"));
				user.setPhone(rs.getString("userPhone"));
				user.setEmail(rs.getString("userEmail"));
				user.setGender(rs.getString("userGender"));
				user.setValid(rs.getBoolean("userIsValid"));
				user.setAvatar(rs.getString("userAvatar"));
				user.setFacebookID(rs.getString("userFacebookID"));
				user.setFacebookLink(rs.getString("userFacebookLink"));
				long forgetPasswordID = rs.getLong("forgetPasswordID");
				Timestamp timestamp = rs.getTimestamp("dateTimeRequest");
				Date dateime = new Date(timestamp.getTime());
				ForgotPassword forgotPassword = new ForgotPassword(forgetPasswordID, user, dateime);
				result.add(forgotPassword);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return result;
	}
	
	public static void main(String[] args) {
		ForgotPasswordDAO forgotPasswordDAO = new ForgotPasswordDAO();
		for (ForgotPassword fo : forgotPasswordDAO.getListForgotPassword()) {
			System.out.println(fo.getDatetime().getTime());
		}
	}

}
