class Slider{
  private boolean horizontal;
  private boolean locked = false;
  private boolean onKnob = false;
  
  private float knobHeight, knobWidth;
  private float xPosition, yPosition;
  private float xStart, xEnd;
  private float xOffset;
  
  private int knobLength = 50;
  private int knobThickness = 20;
  
  private int totalSliderLength = 200;
  
  //private float xStart = 500; 
  //private float xEnd = 700;
  
  private color sliderColour = color(200, 250, 250);
  private color activeKnob = color(150, 200, 200);
  
  Slider(boolean _horizontal, float xPos, float yPos){
     horizontal = _horizontal;
     
     xPosition = xPos;
     yPosition = yPos;
     xStart = xPos - totalSliderLength/2;
     xEnd = xPos + totalSliderLength/2;
     
     if(horizontal){
       knobHeight = knobThickness;
       knobWidth = knobLength;         
     }else{
       knobHeight = knobLength;
       knobWidth = knobThickness;
     }
  }
  
  //Draw over Slider with a rectangle the same colour as the background
  private void refreshSlider(){
    noStroke();
    rectMode(CENTER);
    fill(backgroundColour);   
    rect(xStart+totalSliderLength/2, yPosition, 4*totalSliderLength/3, knobHeight+7);
  }

  private void drawSliderLine(){
    strokeWeight(3);
    stroke(255);
    line (xStart, yPosition, xEnd, yPosition);  
  }
  
  private void updateKnob(){
    if (dist(mouseX, mouseY, xPosition, yPosition) < knobHeight) {
      fill(sliderColour);
      onKnob = true;
    }else {
      fill(activeKnob);
      onKnob = false;
    }  
  }
  
  private void updateXPosition(){
    if (xPosition < xStart) {
      xPosition = xStart;
    }
      
    if (xPosition > xEnd) {
      xPosition = xEnd;
    }
  }
  
  private void drawKnob(){
    rectMode(CENTER);
    rect(xPosition, yPosition, knobWidth, knobHeight);
  }

  public void drawSlider(){
    refreshSlider();
        
    drawSliderLine();
        
    updateKnob();

    updateXPosition();
      
    drawKnob();
  }
  
  public float getRelativeSliderValue(){
    return (xPosition-xStart)/(xEnd-xStart);
  }
  
  void mousePress() {
    if (onKnob) {
      locked = true;
      xOffset = mouseX-xPosition;
    }
  }
  void mouseDrag() {
    if (locked) {
      xPosition = mouseX-xOffset;
    }
  }
  void mouseRelease() {
    locked = false;
  }

}
