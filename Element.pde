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
    pressed = mousePressed && hovering();
    return pressed;
  }
  
  public boolean hovering() {
    return dist(location.x, location.y, mouseX, mouseY) <= 30;
  }
  
  public void display(ArrayList<Node> adjList) {
    fill(220);
    stroke(0);
    strokeWeight(1);
    ellipse(location.x, location.y, 60, 60); 
    if (hovering() && (!optionsWindow.hovering() || !optionsWindow.getVisible())) {
      if (adjList.size() > 0) {
        rect(location.x+40, location.y-40, 270, 21*adjList.size());
        fill(0);
        textSize(18);
        textAlign(LEFT, CENTER);
        for (int i = 0; i < adjList.size(); i++) {
          Node current = adjList.get(i);  
          
          text(String.format("%-3s %-3d %-9s %-3.1f", "To:", current.getUID()+1, "Distance:", current.getWeight()), location.x + 45, (location.y - 50) + (20*(i+1)));
        }
      }
    }
  }
}
