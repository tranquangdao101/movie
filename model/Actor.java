package model;

import java.util.Date;

public class Actor {

	private long actorID;
	private String actorFirstName;
	private String actorLastName;
	private String actorNationality;
	private Date actorBirthday;
	private String actorGender;
	private String actorInfo;

	public Actor() {
		super();
	}

	public Actor(long actorID, String actorFirstName, String actorLastName, String actorNationality,
			Date actorBirthday, String actorGender, String actorInfo) {
		super();
		this.actorID = actorID;
		this.actorFirstName = actorFirstName;
		this.actorLastName = actorLastName;
		this.actorNationality = actorNationality;
		this.actorBirthday = actorBirthday;
		this.actorGender = actorGender;
		this.actorInfo = actorInfo;
	}

	public long getActorID() {
		return actorID;
	}

	public void setActorID(long actorID) {
		this.actorID = actorID;
	}

	public String getActorFirstName() {
		return actorFirstName;
	}

	public void setActorFirstName(String actorFirstName) {
		this.actorFirstName = actorFirstName;
	}

	public String getActorLastName() {
		return actorLastName;
	}

	public void setActorLastName(String actorLastName) {
		this.actorLastName = actorLastName;
	}

	public String getActorNationality() {
		return actorNationality;
	}

	public void setActorNationality(String actorNationality) {
		this.actorNationality = actorNationality;
	}

	public Date getActorBirthday() {
		return actorBirthday;
	}

	public void setActorBirthday(Date actorBirthday) {
		this.actorBirthday = actorBirthday;
	}

	public String getActorGender() {
		return actorGender;
	}

	public void setActorGender(String actorGender) {
		this.actorGender = actorGender;
	}

	public String getActorInfo() {
		return actorInfo;
	}

	public void setActorInfo(String actorInfo) {
		this.actorInfo = actorInfo;
	}

}
