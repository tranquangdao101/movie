package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.regex.Pattern;

import connect.ConnectionPool;
import model.User;

public class UserDAO implements DAO {

	Connection conn;
	ConnectionPool pool;

	public UserDAO() {
		conn = null;
		pool = ConnectionPool.getInstance();
	}

	@Override
	public void delete(Object obj) {
		conn = pool.getConnectionFromPool();
		User u = (User) obj;
		long userID = u.getUserID();
		String query = "Delete from Users where userID = '" + userID + "'  ";
		PreparedStatement ps;
		try {
			ps = conn.prepareCall(query);
			ps.executeUpdate();
		} catch (SQLException ex) {
		}
		pool.returnConnectionToPool(conn);
	}

	@Override
	public void update(Object obj) {
		conn = pool.getConnectionFromPool();
		User u = (User) obj;
		String username = u.getUserName();
		String query = "Update Users set firstName = ?, lastName = ?, userPhone = ?, userEmail = ? where userName = '"
				+ username + "'  ";
		PreparedStatement ps;
		try {
			ps = conn.prepareCall(query);
			ps.setNString(1, u.getFirstName());
			ps.setNString(2, u.getLastName());
			ps.setString(3, u.getPhone());
			ps.setString(4, u.getEmail());
			ps.executeUpdate();
		} catch (SQLException ex) {
		}
		pool.returnConnectionToPool(conn);
	}

	@Override
	public void add(Object obj) {
		conn = pool.getConnectionFromPool();
		User u = (User) obj;
		String query = "Insert Into Users values (?,?,?,?,?,?,?)";
		try {
			PreparedStatement ps = conn.prepareCall(query);
			ps.setString(1, u.getUserName());
			ps.setNString(2, u.getFirstName());
			ps.setNString(3, u.getLastName());
			ps.setString(4, u.getPassword());
			ps.setString(5, u.getPhone());
			ps.setString(6, u.getEmail());
			ps.setBoolean(7, u.isValid());
			ps.executeUpdate();
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
	}

	public ArrayList<User> getListUser() {
		conn = pool.getConnectionFromPool();
		ArrayList<User> list = new ArrayList<User>();
		PreparedStatement ps;
		try {
			ps = conn.prepareCall("Select * from Users");
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
				user.setGoogleID(rs.getString("userGoogleID"));
				user.setGoogleLink(rs.getString("userGoogleLink"));
				list.add(user);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return list;
	}

	public boolean isValidEmailAddress(String email) {
		String ePattern = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\])|(([a-zA-Z\\-0-9]+\\.)+[a-zA-Z]{2,}))$";
		java.util.regex.Pattern p = java.util.regex.Pattern.compile(ePattern);
		java.util.regex.Matcher m = p.matcher(email);
		return m.matches();
	}

	public boolean isValidUsername(String x) {
		return (x != null && Pattern.matches("^[a-zA-Z0-9:]*", x)) ? true : false;
	}

	public static void main(String[] args) {
		UserDAO uDAO = new UserDAO();
		System.out.println(uDAO.getUserByID(1).getFullName());
	}

	public boolean checkEmail(String email) {
		conn = pool.getConnectionFromPool();
		String query = "Select * From Users where userEmail ='" + email + "'";
		PreparedStatement ps;
		try {
			ps = conn.prepareCall(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				pool.returnConnectionToPool(conn);
				return true;
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return false;
	}
	

	public boolean register(User user) {
		conn = pool.getConnectionFromPool();
		PreparedStatement ps = null;
		String userName = user.getUserName();
		String lastName = user.getLastName();
		String firstName = user.getFirstName();
		String facebookID = user.getFacebookID();
		String facebookLink = user.getFacebookLink();
		String userAvatar = user.getAvatar();
		String userGender = user.getGender();
		String userEmail = user.getEmail();
		String sql = "Insert into Users (userName,userFirstName,userLastName,userFacebookID,userFacebookLink,userAvatar,userGender,userEmail) values (?,?,?,?,?,?,?,?)";
		try {
			ps = conn.prepareCall(sql);
			ps.setString(1, userName);
			ps.setNString(2, firstName);
			ps.setNString(3, lastName);
			ps.setString(4, facebookID);
			ps.setString(5, facebookLink);
			ps.setString(6, userAvatar);
			ps.setString(7, userGender);
			ps.setString(8, userEmail);
			int row = ps.executeUpdate();
			if (row > 0)
				pool.returnConnectionToPool(conn);
				return true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		pool.returnConnectionToPool(conn);
		return false;
	}
	
	
	public boolean registerGoogle(User user) {
		conn = pool.getConnectionFromPool();
		PreparedStatement ps = null;
		String userName = user.getUserName();
		String lastName = user.getLastName();
		String firstName = user.getFirstName();
		String googleID = user.getGoogleID();
		String googleLink = user.getGoogleLink();
		String userAvatar = user.getAvatar();
		String userGender = user.getGender();
		String userEmail = user.getEmail();
		String sql = "Insert into Users (userName,userFirstName,userLastName,userGoogleID,userGoogleLink,userAvatar,userGender,userEmail) values (?,?,?,?,?,?,?,?)";
		try {
			ps = conn.prepareCall(sql);
			ps.setString(1, userName);
			ps.setNString(2, firstName);
			ps.setNString(3, lastName);
			ps.setString(4, googleID);
			ps.setString(5, googleLink);
			ps.setString(6, userAvatar);
			ps.setString(7, userGender);
			ps.setString(8, userEmail);
			int row = ps.executeUpdate();
			if (row > 0)
				pool.returnConnectionToPool(conn);
				return true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		pool.returnConnectionToPool(conn);
		return false;
	}

	public User checkLogin(String facebookID) {
		conn = pool.getConnectionFromPool();
		PreparedStatement ps = null;
		User user = new User();
		String sql = "select * from Users where userFacebookID = '" + facebookID + "'";
		try {
			ps = conn.prepareCall(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				long userID = rs.getLong("userID");
				String userName = rs.getString("userName");
				String firstName = rs.getNString("userFirstName");
				String lastName = rs.getNString("userLastName");
				String faceID = rs.getString("userFacebookID");
				String faceLink = rs.getString("userFacebookLink");
				String avatar = rs.getString("userAvatar");

				user.setUserID(userID);
				user.setUserName(userName);
				user.setFirstName(firstName);
				user.setLastName(lastName);
				user.setFacebookID(faceID);
				user.setFacebookLink(faceLink);
				user.setAvatar(avatar);
				pool.returnConnectionToPool(conn);
				return user;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		pool.returnConnectionToPool(conn);
		return null;
	}
	
	public User checkLoginGoogle(String ID) {
		conn = pool.getConnectionFromPool();
		PreparedStatement ps = null;
		User user = new User();
		String sql = "select * from Users where userGoogleID = '" + ID + "'";
		try {
			ps = conn.prepareCall(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				long userID = rs.getLong("userID");
				String userName = rs.getString("userName");
				String firstName = rs.getNString("userFirstName");
				String lastName = rs.getNString("userLastName");
				String googleID = rs.getString("userGoogleID");
				String googleLink = rs.getString("userGoogleLink");
				String avatar = rs.getString("userAvatar");
				
				user.setUserID(userID);
				user.setUserName(userName);
				user.setFirstName(firstName);
				user.setLastName(lastName);
				user.setFacebookID(googleID);
				user.setFacebookLink(googleLink);
				user.setAvatar(avatar);
				pool.returnConnectionToPool(conn);
				return user;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		pool.returnConnectionToPool(conn);
		return null;
	}

	public User getUserByFacebookID(String facebookID) {
		conn = pool.getConnectionFromPool();
		PreparedStatement ps = null;
		User user = new User();
		String sql = "select * from Users where userFacebookID = '" + facebookID + "'";
		try {
			ps = conn.prepareCall(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				long userID = rs.getLong("userID");
				String userName = rs.getString("userName");
				String firstName = rs.getNString("userFirstName");
				String lastName = rs.getNString("userLastName");
				String faceID = rs.getString("userFacebookID");
				String faceLink = rs.getString("userFacebookLink");
				String avatar = rs.getString("userAvatar");
				String email = rs.getString("userEmail");
				String gender = rs.getString("userGender");
				String phone = rs.getString("userPhone");
				
				user.setGender(gender);
				user.setUserID(userID);
				user.setUserName(userName);
				user.setFirstName(firstName);
				user.setLastName(lastName);
				user.setFacebookID(faceID);
				user.setFacebookLink(faceLink);
				user.setAvatar(avatar);
				user.setEmail(email);
				user.setPhone(phone);
				pool.returnConnectionToPool(conn);
				return user;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		pool.returnConnectionToPool(conn);
		return null;
	}
	
	
	public User getUserByGoogleID(String googleID) {
		conn = pool.getConnectionFromPool();
		PreparedStatement ps = null;
		User user = new User();
		String sql = "select * from Users where userGoogleID = '" + googleID + "'";
		try {
			ps = conn.prepareCall(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				long userID = rs.getLong("userID");
				String userName = rs.getString("userName");
				String firstName = rs.getNString("userFirstName");
				String lastName = rs.getNString("userLastName");
				String gID = rs.getString("userGoogleID");
				String gLink = rs.getString("userGoogleLink");
				String avatar = rs.getString("userAvatar");
				String email = rs.getString("userEmail");
				String gender = rs.getString("userGender");
				String userPhone = rs.getString("userPhone");
				
				user.setGender(gender);
				user.setUserID(userID);
				user.setUserName(userName);
				user.setFirstName(firstName);
				user.setLastName(lastName);
				user.setGoogleID(gID);
				user.setGoogleLink(gLink);
				user.setAvatar(avatar);
				user.setEmail(email);
				user.setPhone(userPhone);
				pool.returnConnectionToPool(conn);
				return user;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		pool.returnConnectionToPool(conn);
		return null;
	}

	public User getUserByID(long id) {
		conn = pool.getConnectionFromPool();
		String query = "select * from Users where userID='" + id + "'";
		try {
			User user = new User();
			PreparedStatement ps = conn.prepareCall(query);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
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
				user.setGoogleID(rs.getString("userGoogleID"));
				user.setGoogleLink(rs.getString("userGoogleLink"));
				pool.returnConnectionToPool(conn);
				return user;
			} else {
				pool.returnConnectionToPool(conn);
				return null;
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return null;
	}

	public User getUserByEmail(String email) {
		conn = pool.getConnectionFromPool();
		String query = "select * from Users where userEmail = '" + email + "' AND userFacebookID is Null AND userGoogleID is NULL";
		try {
			PreparedStatement ps = conn.prepareCall(query);
			ResultSet rs = ps.executeQuery();
			User user = new User();
			if (rs.next()) {
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
				pool.returnConnectionToPool(conn);
				return user;
			} else {
				pool.returnConnectionToPool(conn);
				return null;
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return null;
	}

	public void update(User u) {
		conn = pool.getConnectionFromPool();
		long userID = u.getUserID();
		String query = "Update Users set userFirstName = ? , userLastName = ? , userPass = ? , userPhone = ?, userEmail = ?, userGender = ?, userAvatar = ? , userName = ? where userID = '"
				+ userID + "'  ";
		try {
			PreparedStatement ps = conn.prepareCall(query);
			ps.setNString(1, u.getFirstName());
			ps.setNString(2, u.getLastName());
			ps.setString(3, u.getPassword());
			ps.setString(4, u.getPhone());
			ps.setString(5, u.getEmail());
			ps.setString(6, u.getGender());
			ps.setString(7, u.getAvatar());
			ps.setString(8, u.getUserName());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
	}

	public boolean checkUserName(String userName) {
		if(userName==null)
			return false;
		conn = pool.getConnectionFromPool();
		String query = "Select * From Users where userName ='" + userName + "'";
		try {
			PreparedStatement ps = conn.prepareCall(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				pool.returnConnectionToPool(conn);
				return true;
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return false;
	}

	public boolean add(User u) {
		conn = pool.getConnectionFromPool();
		String query = "Insert Into Users (userName,userFirstName,userLastName,userPass,userPhone,userEmail,userGender,userIsValid,userAvatar) values (?,?,?,?,?,?,?,?,?)";
		try {
			PreparedStatement ps = conn.prepareCall(query);
			ps.setString(1, u.getUserName());
			ps.setNString(2, u.getFirstName());
			ps.setNString(3, u.getLastName());
			ps.setString(4, u.getPassword());
			ps.setString(5, u.getPhone());
			ps.setString(6, u.getEmail());
			ps.setString(7, u.getGender());
			ps.setBoolean(8, u.isValid());
			ps.setString(9, u.getAvatar());
			ps.executeUpdate();
			pool.returnConnectionToPool(conn);
			return true;
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return false;
	}

	public User login(String username, String password) {
		conn = pool.getConnectionFromPool();
		String query = "Select* from Users where userName ='" + username + "' AND userPass='" + password + "'";
		PreparedStatement ps;
		try {
			ps = conn.prepareCall(query);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				User u = new User();
				u.setUserName(rs.getString("userName"));
				u.setPassword(rs.getString("userPass"));
				u.setEmail(rs.getString("userEmail"));
				u.setFirstName(rs.getNString("userFirstName"));
				u.setLastName(rs.getNString("userLastName"));
				u.setPhone(rs.getString("userPhone"));
				u.setUserID(rs.getLong("userID"));
				u.setValid(rs.getBoolean("userIsValid"));
				u.setAvatar(rs.getString("userAvatar"));
				u.setGender(rs.getString("userGender"));
				pool.returnConnectionToPool(conn);
				return u;
			}
		} catch (SQLException ex) {

		}
		pool.returnConnectionToPool(conn);
		return null;
	}

}
