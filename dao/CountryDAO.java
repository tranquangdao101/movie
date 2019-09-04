package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import connect.ConnectionPool;
import model.Country;
import model.Movie;

public class CountryDAO implements DAO {

	Connection conn;
	ConnectionPool pool;
	public CountryDAO() {
		conn = null;
		pool = ConnectionPool.getInstance();
	}
	
	public Country getCountryByMovie(long movieID) {
		conn = pool.getConnectionFromPool();
		String sql = "Select * from Movie m join Country c on m.countryID = c.countryID where movieID = "+movieID+"";
		try {
			PreparedStatement ps = conn.prepareCall(sql);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				Country c = new Country();
				c.setCountryID(rs.getString("countryID"));
				c.setCountryName(rs.getNString("countryName"));
				c.setCountryNameVN(rs.getNString("countryNameVN"));
				pool.returnConnectionToPool(conn);
				return c;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return null;
	}
	@Override
	public void add(Object obj) {
		conn = pool.getConnectionFromPool();
		Country c = (Country) obj;
		String query = "Insert Into Country(countryID,countryName,countryNameVN) values (?,?,?)";
		try {
			PreparedStatement ps = conn.prepareCall(query);
			ps.setString(1, c.getCountryID());
			ps.setNString(2, c.getCountryName());
			ps.setNString(3, c.getCountryNameVN());
			ps.executeUpdate();
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
	}

	@Override
	public void update(Object obj) {
		conn = pool.getConnectionFromPool();
		Country c = (Country) obj;
		String query = "Update Country set countryName = ? , countryNameVN = ? where countryID = '"+c.getCountryID()+"'";
		PreparedStatement ps;
		try {
			ps = conn.prepareCall(query);
			ps.setNString(1, c.getCountryName());
			ps.setNString(2, c.getCountryNameVN());
			ps.executeUpdate();
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
	}

	public ArrayList<Country> getListCountryMovie() {
		conn = pool.getConnectionFromPool();
		ArrayList<Country> list = new ArrayList<>();
		String sql = "select * from Country where countryNameVN is not null";
		try {
			PreparedStatement ps = conn.prepareCall(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Country c = new Country();
				c.setCountryID(rs.getString("countryID"));
				c.setCountryName(rs.getNString("countryName"));
				c.setCountryNameVN(rs.getNString("countryNameVN"));
				list.add(c);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return list;
	}
	
	public ArrayList<Country> getListCountry() {
		conn = pool.getConnectionFromPool();
		ArrayList<Country> list = new ArrayList<>();
		String sql = "select * from Country where countryNameVN is not null";
		try {
			PreparedStatement ps = conn.prepareCall(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Country c = new Country();
				c.setCountryID(rs.getString("countryID"));
				c.setCountryName(rs.getNString("countryName"));
				c.setCountryNameVN(rs.getNString("countryNameVN"));
				list.add(c);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return list;
	}

	public Country getCountryByID(String id) {
		ArrayList<Country> list = getListCountry();
		for (Country country : list) {
			if (country.getCountryID().equals(id)) {
				return country;
			}
		}
		return null;
	}

	public boolean checkCountryName(String name) {
		conn = pool.getConnectionFromPool();
		String query = "Select * from Country where countryName = N'" + name + "'";
		try {
			PreparedStatement ps = conn.prepareCall(query);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				pool.returnConnectionToPool(conn);
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return false;
	}
	
	public boolean checkCountryID(String name) {
		conn = pool.getConnectionFromPool();
		String query = "Select * from Country where countryID = N'" + name + "'";
		try {
			PreparedStatement ps = conn.prepareCall(query);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				pool.returnConnectionToPool(conn);
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return false;
	}

	@Override
	public void delete(Object obj) {
		conn = pool.getConnectionFromPool();
		Country c = (Country) obj;
		String query = "Delete from Country where countryID = '" + c.getCountryID() + "'  ";
		PreparedStatement ps;
		try {
			ps = conn.prepareCall(query);
			ps.executeUpdate();
		} catch (SQLException ex) {
		}
		pool.returnConnectionToPool(conn);
	}

	public ArrayList<Movie> getListMoviesByCountry(String id) {
		conn = pool.getConnectionFromPool();
		ArrayList<Movie> list = new ArrayList<>();
		String sql = "select * from Movie m where m.countryID = '"+id+"'";
		try {
			PreparedStatement ps = conn.prepareCall(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Movie m = new Movie();
				m.setMovieID(rs.getLong("movieID"));
				m.setTitle(rs.getNString("movieTitle"));
				m.setRelaseYear(rs.getInt("movieReleaseYear"));
				m.setLink(rs.getString("movieTrailerLink"));
				m.setMovieLength(rs.getInt("movieLength"));
				m.setCountView(rs.getInt("movieView"));
				m.setMovieImage(rs.getString("movieImage"));
				m.setMovieDescription(rs.getNString("movieDescription"));
				m.setRating(rs.getNString("movieRating"));
				m.setRateStar(rs.getDouble("movieRateStar"));
				m.setCountry(getCountry(rs.getString("countryID")));
				list.add(m);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return list;
	}

	public ArrayList<Movie> getMovieFromeCountry(String id, int start, int numberOfMovie) {
		ArrayList<Movie> byID = getListMoviesByCountry(id);
		ArrayList<Movie> result = new ArrayList<Movie>();
		int size = start + numberOfMovie;
		if (size > byID.size()) {
			size = byID.size();
		}
		for (int i = start; i < size; i++) {
			result.add(byID.get(i));
		}
		return result;
	}

	public int countMovieByCountry(String id) {
		return getListMoviesByCountry(id).size();
	}

	public Country getCountry(String id) {
		ArrayList<Country> list = getListCountry();
		for (Country country : list) {
			if (country.getCountryID().equals(id)) {
				return country;
			}
		}
		return null;
	}

	public static void main(String[] args) {
		// CountryDAO cDAO = new CountryDAO();
		// ArrayList<Movie> listmv = cDAO.getMovieFromeCountry(1, 2, 4);
		// for (Movie movie : listmv) {
		// System.out.println(movie.getTitle());
		// }
//		URL url;
//
//		try {
//			// get URL content
//
//			String a = "http://api.getlinkdrive.com/getlink?url=https://drive.google.com/file/d/0B6VYU2mjTdy0WVRjb1BJUU1hYXM/view";
//			url = new URL(a);
//			URLConnection conn = url.openConnection();
//			conn.setRequestProperty("User-Agent",
//					"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.95 Safari/537.11");
//			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
//
//			String inputLine;
//			while ((inputLine = br.readLine()) != null) {
//				System.out.println(inputLine);
//			}
//			br.close();
//		} catch (MalformedURLException e) {
//			e.printStackTrace();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
		CountryDAO countryDAO = new CountryDAO();
		ArrayList<Country> list = countryDAO.getListCountry();
		for (Country country : list) {
			System.out.println("Insert into Country(countryID,countryName,countryNameVN) values('"+country.getCountryID()+"',N'"+country.getCountryName()+"',N'"+country.getCountryNameVN()+"')");
		}
	}

}
