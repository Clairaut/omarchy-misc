import QtQuick
import qs.Ui

// One plugin holding small one-off widgets, chosen per layout entry by `mode`.
// The bar loads this file for every entry, so the two things the bar host needs
// have to be here rather than in the file this loads: injectProps() (Bar.qml)
// writes bar/moduleName/settings into this item only, and the slot reads
// implicitWidth/Height off it.
BarWidget {
  id: root
  moduleName: "clairaut.misc"

  readonly property string mode: setting("mode", "divider")
  readonly property var modes: ({ "divider": "Divider.qml" })

  implicitWidth: view.item ? view.item.implicitWidth : 0
  implicitHeight: view.item ? view.item.implicitHeight : 0

  // Adding a widget later is a new file here plus one line in `modes`, with no
  // new repo and no `omarchy plugin add` on machines that already have this one.
  Loader {
    id: view
    anchors.fill: parent
    source: Qt.resolvedUrl(root.modes[root.mode] || root.modes["divider"])
  }

  // injectProps() reaches this file only, and runs again on a later tick, so
  // bind these downward instead of assigning once in onLoaded.
  Binding { target: view.item; property: "bar";        value: root.bar;        when: view.item }
  Binding { target: view.item; property: "settings";   value: root.settings;   when: view.item }
  Binding { target: view.item; property: "moduleName"; value: root.moduleName; when: view.item }
  Binding { target: view.item; property: "host";       value: root;            when: view.item }
}
