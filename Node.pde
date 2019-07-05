public class Node {
  private int uID;
  private float weight;
  
  public Node(int uID, float weight) {
    setUID(uID);
    setWeight(weight);
  }
  
  public int getUID() {
    return this.uID;
  }
  
  public void setUID(int uID) {
    this.uID = uID; 
  }
  
  public float getWeight() {
    return this.weight; 
  }
  
  public void setWeight(float weight) {
    this.weight = weight; 
  }
}
