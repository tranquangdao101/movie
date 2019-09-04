package model;

public class Country {

	private String countryID;
	private String countryName;
	private String countryNameVN;

	public Country() {
		countryNameVN= null;
	}

	public Country(String countryID, String countryName, String countryNameVN) {
		super();
		this.countryID = countryID;
		this.countryName = countryName;
		this.countryNameVN = countryNameVN;
	}

	public String getCountryNameVN() {
		return countryNameVN;
	}

	public void setCountryNameVN(String countryNameVN) {
		this.countryNameVN = countryNameVN;
	}

	public String getCountryID() {
		return countryID;
	}

	public void setCountryID(String countryID) {
		this.countryID = countryID;
	}

	public String getCountryName() {
		return countryName;
	}

	public void setCountryName(String countryName) {
		this.countryName = countryName;
	}

}
