package utilities;



import com.google.gson.Gson;
import com.google.gson.JsonObject;

public class CaptchaUltis {

	public static final String SITE_KEY = "6LfdYSQUAAAAAPNWKIlQZ-jIL-og752DvTsKzh53";

	public static final String SECRET_KEY = "6LfdYSQUAAAAAC474-HQVgpeIOqeWTGvTEwljfOH";

	public static final String SITE_VERIFY_URL = "https://www.google.com/recaptcha/api/siteverify";

	public static boolean verify(String gRecaptchaResponse) {
		if (gRecaptchaResponse == null || gRecaptchaResponse.length() == 0) {
			return false;
		}

		// Dữ liệu sẽ gửi tới server.
		String postParams = "secret=" + SECRET_KEY + "&response=" + gRecaptchaResponse;

		Gson gson = new Gson();

		String json = NetUtils.getResult(SITE_VERIFY_URL + "?" + postParams);

		JsonObject jsonObject = gson.fromJson(json, JsonObject.class);


		boolean success = jsonObject.get("success").getAsBoolean();
		return success;
	}

}
