#!/bin/bash

# Biến
HOST=$(hostname)
DISK=$(df -h / | tail -1 | awk '{print $5}' | cut -d'%' -f1)
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')

# Kiểm tra disk
if [ $DISK -gt 80 ]; then
    echo "Cảnh báo: Disk usage trên $HOST vượt $DISK% (ngưỡng 80%)"
else
    echo "Disk trên $HOST ổn: $DISK%"
fi

# Kiểm tra CPU
if [ $(echo "$CPU > 90" | bc) -eq 1 ]; then
    echo "Cảnh báo: CPU usage trên $HOST vượt $CPU% (ngưỡng 90%)"
else
    echo "CPU trên $HOST ổn: $CPU%"
fi

# Kiểm tra file log tồn tại
LOG_FILE="/var/log/syslog"
if [ -f "$LOG_FILE" ]; then
    echo "File log $LOG_FILE tồn tại"
else
    echo "Không tìm thấy $LOG_FILE"
fi
