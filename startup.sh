#!/bin/bash

# Display "Hello, Boss"
echo "Hello, Boss"

# Check WiFi connection
WIFI_STATUS=$(nmcli -t -f WIFI general)

if [ "$WIFI_STATUS" = "enabled" ]; then
    # Check if connected to any network
    CONNECTION_STATUS=$(nmcli -t -f STATE general)
    if [ "$CONNECTION_STATUS" = "connected" ]; then
        echo "WiFi is connected"
    else
        echo "WiFi is not connected"
    fi
else
    echo "WiFi is disabled"
fi
