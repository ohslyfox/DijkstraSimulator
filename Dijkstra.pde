import g4p_controls.*;

Graph graph;
OptionsWindow optionsWindow;

PFont mono;
boolean mousePress;

void setup() {
  size(1280, 720);
  smooth(2);
  frameRate(60);
  surface.setTitle("Dijkstra's Shortest Path Simulator");
  mono = createFont("andalemo.ttf", 32);
  textFont(mono);
  mousePress = false;
  
  optionsWindow = new OptionsWindow();
  graph = new Graph(20);
}

public void keyPressed() {
  if (key == 's' || key == 'S') {
    optionsWindow.toggleVisible(); 
  }
}


public void mouseReleased() {
  graph.mouseRelease();
  optionsWindow.mouseRelease();
  mousePress = false;
}

void draw() {
  background(255); 
  if (!optionsWindow.isPressed()) {
    graph.mousePress();
  }
  graph.display();
  optionsWindow.display();
  
  if (!mousePress && mousePressed) {
    mousePress = true;
  }
  
  fill(0,0,0,200);
  textSize(12);
  textAlign(LEFT, CENTER);
  text("by slyfox", 5, height - 12);
}
