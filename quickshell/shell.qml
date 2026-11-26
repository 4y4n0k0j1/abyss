import Quickshell
import Quickshell.Wayland
import QtQuick

ShellRoot {
    PanelWindow {
        id: island

        property bool pinned: false

        property real expand: pinned ? 1.0 : 0.0
        Behavior on expand {
            NumberAnimation {
                duration: AbyssSettings.animationMs
                easing.type: Easing.InOutCubic
            }
        }

        property real hover: (mouse.containsMouse && !pinned) ? 1.0 : 0.0
        Behavior on hover {
            NumberAnimation {
                duration: 250
                easing.type: Easing.OutCubic
            }
        }

        readonly property real barW: AbyssSettings.pillWidth * AbyssSettings.barWidthFactor
        readonly property real growth: 1 + (AbyssSettings.hoverScale - 1) * hover
        readonly property real pillW: AbyssSettings.pillWidth * growth
        readonly property real pillH: AbyssSettings.pillHeight * growth

        anchors {
            left: true
            top: true
            bottom: true
        }

        implicitWidth: barW
        color: "transparent"
        exclusionMode: (AbyssSettings.pushWindows && pinned) ? ExclusionMode.Normal : ExclusionMode.Ignore
        exclusiveZone: barW
        WlrLayershell.namespace: "abyss-island"
        mask: Region { item: shape }

        Item {
            id: shape

            width: island.pillW + (island.barW - island.pillW) * island.expand
            height: island.pillH + (island.height - island.pillH) * island.expand
            x: AbyssSettings.edgeGap * (1 - island.expand)
            y: (island.height - height) / 2

            GradientPill {
                anchors.fill: parent
                fadeWidth: AbyssSettings.fadeWidth
                curve: AbyssSettings.gradientCurve + (AbyssSettings.hoverCurve - AbyssSettings.gradientCurve) * island.hover
                coreAlpha: AbyssSettings.coreOpacity
                edgeAlpha: AbyssSettings.edgeOpacity
                barMix: island.expand
            }

            ClockColumn {
                anchors.centerIn: parent
                timePx: AbyssSettings.pillClockPx
                showDate: false
                opacity: 1 - Math.min(1, island.expand * 3)
                visible: opacity > 0
            }

            ClockColumn {
                x: (AbyssSettings.barContentWidth - width) / 2
                anchors.verticalCenter: parent.verticalCenter
                timePx: AbyssSettings.barClockPx
                showDate: true
                opacity: Math.max(0, Math.min(1, (island.expand - 0.6) / 0.4))
                visible: opacity > 0
            }

            MouseArea {
                id: mouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: island.pinned = !island.pinned
            }
        }
    }
}
