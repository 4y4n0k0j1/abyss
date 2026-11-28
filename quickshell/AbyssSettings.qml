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
    property alias locationQuery: adapter.locationQuery
    property alias ipFallback: adapter.ipFallback
    property alias temperatureUnit: adapter.temperatureUnit
    property alias weatherRefreshMinutes: adapter.weatherRefreshMinutes
    property alias barWeatherPx: adapter.barWeatherPx
    property alias batteryFullPercent: adapter.batteryFullPercent
    property alias batteryMediumPercent: adapter.batteryMediumPercent
    property alias batteryChargePulse: adapter.batteryChargePulse
    property alias pillIconPx: adapter.pillIconPx
    property alias barIconPx: adapter.barIconPx
    property alias batteryDebug: adapter.batteryDebug
    property alias iconGap: adapter.iconGap
    property alias capsulePadding: adapter.capsulePadding
    property alias capsuleOpacity: adapter.capsuleOpacity
    property alias capsuleRadius: adapter.capsuleRadius

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
            property string locationQuery: "Lilongwe"
            property bool ipFallback: true
            property string temperatureUnit: "celsius"
            property int weatherRefreshMinutes: 15
            property int barWeatherPx: 26
            property int batteryFullPercent: 60
            property int batteryMediumPercent: 25
            property bool batteryChargePulse: true
            property int pillIconPx: 20
            property int barIconPx: 26
            property string batteryDebug: ""
            property int iconGap: 8
            property int capsulePadding: 6
            property real capsuleOpacity: 0.08
            property int capsuleRadius: 18
        }
    }
}
