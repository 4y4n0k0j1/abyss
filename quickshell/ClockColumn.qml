import QtQuick
import QtQuick.Layouts

Item {
    id: root

    property real timePx: 16
    property bool showDate: false
    readonly property real datePx: Math.max(9, timePx * 0.42)
    readonly property int timeWeight: Font.DemiBold

    // measured from a fixed sample so the pill width does not change with the digits
    readonly property real timeWidth: metrics.advanceWidth

    signal clicked()

    implicitWidth: column.implicitWidth
    implicitHeight: column.implicitHeight

    TextMetrics {
        id: metrics
        text: "00"
        font.pixelSize: root.timePx
        font.weight: root.timeWeight
    }

    ColumnLayout {
        id: column
        anchors.fill: parent
        spacing: Math.round(root.timePx * 0.05)

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

    MouseArea {
        anchors.fill: parent
        // a few pixels bigger than the text so the clock is easy to hit
        anchors.margins: -6
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}
