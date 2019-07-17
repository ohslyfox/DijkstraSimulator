class DialogBox {
  PVector location, dimensions;
  int oMouseX, oMouseY;
  int opacity;
  String title;
  boolean pressed;
  boolean visible;
  
  public DialogBox(int x, int y, int w, int h, String title) {
    this.location = new PVector(x, y);
    this.dimensions = new PVector(w, h);
    this.title = title;
    this.pressed = false;
    this.visible = false;
    this.opacity = 255;
  }
  
  public void move() {
    if (this.pressed && this.visible) {
      this.location.x += (mouseX - this.oMouseX);
      this.location.y += (mouseY - this.oMouseY);
      this.oMouseX = mouseX;
      this.oMouseY = mouseY;
    }
    bound();
  }
  
  public void setPressed(boolean input) {
    if (this.pressed == false && input == true && this.visible == true) {
      this.oMouseX = mouseX;
      this.oMouseY = mouseY;
    }
    this.pressed = input;
  }
  
  public boolean hoveringTitleBar() {
    if (mouseX > this.location.x && mouseX < (location.x+dimensions.x)) {
      if (mouseY > this.location.y && mouseY < (location.y + (dimensions.y-(dimensions.y-30)))) {
        return true;
      }
    }
    return false;
  }
  
  public boolean hovering() {
    if (mouseX > this.location.x && mouseX < location.x + dimensions.x &&
        mouseY > this.location.y && mouseY < location.y + dimensions.y) {
      return true;      
    }
    return false;
  }
  
  private void bound() {
    if (this.location.x < 0) {
      this.location.x = 0;
    }
    if ((this.location.x + this.dimensions.x) > width) {
      this.location.x = (width - this.dimensions.x);
    }
    if ((this.location.y + this.dimensions.y > height)) {
      this.location.y = (height - this.dimensions.y);
    }
    if (this.location.y < 0) {
      this.location.y = 0;
    }
  }
  
  public void toggleVisible() {
    this.visible = !this.visible;
  }
  
  public boolean getVisible() {
    return this.visible; 
  }
  
  public boolean isPressed() {
    return this.pressed;
  }
  
  public float getX() {
    return this.location.x;
  }
  
  public float getY() {
    return this.location.y;
  }
  
  public void setOpacity(int opacity) {
    this.opacity = opacity; 
  }
  
  public void display() {
    if (this.visible) {
      strokeWeight(1);
      stroke(0,0,0,opacity+50);
      fill(240,240,240,opacity);
      rect(location.x,location.y,dimensions.x,dimensions.y);
      fill(220,220,220,opacity + 50);
      rect(location.x,location.y,dimensions.x,dimensions.y - (dimensions.y-30));
      fill(0,0,0,opacity + 50);
      textAlign(CORNER);
      textSize(20);
      text(title, location.x+10,round(location.y+(dimensions.y - (dimensions.y-22))));
      text(title, location.x+11,round(location.y+(dimensions.y - (dimensions.y-22))));
    }
  }
  
  
}
