pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property alias fadeWidth: adapter.fadeWidth
    property alias pillWidth: adapter.pillWidth
    property alias pillHeight: adapter.pillHeight
    property alias edgeGap: adapter.edgeGap
    property alias coreOpacity: adapter.coreOpacity
    property alias edgeOpacity: adapter.edgeOpacity
    property alias gradientCurve: adapter.gradientCurve
    property alias barWidthFactor: adapter.barWidthFactor
    property alias hoverScale: adapter.hoverScale
    property alias hoverCurve: adapter.hoverCurve
    property alias animationMs: adapter.animationMs
    property alias pushWindows: adapter.pushWindows
    property alias pillClockPx: adapter.pillClockPx
    property alias barClockPx: adapter.barClockPx
    property alias barContentWidth: adapter.barContentWidth
    property alias colorMode: adapter.colorMode
    property alias accentColor: adapter.accentColor
    property alias contentPadding: adapter.contentPadding
    property alias contentGap: adapter.contentGap
    property alias batteryLowPercent: adapter.batteryLowPercent
    property alias batteryCriticalPercent: adapter.batteryCriticalPercent
    property alias batteryPulse: adapter.batteryPulse
    property alias batteryBarWidth: adapter.batteryBarWidth
    property alias batteryBarHeight: adapter.batteryBarHeight

    FileView {
        path: Quickshell.env("HOME") + "/.config/abyss/settings.json"
        blockLoading: true
        watchChanges: true
        onFileChanged: reload()

        JsonAdapter {
            id: adapter
            property int fadeWidth: 12
            property int pillWidth: 40
            property int pillHeight: 280
            property int edgeGap: 16
            property real coreOpacity: 1.0
            property real edgeOpacity: 0.0
            property real gradientCurve: 1.4
            property real barWidthFactor: 2.5
            property real hoverScale: 1.2
            property real hoverCurve: 0.9
            property int animationMs: 550
            property bool pushWindows: false
            property int pillClockPx: 16
            property int barClockPx: 30
            property int barContentWidth: 64
            property string colorMode: "fixed"
            property string accentColor: "#4da3ff"
            property int contentPadding: 4
            property int contentGap: 14
            property int batteryLowPercent: 20
            property int batteryCriticalPercent: 10
            property bool batteryPulse: true
            property int batteryBarWidth: 6
            property int batteryBarHeight: 56
        }
    }
}
