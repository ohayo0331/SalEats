package SalEats;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/SignUpValidate") 
public class SignUpValidate extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignUpValidate() { 
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String fieldToValidate = request.getParameter("field");
    	PrintWriter out = response.getWriter();
    	if (fieldToValidate != null && fieldToValidate.equals("userName")) {
    		String userName = request.getParameter("userName");
    		if (userName != null && userName.length() > 0) {
    				out.println("Valid Username");
    		} else {
    				out.println("Invalid Username");
    		}
    	}
    	
    	if (fieldToValidate != null && fieldToValidate.equals("password")) {
    		String password = request.getParameter("password");
    		String passwordConfirm = request.getParameter("passwordConfirm");
    		if (password != null && password.length() > 0) {
    			out.println("Valid Password");
    		} else {
    			out.println("Invalid Password    ");
    		}
    		if (password != null && !password.equals(passwordConfirm)) {
    			out.println("Please input the same password");
    		}
    	}
    	
    	try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    	if (fieldToValidate != null && fieldToValidate.equals("signup")) {
    		String userName = request.getParameter("userName");
    		String password = request.getParameter("password");
    		String email = request.getParameter("email");
    		String checkBox = request.getParameter("checked");
    		int userID = DatabaseFunctions.getIDFromUserName(userName);
    		String correctPassword = DatabaseFunctions.getPasswordFromID(userID);
    		if (userID != 0) {
    			out.println("<font color=\"red\"><strong>Username cannot be used. Please choose another username.</strong></font><br />");
    		} else {
    			DatabaseFunctions.insertUser(userName, password, email);
    		}
    	}
	}

}
