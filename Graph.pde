public class Graph {
  private int vertexCount;
  private ArrayList<Element> vertexArray;
  private Element draggingElement;
  private Element hoveringElement;
  private ArrayList<ArrayList<Node>> adjList;
  private ArrayList<Integer> pathIDs;
  
  public Graph(int vertexCount) {
    this.vertexCount = vertexCount;
    createGraph();
  }
  
  public void createGraph() {
    draggingElement = null;
    hoveringElement = null;
    pathIDs = new ArrayList<Integer>();
    createVerticies();
    validateVerticies();
    createRandomConnections();
  }
  
  private void createVerticies() {
    vertexArray = new ArrayList<Element>();
    for (int i = 0; i < MAX_NODES; i++) {
      PVector location = new PVector(random(50, width-50), random(50, height-50));
      vertexArray.add(new Element(location, i));
    }
  }

  private void validateVerticies() {
    boolean found = true;
    while (found) {
      found = false;
      for (int i = 0; i < MAX_NODES && !found; i++) {
        for (int j = 0; j < MAX_NODES; j++) {
          if (i == j) {
            continue; 
          }
          if (dist(vertexArray.get(i).location.x, vertexArray.get(i).location.y, vertexArray.get(j).location.x, vertexArray.get(j).location.y) <= 100) {
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

  private void createRandomConnections() {
    adjList = new ArrayList<ArrayList<Node>>();
    for (int i = 0; i < MAX_NODES; i++) {
      adjList.add(new ArrayList<Node>()); 
    }
    
    for (int i = 0; i < this.vertexCount; i++) {
      int stop = 0;
      ArrayList<Node> current = adjList.get(i);
      Element from = vertexArray.get(i);
      
      while (stop < MAX_NODES-1) {
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
            Element to = vertexArray.get(vertexToAdd);
            float weight = dist(from.location.x, from.location.y, to.location.x, to.location.y);
            current.add(new Node(vertexToAdd, weight));
            adjList.get(vertexToAdd).add(new Node(i, weight));
          }
        }
        stop++;
      }
    }
    
    printAdjList();
  }
  
  public void createLink(int from, int to) { 
    if (pathIDs.contains(from) || pathIDs.contains(to)) {
      clearPath(); 
    }
    boolean exists = false;
    ArrayList<Node> fromList = adjList.get(from);
    for (Node n : fromList) {
      if (n.getUID() == to) {
        exists = true; 
      }
    }
    if (!exists) {
      
      Element fromElement = vertexArray.get(from);
      Element toElement = vertexArray.get(to);
      float weight = dist(fromElement.location.x, fromElement.location.y, toElement.location.x, toElement.location.y);
      fromList.add(new Node(to, weight));
      adjList.get(to).add(new Node(from, weight));
    }
  }
  
  public void destroyLink(int from, int to) {
    if (pathIDs.contains(from) || pathIDs.contains(to)) {
      clearPath(); 
    }
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
  
  public ArrayList<Element> dijkstra(int source) {
    //init single source
    for (int i = 0; i < this.vertexCount; i++) {
      vertexArray.get(i).setDistance(Integer.MAX_VALUE/2);
      vertexArray.get(i).setPi(-1);
    }
    vertexArray.get(source).setDistance(0);
    
    ArrayList<Element> queue = new ArrayList<Element>();
    for(int i = 0; i < this.vertexCount; i++) {
      queue.add(vertexArray.get(i)); 
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
    Element from = vertexArray.get(u);
    Element to = vertexArray.get(v);
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
  
  private void runDijkstra() {
    ArrayList<Element> sol = dijkstra(optionsWindow.getFrom()-1);
    ArrayList<Integer> path = new ArrayList<Integer>();
    int current = optionsWindow.getTo()-1;
    while (current >= 0) {
      path.add(current);
      current = sol.get(current).getPi();
    }
    
    graph.setPathIDs(path);
    for (int i = 0; i < graph.getSize(); i++) {
      if (!path.contains(i) && i != optionsWindow.getFrom()-1) {
        sol.get(i).setPi(-2); 
      }
    }
    println();
    for (Element e : sol) {
       println();
       print((e.getUID()+1) + " : " + (e.getPi()+1) + " : " + e.getDistance());
    }
    println(); 
  }
  
  private void updateWeight() {
    for (int i = 0; i < adjList.size(); i++) {
      ArrayList<Node> fromList = adjList.get(i);
      Element fromElement = vertexArray.get(i);
      for (Node n : fromList) {
        Element toElement = vertexArray.get(n.getUID());
        float weight = dist(fromElement.location.x, fromElement.location.y, toElement.location.x, toElement.location.y);
        n.setWeight(weight);
      }
    }
  }
  
  public void mousePress() {
    if (draggingElement != null) {
      draggingElement.mousePress(); 
      updateWeight();
      clearPath();
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
  
  public void setPathIDs(ArrayList<Integer> path) {
    this.pathIDs = path; 
  }
  
  private void clearPath() {
    this.pathIDs.clear();
    for (Element e : vertexArray) {
      e.setPi(-1); 
    }
  }
  
  private void createNode() {
    vertexCount++;
  }
  
  private void removeNode() {
    if (pathIDs.contains(vertexCount-1)) {
      clearPath();
    }
    adjList.get(vertexCount-1).clear();
    for (ArrayList<Node> currentList : adjList) {
      for (int i = currentList.size()-1; i >= 0; i--) {
        if (currentList.get(i).getUID() == vertexCount-1) {
          currentList.remove(i);
        }
      }
    }
    vertexCount--;
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
    //display connections
    for (int i = 0; i < this.vertexCount; i++) {
      ArrayList<Node> currentAdjList = adjList.get(i);
      Element from = vertexArray.get(i);
      for (int j = 0; j < currentAdjList.size(); j++) {
        Node node = currentAdjList.get(j);
        Element to = vertexArray.get(node.getUID());
        if (to.getPi() == from.getUID() || to.getUID() == from.getPi()) {
          strokeWeight(6);
          stroke(0,255,0,200); 
        }
        else {
          strokeWeight(2);
          stroke(255,0,0,80);
        }
        line(from.location.x, from.location.y, to.location.x, to.location.y);
      }
    }

    //display elements
    for (int i = 0; i < this.vertexCount; i++) {
      Element e = vertexArray.get(i);
      e.setFillColor(220,220,220,255);
      if (hoveringElement == null && e.hovering() && (!optionsWindow.hovering() || !optionsWindow.getVisible())) {
        hoveringElement = e;
      }
      if (hoveringElement != null) {
        hoveringElement.setFillColor(185,185,185,255);
      }
      e.display();
      fill(0);
      textSize(32);
      textAlign(CENTER, CENTER);
      text("" + (i+1), e.location.x, e.location.y-4);
    }
    
    //display HUD info box for hovered element
    if (hoveringElement != null) {
      if (hoveringElement.hovering() && (!optionsWindow.hovering() || !optionsWindow.getVisible())) {
        ArrayList<Node> hoveringAdjList = adjList.get(hoveringElement.getUID());
        if (hoveringAdjList.size() > 0) {
          float displayX = mouseX > width-330 ? mouseX - 310 : mouseX + 40;
          float displayY = mouseY-40;
          if (mouseY < 40) {
            displayY = mouseY+10; 
          }
          else if (mouseY > height - 10 - (20*hoveringAdjList.size())) {
            displayY = mouseY-20 - (20*hoveringAdjList.size());
          }
          fill(50,50,50,200);
          strokeWeight(1);
          rect(displayX, displayY, 288, 20*hoveringAdjList.size());
          fill(0);
          textSize(18);
          textAlign(LEFT, CENTER);
          for (int i = 0; i < hoveringAdjList.size(); i++) {
            Node current = hoveringAdjList.get(i);
            fill(255);
            if (pathIDs.contains(hoveringElement.getUID()) && pathIDs.contains(current.getUID())) {
              fill(0,255,0); 
            }
            text(String.format("%-3s %-3d %-9s %-3.1f", "Node:", current.getUID()+1, "Distance:", current.getWeight()), displayX + 5, (displayY - 12) + (20*(i+1)));
          }
        }
      }
      if (!hoveringElement.hovering() || (optionsWindow.hovering() && optionsWindow.getVisible())) {
        hoveringElement = null;
      }
    }
  }
}
