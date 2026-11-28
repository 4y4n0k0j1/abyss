import QtQuick
import QtQuick.Effects

Item {
    id: root

    property string name: ""
    property color color: Theme.text
    property real size: 20

    implicitWidth: size
    implicitHeight: size

    Behavior on color {
        ColorAnimation { duration: 250 }
    }

    Image {
        anchors.fill: parent
        source: root.name !== "" ? Qt.resolvedUrl("icons/" + root.name + ".svg") : ""
        sourceSize: Qt.size(root.size * 2, root.size * 2)
        fillMode: Image.PreserveAspectFit
        smooth: true
        mipmap: true
        asynchronous: true
        layer.enabled: true
        layer.effect: MultiEffect {
            colorization: 1.0
            colorizationColor: root.color
        }
    }
}
