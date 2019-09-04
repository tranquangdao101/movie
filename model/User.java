package model;

import com.google.gson.annotations.SerializedName;

public class User {
	@SerializedName(value = "userID")
	private long userID;
	@SerializedName(value = "username")
	private String userName;
	@SerializedName(value = "first_name")
	private String firstName;
	@SerializedName(value = "last_name")
	private String lastName;
	private String password;
	private String phone;
	@SerializedName(value = "email")
	private String email;
	private boolean isValid;
	private String avatar;
	@SerializedName(value = "gender")
	private String gender;
	@SerializedName(value = "id")
	private String facebookID;
	@SerializedName(value = "link")
	private String facebookLink;
	private String googleID;
	private String googleLink;

	public String getGoogleID() {
		return googleID;
	}

	public void setGoogleID(String googleID) {
		this.googleID = googleID;
	}

	public String getGoogleLink() {
		return googleLink;
	}

	public void setGoogleLink(String googleLink) {
		this.googleLink = googleLink;
	}

	public String getFacebookID() {
		return facebookID;
	}

	public void setFacebookID(String facebookID) {
		this.facebookID = facebookID;
	}

	public String getFacebookLink() {
		return facebookLink;
	}

	public void setFacebookLink(String facebookLink) {
		this.facebookLink = facebookLink;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public User() {
		isValid = false;
		avatar = "unknown.png";
	}

	public User(String userName, String password) {
		this.userName = userName;
		this.password = password;
		avatar = "unknown.png";
	}

	public long getUserID() {
		return userID;
	}

	public void setUserID(long userID) {
		this.userID = userID;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public boolean isValid() {
		return isValid;
	}

	public void setValid(boolean isValid) {
		this.isValid = isValid;
	}

	public String getFullName() {
		return lastName + " " + firstName;
	}

}
