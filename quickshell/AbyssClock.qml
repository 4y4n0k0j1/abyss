pragma Singleton

import Quickshell
import QtQuick

Singleton {
    readonly property var now: clock.date

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
