#!/usr/bin/env bash

# Commands
lock="  Lock"
logout="  Logout"
suspend="󰤄  Suspend"
hibernate="  Hibernate"
reboot="  Reboot"
shutdown="  Shutdown"

confirm() {
    local action="$1"

    local choice
    choice=$(printf "No\nYes" | rofi \
        -dmenu \
        -selected-row 0 \
        -theme ~/.config/rofi/confirm.rasi \
        -mesg "Are you sure you want to ${action}?" \
        -p "")

    [[ "$choice" == "Yes" ]]
}

chosen=$(printf "%s\n%s\n%s\n%s\n%s\n%s" \
    "$lock" \
    "$shutdown" \
    "$reboot" \
    "$suspend" \
    "$hibernate" \
    "$logout" \
| rofi \
    -dmenu \
    -i \
    -p "" \
    -theme ~/.config/rofi/nord-power.rasi)

case "$chosen" in
    "$lock")
        pidof hyprlock >/dev/null || hyprlock
        ;;

    "$logout")
	hyprctl dispatch 'hl.dsp.exit()'
        ;;

    "$suspend")
        systemctl suspend
        ;;

    "$hibernate")
        if confirm "hibernate"; then
            systemctl hibernate
        fi
        ;;

    "$reboot")
        if confirm "reboot"; then
            systemctl reboot
        fi
        ;;

    "$shutdown")
        if confirm "shutdown"; then
            systemctl poweroff
        fi
        ;;
esac
