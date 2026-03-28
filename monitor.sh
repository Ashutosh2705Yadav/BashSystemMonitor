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
    current_time#!/bin/bash

    # Default interval (seconds)
    INTERVAL=$1
    INTERVAL=${INTERVAL:-5}

    # Log file
    LOG_FILE="system.log"

    # Handle Ctrl+C
    trap "echo 'Exiting...'; exit" SIGINT

    # Check required commands
    check_dependencies() {
      for cmd in top df awk sed date; do
        if ! command -v $cmd &>/dev/null; then
          echo "Error: $cmd not found"
          exit 1
        fi
      done
    }

    # Print header
    print_header() {
      echo "=================================="
      echo " DevOps System Monitoring Tool"
      echo "=================================="
    }

    # Current time
    current_time() {
      echo "Time: $(date)"
    }

    # CPU usage (macOS compatible)
    cpu_usage() {
      cpu=$(top -l 1 | awk '/CPU usage/ {print $3}' | sed 's/%//')
      echo "CPU Usage: $cpu%"

      if [ "${cpu%.*}" -gt 80 ]; then
        echo "Warning: High CPU usage"
      fi
    }

    # Memory usage (macOS)
    memory_usage() {
      mem=$(vm_stat | awk '/Pages active/ {print $3}')
      echo "Active Memory Pages: $mem"
    }

    # Disk usage
    disk_usage() {
      disk=$(df -h / | awk 'NR==2 {print $5}')
      echo "Disk Usage: $disk"
    }

    # Save logs
    save_log() {
      timestamp=$(date "+%Y-%m-%d %H:%M:%S")
      echo "$timestamp | CPU: $cpu% | Disk: $disk" >>$LOG_FILE
    }

    # Help option
    if [ "$1" = "--help" ]; then
      echo "Usage: ./monitor.sh [interval_in_seconds]"
      echo "Example: ./monitor.sh 5"
      exit 0
    fi

    # Run dependency check
    check_dependencies

    # Main loop
    while true; do
      print_header
      current_time
      cpu_usage
      memory_usage
      disk_usage
      echo ""

      save_log

      sleep $INTERVAL
    done
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
