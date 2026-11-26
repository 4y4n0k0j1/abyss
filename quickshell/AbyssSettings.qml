pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property alias opacity: adapter.opacity
    property alias fadeWidth: adapter.fadeWidth
    property alias pillWidth: adapter.pillWidth
    property alias pillHeight: adapter.pillHeight
    property alias edgeGap: adapter.edgeGap

    FileView {
        path: Quickshell.env("HOME") + "/.config/abyss/settings.json"
        blockLoading: true
        watchChanges: true
        onFileChanged: reload()

        JsonAdapter {
            id: adapter
            property real opacity: 0.6
            property int fadeWidth: 24
            property int pillWidth: 40
            property int pillHeight: 280
            property int edgeGap: 16
        }
    }
}
