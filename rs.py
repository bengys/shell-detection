import os

def getPID():
	pid_file_reader = open("pids.txt",'r')
	pid_array = pid_file_reader.read().split('\n')
	rs_pid = pid_array[0]
	pid_file_reader.close()
	print(rs_pid)
	return rs_pid
	
def parse_keylog():
	rk_reader = open('rawkey.txt','w+')
	kl_reader = open('keylog.txt','w+')
	#list to store collection of lines
	keylog = []
	#list to store line
	line_buf = []
	for line in kl_reader.readlines():
		if(line[0:4] == 'read'):
			word=line.split("\"")[1]
			if  word != "\\n":
				line_buf.append(word)
			else:
				keylog.append(''.join(line_buf))
				line_buf[:] = []	
	keylog.append(''.join(line_buf))
	for line in keylog:
		print(line)		
	rk_reader.close()
	kl_reader.close()
