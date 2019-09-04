package model;

import java.util.ArrayList;
import java.util.Date;

public class Movie {
	private long movieID;
	private String title;
	private int relaseYear;
	private String link;
	private int movieLength;
	private int countView;
	private String movieImage;
	private String movieDescription;
	private String rating;
	private double rateStar;
	private Date movieEnterDate;
	private ArrayList<Category> category = null;
	private Country country;

	public Movie() {
		category = new ArrayList<>();
	}

	public Movie(long movieID, String title, int relaseYear, String link, int movieLength, int countView,
			String movieImage, String movieDescription, String rating, double rateStar, Date movieEnterDate,
			Country country) {
		super();
		this.movieID = movieID;
		this.title = title;
		this.relaseYear = relaseYear;
		this.link = link;
		this.movieLength = movieLength;
		this.countView = countView;
		this.movieImage = movieImage;
		this.movieDescription = movieDescription;
		this.rating = rating;
		this.rateStar = rateStar;
		this.movieEnterDate = movieEnterDate;
		category = new ArrayList<>();
		this.country = country;
	}
	

	public Country getCountry() {
		return country;
	}

	public void setCountry(Country country) {
		this.country = country;
	}

	public Date getMovieEnterDate() {
		return movieEnterDate;
	}

	public void setMovieEnterDate(Date movieEnterDate) {
		this.movieEnterDate = movieEnterDate;
	}

	public ArrayList<Category> getCategory() {
		return category;
	}

	public void setCategory(ArrayList<Category> category) {
		this.category = category;
	}

	public long getMovieID() {
		return movieID;
	}

	public void setMovieID(long movieID) {
		this.movieID = movieID;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getRelaseYear() {
		return relaseYear;
	}

	public void setRelaseYear(int relaseYear) {
		this.relaseYear = relaseYear;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public int getMovieLength() {
		return movieLength;
	}

	public void setMovieLength(int movieLength) {
		this.movieLength = movieLength;
	}

	public int getCountView() {
		return countView;
	}

	public void setCountView(int countView) {
		this.countView = countView;
	}

	public String getMovieImage() {
		return movieImage;
	}

	public void setMovieImage(String movieImage) {
		this.movieImage = movieImage;
	}

	public String getMovieDescription() {
		return movieDescription;
	}

	public void setMovieDescription(String movieDescription) {
		this.movieDescription = movieDescription;
	}

	public String getRating() {
		return rating;
	}

	public void setRating(String rating) {
		this.rating = rating;
	}

	public double getRateStar() {
		return rateStar;
	}

	public void setRateStar(double rateStar) {
		this.rateStar = rateStar;
	}

}
