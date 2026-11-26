import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root

    property real timePx: 16
    property bool showDate: false
    readonly property real datePx: Math.max(9, timePx * 0.42)
    readonly property int timeWeight: Font.DemiBold
    readonly property real timeWidth: metrics.advanceWidth

    spacing: Math.round(timePx * 0.05)

    TextMetrics {
        id: metrics
        text: "00"
        font.pixelSize: root.timePx
        font.weight: root.timeWeight
    }

    Text {
        Layout.alignment: Qt.AlignHCenter
        text: Qt.formatDateTime(AbyssClock.now, "HH")
        color: Theme.text
        font.pixelSize: root.timePx
        font.weight: root.timeWeight
    }

    Text {
        Layout.alignment: Qt.AlignHCenter
        text: Qt.formatDateTime(AbyssClock.now, "mm")
        color: Theme.text
        font.pixelSize: root.timePx
        font.weight: root.timeWeight
    }

    Item {
        visible: root.showDate
        Layout.preferredHeight: root.timePx * 0.5
    }

    Text {
        visible: root.showDate
        Layout.alignment: Qt.AlignHCenter
        text: Qt.formatDateTime(AbyssClock.now, "ddd").toUpperCase()
        color: Theme.accent
        font.pixelSize: root.datePx
        font.weight: Font.Medium
    }

    Text {
        visible: root.showDate
        Layout.alignment: Qt.AlignHCenter
        text: Qt.formatDateTime(AbyssClock.now, "d")
        color: Theme.text
        font.pixelSize: root.datePx * 1.5
        font.weight: Font.DemiBold
    }

    Text {
        visible: root.showDate
        Layout.alignment: Qt.AlignHCenter
        text: Qt.formatDateTime(AbyssClock.now, "MMM").toUpperCase()
        color: Theme.accent
        font.pixelSize: root.datePx
        font.weight: Font.Medium
    }
}
