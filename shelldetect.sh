#!/bin/bash

# Main script. Run this script as root to activate shell detection and monitoring
# Benji Shear - 14/12/16

# Import bash script functions
. /home/msfadmin/functions.sh

# Clear previous log files
:> keystrokes.log
:> rawkey.txt

echo "Shell detection is active"
echo "..."
echo "..."
echo "..."

# Function to check for existence of reverse shell. Runs as infinite loop till detection
detect_shell

# Trace system calls related to 'read' for the shell process ID
strace -p$shell_pid -o rawkey.txt -e trace=read & > /dev/null

# Track all keystrokes from shell till process terminated
process_on="null"
while [ "$process_on" != "" ] ; do
	
	# Function to log key strokes
	keylogger $shell_pid
	
	# Check inbox for command to terminate shell process
	detect_email_command $shell_pid
	
done
