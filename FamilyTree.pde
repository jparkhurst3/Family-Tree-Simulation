import controlP5.*;
ControlP5 cp5;
String TYPE_FAMILY_NAME_HERE = "";
FamilyInput fam;

int treeSize;
int started;
int i,w=400,h=400,m=w/2; 
float p,a,b,c,x,y,z;
color b1, b2;

DplaItem[] entries; //Entries that match the search word
DplaItem[] results;
JSONArray json; // A JSON object

int[] leafX; //Random x coordinate for leaf
int[] leafY; //Random y coordinate for leaf

void setup() {
  size(400, 400);
  loadData();
  initializeTextBox();
  treeSize = 0;
  started = 0;
  leafX = new int[50];
  leafY = new int[50];
  drawMountains();
}

void draw() {
  //background(255); //white
  frameRate(30);
  drawTree(treeSize);  
}

// 
void loadData() {
  //Enter a search term here as well as number of pages  
  SearchQuery mySearch = new SearchQuery("Family", 1000);
  
  // Handle search results here
  JSONArray JSONresults = mySearch.search();
  entries = new DplaItem[JSONresults.size()];

  // Use search results to fill array of JSONObjects
  for (int i = 0; i < JSONresults.size (); i++) {
    JSONObject rec = JSONresults.getJSONObject(i);
    DplaItem di = new DplaItem(rec);
    entries[i] = di;
  }
}

void initializeTextBox() {
  PFont font = createFont("arial", 20);
  cp5 = new ControlP5(this); 
  cp5.addTextfield("TYPE_FAMILY_NAME_HERE")
     .setPosition(20, 20)
     .setSize(200,40)
     .setFont(createFont("arial",20))
     .setAutoClear(false)
     ;
       
  cp5.addButton("SEARCH")
     .setValue(0)
     .setPosition(240, 20)
     .setSize(80,40)
     //.getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;    
  textFont(font);
}  

void initializeLeaves(int treeSize) {
  int treeHeight = treeSize * 5;
  int leafAreaWidth = treeHeight;
  int leafAreaHeight = treeSize * 3;
  for(int i=0; i<50; i++)
  {
    color leafBackground = color(47, 180, 53);
    int attempt = 0;
    while(attempt < 3) {
      leafX[i] = (width/2) - (leafAreaWidth/2) + (int)random(leafAreaWidth);
      leafY[i] = (height - treeHeight) - 8 - (leafAreaHeight/2) + (int)random(leafAreaHeight);
      color c = get(leafX[i], leafY[i]);
      if (c == leafBackground) {
        attempt = 5;
      } else {
        attempt++;
      }
      if (attempt == 4) {
        leafX[i] = (width/2);
        leafY[i] = (height - treeHeight) - 8 - (leafAreaHeight/2) + (int)random(leafAreaHeight);
      }
    }  
  }
}

public void SEARCH(int theValue) {
  println("Searched For: " + cp5.get(Textfield.class, "TYPE_FAMILY_NAME_HERE").getText());
  fam = new FamilyInput(cp5.get(Textfield.class, "TYPE_FAMILY_NAME_HERE").getText(), entries);
  results = fam.getResults();
  treeSize = fam.getNumResults();
  println("Found: " + treeSize + " results.");
  if(treeSize < 200) {
    initializeLeaves(treeSize);  
  }
  background(255);
  drawMountains();
}

public void clearText() {
  cp5.get(Textfield.class, "TYPE_FAMILY_NAME_HERE").clear();
} 

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
            +theEvent.getName()+"': "
            +theEvent.getStringValue()
            );
  }
}

void drawTree(int treeSize)
{
  if(treeSize > 0 && treeSize < 5) treeSize = 5;
  if(treeSize > 50) treeSize = 50;
  
  int numLeaves = treeSize;
  int numBranches = treeSize/5;
  int treeHeight = treeSize * 5;
  int trunkWidth = treeSize;
  int leafAreaWidth = treeHeight;
  int leafAreaHeight = treeSize * 3;
  
  drawGrass();
  drawTrunk(trunkWidth, treeHeight);
  drawLeaves(numLeaves, treeHeight, leafAreaWidth, leafAreaHeight);
}  

void drawGrass() {
  fill(75, 144, 19);
  noStroke();
  rect(0, height - 30, width, 30);
}  

void drawTrunk(int trunkWidth, int treeHeight) 
{
  int trunkHeight = ((treeHeight*3)/4);
  int topRightCorner = (width/2) - (trunkWidth/2);
  fill(152, 70, 18);
  noStroke();
  rect(topRightCorner, height - ((treeHeight*3)/4) - 20, trunkWidth, trunkHeight);
}  

void drawLeaves(int numLeaves, int treeHeight, int leafAreaWidth, int leafAreaHeight)
{
  fill(47, 180, 53);
  ellipse((width/2), (height - treeHeight) - 8, leafAreaWidth, leafAreaHeight); 
  int colorNum = 0;
  for(int i=0; i<numLeaves; i++) {
    if(colorNum == 0) {
      fill(255, 246, 64);
      colorNum++;
    } else if (colorNum == 1) {
      fill(255, 159, 41);
      colorNum++;
    } else if (colorNum == 2) {
      fill(155, 255, 49);
      colorNum = 0;
    }
    ellipse(leafX[i], leafY[i], 8, 4);
    //results[i].display(leafX[i], leafY[i], 8, 4);
  }
}  

void drawMountains() {
  p+=.005;
  for(x=0;x++<w;)
  {
    y=0;
    for(i=5;i-->0;)
    {
      noiseDetail(14-i*2);
      a = 49 - i*10;
      b = 236 - i*30;
      c = 255 - i*33;
      color d = color(a, b, c);
      //g=150-i*33;
      stroke(d);
      z=h-(noise(33*i+p+x/m)*(h-90*i));
      if(y>0&&z<y)line(x,y,x,z);
      y=z;
    }
  }
}


