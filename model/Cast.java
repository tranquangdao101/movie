package model;

public class Cast {

	private long castID;
	private Crew crew;
	private Movie movie;
	private MovieRole movieRole;

	public Cast() {
	}

	public Cast(long castID, Crew crew, Movie movie, MovieRole movieRole) {
		this.castID = castID;
		this.crew = crew;
		this.movie = movie;
		this.movieRole = movieRole;
	}

	public long getCastID() {
		return castID;
	}

	public void setCastID(long castID) {
		this.castID = castID;
	}

	public Crew getCrew() {
		return crew;
	}

	public void setCrew(Crew crew) {
		this.crew = crew;
	}

	public Movie getMovie() {
		return movie;
	}

	public void setMovie(Movie movie) {
		this.movie = movie;
	}

	public MovieRole getMovieRole() {
		return movieRole;
	}

	public void setMovieRole(MovieRole movieRole) {
		this.movieRole = movieRole;
	}

}
