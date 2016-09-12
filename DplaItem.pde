// Each result is used to create a DplaItem
class DplaItem {
  float x, y;
  float diameter;
  String displayTxt;
  boolean over = false;
  JSONObject jsonParent;
  JSONObject sr;

  // Constructor
  public DplaItem(JSONObject j) {
    x = random(0, width);
    y = random(0, height);
    diameter = 10;

    // Original JSONObject
    jsonParent = j;
    
    // Nested JSONObject that contains useful information
    sr = SourceResource();
    
    // Modify this to determine what is revealed in mouseOver
    displayTxt = getCollectionTITLE();
  }

  // Return original URL of item
  public String getItemURL() {
    String shownAt = jsonParent.getString("isShownAt");
    println(shownAt);
    return shownAt;
  }

  // Get inside SourceResource (Where a lot of useful info resides)
  public JSONObject SourceResource() {
    JSONObject source = jsonParent.getJSONObject("sourceResource");
    return source;
  }

  // Return Title
  public String getTitle() {
    try {
      return sr.getString("title");
    } 
    catch (Exception e) {
      String s = "NA";
      return s;
    }
  }

  // Return Description
  public String getDescription() {
    try {
      return sr.getString("description");
    } 
    catch (Exception e) {
      String s = "NA";
      return s;
    }
  }

  // Return Format
  public String getFormat() {
    try {
      return sr.getString("format");
    }     
    catch (Exception e) {
      String s = "NA";
      return s;
    }
  }

  // Return Collection Name
  public String getCollectionNAME() {
    try {
      return sr.getJSONObject("collection").getString("name");
    } 
    catch (Exception e) {
      String s = "NA";
      return s;
    }
  }

  // Return Provider Name
  public String getProviderName() {
    try {
      return sr.getJSONArray("provider").toString();
    } 
    catch (Exception e) {
      String s = "NA";
      return s;
    }
  }

  // Return CollectionID
  public String getCollectionID() {
    try {
      return sr.getJSONObject("collection").getString("id");
    }
    catch (Exception e) {
      String s = "NA";
      return s;
    }
  }

  // Return Title
  public String getCollectionTITLE() {
    try {
      return sr.getJSONObject("collection").getString("title");
    } 
    catch (Exception e) {
      String s = "NA";
      return s;
    }
  }

  // CHecking if mouse is over the Entry
  void rollover(float px, float py) {
    float d = dist(px, py, x, y);
    if (d < diameter/2) {
      over = true;
    } else {
      over = false;
    }
  }

  // Display the Entry
  void display(int x, int y, int ellipseW, int ellipseH) {
    noStroke();
    fill(200, 100);
    ellipse(x, y, diameter, diameter);
    
    if (over) {
      fill(0);
      textAlign(LEFT);
      text(displayTxt, x, y);
    }

    // Causes "falling" entries
    if (y > height) {
      y = 0;
    } else {
      y+=.5;
    }
    
  }
}

