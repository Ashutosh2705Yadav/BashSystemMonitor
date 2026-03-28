#!/bin/bash

LOG_FILE="system.log"

# Function: Header
print_header() {
  echo "-----------------------------"
  echo " DevOps System Monitor 🚀"
  echo "-----------------------------"
}

# Function: Date & Time
current_time() {
  echo "Time: $(date)"
}

# Function: CPU Usage
cpu_usage() {
  cpu=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | sed 's/%//')
  echo "CPU Usage: $cpu%"

  if [ "${cpu%.*}" -gt 80 ]; then
    echo "⚠️ High CPU usage!"
  fi
}

# Function: Memory Usage
memory_usage() {
  mem=$(vm_stat | grep "Pages active" | awk '{print $3}')
  echo "Memory Active Pages: $mem"
}

# Function: Disk Usage
disk_usage() {
  disk=$(df -h / | awk 'NR==2 {print $5}')
  echo "Disk Usage: $disk"
}

# Function: Save Logs
save_log() {
  echo "Logging data..."
  {
    print_header
    current_time
    cpu_usage
    memory_usage
    disk_usage
    echo ""
  } >>$LOG_FILE
}

# Main Execution
print_header
current_time
cpu_usage
memory_usage
disk_usage

echo ""
save_log
