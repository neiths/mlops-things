#!/bin/bash

# Biến
LOG_FILE="system_log.txt"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Ghi thông tin hệ thống vào log
echo "[$TIMESTAMP] Kiểm tra hệ thống" > $LOG_FILE
echo "Hostname: $(hostname)" >> $LOG_FILE
echo "Disk usage: $(df -h / | tail -1 | awk '{print $5}')" >> $LOG_FILE
echo "CPU usage: $(top -bn1 | grep "Cpu(s)" | awk '{print $2}')%" >> $LOG_FILE

# Kiểm tra và cảnh báo
DISK=$(df -h / | tail -1 | awk '{print $5}' | cut -d'%' -f1)
if [ $DISK -gt 80 ]; then
    echo "[$TIMESTAMP] Cảnh báo: Disk vượt $DISK% (ngưỡng 80%)" >> $LOG_FILE
fi

# Đọc và in log
echo "Nội dung log:"
cat $LOG_FILE
