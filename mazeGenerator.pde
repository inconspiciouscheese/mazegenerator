import java.util.ArrayDeque;
import java.util.Arrays;
int w;
int rows, cols;
ArrayList<Cell> grid = new ArrayList<Cell>();
Cell current;
ArrayDeque<Cell> stack = new ArrayDeque<Cell>();

void setup() {
  size (900, 900);
  w = 60;
  rows = width/w;
  cols = height/w;
  //frameRate(10);

  for (int j = 0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      Cell cell = new Cell (i, j);
      grid.add(cell);
    }
  }

  current = grid.get(0);
}

void draw() {
  background(0);
  for (Cell cell : grid) {
    cell.show();
  }
  if (current != null) {
    current.highlight();
    current.visited = true;

    Cell next = current.move();
    if (next == null) {
      if (stack.size() > 0) {
        current = stack.pop();
      }
    } else {
      stack.push(current);
      removeWalls(current, next);
      current = next;
      next.visited = true;
    }
  }
}

void removeWalls(Cell a, Cell b) {
  //figure out where b is relative to a
  //right
  if (b.i - a.i == 1) {
    a.walls.set(1, false);
    b.walls.set(3, false);
  } //left
  else if (b.i - a.i == -1) {
    a.walls.set(3, false);
    b.walls.set(1, false);
  } //bottom
  else if (b.j - a.j == 1) {
    a.walls.set(2, false);
    b.walls.set(0, false);
  } //top
  else if (b.j - a.j == -1) {
    a.walls.set(0, false);
    b.walls.set(2, false);
  }
}

void mouseClicked() {
  reset();
  for (Cell cell : grid) {
    int x = cell.i * w;
    int y = cell.j * w;
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + w) {
      current = cell;
    }
  }
}

void reset() {
  for (Cell cell : grid) {
    cell.walls.set(0, true);
    cell.walls.set(1, true);
    cell.walls.set(2, true);
    cell.walls.set(3, true);
    cell.visited = false;
  }
}
