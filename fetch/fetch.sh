#!/usr/bin/env bash

getWmInfo() {
    local WAYLAND_DISPLAY="$WAYLAND_DISPLAY"
    if [ -n "$WAYLAND_DISPLAY" ]; then
        local xdgDesktop="$XDG_CURRENT_DESKTOP"
        echo -e " ${xdgDesktop:-Unknown}"
    else
        local display=$(echo $DISPLAY)
        if [ -n "$display" ]; then
            local root=$(xprop -root _NET_SUPPORTING_WM_CHECK | awk -F' ' '{print $NF}')
            local netWmName=$(xprop -id $root _NET_WM_NAME | awk -F' ' '{print $NF}')

            if [ -n "$netWmName" ]; then
                echo -e " $netWmName"
            else
                echo -e " Unknown"
            fi
        else
            echo -e "\ Unknown"
        fi
    fi
}

bunnyfetch() {
    echo -e '(\ /)' '  \033[0;31mus\033[0m' "$(whoami)@$(hostname)"
    echo -e '( . .)' ' \033[0;35mos\033[0m' $(lsb_release -i | cut -f 2-)
    echo -e 'c(")(")' '\033[0;94mwm\033[0m' $(getWmInfo)
}

start() {
 
  bunnyfetch

  echo " "

  string="███"
  modes="normal"
  colors="0 1 2 3 4 5 6 7"

  for mode in ${modes}; do
	  case "${mode}" in
	  	normal) bold=''; bright='3';;
	  	bright) bold=''; bright='9';;
	  	bold) bold=';1'; bright='3';;
	  	both) bold=';1'; bright='9';;
	  esac

  	spectrum_ansi=''

	  for color in ${colors}; do
	  	colorstrip="${colorstrip}\033[0${bold}${spectrum_ansi};${bright}${color}m${string}"
  		[ -n "${transition}" ] && spectrum_ansi=";$(( bright + 1 ))${color}"
  	done

	colorstrip="${colorstrip}\033[0m\n"
  done

printf '%b' "$colorstrip"

}

start
