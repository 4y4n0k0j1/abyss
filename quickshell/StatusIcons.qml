import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root

    property bool wide: false
    property real iconPx: 20

    spacing: AbyssSettings.contentGap

    TextMetrics {
        id: percentSample
        text: "100%"
        font.pixelSize: 13
        font.weight: Font.DemiBold
    }

    IconCapsule {
        Layout.alignment: Qt.AlignHCenter
        padding: AbyssSettings.capsulePadding

        // declared in row order for the wide layout, the second column items drop out of the narrow one
        GridLayout {
            columns: root.wide ? 2 : 1
            rowSpacing: AbyssSettings.iconGap
            columnSpacing: AbyssSettings.iconGap

            StatusIcon {
                Layout.alignment: Qt.AlignCenter
                name: "volume-high"
                size: root.iconPx
            }

            StatusIcon {
                visible: root.wide
                Layout.alignment: Qt.AlignCenter
                name: "mic"
                size: root.iconPx
            }

            StatusIcon {
                Layout.alignment: Qt.AlignCenter
                name: "wifi-full"
                size: root.iconPx
            }

            StatusIcon {
                visible: root.wide
                Layout.alignment: Qt.AlignCenter
                name: "airplane-mode"
                size: root.iconPx
            }

            StatusIcon {
                Layout.alignment: Qt.AlignCenter
                name: "bluetooth"
                size: root.iconPx
            }

            StatusIcon {
                visible: root.wide
                Layout.alignment: Qt.AlignCenter
                name: "clipboard"
                size: root.iconPx
            }

            BatteryIcon {
                id: battery
                Layout.alignment: Qt.AlignCenter
                iconPx: root.iconPx
                showPercent: false
            }

            Text {
                visible: root.wide
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: percentSample.advanceWidth
                horizontalAlignment: Text.AlignHCenter
                text: Math.round(battery.level * 100) + "%"
                color: battery.tone
                font.pixelSize: 13
                font.weight: Font.DemiBold
                opacity: battery.glow
            }
        }
    }

    // placeholder, the power menu comes later
    StatusIcon {
        Layout.alignment: root.wide ? Qt.AlignLeft : Qt.AlignHCenter
        Layout.leftMargin: root.wide ? AbyssSettings.capsulePadding : 0
        name: "power-eco"
        color: Theme.danger
        size: root.iconPx
    }
}
