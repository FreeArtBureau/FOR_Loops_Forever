/*Sketch informations
 WIFI : pass : !Pca2014 loggin : pcaguest
 While operations 
 */
//Sketch properties
int pWidth = 1280;
int pHeight = 720;
String appName = "Dessine moi une boucle FOR ever";
String version = "Alpha";
String subVersion = "0.0.18";
String frameName;

float xOffset;
float lineInc;
int marginTop, marginBottom, marginLeft, marginRight;
float phi;
float phiOffset;
float phiAmplitude;
float dphi;
float[][] orientationList;
int cols, rows;
float gamma;
float speedGamma;

void setup()
{
  size(pWidth, pHeight, P3D);
  smooth(8);
  colorMode(HSB, 360, 100, 100, 100);
  appParameter();

  xOffset = 15;
  lineInc = xOffset/2;
  marginTop = marginBottom = 50;
  marginLeft = marginRight = 50;
  phi = 0.0;
  phiOffset = 0.02;
  phiAmplitude = xOffset;
  gamma = 0;
  speedGamma = 0.05;

  dphi = (TWO_PI/ (height-(marginTop+marginBottom)))*xOffset; 
  cols = int ((height-(marginBottom+marginTop)) / xOffset);
  rows = int((width-(marginRight+marginLeft)) / xOffset);
  orientationList = new float[cols][rows];
  for (int j = 0; j<cols; j++)
  {
    float betaMatrix = map(j, 0, cols-1, 0, PI);
    for (int i = 0; i<rows; i++)
    {
      float thetaMatrix = map(i, 0, rows-1, 0, PI);
      float orientation = betaMatrix + thetaMatrix;
      orientationList[j][i] = orientation;
    }
  }
}

void draw()
{
  background(40);
  //translate(width/2, height/2, 200);
  phi += phiOffset;
  float theta = phi;

  for (int j = 0; j<cols; j++)
  { 
    for (int i = 0; i<rows; i++)
    {
      float beta = sin(theta)*phiAmplitude;
      float x = (marginLeft+i*xOffset);
      float y = (marginTop+j*xOffset)+beta;

      float x1 = cos(gamma)*lineInc;
      float y1 = sin(gamma)*lineInc;

      float x2 = cos(gamma)*(lineInc*-1);
      float y2 = sin(gamma)*(lineInc*-1);

      float dist = dist(x, y, width/2, height/2);
      float hue = map(beta, -phiAmplitude, phiAmplitude, 160, 200);

      float sw = 0;
      float alpha = 0;
      float rectSize = 0;

      float thetaMatrix = orientationList[j][i];

      if (beta < 0)
      {
        sw = map(beta, -phiAmplitude, 0, 1, 3);
        alpha = map(beta, -phiAmplitude, 0, 25, 100);
        rectSize = map(beta, -phiAmplitude, 0, xOffset/2, xOffset);
      } else
      {
        sw = map(beta, 0, phiAmplitude, 3, 1);
        alpha = map(beta, 0, phiAmplitude, 100, 25);
        rectSize = map(beta, 0, phiAmplitude, xOffset, xOffset/2);
      }

      noFill();
      stroke(hue, 100, 100, alpha);
      //strokeWeight(sw);
      rectMode(CENTER);
      pushMatrix();
      translate(x, y);
      rotate(thetaMatrix);
      line(x1, y1, x2, y2);
      popMatrix();

      theta += dphi/2;
    }
  }


    gamma += speedGamma;
    if (gamma >= TWO_PI)
    {
      gamma = 0;
    }

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

void saveImage(String path)
{
  saveFrame(path+frameName+"_Frame_####.tif");
}

void keyPressed()
{
  if (key == 's')
  {
    String p = "C:/Users/Alexandre/Desktop/20141108 - FABWorkshop - boucleFor/Screenshot/";
    saveImage(p);
  }
}

