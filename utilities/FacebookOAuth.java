package utilities;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import model.User;

public class FacebookOAuth {

	private static String appID = "1889957587913297";
	private static String appSecret = "7568b5e1b65b7e49f60b7515aa5c4b8f";
	private static String redirectURL = "http://2017-nhom006.azurewebsites.net/FacebookServlet";
//	private static String redirectURL = "http://localhost:8080/Movie/FacebookServlet";
	private String accessToken;
	private Gson gson;

	public FacebookOAuth() {
		gson = new Gson();
	}

	public String getAccessToken() {
		return accessToken;
	}

	public void setAccessToken(String accessToken) {
		this.accessToken = accessToken;
	}

	public static String getDialogLink() {
		String dialogLink = "https://www.facebook.com/dialog/oauth?client_id=%s&redirect_uri=%s&scope=email&display=popup";
		return String.format(dialogLink, appID, redirectURL);
	}

	public String getAccessToken(String code) {
		String accessTokenLink = "https://graph.facebook.com/oauth/access_token?" + "client_id=%s" + "&client_secret=%s"
				+ "&redirect_uri=%s" + "&code=%s";
		accessTokenLink = String.format(accessTokenLink, appID, appSecret, redirectURL, code);
		String result = NetUtils.getResult(accessTokenLink);
		JsonObject returnvalue = new Gson().fromJson(result, JsonObject.class);
		String token = returnvalue.get("access_token").getAsString();
		return token;
	}

	public User getUserInfo() {
		String infoUrl = "https://graph.facebook.com/me?fields=id,picture,first_name,last_name,link,gender,email&access_token=%s";
		infoUrl = String.format(infoUrl, this.accessToken);
		String result = NetUtils.getResult(infoUrl);
		//System.out.println(result);
		User user = gson.fromJson(result, User.class);
		//JsonParser jsonParser = new JsonParser();
		//String avatar = jsonParser.parse(result).getAsJsonObject().get("picture").getAsJsonObject().get("data").getAsJsonObject().get("link").getAsString();
		//user.setAvatar(avatar);
		user.setAvatar("https://graph.facebook.com/"+user.getFacebookID()+"/picture?type=normal");
		//System.out.println(user.getAvatar());
		return user;
	}

}