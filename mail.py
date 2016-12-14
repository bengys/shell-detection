# Python module for email functionality
# Benji Shear - 14/12/16

import smtplib
import poplib
from email import parser

# Send email 
def send_email(msg):
	server = smtplib.SMTP('smtp.gmail.com', 587)
	server.ehlo()
	server.starttls()
	server.login("reverseshelldetector@gmail.com", "niceandinsecurepassword")
	server.sendmail("reverseshelldetector@gmail.com","bshear13@gmail.com", msg)
	server.quit()


# Alerts owner of RS with email
def email_alert(IP):
	msg = "ATTENTION YOU! \n A potential reverse shell process has been detected on your beloved computer \n Dont stress too much! It is being monitored. \n The connection is from: " + IP + "\n Reply to this messagage in the subject line with: \n END - to terminate shell \n LOG - to recieve an email with keystrokes"
	send_email(msg)

# Emails user with keystroke log	
def email_log():
	log_msg='The following keystrokes have been recorded:'
	file = open('keystrokes.log','r')
	for line in file :
		log_msg+= "\n" + line
	file.close()	
	send_email(log_msg)
	
# Checks for lastest email in inbox
def check_email():
	pop_conn = poplib.POP3_SSL('pop.gmail.com')
	pop_conn.user('reverseshelldetector@gmail.com')
	pop_conn.pass_('niceandinsecurepassword')
	#Get messages from server:
	messages = [pop_conn.retr(i) for i in range(1, len(pop_conn.list()[1]) + 1)]
	# Concat message pieces:
	messages = ["\n".join(mssg[1]) for mssg in messages]
	#Parse message intom an email object:	
	messages = [parser.Parser().parsestr(mssg) for mssg in messages]
	for message in messages:
		print message['subject']
	pop_conn.quit()
