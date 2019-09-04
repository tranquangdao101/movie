package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import connect.ConnectionPool;
import model.Crew;

public class CrewDAO implements DAO {

	Connection conn;
	ConnectionPool pool;
	
	public CrewDAO() {
		conn = null;
		pool = ConnectionPool.getInstance();
	}
	
	@Override
	public void add(Object obj) {
		conn = pool.getConnectionFromPool();
		Crew crew = (Crew) obj;
		String query = "Insert into Crew(crewFirstName,crewLastName,crewNationality,crewBirthday,crewGender,crewInfo,crewPicture) values(?,?,?,?,?,?,?)";
		try {
			PreparedStatement ps = conn.prepareCall(query);
			ps.setNString(1, crew.getCrewFirstName());
			ps.setNString(2, crew.getCrewLastName());
			ps.setNString(3, crew.getCrewNationality());
			ps.setDate(4, new java.sql.Date(crew.getCrewBirthday().getTime()));
			ps.setNString(5, crew.getCrewGender());
			ps.setNString(6, crew.getCrewInfo());
			ps.setString(7, crew.getCrewPicture());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
	}

	@Override
	public void update(Object obj) {
		conn = pool.getConnectionFromPool();
		Crew crew = (Crew) obj;
		String query = "Update Crew set crewFirstName = ? , crewLastName = ? , crewNationality = ? , crewBirthday = ? , crewGender = ? , crewInfo = ? , crewPicture = ? where crewID ='"+crew.getCrewID()+"'";
		try {
			PreparedStatement ps = conn.prepareCall(query);
			ps.setNString(1, crew.getCrewFirstName());
			ps.setNString(2, crew.getCrewLastName());
			ps.setNString(3, crew.getCrewNationality());
			ps.setDate(4, new java.sql.Date(crew.getCrewBirthday().getTime()));
			ps.setNString(5, crew.getCrewGender());
			ps.setNString(6, crew.getCrewInfo());
			ps.setString(7, crew.getCrewPicture());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
	}

	@Override
	public void delete(Object obj) {
		conn = pool.getConnectionFromPool();
		Crew crew = (Crew) obj;
		String query = "Delete Crew where crewID ='"+crew.getCrewID()+"'";
		try {
			PreparedStatement ps = conn.prepareCall(query);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
	}
	
	public Crew getCrew(long id) {
		for (Crew crew : getListCrew()) {
			if(crew.getCrewID()==id) 
				return crew;
		}
		return null;
	}
	
	public ArrayList<Crew> getListCrew() {
		conn = pool.getConnectionFromPool();
		ArrayList<Crew> result = new ArrayList<>();
		String query = "Select * from Crew";
		try {
			PreparedStatement ps = conn.prepareCall(query);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				Crew crew = new Crew();
				crew.setCrewID(rs.getLong("crewID"));
				crew.setCrewFirstName(rs.getNString("crewFirstName"));
				crew.setCrewLastName(rs.getNString("crewLastName"));
				crew.setCrewNationality(rs.getNString("crewNationality"));
				crew.setCrewBirthday(rs.getDate("crewBirthday"));
				crew.setCrewGender(rs.getNString("crewGender"));
				crew.setCrewInfo(rs.getNString("crewInfo"));
				crew.setCrewPicture(rs.getString("crewPicture"));
				result.add(crew);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		pool.returnConnectionToPool(conn);
		return result;
	}
	
	public static void main(String[] args) {
		CrewDAO crewDAO = new CrewDAO();
		ArrayList<Crew> list = crewDAO.getListCrew();
		for (Crew crew : list) {
			String info = crew.getCrewInfo();
			if(info.length()>100) {
				info = info.substring(0,100);
			}
			System.out.println("insert into Crew(crewFirstName,crewLastName,crewNationality,crewBirthday,crewGender,crewInfo) values (N'"+crew.getCrewFirstName()+"',N'"+crew.getCrewLastName()+"',N'"+crew.getCrewNationality()+"','"+crew.getCrewBirthday()+"',N'"+info+"','"+crew.getCrewPicture()+"')");
		}
	}
	
}
