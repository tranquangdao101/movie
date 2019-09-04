package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import connect.ConnectionPool;
import model.CategoryChart;

public class CategoryChartDAO {

	Connection conn;
	ConnectionPool pool;

	public CategoryChartDAO() {
		conn = null;
		pool = ConnectionPool.getInstance();
	}

	public ArrayList<CategoryChart> getListAll() {
		conn = pool.getConnectionFromPool();
		String query = "select mc.categoryID,c.categoryName,count(movieID) as movies from Movie_Category mc join Category c on mc.categoryID=c.categoryID group by mc.categoryID,c.categoryName";
		ArrayList<CategoryChart> list = new ArrayList<>();
		PreparedStatement ps;
		try {
			ps = conn.prepareCall(query);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				CategoryChart c  = new CategoryChart();
				c.setCategoryName(rs.getNString("categoryName"));
				c.setNumberOfMovieInCategory(rs.getInt("movies"));
				list.add(c);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return list;
	}
	
	public ArrayList<CategoryChart> getListAll(Date start,Date end) {
		conn = pool.getConnectionFromPool();
		SimpleDateFormat dateFormatter = new SimpleDateFormat("MM-dd-yyyy");
		String dateStart = dateFormatter.format(start);
		String dateEnd = dateFormatter.format(end);
		String query = "select mc.categoryID,c.categoryName,count(mc.movieID) as movies from Movie_Category mc join Category c on mc.categoryID=c.categoryID join Movie m on m.movieID = mc.movieID where movieEnterDate between '"+dateStart+"' and '"+dateEnd+"' group by mc.categoryID,c.categoryName";
		ArrayList<CategoryChart> list = new ArrayList<>();
		PreparedStatement ps;
		try {
			ps = conn.prepareCall(query);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				CategoryChart c  = new CategoryChart();
				c.setCategoryName(rs.getNString("categoryName"));
				c.setNumberOfMovieInCategory(rs.getInt("movies"));
				list.add(c);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return list;
	}
	
	public int sumAll(ArrayList<CategoryChart> list) {
		int sum = 0;
		for (CategoryChart categoryChart : list) {
			sum+=categoryChart.getNumberOfMovieInCategory();
		}
		return sum;
	}
	
	public static void main(String[] args) {
		SimpleDateFormat sdf = new SimpleDateFormat("MM-dd-yyyy");
		CategoryChartDAO ccDAO = new CategoryChartDAO();
		try {
			for (CategoryChart c : ccDAO.getListAll(sdf.parse("04-8-2017"), sdf.parse("09-15-2017"))) {
				System.out.println(c.getCategoryName());
				System.out.println(c.getNumberOfMovieInCategory());
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
