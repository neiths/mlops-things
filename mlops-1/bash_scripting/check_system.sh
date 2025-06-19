#!/bin/bash

HOST=$(hostname)
DISK=$(df -h / | tail -1 | awk '{print $5}')
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')

echo "Hostname: $HOST"
echo "Disk usage: $DISK"
echo "CPU usage: $CPU%"
