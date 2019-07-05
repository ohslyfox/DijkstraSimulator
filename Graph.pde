public class Graph {
  
  int vertexCount;
  Element vertexArray[];
  ArrayList<ArrayList<Node>> adjList;
  
  public Graph(int vertexCount) {
    this.vertexCount = vertexCount;
    createVerticies();
    validateVerticies();
    createRandomConnections();
  }
  
  void createVerticies() {
    vertexArray = new Element[this.vertexCount];
    for (int i = 0; i < this.vertexCount; i++) {
      PVector location = new PVector(random(50, width-50), random(50, height-50));
      vertexArray[i] = new Element(location, i);
    }
  }

  void validateVerticies() {
    boolean found = true;
    while (found) {
      found = false;
      for (int i = 0; i < this.vertexCount && !found; i++) {
        for (int j = 0; j < this.vertexCount; j++) {
          if (i == j) {
            continue; 
          }
          if (dist(vertexArray[i].location.x, vertexArray[i].location.y, vertexArray[j].location.x, vertexArray[j].location.y) <= 100) {
            found = true;
            break;
          }
        }
      }
      if (found) {
        createVerticies(); 
      }
    }
  }

  void createRandomConnections() {
    adjList = new ArrayList<ArrayList<Node>>();
    for (int i = 0; i < this.vertexCount; i++) {
      adjList.add(new ArrayList<Node>()); 
    }
    
    for (int i = 0; i < this.vertexCount; i++) {
      int stop = 0;
      ArrayList<Node> current = adjList.get(i);
      Element from = vertexArray[i];
      
      while (stop < this.vertexCount-1) {
        int random = (int)random(0, stop+10);
        if (random < 2) {
          Integer vertexToAdd = (int)random(0, this.vertexCount);
          
          boolean exists = false;
          for (Node node : current) {
            if (node.getUID() == (int)vertexToAdd) {
              exists = true; 
            }
          }
          
          if (!exists && (int)vertexToAdd != i) {
            Element to = vertexArray[(int)vertexToAdd];
            float weight = dist(from.location.x, from.location.y, to.location.x, to.location.y);
            current.add(new Node((int)vertexToAdd, weight));
            adjList.get((int)vertexToAdd).add(new Node(i, weight));
          }
          else {
            stop = this.vertexCount;
          }
        }
        stop++;
      }
    }
    
    printAdjList();
  }
  
  public Element[] dijkstra(int source, int destination) {
    //init single source
    for (int i = 0; i < this.vertexCount; i++) {
      vertexArray[i].setDistance(Integer.MAX_VALUE/2);
      vertexArray[i].setPi(-1);
    }
    vertexArray[source].setDistance(0);
    
    ArrayList<Element> queue = new ArrayList<Element>();
    for(int i = 0; i < this.vertexCount; i++) {
      queue.add(vertexArray[i]); 
    }
    
    while(queue.size() > 0) {
      Element u = removeMin(queue);
      ArrayList<Node> uAdjList = adjList.get(u.getUID());
      
      for (Node n : uAdjList) { //<>//
        relax(u.getUID(), n.getUID()); 
      }
    }
    
    return this.vertexArray;
  }
  
  private void relax(int u, int v) {
    Element from = vertexArray[u];
    Element to = vertexArray[v];
    float w = dist(from.location.x, from.location.y, to.location.x, to.location.y);
    if (to.getDistance() > from.getDistance() + w) {
      to.setDistance(from.getDistance() + w);
      to.setPi(u);
    }
  }
  
  private Element removeMin(ArrayList<Element> queue) {
    Element min = null;
    float minDistance = Float.MAX_VALUE;
    
    for (Element e : queue) {
      if (e.getDistance() < minDistance) {
        minDistance = e.getDistance();
        min = e; 
      }
    }
    queue.remove(min);
    return min;
  }
  
  public void mousePress() {
    for (Element e : vertexArray) {
      if (e.getPressed() || e.collision()) {
        e.mousePress();
        break;
      }
    }
  }
  
  public void mouseRelease() {
    for (Element e : vertexArray) {
      e.setPressed(false); 
    }
  }
  
  public void printAdjList() {
    // print adj list
    println();
    for (int i = 0; i < this.vertexCount; i++) {
      ArrayList<Node> current = adjList.get(i);
      print((i+1) + " ");
      for (int j = 0; j < current.size(); j++) {
        Node node = current.get(j);
        print((node.getUID() + 1) + ", " + node.getWeight() + "; "); 
      }
      println();
    }
  }
  
  public void display() {
    for (int i = 0; i < this.vertexCount; i++) {
      ArrayList<Node> currentAdjList = adjList.get(i);
      Element from = vertexArray[i];
      for (int j = 0; j < currentAdjList.size(); j++) {
        Node node = currentAdjList.get(j);
        Element to = vertexArray[node.getUID()];
        if (to.getPi() == from.getUID() || to.getUID() == from.getPi()) {
          stroke(0,255,0); 
        }
        else {
          stroke(255,0,0,100);
        }
        line(from.location.x, from.location.y, to.location.x, to.location.y);
      }
    }
    
    for (int i = 0; i < this.vertexCount; i++) {
      Element e = vertexArray[i];
      e.display();
      fill(0);
      textSize(32);
      text("" + (i+1), e.location.x, e.location.y-4);
    }
  }
}
