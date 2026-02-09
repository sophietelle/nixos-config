import QtQuick
import Quickshell.Wayland

import "../Styling"
import "../Helpers/Slicer.js" as Slicer

StyledText {
  property var toplevel: ToplevelManager.activeToplevel

  text: toplevel && toplevel.activated ? Slicer.sliceAndDot(toplevel.title, 100) : ""
}
