import QtQuick
import Quickshell.Services.Mpris

import "../Styling"
import "../Helpers/Prefixer.js" as Prefixer
import "../Helpers/Slicer.js" as Slicer

StyledText {
  property var player: Mpris.players.values[0]

  text: {
    if (!player)
      return "";

    const pre = player.isPlaying ? "Now playing" : "Paused";

    const artist = Slicer.sliceAndDot(player.trackArtist, 30);
    const title = Slicer.sliceAndDot(player.trackTitle, 30);

    return Prefixer.pre(pre, `${artist} - ${title}`);
  }

  MouseArea {
    anchors.fill: parent
    onClicked: parent.player.playbackState = parent.player.isPlaying ? MprisPlaybackState.Paused : MprisPlaybackState.Playing

    HoverHandler {
      cursorShape: Qt.PointingHandCursor
    }
  }
}
