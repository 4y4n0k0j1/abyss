import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root

    property real iconPx: 20
    property bool showTemp: false
    property real tempPx: 26
    property bool showDetails: false
    property real detailWidth: 56
    readonly property real detailPx: Math.max(9, tempPx * 0.45)
    readonly property int tempWeight: Font.DemiBold
    readonly property real sampleWidth: showTemp ? Math.max(iconPx, metrics.advanceWidth) : iconPx

    spacing: Math.round(iconPx * 0.3)

    // widest likely temperature, so the width does not change when the value does
    TextMetrics {
        id: metrics
        text: "-00°"
        font.pixelSize: root.tempPx
        font.weight: root.tempWeight
    }

    AbyssIcon {
        Layout.alignment: Qt.AlignHCenter
        name: AbyssWeather.ready ? WeatherIcons.nameFor(AbyssWeather.code, AbyssWeather.isDay) : "weather-cloudy"
        size: root.iconPx
        color: AbyssWeather.ready ? Theme.text : Theme.muted
    }

    Text {
        visible: root.showTemp
        Layout.alignment: Qt.AlignHCenter
        text: AbyssWeather.ready ? Math.round(AbyssWeather.temperature) + "°" : "--°"
        color: AbyssWeather.ready ? Theme.text : Theme.muted
        font.pixelSize: root.tempPx
        font.weight: root.tempWeight
    }

    Text {
        visible: root.showDetails && AbyssWeather.ready
        Layout.alignment: Qt.AlignHCenter
        Layout.preferredWidth: root.detailWidth
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
        text: AbyssWeather.condition
        color: Theme.accent
        font.pixelSize: root.detailPx
        font.weight: Font.Medium
    }
}
