import QtQuick
import Quickshell.Services.UPower

import "../Styling"
import "../Helpers/Prefixer.js" as Prefixer

StyledText {
  property var device: UPower.displayDevice

  property var plugged: [UPowerDeviceState.FullyCharged, UPowerDeviceState.Charging].includes(device.state)
  property var percentage: Math.round(device.percentage * 100)

  text: Prefixer.pre("Battery", percentage + "%" + (plugged ? "*" : ""))
}
