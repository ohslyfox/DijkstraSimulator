public class OptionsWindow {
  private DialogBox optionsDialog;
  private Button fromUp, fromDown, toUp, toDown, maxUp, maxDown,
                 dijkstra, createGraph, createLink, destroyLink;
  private int from, to, totalNodes;
  private boolean fade, visible;
  private int opacity;
  
  public OptionsWindow() {
    fromUp = new Button(0, 0, 50, 18, ">");
    fromDown = new Button(0, 0, 50, 18, "<");
    toUp = new Button(0, 0, 50, 18, ">");
    toDown = new Button(0, 0, 50, 18, "<");
    dijkstra = new Button(0, 0, 230, 25, "dijkstra's shortest path");
    createGraph = new Button(0, 0, 112, 25, "new graph");
    createLink = new Button(0, 0, 112, 25, "create link");
    destroyLink = new Button(0, 0, 112, 25, "remove link");
    maxUp = new Button(0, 0, 50, 18, ">");
    maxDown = new Button(0, 0, 50, 18, "<");
    from = 1;
    to = 20;
    totalNodes = 20;
    optionsDialog = new DialogBox(10, 10, 250, 204, "Settings");
    optionsDialog.visible();
    this.fade = false;
    this.visible = true;
    this.opacity = 255;
  }
  
  public void mouseRelease() {
    optionsDialog.setPressed(false);
    fromUp.setActivated(false);
    fromDown.setActivated(false);
    toUp.setActivated(false);
    toDown.setActivated(false);
    dijkstra.setActivated(false);
    createGraph.setActivated(false);
    createLink.setActivated(false);
    destroyLink.setActivated(false);
    maxUp.setActivated(false);
    maxDown.setActivated(false);
  }
  
  public boolean isPressed() {
    return optionsDialog.isPressed();
  }
  
  public void setPressed(boolean pressed) {
    optionsDialog.setPressed(pressed);
  }
  
  public void toggleVisible() {
    this.visible = !this.visible;
  }
  
  public boolean hovering() {
    return optionsDialog.hovering(); 
  }
  
  public boolean getVisible() {
    return this.visible;
  }
  
  private void runDijkstra() {
    ArrayList<Element> sol = graph.dijkstra(from-1);
    ArrayList<Integer> path = new ArrayList<Integer>();
    int current = to-1;
    while (current >= 0) {
      path.add(current);
      current = sol.get(current).getPi();
    }
    
    graph.setPathIDs(path);
    for (int i = 0; i < graph.getSize(); i++) {
      if (!path.contains(i) && i != from-1) {
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
  
  public void display() {
    if (this.visible) {
      if (fade) {
        if (hovering()) {
          opacity = opacity < 255 ? opacity+20 : 255;
        }
        else {
          opacity = opacity > 100 ? opacity-10 : 100;
        }
      }
      // turn on fade after first hover
      else {
        if (hovering()) {
          fade = true; 
        }
      }
      
      if (optionsDialog.getVisible() && !graph.isDragging()) {
        if (mousePressed && optionsDialog.collision()) {
          optionsWindow.setPressed(true); 
        }
      }
      optionsDialog.move();
      optionsDialog.setOpacity(opacity);
      optionsDialog.display();
      if (optionsDialog.getVisible()) {
        fill(0, 0, 0, opacity);
        text("From: " + from, optionsDialog.getX() + 10, optionsDialog.getY() + 54);
        text("To: " + to, optionsDialog.getX() + 135, optionsDialog.getY() + 54);
        text("Nodes: " + totalNodes, optionsDialog.getX() + 10, optionsDialog.getY() + 170);
        textSize(10);
        text("'S' to hide settings", optionsDialog.getX() + 123, optionsDialog.getY() + 194);
        fromUp.setLocation(optionsDialog.getX() + 65, optionsDialog.getY() + 62);
        fromUp.setOpacity(opacity);
        fromUp.display();
        if (fromUp.isPressed()) {
          if (from < to-1 && from < graph.getSize()) {
            from++; 
          }
        }
      
        fromDown.setLocation(optionsDialog.getX() + 10, optionsDialog.getY() + 62);
        fromDown.setOpacity(opacity);
        fromDown.display();
        if (fromDown.isPressed()) {
          if (from > 1) {
            from--; 
          }
        }
        
        toUp.setLocation(optionsDialog.getX() + 190, optionsDialog.getY() + 62);
        toUp.setOpacity(opacity);
        toUp.display();
        if (toUp.isPressed()) {
          if (to < graph.getSize() && to < totalNodes) {
            to++; 
          }
        }
      
        toDown.setLocation(optionsDialog.getX() + 135, optionsDialog.getY() + 62);
        toDown.setOpacity(opacity);
        toDown.display();
        if (toDown.isPressed()) {
          if (to > from+1 && to > 1) {
            to--; 
          }
        }
        
        dijkstra.setLocation(optionsDialog.getX() + 10, optionsDialog.getY() + 90);
        dijkstra.setOpacity(opacity);
        dijkstra.display();
        if (dijkstra.isPressed()) {
          runDijkstra();
        }
        
        createGraph.setLocation(optionsDialog.getX() + 128, optionsDialog.getY() + 152);
        createGraph.setOpacity(opacity);
        createGraph.display();
        if (createGraph.isPressed()) {
          graph.createGraph(); 
        }
        
        createLink.setLocation(optionsDialog.getX() + 10, optionsDialog.getY() + 121);
        createLink.setOpacity(opacity);
        createLink.display();
        if (createLink.isPressed()) {
          graph.createLink(from-1, to-1); 
        }
        
        destroyLink.setLocation(optionsDialog.getX() + 128, optionsDialog.getY() + 121);
        destroyLink.setOpacity(opacity);
        destroyLink.display();
        if (destroyLink.isPressed()) {
          graph.destroyLink(from-1, to-1); 
        }
        
        maxUp.setLocation(optionsDialog.getX() + 65, optionsDialog.getY() + 178);
        maxUp.setOpacity(opacity);
        maxUp.display();
        if (maxUp.isPressed()) {
          if (totalNodes < 20) {
            totalNodes++; 
            graph.createNode();
          }
        }
        
        maxDown.setLocation(optionsDialog.getX() + 10, optionsDialog.getY() + 178);
        maxDown.setOpacity(opacity);
        maxDown.display();
        if (maxDown.isPressed()) {
          if (totalNodes > 2) {
            totalNodes--;
            if (totalNodes < to) {
              to = totalNodes; 
            }
            graph.removeNode();
          }
        }
      }
    }
  }
}
