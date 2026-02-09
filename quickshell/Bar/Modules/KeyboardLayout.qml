import QtQuick
import Quickshell.Io

import "../Styling"
import "../Helpers/Prefixer.js" as Prefixer

StyledText {
  id: keyboardLayoutModule

  property var layout: "English (US)"
  text: Prefixer.pre("Lang", layout)

  Process {
    id: keyboardLayoutProc

    command: ["swaymsg", "-t", "get_inputs", "-r"]
    running: true

    stdout: StdioCollector {
      onStreamFinished: function () {
        const ret = JSON.parse(this.text);
        const firstKeyboard = ret.find(ret => ret.type == "keyboard");
        keyboardLayoutModule.layout = firstKeyboard.xkb_active_layout_name;
      }
    }
  }

  Timer {
    interval: 100
    running: true
    repeat: true

    onTriggered: keyboardLayoutProc.running = true
  }
}
