package model;

public class CategoryChart {
	
	private String categoryName;
	private int numberOfMovieInCategory;
	
	
	
	public CategoryChart() {
		super();
	}
	public CategoryChart(String categoryName, int numberOfMovieInCategory) {
		super();
		this.categoryName = categoryName;
		this.numberOfMovieInCategory = numberOfMovieInCategory;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public int getNumberOfMovieInCategory() {
		return numberOfMovieInCategory;
	}
	public void setNumberOfMovieInCategory(int numberOfMovieInCategory) {
		this.numberOfMovieInCategory = numberOfMovieInCategory;
	}
	
	

}
