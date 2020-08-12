#!/bin/sh

mem()
{
   echo $(free --mebi | sed -n '2{p;q}' | awk '{printf ("🧠%2.2fGiB/%2.2fGiB\n", ( $3 / 1024), ($2 / 1024))}')
}

battery()
{
   BATT=$( acpi -b | sed 's/.*[charging|unknown], \([0-9]*\)%.*/\1/gi' )
   STATUS=$( acpi -b | sed 's/.*: \([a-zA-Z]*\),.*/\1/gi' )
   BATT_SYM=" "
   PLUG_SYM=""
   [[ $STATUS =~ Charg ]] && echo "$BATT $PLUG_SYM"|| echo "$BATT $BATT_SYM"
}

volume()
{
   echo $(amixer -D pulse sget Master | grep 'Left:' | awk -F'[][]' '{ print $2 }')
}

get_date()
{
   echo $(date +'%Y-%m-%d %H:%M:%S')
}

internet()
{
   # case $BLOCK_BUTTON in
   #    1) "$TERMINAL" -e nmtui; pkill -RTMIN+4 dwmblocks ;;
   #    3) notify-send "🌐 Internet module" "\- Click to connect
   #       📡: no wifi connection
   #       📶: wifi connection with quality
   #       ❎: no ethernet
   #       🌐: ethernet working
   #       " ;;
   #    6) "$TERMINAL" -e "$EDITOR" "$0" ;;
   # esac

   case "$(cat /sys/class/net/w*/operstate 2>/dev/null)" in
      down) wifiicon="📡 " ;;
      up) wifiicon="$(awk '/^\s*w/ { print "📶", int($3 * 100 / 70) "% " }' /proc/net/wireless)" ;;
   esac

   printf "%s%s\n" "$wifiicon" "$(sed "s/down/❎/;s/up/🌐/" /sys/class/net/e*/operstate 2>/dev/null)"

}

## TODO 
#  make every instance call function which
#  contains updated values for xsetroot

CURR_INSTANCE=$(pgrep -n "statusbar.sh")
OLD_INSTANCE=$(pgrep "statusbar.sh")
[[ $CURR_INSTANCE == $OLD_INSTANCE ]] || kill $OLD_INSTANCE && echo "no instance detected!"

while true; do
   xsetroot -name " $(volume) | $(mem) | $(internet) | $(battery) | $(get_date)"
sleep 1
done &

