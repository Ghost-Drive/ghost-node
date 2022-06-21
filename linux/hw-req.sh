#!/bin/bash
echo -e "-------------------------------System Information----------------------------"
echo -e "Hostname:\t\t"`hostname`
echo -e "Manufacturer:\t\t"`sudo cat /sys/class/dmi/id/chassis_vendor`
echo -e "Product Name:\t\t"`sudo cat /sys/class/dmi/id/product_name`
echo -e "Version:\t\t"`sudo cat /sys/class/dmi/id/product_version`
echo -e "Machine Type:\t\t"`vserver=$(lscpu | grep Hypervisor | wc -l); if [ $vserver -gt 0 ]; then echo "VM"; else echo "Physical"; fi`
echo -e "Operating System:\t"`hostnamectl | grep "Operating System" | cut -d ' ' -f5-`
echo -e "Kernel:\t\t\t"`uname -r`
echo -e "Architecture:\t\t"`arch`
echo -e "System Main IP:\t\t"`hostname -I`

echo ""
echo -e "-------------------------------CPU/Memory-------------------------------"
echo -e "Processor Name:\t\t"`awk -F':' '/^model name/ {print $2}' /proc/cpuinfo | uniq | sed -e 's/^[ \t]*//'`
echo -e "Memory Total:\t"`free -mh | awk '/Mem/{printf$2}'`
echo -e "Swap Total:\t"`free -mh | awk '/Swap/{printf$2}'`

echo ""
echo -e "-------------------------------Disk-------------------------------"
echo -e "Manufacturer and Type"
lsblk -d -e 7 -o NAME,ROTA,DISC-MAX,MODEL
echo ""
echo -e "Size and Usage"
df -Ph



