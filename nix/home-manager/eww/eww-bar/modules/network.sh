
# Проверяем интерфейсы через nmcli
STATUS=$(nmcli -t -f TYPE,STATE dev | grep "connected" | head -n 1)

if [[ -z "$STATUS" ]]; then
    echo '{"icon": "󰤮", "class": "disconnected", "name": "Offline"}'
    exit 0
fi

# Если есть ethernet
if [[ "$STATUS" == "ethernet:connected" ]]; then
    ICON="󰈀"
    CLASS="ethernet"
else
    # Если wifi, проверяем реальный интернет пингом
    if ping -c 1 1.1.1.1 > /dev/null 2>&1; then
        ICON="󰤨"
        CLASS="wifi"
    else
        ICON="󰤨!" # Иконка с восклицательным знаком (или 󰤫)
        CLASS="no-internet"
    fi
fi

echo "{\"icon\": \"$ICON\", \"class\": \"$CLASS\"}"
