package SalEats;

import java.io.IOException;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import com.google.gson.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.ResponseBody;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

@WebServlet("/DetailServlet") 
public class DetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DetailServlet() { 
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	PrintWriter out = response.getWriter();
        String searchTerm = request.getParameter("searchTerm");
        
	}
    
    public static Restaurant parseRestaurant(JSONObject json) throws ClassCastException {
        // Check that all the fields exist (Can throw a FieldNotFoundException)
        
        
        // Get field value (Each cast can throw a ClassCastException which tells us that the data was malformed)
    	String id = (String) json.get("id");
        String name = (String) json.get("name");
        JSONObject location = (JSONObject) json.get("location");
        String address1 = (String) location.get("address1");
        String city = (String) location.get("city");
        String state = (String) location.get("state");
        String zipCode = (String) location.get("zip_code");
        String address = address1 + ", " + city + ", " + state + " " + zipCode;
        String url = (String) json.get("url");
        String image = (String) json.get("image_url");
        JSONObject coordinates = (JSONObject) json.get("coordinates");
        double latitude = (Double) coordinates.get("latitude");
        double longitude = (Double) coordinates.get("longitude");
        String phoneNum = (String) json.get("display_phone");
        JSONArray categories = (JSONArray) json.get("categories");
        JSONObject category = (JSONObject) categories.get(0);
        String cuisine = (String) category.get("title");
        String price = (String) json.get("price");
        double rating = (Double) json.get("rating");
        
        return new Restaurant(id, name, new Coordinates(latitude, longitude), address, url, image, phoneNum, cuisine, price, rating);
    }

}
