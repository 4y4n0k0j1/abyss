import QtQuick
import QtQuick.Layouts

Item {
    id: root

    // children declared inside a capsule land in its column
    default property alias content: column.data

    property real gap: 8
    property real padding: 6

    implicitWidth: column.implicitWidth + padding * 2
    implicitHeight: column.implicitHeight + padding * 2

    Rectangle {
        anchors.fill: parent
        radius: Math.min(width, height) / 2
        color: Theme.capsule
    }

    ColumnLayout {
        id: column
        anchors.centerIn: parent
        spacing: root.gap
    }
}
