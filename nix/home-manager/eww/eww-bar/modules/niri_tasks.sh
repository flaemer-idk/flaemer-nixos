
# Получаем JSON окон от niri
WINDOWS=$(niri msg --json windows)

# Если окон нет, выходим
if [ "$WINDOWS" == "[]" ] || [ -z "$WINDOWS" ]; then
    echo "(box)"
    exit 0
fi

# Генерируем yuck-код. 
# Берем первую букву app_id или title и делаем кнопку.
echo "$WINDOWS" | jq -r '
  .[] | "(button :class \"task-entry\" :onclick \"niri msg action focus-window --id \(.id)\" :tooltip \"\(.title)\" \"\(.app_id // .title | .[0:1] | ascii_upcase)\")"
' | tr '\n' ' ' | sed 's/^/(box :orientation "v" :space-evenly false :spacing 10 /' | sed 's/$/)/'
