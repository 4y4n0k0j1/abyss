pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    property bool ready: false
    property real temperature: 0
    property int code: 0
    property string place: ""
    property bool isDay: true

    property real lat: 0
    property real lon: 0
    property bool located: false
    property int failures: 0
    property var request: null

    readonly property string condition: describe(code)

    function describe(c) {
        if (c === 0) return "Clear sky"
        if (c === 1) return "Mainly clear"
        if (c === 2) return "Partly cloudy"
        if (c === 3) return "Overcast"
        if (c === 45 || c === 48) return "Fog"
        if (c >= 51 && c <= 55) return "Drizzle"
        if (c === 56 || c === 57) return "Freezing drizzle"
        if (c === 61) return "Light rain"
        if (c === 63) return "Rain"
        if (c === 65) return "Heavy rain"
        if (c === 66 || c === 67) return "Freezing rain"
        if (c >= 71 && c <= 77) return "Snow"
        if (c >= 80 && c <= 82) return "Rain showers"
        if (c === 85 || c === 86) return "Snow showers"
        if (c === 95) return "Thunderstorm"
        if (c === 96 || c === 99) return "Thunderstorm and hail"
        return "Unknown"
    }

    function refreshMs() {
        return Math.max(5, AbyssSettings.weatherRefreshMinutes) * 60000
    }

    function getJson(url, onOk, onFail) {
        if (request) {
            request.onreadystatechange = null
            request.abort()
        }
        var xhr = new XMLHttpRequest()
        request = xhr
        timeout.restart()
        xhr.onreadystatechange = function () {
            if (xhr.readyState !== XMLHttpRequest.DONE)
                return
            timeout.stop()
            if (request === xhr)
                request = null
            if (xhr.status !== 200) {
                onFail("http " + xhr.status)
                return
            }
            var data
            try {
                data = JSON.parse(xhr.responseText)
            } catch (e) {
                onFail("bad json")
                return
            }
            onOk(data)
        }
        xhr.open("GET", url)
        xhr.send()
    }

    function setLocation(la, lo, name) {
        var a = Number(la)
        var o = Number(lo)
        if (!isFinite(a) || !isFinite(o) || Math.abs(a) > 90 || Math.abs(o) > 180)
            return false
        lat = a
        lon = o
        place = String(name || "")
        located = true
        return true
    }

    function resolveLocation() {
        var q = AbyssSettings.locationQuery.trim()
        if (q === "") {
            fallbackToIp()
            return
        }
        getJson("https://geocoding-api.open-meteo.com/v1/search?name=" + encodeURIComponent(q) + "&count=1&language=en&format=json",
            function (d) {
                var hit = (d.results && d.results.length > 0) ? d.results[0] : null
                if (hit && setLocation(hit.latitude, hit.longitude, hit.name))
                    fetchWeather()
                else
                    fallbackToIp()
            },
            function (why) {
                fallbackToIp()
            })
    }

    function fallbackToIp() {
        if (!AbyssSettings.ipFallback) {
            fail("no location and ip fallback is off")
            return
        }
        getJson("https://ipwho.is/",
            function (d) {
                if (d && d.success !== false && setLocation(d.latitude, d.longitude, d.city))
                    fetchWeather()
                else
                    fail("ip lookup returned nothing usable")
            },
            function (why) {
                fail("ip lookup " + why)
            })
    }

    function fetchWeather() {
        if (!located) {
            resolveLocation()
            return
        }
        var unit = AbyssSettings.temperatureUnit === "fahrenheit" ? "fahrenheit" : "celsius"
        var url = "https://api.open-meteo.com/v1/forecast?latitude=" + lat.toFixed(2)
            + "&longitude=" + lon.toFixed(2)
            + "&current=temperature_2m,weather_code,is_day"
            + "&timezone=auto"
            + "&temperature_unit=" + unit
        getJson(url,
            function (d) {
                var t = d.current ? Number(d.current.temperature_2m) : NaN
                var c = d.current ? Number(d.current.weather_code) : NaN
                if (!isFinite(t) || t < -100 || t > 150 || !isFinite(c)) {
                    fail("unusable weather values")
                    return
                }
                temperature = t
                isDay = !(d.current && Number(d.current.is_day) === 0)
                code = Math.max(0, Math.min(99, Math.round(c)))
                ready = true
                failures = 0
                retry.interval = refreshMs()
                retry.restart()
            },
            function (why) {
                fail(why)
            })
    }

    function fail(why) {
        failures += 1
        console.warn("abyss weather:", why)
        retry.interval = Math.min(300000, 60000 * Math.pow(2, failures - 1))
        retry.restart()
    }

    Timer {
        id: timeout
        interval: 10000
        onTriggered: if (root.request) root.request.abort()
    }

    Timer {
        id: retry
        onTriggered: root.fetchWeather()
    }

    Connections {
        target: AbyssSettings

        function onLocationQueryChanged() {
            root.located = false
            root.resolveLocation()
        }

        function onTemperatureUnitChanged() {
            root.fetchWeather()
        }
    }

    Component.onCompleted: resolveLocation()
}
