package connect;

public class Configuration {

 public String DB_USER_NAME ;

 public String DB_PASSWORD ;

 public String DB_URL;

 public String DB_DRIVER;

 public Integer DB_MAX_CONNECTIONS;

 public Configuration(){
  init();
 }

 private static Configuration configuration = new Configuration();

 public static Configuration getInstance(){ 
  return configuration;
 }

 private void init(){
  DB_USER_NAME = "root";
  DB_PASSWORD = "root";
  DB_URL = "jdbc:mysql://localhost:3306/jmanne";
  DB_DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
  DB_MAX_CONNECTIONS = 36;
 }     
}