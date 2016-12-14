#!/bin/bash

# Main script. Run this script as root to activate reverseshell detection
# Benji Shear - 14/12/16

# Import bash script functions
. /home/msfadmin/functions.sh

# Clear previous log files
:> keystrokes.log
:> rawkey.txt

echo "Reverse shell detection is active"
echo "..."
echo "..."
echo "..."

# Function to check for existence of reverse shell. Runs as infinite loop till detection
detect_reverse_shell

# Trace system calls related to 'read' (input from RS) for the RS process ID
strace -p$shell_pid -o rawkey.txt -e trace=read & > /dev/null

# Track all keystrokes from RS till process terminated
process_on="null"
while [ "$process_on" != "" ] ; do
	
	# Function to log key strokes
	keylogger $shell_pid
	
	# Check inbox for command to terminate RS process
	detect_email_command $shell_pid
	
done
