import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower

ColumnLayout {
    id: root

    property real iconPx: 20
    property bool showPercent: false
    property real textPx: 13

    readonly property var dev: UPower.displayDevice
    readonly property string mock: AbyssSettings.batteryDebug
    readonly property real realLevel: Math.max(0, Math.min(1, dev ? dev.percentage : 0))
    readonly property bool realCharging: dev ? dev.state === UPowerDeviceState.Charging : false

    readonly property real level: mock === "critical" ? 0.07 : (mock === "low" ? 0.18 : (mock === "charging" ? 0.5 : realLevel))
    readonly property bool charging: mock === "charging" || (mock === "" && realCharging)
    readonly property bool low: !charging && level <= AbyssSettings.batteryLowPercent / 100
    readonly property bool critical: !charging && level <= AbyssSettings.batteryCriticalPercent / 100
    readonly property bool pulsing: (charging && AbyssSettings.batteryChargePulse) || (critical && AbyssSettings.batteryPulse)
    readonly property color tone: charging ? Theme.accent : (low ? Theme.danger : Theme.text)
    readonly property string iconName: level >= AbyssSettings.batteryFullPercent / 100 ? "battery-full" : (level >= AbyssSettings.batteryMediumPercent / 100 ? "battery-medium" : "battery-low")

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

    AbyssIcon {
        Layout.alignment: Qt.AlignHCenter
        name: root.iconName
        size: root.iconPx
        color: root.tone
        opacity: root.glow
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
