#!/bin/sh

case $1 in
    "up")    command="-i 5 --allow-boost" ;;
    "down")  command="-d 5 --allow-boost" ;;
    "toggle") command="-t" ;; # Исправил опечатку toogle -> toggle
    *)       command="" ;;    # Дефолтный вариант всегда в конце
esac

[ -n "$command" ] && pamixer $command 
mute=$(pamixer --get-mute)
if [ "$mute" = "true" ]; then
      volume=""
      icon=""
else 
      volume="$(pamixer --get-volume)"
      if [ "$volume" -gt 75 ]; then
            icon=""
      elif [ "$volume" -gt 50 ]; then
            icon="󰕾"
      elif [ "$volume" -gt 25 ]; then 
            icon=""            
      elif [ "$volume" -gt 0 ]; then 
            icon=""
      else 
            icon=""
      fi
      volume="$volume%"
fi

echo "{\"content\": \"$volume\", \"icon\": \"$icon\"}"


