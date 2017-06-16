
PVector[][] grid;
PVector[][] next;

int gridSize;
float dA = 1.0;
float dB = 0.5;
float feed = 0.055;
float k = 0.062;
float t = 1.0;

void setup() {
  size(500, 500);
  //fullScreen(2);


  gridSize = 10;
  grid = new PVector[width][height];
  next = new PVector[width][height];



  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      grid[x][y] = new PVector(1, 0);
      next[x][y] = new PVector(1, 0);
    }
  }

  for (int i = 80; i < 120; i++) {
    for (int j = 100; j < 110; j++) {
      grid[i][j].y = 0.5;
    }
  }
  
}

void draw() {

  loadPixels();

  //update
  for (int x = 1; x < width-1; x++) {
    for (int y = 1; y < height-1; y++) {
      float a = grid[x][y].x;
      float b = grid[x][y].y;
      next[x][y].x = a + dA * laplaceA(x, y) - a * b * b + (feed * (1-a)) * t;
      next[x][y].y = b + dB * laplaceB(x, y) + a * b * b - (k + feed) * b * t;
      //next[x][y].x = a + dA * laplaceA(x, y) - a * b * b + (feed * (1-a)) * t;
      //next[x][y].y = b + dB * laplaceB(x, y) + a * b * b - (k + feed) * b * t;
    }
  }

  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int index = x + y * width;
      //float simcol = map (abs(next[x][y].x - next[x][y].y), 0, 1, 150, 255);
      pixels[index] = color(next[x][y].x*255, next[x][y].y*255, 0);
      //pixels[index] = color(simcol, simcol, simcol);
    }
  }
  updatePixels();

  swap();
}

void swap() {
  PVector[][] temp = grid;
  grid = next;
  next = temp;
}


float laplaceA(int x, int y) {
  float sum = 0;
  sum += grid[x][y].x * -1;
  sum += grid[x-1][y].x * 0.2;
  sum += grid[x+1][y].x * 0.2;
  sum += grid[x][y+1].x * 0.2;
  sum += grid[x][y-1].x * 0.2;
  sum += grid[x-1][y-1].x * 0.05;
  sum += grid[x+1][y-1].x * 0.05;
  sum += grid[x-1][y+1].x * 0.05;
  sum += grid[x+1][y+1].x * 0.05;
  
  //sum = 1.0;
  return sum;
}

float laplaceB(int x, int y) {
  float sum = 0;
  sum += grid[x][y].y * -1;
  sum += grid[x-1][y].y * 0.2;
  sum += grid[x+1][y].y * 0.2;
  sum += grid[x][y+1].y * 0.2;
  sum += grid[x][y-1].y * 0.2;
  sum += grid[x-1][y-1].y * 0.05;
  sum += grid[x+1][y-1].y * 0.05;
  sum += grid[x-1][y+1].y * 0.05;
  sum += grid[x+1][y+1].y * 0.05;

  //sum = 1.0;
  return sum;
}