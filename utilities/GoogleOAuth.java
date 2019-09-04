package utilities;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import model.User;

public class GoogleOAuth {

	private static String clientID = "1054667902974-su7bchrop227itbka30b9k6k6n3ffjom.apps.googleusercontent.com";
	private static String clientSecret = "TS3YeJTyjulI0nLIrAMeV0Fq";
//	private static String redirectURL = "http://localhost:8080/Movie/GoogleOAuthServlet";
	private static String redirectURL = "http://2017-nhom006.azurewebsites.net/GoogleOAuthServlet";
	
	private Gson gson;
	private String accessToken;

	public GoogleOAuth() {
		gson = new Gson();
	}

	public String getAccessToken() {
		return accessToken;
	}

	public void setAccessToken(String accessToken) {
		this.accessToken = accessToken;
	}

	public static String getDialogLink() {
		String dialogLink = "https://accounts.google.com/o/oauth2/auth?scope=openid+profile+email&redirect_uri=%s&response_type=code&client_id=%s&approval_prompt=force";
		return String.format(dialogLink, redirectURL, clientID);
	}

	public String getAccessToken(String code) {
//		String accessTokenLink = "https://accounts.google.com/o/oauth2/token?" + "&client_id=%s" + "&client_secret=%s"
//				+ "&redirect_uri=%s" + "&code=%s" + "&grant_type=authorization_code";
		URL url;
		try {
			url = new URL("https://accounts.google.com/o/oauth2/token");
			String urlParameters = "client_id=%s" + "&client_secret=%s" + "&redirect_uri=%s" + "&code=%s"
					+ "&grant_type=authorization_code";
			urlParameters = String.format(urlParameters, clientID, clientSecret, redirectURL, code);
			URLConnection urlConn = url.openConnection();
			urlConn.setDoOutput(true);
			OutputStreamWriter writer = new OutputStreamWriter(urlConn.getOutputStream());
			writer.write(urlParameters);
			writer.flush();
			BufferedReader contactReader = new BufferedReader(new InputStreamReader(urlConn.getInputStream()));
			String contactLine;
			String json = "";
			while ((contactLine = contactReader.readLine()) != null) {
				json += contactLine;
			}
			Gson gson = new Gson();
			JsonElement element = gson.fromJson(json, JsonElement.class);
			JsonObject jsonObj = element.getAsJsonObject();
			String token = jsonObj.get("access_token").getAsString();
			return token;
		} catch (Exception e) {
			e.printStackTrace();
		}
		// accessTokenLink = String.format(accessTokenLink, clientID,
		// clientSecret, redirectURL, code);
		// String result = NetUtils.getResult(accessTokenLink);
		// JsonObject returnvalue = new Gson().fromJson(result,
		// JsonObject.class);

//		String token = returnvalue.get("access_token").getAsString();
		return null;
	}

	public User getUserInfo() {
		String infoUrl = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=%s";
		infoUrl = String.format(infoUrl, this.accessToken);
		String result = NetUtils.getResult(infoUrl);
		// System.out.println(result);
		System.out.println(result);
		JsonElement element = gson.fromJson(result, JsonElement.class);
		JsonObject jsonObj = element.getAsJsonObject();
		String email = jsonObj.get("email").getAsString();
		String id = jsonObj.get("id").getAsString();
		String firstName = jsonObj.get("given_name").getAsString();
		String lastName = jsonObj.get("family_name").getAsString();
		String link = jsonObj.get("link").getAsString();
		String avatar = jsonObj.get("picture").getAsString();
		String gender = "Male";
		User user = new User();
		user.setGoogleID(id);
		user.setEmail(email);
		user.setFirstName(firstName);
		user.setLastName(lastName);
		user.setGoogleLink(link);
		user.setAvatar(avatar);
		user.setGender(gender);
		// JsonParser jsonParser = new JsonParser();
		// String avatar =
		// jsonParser.parse(result).getAsJsonObject().get("picture").getAsJsonObject().get("data").getAsJsonObject().get("link").getAsString();
		// user.setAvatar(avatar);
		// System.out.println(user.getAvatar());
		return user;
	}

}
