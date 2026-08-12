#!/usr/bin/env bash

set -euo pipefail

DIR="$HOME/.config/waybar"

reload_waybar() {
    killall -SIGUSR2 waybar
}

while true; do
    file=$(inotifywait -q \
        -e close_write,moved_to \
        --format '%f' \
        "$DIR")

    case "$file" in
        config.jsonc|style.css)
            reload_waybar
            ;;
    esac
done
