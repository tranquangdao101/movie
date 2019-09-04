package model;

import java.util.Date;

public class Crew {

	private long crewID;
	private String crewFirstName;
	private String crewLastName;
	private String crewNationality;
	private Date crewBirthday;
	private String crewGender;
	private String crewInfo;
	private String crewPicture;

	public Crew() {
		super();
		crewPicture = "unknown.jpg";
	}

	public Crew(long crewID, String crewFirstName, String crewLastName, String crewNationality, Date crewBirthday,
			String crewGender, String crewInfo, String crewPicture) {
		super();
		this.crewID = crewID;
		this.crewFirstName = crewFirstName;
		this.crewLastName = crewLastName;
		this.crewNationality = crewNationality;
		this.crewBirthday = crewBirthday;
		this.crewGender = crewGender;
		this.crewInfo = crewInfo;
		this.crewPicture = crewPicture;
	}

	public long getCrewID() {
		return crewID;
	}

	public void setCrewID(long crewID) {
		this.crewID = crewID;
	}

	public String getCrewFirstName() {
		return crewFirstName;
	}

	public void setCrewFirstName(String crewFirstName) {
		this.crewFirstName = crewFirstName;
	}

	public String getCrewLastName() {
		return crewLastName;
	}

	public void setCrewLastName(String crewLastName) {
		this.crewLastName = crewLastName;
	}

	public String getCrewNationality() {
		return crewNationality;
	}

	public void setCrewNationality(String crewNationality) {
		this.crewNationality = crewNationality;
	}

	public Date getCrewBirthday() {
		return crewBirthday;
	}

	public void setCrewBirthday(Date crewBirthday) {
		this.crewBirthday = crewBirthday;
	}

	public String getCrewGender() {
		return crewGender;
	}

	public void setCrewGender(String crewGender) {
		this.crewGender = crewGender;
	}

	public String getCrewInfo() {
		return crewInfo;
	}

	public void setCrewInfo(String crewInfo) {
		this.crewInfo = crewInfo;
	}

	public String getCrewPicture() {
		return crewPicture;
	}

	public void setCrewPicture(String crewPicture) {
		this.crewPicture = crewPicture;
	}

}
