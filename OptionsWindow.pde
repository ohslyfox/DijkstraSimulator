public class OptionsWindow {
  private DialogBox optionsDialog;
  private Button fromUp, fromDown, toUp, toDown, dijkstra,
                 genNodes, createLink, destroyLink;
  private int from, to;
  
  public OptionsWindow() {
    fromUp = new Button(0, 0, 20, 20, ">");
    fromDown = new Button(0, 0, 20, 20, "<");
    toUp = new Button(0, 0, 20, 20, ">");
    toDown = new Button(0, 0, 20, 20, "<");
    dijkstra = new Button(0, 0, 100, 25, "dijkstra");
    genNodes = new Button(0, 0, 100, 25, "create nodes");
    createLink = new Button(0, 0, 100, 25, "create link");
    destroyLink = new Button(0, 0, 100, 25, "remove link");
    from = 1;
    to = 20;
    optionsDialog = new DialogBox(10, 10, 250, 150, "Dijkstra Options");
    optionsDialog.visible();
    optionsDialog.setFade(true);
  }
  
  public void mouseRelease() {
    optionsDialog.setPressed(false);
    fromUp.setActivated(false);
    fromDown.setActivated(false);
    toUp.setActivated(false);
    toDown.setActivated(false);
    dijkstra.setActivated(false);
    genNodes.setActivated(false);
    createLink.setActivated(false);
    destroyLink.setActivated(false);
  }
  
  public boolean isPressed() {
    return optionsDialog.isPressed();
  }
  
  public void setPressed(boolean pressed) {
    optionsDialog.setPressed(pressed);
  }
  
  public void toggleVisible() {
    optionsDialog.visible(); 
  }
  
  public boolean hovering() {
    return optionsDialog.hovering(); 
  }
  
  public boolean getVisible() {
    return optionsDialog.getVisible();
  }
  
  private void runDijkstra() {
    Element[] sol = graph.dijkstra(from-1,to-1);
    ArrayList<Integer> path = new ArrayList<Integer>();
    int current = to-1;
    while (current > 0) {
      path.add(current);
      current = sol[current].getPi();
    }
    for (int i = 0; i < graph.getSize(); i++) {
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
  
  public void display() {
    if (optionsDialog.getVisible() && !graph.isDragging()) {
      if (mousePressed && optionsDialog.collision()) {
        optionsWindow.setPressed(true); 
      }
    }
    optionsDialog.move();
    optionsDialog.display();
    if (optionsDialog.getVisible()) {
      text("From: " + from, optionsDialog.getX() + 10, optionsDialog.getY() + 54);
      text("To: " + to, optionsDialog.getX() + 10, optionsDialog.getY() + 114);
      fromUp.setLocation(optionsDialog.getX() + 34, optionsDialog.getY() + 62);
      fromUp.display();
      if (fromUp.isPressed()) {
        if (from < to-1 && from < graph.getSize()) {
          from++; 
        }
      }
    
      fromDown.setLocation(optionsDialog.getX() + 12, optionsDialog.getY() + 62);
      fromDown.display();
      if (fromDown.isPressed()) {
        if (from > 1) {
          from--; 
        }
      }
      
      toUp.setLocation(optionsDialog.getX() + 34, optionsDialog.getY() + 122);
      toUp.display();
      if (toUp.isPressed()) {
        if (to < graph.getSize()) {
          to++; 
        }
      }
    
      toDown.setLocation(optionsDialog.getX() + 12, optionsDialog.getY() + 122);
      toDown.display();
      if (toDown.isPressed()) {
        if (to > from+1 && to > 1) {
          to--; 
        }
      }
      
      dijkstra.setLocation(optionsDialog.getX() + 140, optionsDialog.getY() + 38);
      dijkstra.display();
      if (dijkstra.isPressed()) {
        runDijkstra();
      }
      
      genNodes.setLocation(optionsDialog.getX() + 140, optionsDialog.getY() + 65);
      genNodes.display();
      if (genNodes.isPressed()) {
        graph = new Graph(20); 
      }
      
      createLink.setLocation(optionsDialog.getX() + 140, optionsDialog.getY() + 92);
      createLink.display();
      if (createLink.isPressed()) {
        graph.createLink(from-1, to-1); 
      }
      
      destroyLink.setLocation(optionsDialog.getX() + 140, optionsDialog.getY() + 119);
      destroyLink.display();
      if (destroyLink.isPressed()) {
        graph.destroyLink(from-1, to-1); 
      }
    }
  }
}
