package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import connect.ConnectionPool;
import model.Category;
import model.Country;
import model.Movie;

public class MovieDAO implements DAO {

	Connection conn;
	ConnectionPool pool;

	public MovieDAO() {
		conn = null;
		pool = ConnectionPool.getInstance();
	}

	public ArrayList<Movie> getListMovies() {
		conn = pool.getConnectionFromPool();
		ArrayList<Movie> list = new ArrayList<>();
		String sql = "select * from Movie m join Movie_Category mc on m.movieID = mc.movieID  join Category c on c.categoryID = mc.categoryID join Country country on country.countryID = m.countryID";
		try {
			PreparedStatement ps = conn.prepareCall(sql);
			ResultSet rs = ps.executeQuery();
			outer: while (rs.next()) {
				for (Movie movie : list) {
					if (movie.getMovieID() == rs.getLong("movieID")) {
						movie.getCategory().add(new Category(rs.getLong("categoryID"), rs.getNString("categoryName")));
						continue outer;
					}
				}
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
				m.setCountry(new Country(rs.getString("countryID"), rs.getNString("countryName"), rs.getNString("countryNameVN")));
				m.setMovieEnterDate(new Date(rs.getTimestamp("movieEnterDate").getTime()));
				m.getCategory().add(new Category(rs.getLong("categoryID"), rs.getNString("categoryName")));
				list.add(m);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return list;
	}

	public ArrayList<Movie> getListMoviesBy(char c) {
		conn = pool.getConnectionFromPool();
		ArrayList<Movie> list = new ArrayList<>();
		String sql = "select * from Movie where movieTitle like '" + c + "" + "%'";
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
				CategoryDAO cDao = new CategoryDAO();
				m.setCategory(cDao.getListCategoryByMovie(m.getMovieID()));
				CountryDAO countryDAO = new CountryDAO();
				m.setCountry(countryDAO.getCountryByMovie(m.getMovieID()));
				list.add(m);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return list;
	}

	public ArrayList<Movie> getMovieByStr(String str) {
		conn = pool.getConnectionFromPool();
		ArrayList<Movie> list = new ArrayList<>();
		String sql = "select * from Movie where movieTitle like N'" + str + "%'";
		if (str.trim().isEmpty())
			return list;
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
				list.add(m);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return list;
	}

	public ArrayList<Movie> getTenLatest() {
		conn = pool.getConnectionFromPool();
		ArrayList<Movie> list = new ArrayList<>();
		String sql = "select top 10 * from Movie order by movieEnterDate DESC ";
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
				list.add(m);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return list;
	}

	public ArrayList<Movie> getTenMostViewed() {
		conn = pool.getConnectionFromPool();
		ArrayList<Movie> list = new ArrayList<>();
		String sql = "select top 10 * from Movie order by movieView DESC";
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
				list.add(m);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return list;
	}
	
	public ArrayList<Movie> getMostViewedMovie(int n) {
		conn = pool.getConnectionFromPool();
		ArrayList<Movie> list = new ArrayList<>();
		String sql = "select top "+n+" * from Movie order by movieView DESC";
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
				list.add(m);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return list;
	}
	
	public ArrayList<Movie> getMostViewedMovie(int n,Date start,Date end) {
		conn = pool.getConnectionFromPool();
		ArrayList<Movie> list = new ArrayList<>();
		SimpleDateFormat dateFormatter = new SimpleDateFormat("MM-dd-yyyy");
		String dateStart = dateFormatter.format(start);
		String dateEnd = dateFormatter.format(end);
		String sql = "select top "+n+" * from Movie  where movieEnterDate between '"+dateStart+"' and '"+dateEnd+"' order by movieView DESC ";
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
				list.add(m);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return list;
	}


	public void increaseCountView(long id) {
		conn = pool.getConnectionFromPool();
		Movie m = getMovie(id);
		int count = m.getCountView();
		count++;
		String sql = "Update Movie set movieView =" + count + " where movieID=" + id + " ";
		try {
			PreparedStatement ps = conn.prepareCall(sql);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
	}

	public Movie getMovie(long id) {
		ArrayList<Movie> list = getListMovies();
		for (Movie movie : list) {
			if (movie.getMovieID() == id)
				return movie;
		}
		return null;
	}

	public long getLatestMovieID() {
		conn = pool.getConnectionFromPool();
		long result = -1;
		String query = "select top 1 movieID from Movie order by movieID DESC";
		try {
			PreparedStatement ps = conn.prepareCall(query);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				result = rs.getLong("movieID");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return result;
	}

	@Override
	public synchronized void add(Object obj) {
		conn = pool.getConnectionFromPool();
		Movie movie = (Movie) obj;
		String title = movie.getTitle();
		int releaseYear = movie.getRelaseYear();
		String movieLink = movie.getLink();
		int movieLength = movie.getMovieLength();
		int view = movie.getCountView();
		String image = movie.getMovieImage();
		String movieDescription = movie.getMovieDescription();
		String sql = "Insert into Movie values (?,?,?,?,?,?,?,?,?,?,?)";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, title);
			ps.setInt(2, releaseYear);
			ps.setString(3, movieLink);
			ps.setInt(4, movieLength);
			ps.setInt(5, view);
			ps.setString(6, image);
			ps.setNString(7, movieDescription);
			ps.setString(8, "R");
			ps.setInt(9, 0);
			ps.setTimestamp(10, getCurrentTimeStamp());
			ps.setString(11,movie.getCountry().getCountryID());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return;
		}
		long id = getLatestMovieID();
		for (Category iter : movie.getCategory()) {
			String query = "Insert into Movie_Category values(?,?)";
			try {
				PreparedStatement ps = conn.prepareCall(query);
				ps.setLong(1, id);
				ps.setLong(2, iter.getId());
				ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		pool.returnConnectionToPool(conn);
	}

	private static java.sql.Timestamp getCurrentTimeStamp() {

		java.util.Date today = new java.util.Date();
		return new java.sql.Timestamp(today.getTime());

	}

	@Override
	public void update(Object obj) {
		conn = pool.getConnectionFromPool();
		Movie m = (Movie) obj;
		String sql = "Update Movie set movieTitle = ? , movieReleaseYear = ? , movieTrailerLink = ? , movieLength = ? , movieView = ? , movieImage = ? , movieDescription = ? , countryID = ?  where movieID='"
				+ m.getMovieID() + "'";
		try {
			PreparedStatement ps = conn.prepareCall(sql);
			ps.setString(1, m.getTitle());
			ps.setInt(2, m.getRelaseYear());
			ps.setString(3, m.getLink());
			ps.setInt(4, m.getMovieLength());
			ps.setLong(5, m.getCountView());
			ps.setString(6, m.getMovieImage());
			ps.setNString(7, m.getMovieDescription());
			ps.setString(8, m.getCountry().getCountryID());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		String query1 = "Delete Movie_Category where movieID='" + m.getMovieID() + "'";
		try {
			PreparedStatement ps = conn.prepareCall(query1);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		for (Category iter : m.getCategory()) {
			String query = "Insert into Movie_Category values(?,?)";
			try {
				PreparedStatement ps = conn.prepareCall(query);
				ps.setLong(1, m.getMovieID());
				ps.setLong(2, iter.getId());
				ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		pool.returnConnectionToPool(conn);
	}

	@Override
	public void delete(Object obj) {
		conn = pool.getConnectionFromPool();
		Movie m = (Movie) obj;
		long id = m.getMovieID();
		String query1 = "Delete Movie_Category where movieID='" + id + "'";
		try {
			PreparedStatement ps = conn.prepareCall(query1);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		String query2 = "Delete Movie where movieID='" + id + "'";
		try {
			PreparedStatement ps = conn.prepareCall(query2);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
	}

	public static void main(String[] args) {
		MovieDAO mDAO = new MovieDAO();
		ArrayList<Movie> list = mDAO.getListMovies();
		//SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for (Movie movie : list) {
			//System.out.println("Insert into Movie(movieTitle,movieReleaseYear,movieTrailerLink,movieLength,movieView,movieImage,movieDescription,movieRating,movieRateStar,movieEnterDate,countryID) values (N'"+movie.getTitle()+"',"+movie.getRelaseYear()+",'"+movie.getLink()+"',"+movie.getMovieLength()+","+movie.getCountView()+",'"+movie.getMovieImage()+"',N'"+movie.getMovieDescription()+"','"+movie.getRating()+"',"+movie.getRateStar()+",'"+fmt.format(movie.getMovieEnterDate())+"','"+movie.getCountry().getCountryID()+"')");
			ArrayList<Category> cateList = movie.getCategory();
			for (Category category : cateList) {
				System.out.println("Insert into Movie_Category(movieID,categoryID) values("+movie.getMovieID()+","+category.getId()+")");
			}
		
		}
	}

}
