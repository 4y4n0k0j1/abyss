pragma Singleton

import Quickshell
import QtQuick

Singleton {
    function nameFor(code, day) {
        if (code === 0 || code === 1)
            return day ? "weather-day-clear" : "weather-night-clear"
        if (code === 2 || code === 3)
            return day ? "weather-cloudy" : "weather-night-cloudy"
        if (code === 45 || code === 48)
            return "weather-fog"
        if ((code >= 51 && code <= 57) || code === 61 || code === 80)
            return "weather-rain-light"
        if (code === 63 || code === 65 || code === 66 || code === 67 || code === 81 || code === 82 || code >= 95)
            return "weather-rain-heavy"
        return day ? "weather-cloudy" : "weather-night-cloudy"
    }
}
