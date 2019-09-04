package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import connect.ConnectionPool;
import model.Category;
import model.Movie;

public class CategoryDAO implements DAO {

	Connection conn;
	ConnectionPool pool;

	public CategoryDAO() {
		conn = null;
		pool = ConnectionPool.getInstance();
	}

	@Override
	public void add(Object obj) {
		conn = pool.getConnectionFromPool();
		Category c = (Category) obj;
		String query = "Insert Into Category values (?)";
		try {
			PreparedStatement ps = conn.prepareCall(query);
			ps.setNString(1, c.getName());
			ps.executeUpdate();
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
	}

	@Override
	public void update(Object obj) {
		conn = pool.getConnectionFromPool();
		Category c = (Category) obj;
		String query = "Update Category set categoryName = ? where categoryID = '" + c.getId() + "'  ";
		PreparedStatement ps;
		try {
			ps = conn.prepareCall(query);
			ps.setNString(1, c.getName());
			ps.executeUpdate();
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
	}

	public ArrayList<Category> getListCategory() {
		conn = pool.getConnectionFromPool();
		ArrayList<Category> list = new ArrayList<>();
		String sql = "select * from Category";
		try {
			PreparedStatement ps = conn.prepareCall(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Category c = new Category();
				c.setId(rs.getLong("categoryID"));
				c.setName(rs.getNString("categoryName"));
				list.add(c);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return list;
	}

	public Category getCategoryByID(long id) {
		ArrayList<Category> list = getListCategory();
		for (Category category : list) {
			if (category.getId() == id) {
				return category;
			}
		}
		return null;
	}

	public boolean checkCategoryName(String name) {
		conn = pool.getConnectionFromPool();
		String query = "Select * from Category where categoryName = N'" + name + "'";
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
		Category c = (Category) obj;
		String query = "Delete from Category where categoryID = '" + c.getId() + "'  ";
		PreparedStatement ps;
		try {
			ps = conn.prepareCall(query);
			ps.executeUpdate();
		} catch (SQLException ex) {
		}
		pool.returnConnectionToPool(conn);
	}
	
	public ArrayList<Category> getListCategoryByMovie(long movieID) {
		conn = pool.getConnectionFromPool();
		ArrayList<Category> result = new ArrayList<>();
		String sql = "Select * from Movie_Category mc join Category c on mc.categoryID = c.categoryID where movieID = "+movieID+"";
		try {
			PreparedStatement ps = conn.prepareCall(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				Category c = new Category();
				c.setId(rs.getLong("categoryID"));
				c.setName(rs.getNString("categoryName"));
				result.add(c);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return result;
	}

	public ArrayList<Movie> getListMoviesByCategory(long id) {
		conn = pool.getConnectionFromPool();
		ArrayList<Movie> list = new ArrayList<>();
		String sql = "select * from Movie m join Movie_Category mc on m.movieID = mc.movieID  join Category c on c.categoryID = mc.categoryID where c.categoryID='"
				+ id + "'";
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

	public ArrayList<Movie> getMovieFromeCategory(long id, int start, int numberOfMovie) {
		ArrayList<Movie> byID = getListMoviesByCategory(id);
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

	public int countMovieByCategory(long id) {
		return getListMoviesByCategory(id).size();
	}

	public Category getCategory(long id) {
		ArrayList<Category> list = getListCategory();
		for (Category c : list) {
			if (c.getId() == id)
				return c;
		}
		return null;
	}

	public static void main(String[] args) {
		// CategoryDAO cDAO = new CategoryDAO();
		// ArrayList<Movie> listmv = cDAO.getMovieFromeCategory(1, 2, 4);
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
		CategoryDAO categoryDAO = new CategoryDAO();
		ArrayList<Category> list = categoryDAO.getListCategory();
		for (Category category : list) {
			System.out.println("Insert into Category(categoryName) values(N'"+category.getName()+"')");
		}
	}

}
