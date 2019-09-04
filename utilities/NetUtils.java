package utilities;

import java.io.IOException;

import org.apache.http.client.fluent.Request;

public class NetUtils {

	public static String getResult(String url) {
		try {
			return Request.Get(url).setHeader("Accept-Charset", "utf-8").execute().returnContent().asString();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static void main(String[] args) {
		System.out.println(NetUtils.getResult("http://kieutrongkhanh.net/index.php/servlet-jsp/105-login-application-using-facebook"));
	}
	
}
