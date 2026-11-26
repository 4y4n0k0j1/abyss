import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell.Services.UPower

ColumnLayout {
    id: root

    property bool showPercent: false
    property real textPx: 13

    readonly property var dev: UPower.displayDevice
    readonly property real level: Math.max(0, Math.min(1, dev ? dev.percentage : 0))
    readonly property bool charging: dev ? dev.state === UPowerDeviceState.Charging : false
    readonly property bool low: !charging && level <= AbyssSettings.batteryLowPercent / 100
    readonly property bool critical: !charging && level <= AbyssSettings.batteryCriticalPercent / 100
    readonly property bool pulsing: AbyssSettings.batteryPulse && (charging || critical)
    readonly property color tone: charging ? Theme.accent : (low ? Theme.danger : Theme.text)

    property real pulse: 1.0
    readonly property real glow: pulsing ? pulse : 1.0

    spacing: 6

    SequentialAnimation on pulse {
        loops: Animation.Infinite
        running: root.pulsing && root.visible

        NumberAnimation {
            to: 0.4
            duration: root.critical ? 450 : 1100
            easing.type: Easing.InOutSine
        }
        NumberAnimation {
            to: 1.0
            duration: root.critical ? 450 : 1100
            easing.type: Easing.InOutSine
        }
    }

    Shape {
        visible: root.charging
        Layout.alignment: Qt.AlignHCenter
        Layout.preferredWidth: 10
        Layout.preferredHeight: 16
        preferredRendererType: Shape.CurveRenderer
        opacity: root.glow

        ShapePath {
            fillColor: Theme.accent
            strokeColor: "transparent"
            PathSvg { path: "M 6 0 L 0 9 L 4.5 9 L 3 16 L 10 6 L 5.5 6 Z" }
        }
    }

    Rectangle {
        Layout.alignment: Qt.AlignHCenter
        Layout.preferredWidth: AbyssSettings.batteryBarWidth
        Layout.preferredHeight: AbyssSettings.batteryBarHeight
        radius: width / 2
        color: Theme.track

        Rectangle {
            anchors.bottom: parent.bottom
            width: parent.width
            height: Math.max(parent.width, parent.height * root.level)
            radius: width / 2
            color: root.tone
            opacity: root.glow

            Behavior on height {
                NumberAnimation {
                    duration: 400
                    easing.type: Easing.OutCubic
                }
            }
        }
    }

    Text {
        visible: root.showPercent
        Layout.alignment: Qt.AlignHCenter
        text: Math.round(root.level * 100) + "%"
        color: root.tone
        font.pixelSize: root.textPx
        font.weight: Font.DemiBold
        opacity: root.glow
    }
}
