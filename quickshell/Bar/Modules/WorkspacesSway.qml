import QtQuick
import QtQuick.Layouts
import Quickshell.I3

import "../Styling"

// I vibecoded the transition part (animate only on hover, not on click)
// Please forbid me gods of selfcoding :pray:
RowLayout {
  spacing: 3

  Repeater {
    model: I3.workspaces

    Rectangle {
      id: workspaceRect
      required property var modelData
      property var isActive: I3.focusedWorkspace && I3.focusedWorkspace.id == modelData.id
      property var isHovered: false

      width: 24
      height: 24
      radius: 9

      color: "transparent"

      StyledText {
        id: workspaceText
        anchors.centerIn: parent
        text: parent.modelData.name
        font.bold: true

        color: "white"
      }

      states: [
        // "active" state takes priority (checked first or implies exclusivity logic)
        State {
          name: "active"
          when: workspaceRect.isActive
          PropertyChanges {
            target: workspaceRect
            color: "white"
          }
          PropertyChanges {
            target: workspaceText
            color: "#1a1a1a"
          }
        },
        // "hovered" state only applies if not active
        State {
          name: "hovered"
          when: workspaceRect.isHovered && !workspaceRect.isActive
          PropertyChanges {
            target: workspaceRect
            color: "white"
          }
          PropertyChanges {
            target: workspaceText
            color: "#1a1a1a"
          }
        }
      ]

      // 3. Define Transitions ONLY for the hover state
      transitions: [
        Transition {
          // This creates the fade effect when entering/leaving "hovered"
          to: "hovered"
          from: "*" // From any state (usually default)
          reversible: true
          ColorAnimation {
            duration: 250
            easing.type: Easing.InOutQuad
          }
        }
      ]

      MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onClicked: parent.modelData.activate()
        onEntered: parent.isHovered = true
        onExited: parent.isHovered = false

        HoverHandler {
          cursorShape: Qt.PointingHandCursor
        }
      }
    }
  }
}
