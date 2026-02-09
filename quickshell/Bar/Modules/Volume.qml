import QtQuick
import Quickshell.Services.Pipewire

import "../Styling"
import "../Helpers/Prefixer.js" as Prefixer

StyledText {
  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }

  property var sink: Pipewire.defaultAudioSink

  text: {
    const pre = Prefixer.create("Volume");

    if (!sink || !sink.ready)
      return pre("....%");
    if (sink.audio.muted)
      return pre("muted");

    return pre(Math.floor(Pipewire.defaultAudioSink.audio.volume * 100) + "%");
  }

  MouseArea {
    property var scrollStep: 0.02
    property var scrollCap: 1

    anchors.fill: parent
    onWheel: function (wheel) {
      const step = wheel.angleDelta.y < 0 ? -scrollStep : scrollStep;
      parent.sink.audio.volume = Math.min(parent.sink.audio.volume + step, scrollCap);
    }
  }
}
