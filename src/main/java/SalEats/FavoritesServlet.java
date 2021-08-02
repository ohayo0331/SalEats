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

@WebServlet("/FavoritesServlet") 
public class FavoritesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FavoritesServlet() { 
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	PrintWriter out = response.getWriter();
        String userName = request.getParameter("userName");
        int userID = DatabaseFunctions.getIDFromUserName(userName);
        String resID = request.getParameter("resID");
        if (!resID.equals("") && !resID.equals("undefined")) {
        	DatabaseFunctions.insertFav(resID, userID, userName);
        }
        else {
        	ArrayList<String> favs = DatabaseFunctions.getFavFromID(userID);
        	OkHttpClient client = new OkHttpClient().newBuilder().build();
        	JsonArray restaurants = new JsonArray();
        	for (String tempID : favs) {
        		Request apiRequest = new Request.Builder()
    	                .url("https://api.yelp.com/v3/businesses/" + tempID)
    	                .method("GET", null)
    	                .addHeader("Authorization", "Bearer C9Q5_VrG3F3oLeT9cCW_NTRR9UUBVxblqP_6ItKFlv1NDUy_s6ItZ-xeoc2XtgQhSOJObie3vpzFbp3LhQeEUR-aEc7RsdgW09P7_VEngyukuVqKIFtTl7Mc75aBXnYx")
    	                .addHeader("Cookie", "__cfduid=d2c55fc647721c6ea8651cdc4685bc4bd1585592304")
    	                .build();
    	        ResponseBody responseBody = client.newCall(apiRequest).execute().body();
    	        JSONParser parser = new JSONParser();
    	        try {
    				JSONObject data = (JSONObject) parser.parse(responseBody.string());
    				Restaurant temp = parseRestaurant(data);
    				JsonObject restaurant = new JsonObject();
    				restaurant.addProperty("id", temp.getID());
    				restaurant.addProperty("name", temp.getName());
    				restaurant.addProperty("address", temp.getAddress());
    				restaurant.addProperty("url", temp.getUrl().substring(0, temp.getUrl().indexOf('?')));
    				restaurant.addProperty("image", temp.getImage());
    				restaurant.addProperty("phone", temp.getPhoneNum());
    				restaurant.addProperty("cuisine", temp.getCuisine());
    				restaurant.addProperty("price", temp.getPrice());
    				restaurant.addProperty("rating", temp.getRating());
    				restaurants.add(restaurant);
    			} catch (ParseException e) {
    				e.printStackTrace();
    			} catch (IOException e) {
    				e.printStackTrace();
    			}
        	}
        	JsonObject resData = new JsonObject();
			resData.add("resData", restaurants);
	        out.write(resData.toString());
        }
        
	}
    
    public static Restaurant parseRestaurant(JSONObject json) throws ClassCastException {
        // Check that all the fields exist (Can throw a FieldNotFoundException)
        
        
        // Get field value (Each cast can throw a ClassCastException which tells us that the data was malformed)
    	String resID = (String) json.get("id");
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
        
        return new Restaurant(resID, name, new Coordinates(latitude, longitude), address, url, image, phoneNum, cuisine, price, rating);
    }

}
