# Network Scanner

This Bash script performs a simple network scan using ARP requests to discover MAC addresses and IP pairs within a specified IP address range.

## Usage

```bash
./arpspy.sh <IP_ADDRESS_BASE> <TOTAL_HOSTS>
```

## Dependencies

- **arping:** Make sure it is installed on your system.

## Features

- **Utilizes ARP Requests:** Discovers MAC addresses and IP pairs using ARP requests.
- **Progress Bar Display:** Provides a visual progress bar during the scan.
- **Results Saved:** The scan results are saved in a file named `macip.txt`.
