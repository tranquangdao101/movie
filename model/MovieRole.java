package model;

public class MovieRole {

	private long movieRoleID;
	private String movieRoleName;

	public MovieRole() {
	}

	public MovieRole(long movieRoleID, String movieRoleName) {
		this.movieRoleID = movieRoleID;
		this.movieRoleName = movieRoleName;
	}

	public long getMovieRoleID() {
		return movieRoleID;
	}

	public void setMovieRoleID(long movieRoleID) {
		this.movieRoleID = movieRoleID;
	}

	public String getMovieRoleName() {
		return movieRoleName;
	}

	public void setMovieRoleName(String movieRoleName) {
		this.movieRoleName = movieRoleName;
	}
}
