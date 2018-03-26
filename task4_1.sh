#!/bin/bash
exec 1>task4_1.out
echo "--- Hardware ---"
echo "CPU:"; lscpu | grep "Model name" | cut -d : -f 2
echo "RAM: "; sudo dmidecode -t memory | grep -i size | head -n 1 | cut -d : -f 2
echo "Motherboard: "sudo dmidecode -t 2 | grep "Product Name" | cut -d : -f 2
echo "System Serial Number: "; sudo dmidecode -s system-serial-number
echo "--- System ---"
echo "OS Distribution: " lsb_release -d | cut -d : -f 2
echo "Kernel version:" $(uname -r)
echo "Installation date: " 
echo "Hostname:" $(hostname)
echo "Uptime: "
echo "Processes running: "
echo "User logged in: "
echo "--- Network ---"
for interface in $(ifconfig -l); do
            echo $interface
        done
