import QtQuick

Rectangle {
  width: parent.width
  height: parent.height

  gradient: Gradient {
    GradientStop {
      position: 0.0
      color: "#cc000000"
    }
    GradientStop {
      position: 1.0
      color: "#00000000"
    }
  }
}
