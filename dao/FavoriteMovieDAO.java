package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import connect.ConnectionPool;
import model.FavoriteMovie;
import model.Movie;

public class FavoriteMovieDAO {
	
	Connection conn;
	ConnectionPool pool;
	
	public FavoriteMovieDAO() {
		conn = null;
		pool = ConnectionPool.getInstance();
	}
	
	public void add(FavoriteMovie fMovie) {
		conn = pool.getConnectionFromPool();
		String query = "Insert into FavoriteMovie values(?,?)";
		try {
			PreparedStatement ps = conn.prepareCall(query);
			ps.setLong(1, fMovie.getUserID());
			ps.setLong(2, fMovie.getMovieID());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
	}
	
	public void remove(long userID,long movieID) {
		conn = pool.getConnectionFromPool();
		String query ="Delete FavoriteMovie where movieID='"+movieID+"' AND userID='"+userID+"'";
		try {
			PreparedStatement ps = conn.prepareCall(query);
			ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
	}
	
	public ArrayList<Movie> getListMovieFavoriteByUser(long userID) {
		conn = pool.getConnectionFromPool();
		String query = "Select * from FavoriteMovie where userID='"+userID+"'";
		MovieDAO mDAO = new MovieDAO();
		ArrayList<Movie> list = new ArrayList<>();
		try {
			PreparedStatement ps = conn.prepareCall(query);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				list.add(mDAO.getMovie(rs.getLong("movieID")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return list;
	}
	
}
