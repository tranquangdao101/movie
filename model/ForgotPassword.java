package model;

import java.util.Date;

public class ForgotPassword {

	private long forgetID;
	private User user;
	private Date datetime;

	public ForgotPassword() {
		super();
	}

	public ForgotPassword(long forgetID, User user, Date datetime) {
		super();
		this.forgetID = forgetID;
		this.user = user;
		this.datetime = datetime;
	}

	public long getForgetID() {
		return forgetID;
	}

	public void setForgetID(long forgetID) {
		this.forgetID = forgetID;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Date getDatetime() {
		return datetime;
	}

	public void setDatetime(Date datetime) {
		this.datetime = datetime;
	}

}
