public class Graph {
  int vertexCount;
  Element vertexArray[];
  Element draggingElement;
  ArrayList<ArrayList<Node>> adjList;
  
  public Graph(int vertexCount) {
    draggingElement = null;
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
          int vertexToAdd = (int)random(0, this.vertexCount);
          
          boolean exists = vertexToAdd == i ? true : false;
          if (!exists) {
            for (Node node : current) {
              if (node.getUID() == vertexToAdd) {
                exists = true; 
              }
            }
          }
          if (!exists) {
            Element to = vertexArray[vertexToAdd];
            float weight = dist(from.location.x, from.location.y, to.location.x, to.location.y);
            current.add(new Node(vertexToAdd, weight));
            adjList.get(vertexToAdd).add(new Node(i, weight));
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
  
  public void createLink(int from, int to) {
    boolean exists = false;
    ArrayList<Node> fromList = adjList.get(from);
    for (Node n : fromList) {
      if (n.getUID() == to) {
        exists = true; 
      }
    }
    
    if (!exists) {
      Element fromElement = vertexArray[from];
      Element toElement = vertexArray[to];
      float weight = dist(fromElement.location.x, fromElement.location.y, toElement.location.x, toElement.location.y);
      fromList.add(new Node(to, weight));
      adjList.get(to).add(new Node(from, weight));
    }
  }
  
  public void destroyLink(int from, int to) {
    ArrayList<Node> fromList = adjList.get(from);
    for (int i = 0; i < fromList.size(); i++) {
      if (fromList.get(i).getUID() == to) {
        fromList.remove(i);
      }
    }
    
    ArrayList<Node> toList = adjList.get(to);
    for (int i = 0; i < toList.size(); i++) {
      if (toList.get(i).getUID() == from) {
        toList.remove(i); 
      }
    }
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
  
  private void updateWeight() {
    for (int i = 0; i < adjList.size(); i++) {
      ArrayList<Node> fromList = adjList.get(i);
      Element fromElement = vertexArray[i];
      for (Node n : fromList) {
        Element toElement = vertexArray[n.getUID()];
        float weight = dist(fromElement.location.x, fromElement.location.y, toElement.location.x, toElement.location.y);
        n.setWeight(weight);
      }
    }
  }
  
  public void mousePress() {
    if (draggingElement != null) {
      draggingElement.mousePress(); 
      updateWeight();
    }
    else if (!optionsWindow.getVisible() || !optionsWindow.hovering()) {
      for (Element e : vertexArray) {
        if (e.getPressed() || e.collision()) {
          draggingElement = e;
          break;
        }
      }
    }
  }
  
  public void mouseRelease() {
    if (draggingElement != null) {
      draggingElement.setPressed(false);
      draggingElement = null;
    }
  }
  
  public boolean isDragging() {
    return draggingElement != null; 
  }
  
  public int getSize() {
    return this.vertexCount;
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
          strokeWeight(6);
          stroke(0,255,0,200); 
        }
        else {
          strokeWeight(1);
          stroke(255,0,0,100);
        }
        line(from.location.x, from.location.y, to.location.x, to.location.y);
      }
    }

    for (int i = 0; i < this.vertexCount; i++) {
      Element e = vertexArray[i];
      e.display(adjList.get(i));
      fill(0);
      textSize(32);
      textAlign(CENTER, CENTER);
      text("" + (i+1), e.location.x, e.location.y-4);
    }
  }
}
