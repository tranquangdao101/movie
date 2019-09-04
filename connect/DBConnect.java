package connect;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect {

	public static Connection getConnection() {
		Connection conn =null;
		//String url = "jdbc:sqlserver://nhom006-2017.database.windows.net:1433;database=Nhom006;user=nhom006@nhom006-2017;password=Qwerty123;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;";
		String url = "jdbc:sqlserver://localhost;databaseName=Nhom006;user=sa;password=sa";
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			conn = DriverManager.getConnection(url);

		} catch (Exception ex) {
			System.err.println(">> " + ex.getMessage());
		}
		return conn;
	}

}
