import g4p_controls.*;

Graph graph;
OptionsWindow optionsWindow;

PFont mono;
boolean mousePress;

void setup() {
  size(1280, 720);
  smooth(2);
  
  mono = createFont("andalemo.ttf", 32);
  textFont(mono);
  mousePress = false;
  
  optionsWindow = new OptionsWindow();
  graph = new Graph(20);
}

public void keyPressed() {
  if (key == 'r' || key == 'R') {
    graph = new Graph(20);
  }
  if (key == 'd' || key == 'D') {
    Element[] sol = graph.dijkstra(0,19);
    ArrayList<Integer> path = new ArrayList<Integer>();
    int current = 19;
    while (current > 0) {
      path.add(current);
      current = sol[current].getPi();
    }
    for (int i = 0; i < 19; i++) {
      if (!path.contains(i)) {
        sol[i].setPi(-1); 
      }
    }
    println();
    for (Element e : sol) {
       println();
       print((e.getUID()+1) + " : " + (e.getPi()+1) + " : " + e.getDistance());
    }
    println();
  }
  if (key == 'w' || key == 'W') {
    optionsWindow.toggleVisible(); 
  }
}


public void mouseReleased() {
  graph.mouseRelease();
  optionsWindow.mouseRelease();
  mousePress = false;
  //optionsWindow.setPressed(false);
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
}
