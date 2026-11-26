import Quickshell
import Quickshell.Wayland
import QtQuick

ShellRoot {
    PanelWindow {
        id: island

        anchors {
            left: true
        }
        margins {
            left: 16
        }

        implicitWidth: 40
        implicitHeight: 280

        color: "transparent"
        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.namespace: "abyss-island"

        Rectangle {
            anchors.fill: parent
            radius: Math.min(width, height) / 2
            color: Qt.rgba(0, 0, 0, 0.6)
        }
    }
}
