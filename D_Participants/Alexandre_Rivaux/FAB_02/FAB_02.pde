/*Sketch informations
 WIFI : pass : !Pca2014 loggin : pcaguest
 While operations 
 */
//Sketch properties
int pWidth = 1280;
int pHeight = 720;
String appName = "Dessine moi une boucle FOR ever";
String version = "Alpha";
String subVersion = "0.0.2";
String frameName;

float xOffset;
int marginTop, marginBottom, marginLeft, marginRight;

void setup()
{
  size(pWidth, pHeight, P3D);
  smooth(8);
  colorMode(HSB, 360, 100, 100, 100);
  appParameter();
  
  xOffset = 25;
  marginTop = marginBottom = 50;
  marginLeft = marginRight = 50;
}

void draw()
{
  background(40);
  //translate(width/2, height/2, 200);

  for (int j = marginTop; j<height-marginBottom; j+=xOffset)
  {
    for (int i = marginLeft; i<width-marginRight; i+=xOffset)
    {
      float phi = map(i, 0, width, 0, TWO_PI);
      float x = i;
      float y = j+sin(phi)*(height/2-mouseY);

      float dist = dist(x, y, width/2, height/2);
      float hue = map(dist, 0, height/2, 160, 200);

      noFill();
      stroke(hue, 100, 100);

      if (j % 2 == 0)
      {
        pushMatrix();
        translate(x, y);
        rotate(phi);
        rectMode(CENTER);
        rect(0, 0, 25, 25);
        popMatrix();
      } else
      {  
        ellipse(x, y, 25, 25);
      }
    }
  }


  //noLoop();

  //drawAxis(100, "RVB");
  showFpsOnFrameTitle();
}

//App Parameters
void appParameter()
{
  frameName = appName+"_"+version+"_"+subVersion;
  frame.setTitle(frameName);
}

void showFpsOnFrameTitle()
{
  frame.setTitle(frameName+"    FPS : "+int(frameRate));
}

void drawAxis(float l, String colorMode)
{
  color xAxis = color(255, 0, 0);
  color yAxis = color(0, 255, 0);
  color zAxis = color(0, 0, 255);

  if (colorMode == "rvb" || colorMode == "RVB")
  {
    xAxis = color(255, 0, 0);
    yAxis = color(0, 255, 0);
    zAxis = color(0, 0, 255);
  } else if (colorMode == "hsb" || colorMode == "HSB")
  {
    xAxis = color(0, 100, 100);
    yAxis = color(115, 100, 100);
    zAxis = color(215, 100, 100);
  }

  pushStyle();
  strokeWeight(1);
  //x-axis
  stroke(xAxis); 
  line(0, 0, 0, l, 0, 0);
  //y-axis
  stroke(yAxis); 
  line(0, 0, 0, 0, l, 0);
  //z-axis
  stroke(zAxis); 
  line(0, 0, 0, 0, 0, l);
  popStyle();
}

