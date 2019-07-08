public class Button {
  private PVector location;
  private PVector dimensions;
  private color base, hover, clicked;
  private boolean activated;
  private String text;
  private int opacity;
  
  public Button(int x, int y, int w, int h, String text) {
    this.location = new PVector(x, y);
    this.dimensions = new PVector(w, h);
    this.text = text;
    this.activated = false;
    this.base = color(152, 251, 152);
    this.hover = color(87, 251, 87);
    this.clicked = color(171,171,171);
    this.opacity = 255;
  }
  
  public void setLocation(int x, int y) {
    location.x = x;
    location.y = y;
  }
  
  private boolean hovering() {
    if (mouseX > location.x && mouseX < location.x + dimensions.x &&
        mouseY > location.y && mouseY < location.y + dimensions.y) {
      return true;      
    }
    return false;
  }
  
  private boolean isPressed() {
    if (!mousePress && !activated && mousePressed && hovering()) {
      activated = true;
      return true; 
    }
    return false;
  }
  
  public void setActivated(boolean activated) {
    this.activated = activated; 
  }
  
  public void setOpacity(int opacity) {
    this.opacity = opacity; 
  }
  
  public void display() {
    fill(base, opacity);
    if (hovering()) {
      fill(hover, opacity);
      if (mousePressed) {
        fill(clicked, opacity); 
      }
    }
    strokeWeight(1);
    stroke(0,0,0,opacity);
    rect(location.x, location.y, dimensions.x, dimensions.y);
    fill(0, opacity);
    textSize(12);
    textAlign(CENTER,CENTER);
    text(this.text, location.x + dimensions.x/2, location.y + dimensions.y/2);
  }
}
