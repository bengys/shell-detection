#!/bin/bash

# Bash script functions used by reverseshell.sh
# Benji Shear - 14/12/16

#=======================================================================

#Reads input from strace of the shell and isolates and formats the keystrokes from the reverse shell
function keylogger(){ 
			process_on="$(ps -A | grep $1)"
			
			#Check for new data
			if [ -s rawkey.txt ] ; then
				python -c "import rs; rs.parse_rawkeys();"
			fi
}

#=======================================================================

# Checks for a process that displays signs of being a RS and notifys the owner
function detect_reverse_shell(){
	shell_detected=false
	while [ "$shell_detected" != true ] ; do	
	
		#Check for a 'bash' or 'sh' shell that is connected to a remote internet adress. Gets the PID
		shell_pid="$(lsof -i | grep -w -e 'bash' -e 'sh' | awk '{print $2}'| head -n1 )"	
		
		# If a RS process has been detected
		if [ "$shell_pid" != ""  ] ; then
			shell_detected=true
			echo "A new reverse shell process has been detected with PID: $shell_pid"
			remote_IP="$(lsof -i| grep $shell_pid| awk '{print $8}'| head -n1| sed -n -e 's/^.*->//p' )"
			echo "From IP: $remote_IP"
			#Notify the user by email
			python -c "import mail;mail.email_alert('$remote_IP')"
		fi
	done
}

#=======================================================================

#Checks for a command from user by email to kill RS process
function detect_email_command(){
	#Check in box
	em_content="$(python -c "import mail;mail.check_email();")"	
	if [ "$em_content" = "YES" ] ; then
		kill $shell_pid
		echo "Reverse shell session has been killed"
	fi	
}
