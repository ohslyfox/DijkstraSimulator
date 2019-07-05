class Element {
  private PVector location;
  private float distance;
  private int pi;
  private int uID;
  private boolean pressed;
  
  public Element(PVector location, int uID) {
    this.setLocation(location);
    this.distance = Integer.MAX_VALUE/2;
    this.pi = -1;
    this.uID = uID;
  }
  
  public void setLocation(PVector location) {
    this.location = location; 
  }
  
  public PVector getLocation() {
    return this.location;
  }
  
  public void setDistance(float distance) {
    this.distance = distance; 
  }
  
  public float getDistance() {
    return this.distance; 
  }
  
  public void setPi(int pi) {
    this.pi = pi;
  }
  
  public int getPi() {
    return this.pi; 
  }
  
  public int getUID() {
    return this.uID;
  }
  
  public boolean getPressed() {
    return this.pressed; 
  }
  
  public void mousePress() {
    if (pressed) {
      if (mouseX > 0 && mouseX < width && mouseY > 0 && mouseY < height) {
        location.x = mouseX;
        location.y = mouseY;
      }
    }
  }
  
  public void setPressed(boolean pressed) {
    this.pressed = pressed; 
  }
  
  public boolean collision() {
    pressed = mousePressed && dist(location.x, location.y, mouseX, mouseY) <= 30;
    return pressed;
  }
  
  public void display() {
    fill(220);
    stroke(0);
    ellipse(location.x, location.y, 60, 60); 
  }
}
