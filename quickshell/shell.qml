import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Effects

ShellRoot {
    PanelWindow {
        id: island

        readonly property int pad: AbyssSettings.fadeWidth * 2

        anchors {
            left: true
        }
        margins {
            left: Math.max(0, AbyssSettings.edgeGap - pad)
        }

        implicitWidth: AbyssSettings.pillWidth + pad * 2
        implicitHeight: AbyssSettings.pillHeight + pad * 2

        color: "transparent"
        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.namespace: "abyss-island"
        mask: Region { item: hitbox }

        Item {
            id: hitbox
            anchors.centerIn: parent
            width: AbyssSettings.pillWidth
            height: AbyssSettings.pillHeight
        }

        Item {
            id: shape
            anchors.fill: parent
            visible: false

            Rectangle {
                anchors.centerIn: parent
                width: AbyssSettings.pillWidth
                height: AbyssSettings.pillHeight
                radius: Math.min(width, height) / 2
                color: "black"
            }
        }

        MultiEffect {
            anchors.fill: parent
            source: shape
            blurEnabled: true
            blurMax: 64
            blur: Math.min(1, AbyssSettings.fadeWidth / 64)
            opacity: AbyssSettings.opacity
        }
    }
}
