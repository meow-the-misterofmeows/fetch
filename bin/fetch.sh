#!/usr/bin/env bash

wm() {
  if [ -n "$WAYLAND_DISPLAY" ]; then
    echo "${XDG_CURRENT_DESKTOP:-Unknown}"
  elif [ -n "$DISPLAY" ]; then
    local root
    root=$(xprop -root _NET_SUPPORTING_WM_CHECK | awk '{print $NF}')
    local netWmName
    netWmName=$(xprop -id "$root" _NET_WM_NAME | awk '{print $NF}')
    echo " ${netWmName:-Unknown}"
  else
    echo "no wm detected :3"
  fi
}

col() {
  string="meow "
  modes="normal"
  colors=(0 1 2 3 4 5 6 7)
  declare -A ansi_codes
  ansi_codes=(
    [normal]=';3'
    [bright]=';9'
    [bold]=';1;3'
    [both]=';1;9'
  )

  for mode in ${modes}; do
    IFS=';' read -r bold bright <<<"${ansi_codes[$mode]}"

    colorstrip=""
    for color in "${colors[@]}"; do
      colorstrip+="\033[0${bold}${bright}${color}m${string}"
    done

    colorstrip+="\033[0m\n"
  done

  printf '%b' "$colorstrip"
}

fetch_base() {
  echo -e '(\ /)   \033[0;31mus\033[0m '"$(whoami)@$(hostname)"
  echo -e '( . .)  \033[0;35mos\033[0m '"$(lsb_release -i | awk -F: '{print $2}' | xargs)"
  echo -e 'c(")(") \033[0;94mwm\033[0m '"$(wm)"
}

# fetch start

fetch_base
echo
col
