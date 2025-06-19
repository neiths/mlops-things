#!/bin/bash

# Log file path
LOG_FILE="/var/log/syslog"

while true
do
    # Get hostname
    HOST=$(hostname)
    
    # Get Disk usage (%)
    DISK=$(df -h / | tail -1 | awk '{print $5}' | cut -d'%' -f1)
    
    # Get CPU usage (% idle -> used = 100 - idle)
    CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')
    CPU_USAGE=$(echo "100 - $CPU_IDLE" | bc)

    # Get current timestamp
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    
    echo "============================"
    echo "[$TIMESTAMP] System Status on $HOST"
    
    # Check Disk usage
    if [ $DISK -gt 80 ]; then
        echo "🚨 Disk Warning: Usage is $DISK% (Threshold: 80%)"
    else
        echo "✅ Disk OK: Usage is $DISK%"
    fi

    # Check CPU usage
    if [ $(echo "$CPU_USAGE > 90" | bc) -eq 1 ]; then
        echo "🚨 CPU Warning: Usage is ${CPU_USAGE}% (Threshold: 90%)"
    else
        echo "✅ CPU OK: Usage is ${CPU_USAGE}%"
    fi

    # Check log file existence
    if [ -f "$LOG_FILE" ]; then
        echo "✅ Log File Exists: $LOG_FILE"
    else
        echo "❌ Log File Not Found: $LOG_FILE"
    fi

    echo "============================"
    echo ""

    # Wait 2 seconds before next check
    sleep 2
done

