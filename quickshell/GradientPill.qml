import QtQuick

ShaderEffect {
    property real fadeWidth: 12
    property real curve: 1.4
    property real coreAlpha: 1.0
    property real edgeAlpha: 0.0
    property real barMix: 0.0
    property vector2d pillSize: Qt.vector2d(width, height)

    fragmentShader: Qt.resolvedUrl("shaders/pill.frag.qsb")
}
