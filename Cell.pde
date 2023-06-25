class Cell {
  int i, j;
  boolean visited = false;
  //order of walls: top, right, bottom, left
  ArrayList<Boolean> walls = new ArrayList<Boolean>(Arrays.asList(true, true, true, true));

  Cell(int _i, int _j) {
    i = _i;
    j = _j;
  }

  void show() {
    int x = i * w;
    int y = j * w;

    if (visited) {
      noStroke();
      fill(51);
      rect(x, y, w, w);

      stroke(255);
      //strokeWeight(4);
      if (walls.get(0)) line(x, y, x+w, y);
      if (walls.get(1)) line(x+w, y, x+w, y+w);
      if (walls.get(2)) line(x+w, y+w, x, y+w);
      if (walls.get(3)) line(x, y+w, x, y);
    }
  }

  void highlight() {
    noStroke();
    fill(0, 0, 255);
    rect(i*w, j*w, w, w);
  }

  Cell move() {
    ArrayList<Cell> possibleNeighbors = new ArrayList<Cell>();
    int top = index(i, j-1);
    int right = index(i+1, j);
    int bottom = index(i, j+1);
    int left = index(i-1, j);

    if (top != -1) {
      Cell ctop = grid.get(top);
      if (!ctop.visited) possibleNeighbors.add(ctop);
    }
    if (right != -1) {
      Cell cright = grid.get(right);
      if (!cright.visited) possibleNeighbors.add(cright);
    }
    if (bottom != -1) {
      Cell cbottom = grid.get(bottom);
      if (!cbottom.visited) possibleNeighbors.add(cbottom);
    }
    if (left != -1) {
      Cell cleft = grid.get(left);
      if (!cleft.visited) possibleNeighbors.add(cleft);
    }

    if (possibleNeighbors.size() > 0) {
      return (possibleNeighbors.get(floor(random(possibleNeighbors.size()))));
    } else return null;
  }
}

int index(int i, int j) {
  if (i < 0 || j < 0 || i > cols - 1 || j > rows - 1) {
    return -1;
  }
  return i + j * cols;
}
