package SalEats;

import org.json.simple.JSONObject;

public class Restaurant {
	private String id;
	private String name;
    private Coordinates coordinates;
    private String address;
    private String url;
    private String image;
    private String phoneNum;
    private String cuisine;
    private String price;
    private double rating;

    public Restaurant(String id, String name, Coordinates coordinates, String address, String url, String image, 
    		String phoneNum, String cuisine, String price, double rating) {
    	this.id = id;
        this.name = name;
        this.coordinates = coordinates;
        this.address = address;
        this.url = url;
        this.image = image;
        this.phoneNum = phoneNum;
        this.cuisine = cuisine;
        this.price = price;
        this.rating = rating;
    }
    
    public String getID() {
    	return id;
    }
    
    public void setID(String id) {
    	this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Coordinates getCoordinates() {
        return coordinates;
    }

    public void setCoordinates(Coordinates coordinates) {
        this.coordinates = coordinates;
    }

    @SuppressWarnings("unchecked")
    public JSONObject toJson() {
        // Initialize new JSONObject
        JSONObject jsonObject = new JSONObject();

        // Insert components into jsonObject
        jsonObject.put("name", this.name);
        jsonObject.put("coordinates", this.coordinates);

        return jsonObject;
    }

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getCuisine() {
		return cuisine;
	}

	public void setCuisine(String cuisine) {
		this.cuisine = cuisine;
	}

	public String getPhoneNum() {
		return phoneNum;
	}

	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}

	public double getRating() {
		return rating;
	}

	public void setRating(double rating) {
		this.rating = rating;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}
}
