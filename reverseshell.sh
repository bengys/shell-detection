#!/bin/bash
. /home/msfadmin/functions.sh
:> keystrokes.log
:> rawkey.txt


detect_reverse_shell
strace -p$shell_pid -o rawkey.txt -e trace=read & > /dev/null
process_on="null"
while [ "$process_on" != "" ] ; do
	keylogger $shell_pid
	detect_email_command $shell_pid
done
echo "DONE"
