Graph graph;

void setup() {
  size(1280, 720);
  smooth(2);
  textAlign(CENTER, CENTER);
  graph = new Graph(20);
}

public void keyPressed() {
  if (key == 'r' || key == 'R') {
    graph = new Graph(20);
  }
  if (key == 'd' || key == 'D') {
    Element[] sol = graph.dijkstra(0,19);
    int target = 19;
    for (int i = 19; i >= 0; i--) {
      Element e = sol[i];
      if (target != e.getUID()()) {
        e.setPi(-1); 
      }
      target = e.getPi();
    }
    println();
    for (Element e : sol) {
       println();
       print((e.getUID()+1) + " : " + (e.getPi()+1) + " : " + e.getDistance());
    }
    println();
  }
}

public void mouseReleased() {
  graph.mouseRelease();
}


void draw() {
  background(255);
  graph.mousePress();
  graph.display();
}
