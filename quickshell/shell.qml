import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

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

        readonly property real basePillW: Math.round(Math.max(AbyssSettings.pillWidth, pillClock.timeWidth + 2 * (AbyssSettings.fadeWidth + AbyssSettings.contentPadding)))
        readonly property real barW: Math.round(basePillW * AbyssSettings.barWidthFactor)
        readonly property real growth: 1 + (AbyssSettings.hoverScale - 1) * hover
        readonly property real pillW: basePillW * growth
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

            ColumnLayout {
                id: pillContent
                anchors.centerIn: parent
                spacing: AbyssSettings.contentGap
                opacity: 1 - Math.min(1, island.expand * 3)
                visible: opacity > 0

                ClockColumn {
                    id: pillClock
                    Layout.alignment: Qt.AlignHCenter
                    timePx: AbyssSettings.pillClockPx
                    showDate: false
                }

                BatteryBar {
                    Layout.alignment: Qt.AlignHCenter
                    showPercent: false
                }
            }

            ColumnLayout {
                id: barContent
                x: (AbyssSettings.barContentWidth - width) / 2
                anchors.verticalCenter: parent.verticalCenter
                spacing: AbyssSettings.contentGap * 2
                opacity: Math.max(0, Math.min(1, (island.expand - 0.6) / 0.4))
                visible: opacity > 0

                ClockColumn {
                    Layout.alignment: Qt.AlignHCenter
                    timePx: AbyssSettings.barClockPx
                    showDate: true
                }

                BatteryBar {
                    Layout.alignment: Qt.AlignHCenter
                    showPercent: true
                }
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
