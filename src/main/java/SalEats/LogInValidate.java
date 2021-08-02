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

/**
 * Servlet implementation class LogValidate
 */
@WebServlet("/LogInValidate")
public class LogInValidate extends HttpServlet {
	private static final long serialVersionUID = 1L;
        
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LogInValidate() { 
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
    		if(password != null && password.length() > 0) {
    			out.println("Valid Password");
    		} else {
    			out.println("Invalid Password");
    		}
    	}
    	
    	try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    	if (fieldToValidate != null && fieldToValidate.equals("login")) {
    		String userName = request.getParameter("userName");
    		String password = request.getParameter("password");
    		int userID = DatabaseFunctions.getIDFromUserName(userName);
    		String correctPassword = DatabaseFunctions.getPasswordFromID(userID);
    		if (userID == 0 || userID == -1) {
    			out.println("<font color=\"red\"><strong>The username you specified are not correct</strong></font><br />");
    		} else if (!password.trim().equals(correctPassword.trim())) {
				out.println("<font color=\"red\"><strong>The password you specified are not correct</strong></font><br />");
			}
    	}
	}

}

