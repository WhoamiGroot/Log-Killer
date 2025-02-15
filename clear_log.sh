#!/bin/bash

# This script will clear all logs in the /var/log directory
# Caution: Only run this if you are sure you want to clear all log files

echo "Clearing all logs in /var/log..."

# Clear log files in /var/log (but exclude directories)
find /var/log -type f -exec truncate -s 0 {} \;

# Optionally remove specific log files like wtmp and btmp (login logs)
truncate -s 0 /var/log/wtmp
truncate -s 0 /var/log/btmp

# Clear journal logs (for systems using systemd)
if command -v journalctl &> /dev/null
then
    echo "Clearing systemd journal logs..."
    journalctl --vacuum-time=1s
    # Alternatively, you can use the following command to remove logs entirely:
    # journalctl --rotate
    # journalctl --vacuum-size=1M
fi

echo "Logs cleared."

