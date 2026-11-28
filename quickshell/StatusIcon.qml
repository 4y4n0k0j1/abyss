import QtQuick

Item {
    id: root

    property string name: ""
    property color color: Theme.text
    property real size: 20

    signal clicked()

    implicitWidth: size
    implicitHeight: size

    AbyssIcon {
        anchors.fill: parent
        name: root.name
        color: root.color
        size: root.size
        scale: area.containsMouse ? 1.15 : 1.0

        Behavior on scale {
            NumberAnimation {
                duration: 120
                easing.type: Easing.OutCubic
            }
        }
    }

    MouseArea {
        id: area
        anchors.fill: parent
        // a few pixels bigger than the icon so it is easy to hit
        anchors.margins: -4
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}
