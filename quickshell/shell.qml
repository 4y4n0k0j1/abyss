import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

ShellRoot {
    // lets a mango keybind drive the bar: qs -c abyss ipc call island toggle
    IpcHandler {
        target: "island"

        function toggle(): void {
            island.pinned = !island.pinned
        }

        function open(): void {
            island.pinned = true
        }

        function close(): void {
            island.pinned = false
        }
    }

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

        property real hover: (hoverTracker.hovered && !pinned) ? 1.0 : 0.0
        Behavior on hover {
            NumberAnimation {
                duration: 250
                easing.type: Easing.OutCubic
            }
        }

        readonly property real contentW: Math.max(pillClock.timeWidth, pillWeather.sampleWidth, AbyssSettings.pillIconPx)

        // never narrower than the content plus both fade zones, so nothing overflows the solid core
        readonly property real basePillW: Math.round(Math.max(AbyssSettings.pillWidth, contentW + 2 * (AbyssSettings.fadeWidth + AbyssSettings.contentPadding)))
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

        // only the visible shape takes mouse input, the rest of the window is click-through
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

            // passive on purpose, so clicks still reach the clock and the icons
            HoverHandler {
                id: hoverTracker
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
                    onClicked: island.pinned = !island.pinned
                }

                WeatherReadout {
                    id: pillWeather
                    Layout.alignment: Qt.AlignHCenter
                    iconPx: AbyssSettings.pillIconPx
                    showTemp: false
                    showDetails: false
                }

                BatteryIcon {
                    Layout.alignment: Qt.AlignHCenter
                    iconPx: AbyssSettings.pillIconPx
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
                    onClicked: island.pinned = !island.pinned
                }

                WeatherReadout {
                    Layout.alignment: Qt.AlignHCenter
                    iconPx: AbyssSettings.barIconPx
                    showTemp: true
                    tempPx: AbyssSettings.barWeatherPx
                    showDetails: true
                    detailWidth: AbyssSettings.barContentWidth - 8
                }

                BatteryIcon {
                    Layout.alignment: Qt.AlignHCenter
                    iconPx: AbyssSettings.barIconPx
                    showPercent: true
                }
            }
        }
    }
}
