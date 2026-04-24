import QtQuick
import QtQuick.Shapes
import Quickshell

PanelWindow {
    id: topPanel
    
    // Anchor the panel to the top, left, and right of the monitor
    anchors {
        top: true
        left: true
        right: true
    }
    
    // The total height of the Wayland window is the Bar Height + Corner Radius.
    // We make the base window completely transparent so the cutouts work!
    height: 40 + 20 
    color: "transparent" 
    
    // Tell Hyprland to only reserve 40 pixels for the bar, letting 
    // your app windows slide *under* the 20px corners!
    exclusiveZone: 40 

    // 1. THE MAIN TASKBAR
    Rectangle {
        id: barBackground
        width: parent.width
        height: 40
        color: "#1e1e2e" // Your bar color (e.g., Catppuccin Mocha surface)
    }

    // 2. THE LEFT CONCAVE CORNER
    Shape {
        anchors.top: barBackground.bottom // Sits right under the bar
        anchors.left: parent.left         // Pushed flush against the left monitor edge
        width: 20
        height: 20

        ShapePath {
            fillColor: barBackground.color // Matches the bar to blend seamlessly
            strokeColor: "transparent"
            startX: 20; startY: 0                 // Start at Top-Left
            PathArc {
                x: 0; y: 20                      // Arc down to Bottom-Left
                radiusX: 20; radiusY: 20
                direction: PathArc.Counterclockwise
              }
            PathLine {x:0;y:0} 
            PathLine {x:20;y:0}
              
        }
    }

    // 3. THE RIGHT CONCAVE CORNER
    Shape {
        anchors.top: barBackground.bottom // Sits right under the bar
        anchors.right: parent.right       // Pushed flush against the right monitor edge
        width: 20
        height: 20

        ShapePath {
            fillColor: barBackground.color 
            strokeColor: "transparent"

            // Draw a path that fills the top-right, leaving the bottom-left transparent
            startX: 20; startY: 0                // Start at Top-Right
            PathLine { x: 0; y: 0 }              // Draw line to Top-Left
            PathArc {
                x: 20; y: 20                     // Arc down to Bottom-Right
                radiusX: 20; radiusY: 20
                direction: PathArc.Clockwise
            }
            PathLine { x: 20; y: 0 }             // Close the shape back to Top-Right
        }
    }
}

