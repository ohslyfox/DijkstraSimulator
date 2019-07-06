class DialogBox {
  int x, y;
  int w, h;
  int oMouseX, oMouseY;
  int opacity;
  String title;
  boolean pressed;
  boolean visible;
  boolean fade;
  
  DialogBox(int x, int y, int w, int h, String title) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.title = title;
    this.pressed = false;
    this.visible = false;
    this.fade = false;
    this.opacity = 255;
  }
  
  void move() {
    if (this.pressed && this.visible) {
      this.x += (mouseX - this.oMouseX);
      this.y += (mouseY - this.oMouseY);
      this.oMouseX = mouseX;
      this.oMouseY = mouseY;
    }
    perimeter();
  }
  
  void setPressed(boolean input) {
    if (this.pressed == false && input == true && this.visible == true) {
      this.oMouseX = mouseX;
      this.oMouseY = mouseY;
    }
    this.pressed = input;
  }
  
  boolean collision() {
    if (mouseX > this.x && mouseX < (x+w)) {
      if (mouseY > this.y && mouseY < (y + (h-(h-30)))) {
        return true;
      }
    }
    return false;
  }
  
  public boolean hovering() {
    if (mouseX > this.x && mouseX < x + w &&
        mouseY > this.y && mouseY < y + h) {
      return true;      
    }
    return false;
  }
  
  void perimeter() {
    if (this.x < 0) {
      this.x = 0;
    }
    if ((this.x + this.w) > width) {
      this.x = (width - this.w);
    }
    if ((this.y + this.h > height)) {
      this.y = (height - this.h);
    }
    if (this.y < 0) {
      this.y = 0;
    }
  }
  
  void visible() {
    this.visible = !this.visible;
  }
  
  public void setFade(boolean fade) {
    this.fade = fade; 
  }
  
  boolean getVisible() {
    return this.visible; 
  }
  
  boolean isPressed() {
    return this.pressed;
  }
  
  int getX() {
    return this.x;
  }
  
  int getY() {
    return this.y;
  }
  
  void display() {
    if (this.visible) {
      if (fade) {
        if (hovering()) {
          opacity = opacity < 255 ? opacity+12 : 255;
        }
        else {
          opacity = opacity > 100 ? opacity-12 : 100;
        }
      }
      strokeWeight(1);
      fill(240,240,240,opacity);
      rect(x,y,w,h);
      fill(220,220,220,opacity + 50);
      rect(x,y,w,h - (h-30));
      fill(0);
      textAlign(CORNER);
      textSize(20);
      text(title, x+10,round(y+(h - (h-22))));
      text(title, x+11,round(y+(h - (h-22))));
    }
  }
  
  
}
