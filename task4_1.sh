#!/bin/bash
exec 1>task4_1.out
echo "--- Hardware ---"
echo "CPU:" $(lscpu | grep "Model name" | cut -d : -f 2)
echo "RAM:" $(dmidecode -t memory | grep -i size | head -n 1 | cut -d : -f 2)
MOTHERBOARD=$(dmidecode -s baseboard-manufacturer) $(dmidecode -s baseboard-product-name)
[[ -z $MOTHERBOARD ]]&&MOTHERBOARD=Unknown
echo "Motherboard:" $MOTHERBOARD
SERIAL=$(dmidecode -s system-serial-number)
[[ -z $SERIAL ]] && SERIAL=Unknown
echo "System Serial Number:" $SERIAL
echo "--- System ---"
echo "OS Distribution:" $(lsb_release -d | cut -d : -f 2)
echo "Kernel version:" $(uname -r)
echo "Installation date:" $(ls -alct /|tail -1|awk '{print $6, $7, $8}')
echo "Hostname:" $(hostname)
echo "Uptime:" $(uptime | awk -F'( |,|:)+' '{print $6,$7",",$8,"hours,",$9,"minutes"}')
echo "Processes running:" $(ps aux | wc -l)
echo "User logged in:" $(who | sort -k1,1 -u | wc -l)
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

