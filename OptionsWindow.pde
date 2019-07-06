public class OptionsWindow {
  private DialogBox optionsDialog;
  private Button fromUp, fromDown, toUp, toDown, dijkstra,
                 genNodes, createLink, destroyLink;
  private int from, to;
  
  public OptionsWindow() {
    fromUp = new Button(0, 0, 25, 25, "^");
    fromDown = new Button(0, 0, 25, 25, "v");
    toUp = new Button(0, 0, 25, 25, "^");
    toDown = new Button(0, 0, 25, 25, "v");
    dijkstra = new Button(0, 0, 100, 25, "dijkstra");
    genNodes = new Button(0, 0, 100, 25, "create nodes");
    createLink = new Button(0, 0, 100, 25, "create link");
    destroyLink = new Button(0, 0, 100, 25, "remove link");
    from = 1;
    to = 20;
    optionsDialog = new DialogBox(width/2, height/2, 300, 200, "Options");
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
      text("" + from, optionsDialog.getX() + 75, optionsDialog.getY() + 50);
      text("" + to, optionsDialog.getX() + 175, optionsDialog.getY() + 50);
      fromUp.setLocation(optionsDialog.getX() + 50, optionsDialog.getY() + 50);
      fromUp.display();
      if (fromUp.isPressed()) {
        if (from < to-1 && from < graph.getSize()) {
          from++; 
        }
      }
    
      fromDown.setLocation(optionsDialog.getX() + 100, optionsDialog.getY() + 50);
      fromDown.display();
      if (fromDown.isPressed()) {
        if (from > 1) {
          from--; 
        }
      }
      
      toUp.setLocation(optionsDialog.getX() + 150, optionsDialog.getY() + 50);
      toUp.display();
      if (toUp.isPressed()) {
        if (to < graph.getSize()) {
          to++; 
        }
      }
    
      toDown.setLocation(optionsDialog.getX() + 200, optionsDialog.getY() + 50);
      toDown.display();
      if (toDown.isPressed()) {
        if (to > from+1 && to > 1) {
          to--; 
        }
      }
      
      dijkstra.setLocation(optionsDialog.getX() + 100, optionsDialog.getY() + 100);
      dijkstra.display();
      if (dijkstra.isPressed()) {
        println("HIT");
        runDijkstra();
      }
      
      genNodes.setLocation(optionsDialog.getX() + 100, optionsDialog.getY() + 135);
      genNodes.display();
      if (genNodes.isPressed()) {
        graph = new Graph(20); 
      }
      
      createLink.setLocation(optionsDialog.getX() + 40, optionsDialog.getY() + 165);
      createLink.display();
      if (createLink.isPressed()) {
        graph.createLink(from-1, to-1); 
      }
      
      destroyLink.setLocation(optionsDialog.getX() + 160, optionsDialog.getY() + 165);
      destroyLink.display();
      if (destroyLink.isPressed()) {
        graph.destroyLink(from-1, to-1); 
      }
    }
  }
}
