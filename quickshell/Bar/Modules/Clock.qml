import QtQuick
import Quickshell

import "../Styling"

StyledText {
  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }

  text: Qt.formatDateTime(clock.date, "hh:mm AP")
}
