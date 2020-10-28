final color backgroundColour = color(135,206,235);
color treeColour = color(0, 80, 80);

Slider angleSlider;

boolean onLoad = true;

float theta;

void setup(){
    size(800 ,800);
    background(backgroundColour); 
    
    angleSlider = new Slider(true, 600, 700);
}

void leafSetup(float len){
  strokeWeight(0.02*len);
  stroke(treeColour);
  fill(treeColour);
  smooth();
}

void drawStem(float len){
  beginShape();
  curveVertex(0, 0);
  curveVertex(0, 0);
  if(random(-1, 1) > 0){
    curveVertex(random(0, len/20), -len/9);
    curveVertex(random(0, len/20), -2*len/9);
  }else{
    curveVertex(random(-len/20, 0), -len/9);
    curveVertex(random(-len/20, 0), -2*len/9);  
  }
  curveVertex(0, -len/3);
  curveVertex(0, -len/3); 
  endShape();
}

void drawLeafBody(float len){
  float offset = len/9;
  float rand;
  
  beginShape();
  curveVertex(0,-len/3); 
  curveVertex(0, -len/3); 
  rand = random(-len/3, 0);
  curveVertex(rand, -5*len/9);
  curveVertex(random(rand-offset, rand+offset), -8*len/9);
  curveVertex(0, -len); 
  curveVertex(0, -len); 
  endShape();

  beginShape();
  curveVertex(0, -len); 
  curveVertex(0, -len);
  rand = random(0, len/3);
  curveVertex(rand, -7*len/9);  
  curveVertex(random(rand-offset, rand+offset), -4*len/9);  
  curveVertex(0,-len/3);
  curveVertex(0, -len/3);
  endShape();
}

void drawLeaf(float len){
  leafSetup(len);

  drawStem(len);
  
  drawLeafBody(len);
}

void drawBranchBody(float len){
  strokeWeight(0.02*len);
  stroke(treeColour);
  noFill();
  smooth();
  beginShape();
  curveVertex(0, 0);
  curveVertex(0, 0); 
  curveVertex(random(-len/20, len/20), -len/3);
  curveVertex(random(-len/20, len/20), -2*len/3);
  curveVertex(0, -len);
  curveVertex(0, -len);
  endShape();
}

void drawBranch(float len) {
  int noOfBranches = int(random(1, 4.2));
  float totalAngle = 0;
  float angle;
  
  drawBranchBody(len);
  
  translate(0, -len);
  len *= random(0.5, 0.7);
 
  if (len > 5) {
    for(int i=0; i<noOfBranches; i++){
       pushMatrix();
       angle = random(-theta, theta);
       totalAngle += angle;
       rotate(angle);
       if(len>10){
         drawBranch(len);
       }else{
         drawLeaf(len);
       }
       popMatrix();
    }
    
    angle = 0-totalAngle;
    
       if(angle < -theta/4 || angle > theta/4){
         if(angle > theta || angle < -theta){
           pushMatrix();
           float angle1 = random(angle/2-angle/4, angle/2+angle/4);
           rotate(angle1);
           drawBranch(len);
           popMatrix();
           
           pushMatrix();
           rotate(angle-angle1);
           drawBranch(len);
           popMatrix();
         }else{
           pushMatrix();
           rotate(angle);
           drawBranch(len);
           popMatrix();       
         }
     }
  }
}

void moveToTreeBase(){
  translate(width/2, height);
}

void draw(){
  theta = map(angleSlider.getRelativeSliderValue(), 0, 1, 0, PI/2);

  angleSlider.drawSlider();
  
  moveToTreeBase();

  if(onLoad){
    drawBranch(height/3);
    onLoad = false;
  }
  

}

void mousePressed(){
   angleSlider.mousePress(); 
}

void mouseDragged(){
  angleSlider.mouseDrag();
}

void mouseReleased(){
  angleSlider.mouseRelease();
  background(backgroundColour);
  drawBranch(height/3);
}
