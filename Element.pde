class Element {
  private PVector location;
  private float distance;
  private int pi;
  private int uID;
  private boolean pressed;
  private color fill;
  
  public Element(PVector location, int uID) {
    this.setLocation(location);
    this.distance = Integer.MAX_VALUE/2;
    this.pi = -1;
    this.uID = uID;
    this.fill = color(220,220,220,255);
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
  
  public float getX() {
    return location.x; 
  }
  
  public float getY() {
    return location.y; 
  }
  
  public void setFillColor(int r, int g, int b, int o) {
    this.fill = color(r, g, b, o); 
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
    pressed = mousePressed && hovering();
    return pressed;
  }
  
  public boolean hovering() {
    return dist(location.x, location.y, mouseX, mouseY) <= 30;
  }
  
  public void display() {
    fill(fill);
    stroke(0);
    strokeWeight(2);
    ellipse(location.x, location.y, 60, 60); 
    
  }
}
