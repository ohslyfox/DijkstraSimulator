public class OptionsWindow {
  private DialogBox optionsDialog;
  private Button fromUp, fromDown, toUp, toDown, maxUp, maxDown,
                 dijkstra, createGraph, createLink, destroyLink;
  private int from, to, totalNodes, opacity;
  private boolean fade, visible;
  
  public OptionsWindow() {
    fromUp = new Button(0, 0, 50, 18, ">");
    fromDown = new Button(0, 0, 50, 18, "<");
    toUp = new Button(0, 0, 50, 18, ">");
    toDown = new Button(0, 0, 50, 18, "<");
    maxUp = new Button(0, 0, 50, 18, ">");
    maxDown = new Button(0, 0, 50, 18, "<");
    dijkstra = new Button(0, 0, 230, 25, "dijkstra's shortest path");
    createGraph = new Button(0, 0, 112, 25, "new graph");
    createLink = new Button(0, 0, 112, 25, "create link");
    destroyLink = new Button(0, 0, 112, 25, "remove link");
    
    from = 1;
    to = MAX_NODES;
    totalNodes = MAX_NODES;
    optionsDialog = new DialogBox(10, 10, 250, 204, "Settings");
    optionsDialog.toggleVisible();
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
  
  public int getFrom() {
    return this.from; 
  }
  
  public int getTo() {
    return this.to; 
  }
  
  public void display() {
    if (this.visible) {
      if (fade) {
        if (hovering()) {
          opacity = opacity < 255 ? opacity+12 : 255;
        }
        else {
          opacity = opacity > 80 ? opacity-10 : 80;
        }
      }
      // turn on fade after first hover
      else {
        if (hovering()) {
          fade = true; 
        }
      }
      
      if (optionsDialog.getVisible() && !graph.isDragging()) {
        if (mousePressed && optionsDialog.hoveringTitleBar()) {
          optionsWindow.setPressed(true); 
        }
      }
      optionsDialog.move();
      optionsDialog.setOpacity(opacity);
      optionsDialog.display();
      if (optionsDialog.getVisible()) {
        fill(0, opacity);
        text("From: " + from, optionsDialog.getX() + 10, optionsDialog.getY() + 54);
        text("To: " + to, optionsDialog.getX() + 135, optionsDialog.getY() + 54);
        text("Nodes: " + totalNodes, optionsDialog.getX() + 10, optionsDialog.getY() + 170);
        textSize(9);
        text("'S' to hide settings", optionsDialog.getX() + 130, optionsDialog.getY() + 192);
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
        
        maxUp.setLocation(optionsDialog.getX() + 65, optionsDialog.getY() + 178);
        maxUp.setOpacity(opacity);
        maxUp.display();
        if (maxUp.isPressed()) {
          if (totalNodes < MAX_NODES) {
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
            if (totalNodes-1 < from) {
              from = totalNodes-1; 
            }
            graph.removeNode();
          }
        }
        
        dijkstra.setLocation(optionsDialog.getX() + 10, optionsDialog.getY() + 88);
        dijkstra.setOpacity(opacity);
        dijkstra.display();
        if (dijkstra.isPressed()) {
          graph.runDijkstra();
        }
        
        createGraph.setLocation(optionsDialog.getX() + 128, optionsDialog.getY() + 150);
        createGraph.setOpacity(opacity);
        createGraph.display();
        if (createGraph.isPressed()) {
          graph.createGraph(); 
        }
        
        createLink.setLocation(optionsDialog.getX() + 10, optionsDialog.getY() + 119);
        createLink.setOpacity(opacity);
        createLink.display();
        if (createLink.isPressed()) {
          graph.createLink(from-1, to-1); 
        }
        
        destroyLink.setLocation(optionsDialog.getX() + 128, optionsDialog.getY() + 119);
        destroyLink.setOpacity(opacity);
        destroyLink.display();
        if (destroyLink.isPressed()) {
          graph.destroyLink(from-1, to-1); 
        }
      }
    }
  }
}
