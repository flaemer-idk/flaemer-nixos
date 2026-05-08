#!/bin/sh

# Получаем имя текущей сети
SSID=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)

if [ -z "$SSID" ]; then
    # Если Wi-Fi не подключен, проверяем провод (Ethernet)
    ETH_STATUS=$(nmcli device status | grep "^eth0" | awk '{print $3}')
    if [ "$ETH_STATUS" = "connected" ]; then
        echo "{\"icon\": \"󰈀\", \"name\": \"Ethernet\"}"
    else
        echo "{\"icon\": \"󰤮\", \"name\": \"Disconnected\"}"
    fi
else
    # Если Wi-Fi подключен, выбираем иконку по уровню сигнала
    SIGNAL=$(nmcli -f IN-USE,SIGNAL dev wifi | grep '*' | awk '{print $2}')
    
    if [ "$SIGNAL" -gt 75 ]; then icon="󰤨";
    elif [ "$SIGNAL" -gt 50 ]; then icon="󰤥";
    elif [ "$SIGNAL" -gt 25 ]; then icon="󰤢";
    else icon="󰤟"; fi

    echo "{\"icon\": \"$icon\"}"
fi
