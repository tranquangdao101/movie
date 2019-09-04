package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import connect.ConnectionPool;
import model.Cast;
import model.Crew;
import model.Movie;
import model.MovieRole;

public class CastDAO implements DAO {

	Connection conn;
	ConnectionPool pool;

	public CastDAO() {
		conn = null;
		pool = ConnectionPool.getInstance();
	}

	@Override
	public void add(Object obj) {
		conn = pool.getConnectionFromPool();
		Cast cast = (Cast) obj;
		long movieID = cast.getMovie().getMovieID();
		long crewID = cast.getCrew().getCrewID();
		long movieRoleID = cast.getMovieRole().getMovieRoleID();
		String sql = "insert into Casts(movieID,crewID,movieRoleID) values (?,?,?)";
		try {
			PreparedStatement ps = conn.prepareCall(sql);
			ps.setLong(1, movieID);
			ps.setLong(2, crewID);
			ps.setLong(3, movieRoleID);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
	}

	@Override
	public void update(Object obj) {
		conn = pool.getConnectionFromPool();
		Cast cast = (Cast) obj;
		String sql = "Update Casts set movieID = ? , crewID = ? , movieRoleID = ? where castID = '" + cast.getCastID()
				+ "'";
		try {
			PreparedStatement ps = conn.prepareCall(sql);
			ps.setLong(1, cast.getMovie().getMovieID());
			ps.setLong(2, cast.getCrew().getCrewID());
			ps.setLong(3, cast.getMovieRole().getMovieRoleID());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
	}
	
	public void updateActor(long movieID, long[] crewID) {
		conn = pool.getConnectionFromPool();
		String query = "Delete Casts where movieID = '"+movieID+"'";
		try {
			PreparedStatement ps = conn.prepareStatement(query);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		for (long l : crewID) {
			try {
				PreparedStatement ps = conn.prepareStatement("insert into Casts(movieID,crewID,movieRoleID) values (?,?,?)");
				ps.setLong(1, movieID);
				ps.setLong(2, l);
				ps.setLong(3, 1);
				ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	

	@Override
	public void delete(Object obj) {
		conn = pool.getConnectionFromPool();
		Cast cast = (Cast) obj;
		String query = "Delete Casts where castID = '" + cast.getCastID() + "'";
		try {
			PreparedStatement ps = conn.prepareCall(query);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
	}

	public ArrayList<Cast> getListCast() {
		conn = pool.getConnectionFromPool();
		String sql = "Select * from Casts";
		ArrayList<Cast> result = new ArrayList<>();
		try {
			PreparedStatement ps = conn.prepareCall(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Crew crew = new Crew();
				Movie movie = new Movie();
				MovieRole movieRole = new MovieRole();
				crew.setCrewID(rs.getLong("crewID"));
				movie.setMovieID(rs.getLong("movieID"));
				movieRole.setMovieRoleID(rs.getLong("movieRoleID"));
				Cast cast = new Cast(rs.getLong("castID"), crew, movie, movieRole);
				result.add(cast);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return result;
	}

	public ArrayList<Cast> getListCastByMovie(long movieID) {
		conn = pool.getConnectionFromPool();
		ArrayList<Cast> result = new ArrayList<>();
		for (Cast cast : getListCast()) {
			if (cast.getMovie().getMovieID() == movieID) {
				result.add(cast);
			}
		}
		pool.returnConnectionToPool(conn);
		return result;
	}

	public static void main(String[] args) {
		CastDAO castDAO = new CastDAO();
		ArrayList<Cast> arraylist = castDAO.getListCast();
		for (Cast cast : arraylist) {
			System.out.println("insert into Casts(movieID,crewID,movieRoleID) values (" + cast.getMovie().getMovieID()
					+ "," + cast.getCrew().getCrewID() + "," + cast.getMovieRole().getMovieRoleID() + ")");
		}
	}

}
