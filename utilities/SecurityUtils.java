package utilities;

public class SecurityUtils {
	
	public static String hashMD5(String md5) {
		try {
			java.security.MessageDigest md = java.security.MessageDigest.getInstance("MD5");
			byte[] array = md.digest(md5.getBytes());
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < array.length; ++i) {
				sb.append(Integer.toHexString((array[i] & 0xFF) | 0x100).substring(1, 3));
			}
			return sb.toString();
		} catch (java.security.NoSuchAlgorithmException e) {
		}
		return null;
	}
	
	public static void main(String[] args) {
		String text ="adasdasdasdasdsadsdsssssdasdadasdasdas";
		System.out.println(hashMD5(text));
		System.out.println(hashMD5(text).length());
	}
	
}
