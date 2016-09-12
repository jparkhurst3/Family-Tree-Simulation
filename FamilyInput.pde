public class FamilyInput {
  public String familyName;
  DplaItem[] entries;
  DplaItem[] results;
  int num;
  
  public FamilyInput(String input, DplaItem[] e) { //e is entries from main 
    familyName = input;
    entries = e;
    results = new DplaItem[100];
    num = 0;
  }
  
  public DplaItem[] getResults() {
    int numResults = 0;
    for(int i=0; i<entries.length; i++) {
      String title = entries[i].getTitle();
      if(title.toLowerCase().indexOf(familyName.toLowerCase()) != -1) {
        numResults++;
        if(numResults < 100){
          results[numResults] = entries[i];
        }
      }  
    }
    num = numResults; 
    return results;
  }

  public int getNumResults() {
    return num;
  }  
}
