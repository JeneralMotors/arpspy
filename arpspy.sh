#!/bin/bash

if [ -e "macip.txt" ]; then
    rm macip.txt
fi

count=0
scan_interval=10

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Check if an IP address and total hosts are provided as parameters
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <IP_ADDRESS_BASE> <TOTAL_HOSTS>"
    exit 1
fi

ip_address_base="$1"
total_hosts="$2"

if ! [[ "$ip_address_base" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Error: Invalid IP address format. Usage: $0 <IP_ADDRESS_BASE> <TOTAL_HOSTS>"
    exit 1
fi

# Function to print progress bar
print_progress() {
    local progress=$1
    local length=$2
    local percent=$((progress * 100 / length))
    local bar_length=$((progress * 50 / length))

    echo -ne '['
    for ((i = 0; i < bar_length; i++)); do
        echo -ne '#'
    done

    for ((i = bar_length; i < 50; i++)); do
        echo -ne ' '
    done

    echo -ne "] ($percent%)\r"
}

tput civis
printf "\n${RED}Scan started.${NC}\n\n"

# Loop for each possible host
for ((ip=1; ip<=$total_hosts; ip++)); do
    arping -q -r -R -c 1 -W 0.01 -U -I eth0 "$ip_address_base.$ip" >> macip.txt
    ((count++))

    # Display the progress bar every 10 hosts
    if ((count % scan_interval == 0)); then
        print_progress "$count" "$total_hosts"
    fi
done

# Print final progress bar
print_progress "$total_hosts" "$total_hosts"
echo -ne '\n'

printf "\n${RED}Scan completed.${NC} Results saved in ${GREEN}macip.txt${NC}\n"

cat macip.txt

tput cnorm
