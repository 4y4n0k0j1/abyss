pragma Singleton

import Quickshell
import QtQuick

Singleton {
    readonly property color text: "#f2f2f2"
    readonly property color accent: AbyssSettings.colorMode === "dynamic" ? dynamicAccent : AbyssSettings.accentColor

    // placeholder until the wallpaper color piece exists
    readonly property color dynamicAccent: AbyssSettings.accentColor
}
