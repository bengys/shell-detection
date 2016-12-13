#!/bin/bash
function keylogger(){ 
			process_on="$(ps -A | grep $1)"
			if [ -s rawkey.txt ] ; then
				python -c "import rs; rs.parse_rawkeys();"
			fi
}

function detect_reverse_shell(){
	shell_detected=false
	while [ "$shell_detected" != true ] ; do	
		shell_pid="$(lsof -i | grep -w -e 'bash' -e 'sh' | awk '{print $2}'| head -n1 )"	
		if [ "$shell_pid" != ""  ] ; then
			shell_detected=true
			echo $shell_pid
			remote_IP="$(lsof -i| grep $shell_pid| awk '{print $8}'| head -n1| sed -n -e 's/^.*->//p' )"
			echo $remote_IP
			python -c "import email;email.email_alert('$remote_IP')"
		fi
	done
}

function detect_email_command(){
	em_content="$(python -c "import email;email.check_email();")"	
	if [ "$em_content" = "YES" ] ; then
		kill $shell_pid
		echo "Reverse shell session has been killed"
	fi	
}
