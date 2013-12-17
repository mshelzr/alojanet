package pe.libertadores.alojamiento.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionDM {
	static{
		try {
			Class.forName("com.mysql.jdbc.Driver");
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public static Connection getConexion(){
		Connection con=null;
		String db="jdbc:mysql://ec2-50-19-213-178.compute-1.amazonaws.com:3306/alojamientodb?user=scotti&password=pwd2ciber1";
		
		try {
			con=DriverManager.getConnection(db);
		}catch (SQLException e) {
			e.printStackTrace();
		}
		
		return con;
	}
	
}
