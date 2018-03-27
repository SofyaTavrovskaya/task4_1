#!/bin/bash
exec 1>task4_1.out
echo "--- Hardware ---"
echo "CPU:" $(lscpu | grep "Model name" | cut -d : -f 2)
echo "RAM: " $(dmidecode -t memory | grep -i size | head -n 1 | cut -d : -f 2)
echo "Motherboard: " $(dmidecode -t 2 | grep "Product Name" | cut -d : -f 2)
echo "System Serial Number: " $(dmidecode -s system-serial-number)
echo "--- System ---"
echo "OS Distribution: " $(lsb_release -d | cut -d : -f 2)
echo "Kernel version:" $(uname -r)
echo "Installation date: " $(ls -alct /|tail -1|awk '{print $6, $7, $8}')
echo "Hostname:" $(hostname)
echo "Uptime: " $(uptime -p| awk -F'( |,)' '{print $2, $3}')
echo "Processes running: " $(ps aux | wc -l)
echo "User logged in: " $(who | sort -k1,1 -u | wc -l)
echo "--- Network ---"
echo $(ip -o -a addr show|tr -s ' '| cut -d ' ' -f 2,4)

