import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Services.UPower

import "./Modules"
import "./Styling"

PanelWindow {
  id: statusBar

  anchors {
    top: true
    left: true
    right: true
  }

  implicitHeight: 36
  color: "transparent"

  StyledBgRect {
    Item {
      anchors.fill: parent
      anchors.leftMargin: 12
      anchors.rightMargin: 12

      RowLayout {
        spacing: 7
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter

        WorkspacesSway {}
        Player {}
      }

      Item {
        id: centerItem
        anchors.centerIn: parent
        width: childrenRect.width
        height: childrenRect.height

        ActiveWindow {}
      }

      RowLayout {
        spacing: 7
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        KeyboardLayout {}
        Loader {
          active: UPower.displayDevice.ready
          sourceComponent: Battery {}
        }
        Volume {}
        Clock {}
      }
    }
  }
}
