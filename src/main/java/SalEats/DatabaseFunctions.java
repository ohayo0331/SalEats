package SalEats;

import java.sql.Connection;


import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Scanner;


/*
This file has several functions related to the database, including: inserting data, retrieving data, and verifying data
 */
public class DatabaseFunctions {
	
	private static String url = "jdbc:mysql://aws-mystocks.cdrxcxtcizmo.us-east-2.rds.amazonaws.com:3306/SalEatsDB?user=admin&password=19990331&useSSL=false";
	
	public static void main (String[] args) {
	
	}
	
	/* 
	This method inserts a user into the database. 
	*/
	public static void insertUser(String userName, String password, String email) {
		try {
			Connection conn = DriverManager.getConnection(url); 
			String query = "INSERT INTO Users(userName, password, email) VALUES" + 
					"(\""+userName+"\",\""+password+"\",\""+email+"\");";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.execute();
			conn.close();
		} catch (SQLException sqle) {
			System.out.println("sqle:" + sqle.getMessage());
		}
	}
	
	/* 
	This method checks if the user exists by comparing the email 
	*/
	public static boolean ifUserExists(String email) {
		boolean result = false;
		try {
			Connection conn = DriverManager.getConnection(url);
			String query = "SELECT * FROM Users WHERE email = \""+email+"\";";
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(query);
			result = rs.next();
			conn.close();
		} catch (SQLException sqle) {
			System.out.println("sqle:" + sqle.getMessage());
		}
		return result;
	}
	
	/* 
	This method inserts a favorite restaurant to the user into the database. 
	*/
	public static void insertFav(String resID, int userID, String userName) {
		try {
			Connection conn = DriverManager.getConnection(url);
			ArrayList<String> favs = getFavFromID(userID);
			for (String tempID : favs) {
				if (tempID.equals(resID)) {
					return;
				}
			}
			String query = "INSERT INTO Favorites(resID, userID, userName) VALUES" + 
					"(\""+resID+"\",\""+userID+"\",\""+userName+"\");";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.execute();
			conn.close();
		} catch (SQLException sqle) {
			System.out.println("sqle:" + sqle.getMessage());
		}
	}
	
	public static ArrayList<String> getFavFromID(int userID) {
		ArrayList<String> favs = new ArrayList<String>();
		try {
			Connection conn = DriverManager.getConnection(url);
			String query = "SELECT resID FROM Favorites WHERE userID = \""+userID+"\";";
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(query);
			String tempID = null;
			while(rs.next()) {
				tempID =  rs.getString("resID"); //so that I can close and then return
				favs.add(tempID);
			}
			conn.close();
		} catch (SQLException sqle) {
			System.out.println("sqle:" + sqle.getMessage());
		}
		return favs;
	}
	
	
	/*
	 * Takes id as argument, and returns username. Returns null if the ID does not exist
	 *
	 */
	public static String getNameFromID(int id) {
		try {
			Connection conn = DriverManager.getConnection(url);
			String query = "SELECT userName FROM Users WHERE userID = \""+id+"\";";
			Statement st = conn.createStatement(); 
			ResultSet rs = st.executeQuery(query);
			String returnString = null;
			while(rs.next()) {
				returnString =  rs.getString("userName"); //so that I can close and then return
			}
			conn.close();
			return returnString;
		} catch (SQLException sqle) {
			System.out.println("sqle:" + sqle.getMessage());
		} 
		return ""; 
	}
	
	/*
	 * Input a username, gives back the id (the primary key of the database). returns 0 if username doesn't exist
	 */
	public static int getIDFromUserName(String userName) {
		try {
			Connection conn = DriverManager.getConnection(url);	
			String query = "SELECT userID FROM Users WHERE userName = \""+userName+"\";";
			Statement st = conn.createStatement(); 
			ResultSet rs = st.executeQuery(query);
			int returnID = 0;
			while(rs.next()) {
				returnID =  rs.getInt("userID"); //so that I can close and then return
			} //there is only a single primary key so this while loop iterates once. 
			conn.close();
			return returnID;
		} catch (SQLException sqle) {
			System.out.println("sqle:" + sqle.getMessage());
		} 
		//this is not reached if the program can access the database. it is only here to avoid the error from eclipse.
		return -1;
	}
	
	/*
	 * Enter id, get password. Returns null if id does not exist
	 */
	public static String getPasswordFromID(int id) {
		try {
			Connection conn = DriverManager.getConnection(url);
			String query = "SELECT password FROM Users WHERE userID = \""+id+"\";";
			Statement st = conn.createStatement(); 
			ResultSet rs = st.executeQuery(query);
			String returnString = null;
			while(rs.next()) {
				returnString =  rs.getString("password"); //so that I can close and then return
			}
			conn.close();
			return returnString;
		} catch (SQLException sqle) {
			System.out.println("sqle:" + sqle.getMessage());
		} 
		return "";  
	}
		
	//This is a function for editing the username.
	public static void updateUserName(int userID, String newUserName) {
		try {
			Connection conn = DriverManager.getConnection(url);
			String query = "UPDATE users SET userName = \""+newUserName+"\" WHERE userID = \""+userID+"\";" ;
			PreparedStatement ps = conn.prepareStatement(query);
			ps.execute();
			conn.close();
		} catch (SQLException sqle) {
			System.out.println("sqle:" + sqle.getMessage());
		}
	}

}
