import QtQuick
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  // Set by the dispatcher; the host injects bar/settings/moduleName into it, not into this file.
  property var host: null

  // Tunable from the shell.json entry: gap either side, rule length as a fraction of the bar, and rule opacity
  readonly property int gap: Number(setting("gap", 10))
  readonly property real extent: Number(setting("extent", 0.55))
  readonly property real opacity_: Number(setting("alpha", 0.25))

  implicitWidth: vertical ? barSize : gap * 2 + 1
  implicitHeight: vertical ? gap * 2 + 1 : barSize

  Rectangle {
    anchors.centerIn: parent
    width: root.vertical ? Math.round(root.barSize * root.extent) : 1
    height: root.vertical ? 1 : Math.round(root.barSize * root.extent)
    color: Util.alpha(root.bar ? root.bar.barForeground : Color.bar.text, root.opacity_)
  }
}
