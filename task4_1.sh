#!/bin/bash
exec 1>task4_1.out
echo "--- Hardware ---"
echo "CPU:" $(lscpu | grep "Model name" | cut -d : -f 2)
echo "RAM:" $(dmidecode -t memory | grep -i size | head -n 1 | cut -d : -f 2)
MANUFACTURER=$(dmidecode -s baseboard-manufacturer)
MOTHERBOARD=$(dmidecode -s baseboard-product-name)
[[ -z $MOTHERBOARD ]]&&MOTHERBOARD=Unknown
[[ -z $MANUFACTURER ]]&&MANUFACTURER=Unknown
#if we have Unknown twice in answer, return only one Unknown
if [[ $MOTHERBOARD == "Unknown" && $MANUFACTURER=="Unknown" ]] ; then
echo "Motherboard: Unknown"
else 
echo "Motherboard:" $MANUFACTURER $MOTHERBOARD 
fi
SERIAL=$(dmidecode -s system-serial-number)
[[ -z $SERIAL ]] && SERIAL=Unknown
echo "System Serial Number:" $SERIAL
echo "--- System ---"
echo "OS Distribution:" $(lsb_release -d | cut -d : -f 2)
echo "Kernel version:" $(uname -r)
echo "Installation date:" $(ls -alct /|tail -1|awk '{print $6, $7, $8}')
echo "Hostname:" $(hostname -f)
echo "Uptime:" $(uptime -p | cut -d " " -f2-)
echo "Processes running:" $(ps aux | wc -l)
echo "User logged in:" $(users|wc -w)
echo "--- Network ---"
for interface in $(ls /sys/class/net); do
     # echo $interface
     is_up=$(ip -o addr show $interface | wc -l)
      # echo $is_up
     if ((is_up > 0)); then
         echo -e "$interface: \c"
     ip -o -4 -a addr show $interface|tr -s ' '| cut -d ' ' -f 4| paste -d',' -s|sed 's/,/, /'
         else
             echo "$interface: -"
             fi
         done

