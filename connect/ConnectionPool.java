package connect;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class ConnectionPool {

	List<Connection> availableConnections = new ArrayList<Connection>();

	private ConnectionPool() {
		initializeConnectionPool();
	}

	private static ConnectionPool instance = new ConnectionPool();
	
	
	public static synchronized ConnectionPool getInstance() {
		return instance;
	}

	private void initializeConnectionPool() {
		while (!checkIfConnectionPoolIsFull()) {
			availableConnections.add(createNewConnectionForPool());
		}
	}

	private synchronized boolean checkIfConnectionPoolIsFull() {
		final int MAX_POOL_SIZE = Configuration.getInstance().DB_MAX_CONNECTIONS;

		if (availableConnections.size() < MAX_POOL_SIZE) {
			return false;
		}

		return true;
	}

	// Creating a connection
	private Connection createNewConnectionForPool() {
		Configuration config = Configuration.getInstance();
		try {
			Class.forName(config.DB_DRIVER);
//			Connection connection = (Connection) DriverManager.getConnection(config.DB_URL, config.DB_USER_NAME,
//					config.DB_PASSWORD);
			Connection connection = (Connection) DriverManager.getConnection("jdbc:sqlserver://nhom006-2017.database.windows.net:1433;database=Nhom006;user=nhom006@nhom006-2017;password=Qwerty123;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;");
//			Connection connection = (Connection) DriverManager.getConnection("jdbc:sqlserver://localhost;databaseName=Nhom006;user=sa;password=sa");
			return connection;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;

	}

	public synchronized Connection getConnectionFromPool() {
		Connection connection = null;
		if (availableConnections.size() > 0) {
			connection = (Connection) availableConnections.get(0);
			availableConnections.remove(0);
		}
		return connection;
	}

	public synchronized void returnConnectionToPool(Connection connection) {
		if(connection == null)
			return;
		availableConnections.add(connection);
	}

}
