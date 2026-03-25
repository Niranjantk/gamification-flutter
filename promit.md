
## **📌 Project Title:**

**Turtle Escape — 3D-Style Maze Adventure (Flutter + MVVM + Provider)**

---

# **1. Overview**

Convert an existing **2D Pac-Man style Flutter grid game** into a **3D-style maze escape game** featuring:

* A **3D Blender turtle model** rendered in Flutter (fake-3D style using animations or sprite rotations)
* A maze generated using **DFS Maze Generation Algorithm**
* Maze solving using **DFS Pathfinding** to find an exit (the ocean)
* Gameplay: A turtle navigates through a maze and finds its way to the ocean

The architecture must follow:

* **MVVM pattern (Model–View–ViewModel)**
* **Provider** for state management
* Clean, maintainable, scalable project structure

---

# **2. Core Game Concept**

### **🟢 Player Character**

* A **3D Blender turtle model** exported as:
i have already the moddel int he assets/turtle_3d_model/tuttle.obj use that 
  * `.glb` OR
  * sprite sheet with 4 rotation frames (Front, Back, Left, Right)
* Turtle rotates based on movement direction
* Turtle can move **up/down/left/right**

### **🟦 Maze**

* Represented as a 2D grid, but rendered with 3D-style tiles (fake-3D)
* Generated using **DFS Maze Generation**
* Contains:

  * Walls
  * Floor
  * Ocean EXIT tile

### **🔵 Objective**

Guide the turtle from START ➝ EXIT using:

* Player control
* OR auto-pathfinding using DFS Solve algorithm

---

# **3. Required Algorithms**

### **3.1 Maze Generation (DFS Backtracking Algorithm)**

* Generate a perfect maze (no loops)
* Store as `List<List<Cell>>`
* Must run inside the **MazeViewModel**

### **3.2 Pathfinding (DFS Solve Algorithm)**

* DFS should find a path from turtle spawn point → ocean exit
* Path is displayed only when needed

---

# **4. Flutter Architecture (MVVM)**

## **4.1 Models**

```
/models
  ├─ cell.dart
  ├─ maze.dart
  ├─ turtle.dart
```

### **Models include:**

* `Cell` → wall, floor, visited, etc.
* `Maze` → matrix with generated DFS maze
* `Turtle` → position, direction, rotation angle

---

## **4.2 ViewModels (Provider)**

```
/viewmodels
  ├─ maze_viewmodel.dart
  ├─ turtle_viewmodel.dart
  ├─ game_viewmodel.dart
```

### **Responsibilities**

#### **MazeViewModel**

* Generate maze (DFS)
* Provide maze grid
* Provide exit tile
* Provide pathfinding results

#### **TurtleViewModel**

* Controls turtle movement
* Rotates turtle model based on direction
* Validates movement against walls

#### **GameViewModel**

* Coordinates MazeViewModel + TurtleViewModel
* Handles game states: loading, ready, playing, solved

---

## **4.3 Views (UI Layer with Fake 3D)**

```
/views
  ├─ game_screen.dart
  ├─ maze_view.dart
  ├─ tile_widget.dart
  ├─ turtle_widget.dart
```

### **Rendering**

* Use 2D grid but make it *look 3D* using:

  * shadows
  * perspective transform
  * Blender turtle rendered from top-down rotated

---

# **5. Blender Integration**

### **Turtle Requirements**

* Create a simple, low-poly turtle in Blender
* Export as:

  * `.glb` (using `flutter_gl` or `model_viewer`)
  * OR 4-direction sprite sheet (easier for performance)

### In Flutter:

* If using `.glb`: render using `model_viewer_plus`
* If using sprite sheet: rotate sprite based on movement direction (N, S, E, W)

---

# **6. Movement + Rotation Logic**

When user moves:

```
UP    → rotate 0°
DOWN  → rotate 180°
LEFT  → rotate 270°
RIGHT → rotate 90°
```

TurtleViewModel updates:

* new position
* rotation angle
* animation state

---

# **7. Fake 3D Maze Rendering**

Tiles should appear 3D using:

* gradient depth
* drop shadows
* perspective scale (top row smaller, bottom row larger)

Each tile:

* Wall = raised block (3D effect)
* Floor = flat tile
* Ocean = animated blue tile

---

# **8. Auto-Solve Mode**

Add a toggle:

```
[Find Path to Ocean]
```

When pressed:

MazeViewModel:

* Runs DFS solve
* Returns list of cells (path)
* Game animates turtle walking through path slowly

---

# **9. Folder Structure (Final)**

```
lib/
  models/
  viewmodels/
  views/
  widgets/
  services/
  utils/
  assets/
    models/turtle.glb
    textures/
```

---

# **10. Deliverables**

### **You must produce:**

✔ DFS Maze Generator (Model + ViewModel)
✔ DFS Solver (Model + ViewModel)
✔ Turtle movement + rotation logic
✔ Fake 3D rendering of maze
✔ Blender 3D turtle model support
✔ MVVM + Provider architecture
✔ Fully working Flutter game: "Turtle Escape"

---
