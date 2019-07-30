 #!/bin/bash

while true
    do
        current_battery_level=`system_profiler SPPowerDataType | awk '/Charge Remaining /' | tr -cd [:digit:]`
        max_battery_level=`system_profiler SPPowerDataType | awk '/Full Charge Capacity /' | tr -cd [:digit:]`
        let battery_percentage="$current_battery_level * 100 / $max_battery_level"

        Charging=`system_profiler SPPowerDataType | awk '/Charging/'`

        while [[ $Charging == *"Yes"* ]] && [[ $battery_percentage -ge 80 ]]; do
            osascript -e 'display notification "Battery charging above 80%!" with title "Unplug Adapters"'
            sleep 10
            Charging=`system_profiler SPPowerDataType | awk '/Charging/'`
        done

        while [[ $Charging == *"No"* ]] && [[ $battery_percentage -le 40 ]]; do
            osascript -e 'display notification "Battery charging below 40%!" with title "Plugin Adapter"'
            sleep 10
            Charging=`system_profiler SPPowerDataType | awk '/Charging/'`
        done
    done