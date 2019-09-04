package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import connect.ConnectionPool;
import model.MovieRole;

public class MovieRoleDAO implements DAO {
	
	Connection conn;
	ConnectionPool pool;
	
	public MovieRoleDAO() {
		conn = null;
		pool = ConnectionPool.getInstance();
	}
	

	@Override
	public void add(Object obj) {
		conn = pool.getConnectionFromPool();
		MovieRole mr = (MovieRole) obj;
		String query = "Insert into MovieRole(movieRoleName) values(?)";
		try {
			PreparedStatement ps = conn.prepareCall(query);
			ps.setNString(1, mr.getMovieRoleName());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
	}

	@Override
	public void update(Object obj) {
		conn = pool.getConnectionFromPool();
		MovieRole mr = (MovieRole) obj;
		String query ="Update MovieRole set movieRoleName = ? where movieRoleID = '"+mr.getMovieRoleID()+"'";
		try {
			PreparedStatement ps = conn.prepareCall(query);
			ps.setNString(1, mr.getMovieRoleName());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
	}

	@Override
	public void delete(Object obj) {
		conn = pool.getConnectionFromPool();
		MovieRole mr = (MovieRole) obj;
		String query ="Delete MovieRole where movieRoleID = '"+mr.getMovieRoleID()+"'";
		try {
			PreparedStatement ps = conn.prepareCall(query);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
	}
	
	public ArrayList<MovieRole> getListMovieRole() {
		conn = pool.getConnectionFromPool();
		ArrayList<MovieRole> result = new ArrayList<>();
		String query = "Select * from MovieRole";
		try {
			PreparedStatement ps = conn.prepareCall(query);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				MovieRole m = new MovieRole();
				m.setMovieRoleID(rs.getLong("movieRoleID"));
				m.setMovieRoleName(rs.getNString("movieRoleName"));
				result.add(m);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return result;
	}
	
	public boolean checkMovieRoleName(String name) {
		conn = pool.getConnectionFromPool();
		String query= "Select * from MovieRole where movieRoleName =N'"+name+"'";
		try {
			PreparedStatement ps = conn.prepareCall(query);
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
	
	public MovieRole getMovieRole(long id) {
		conn = pool.getConnectionFromPool();
		String query = "Select * from MovieRole where movieRoleID ="+id+"";
		try {
			PreparedStatement ps = conn.prepareCall(query);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				pool.returnConnectionToPool(conn);
				return new MovieRole(rs.getLong("movieRoleID"),rs.getNString("movieRoleName"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return null;
	}
	
}
