import smtplib
import poplib
from email import parser

def email_alert(IP):
	server = smtplib.SMTP('smtp.gmail.com', 587)
	server.ehlo()
	server.starttls()
	server.login("reverseshelldetector@gmail.com", "niceandinsecurepassword")
	msg = "ATTENTION YOU! \n A potential reverse shell process has been detected on your beloved computer \n Dont stress too much! It is being monitored. \n The connection is from: " + IP + "\n To end the RS process reply to this message with YES in the subject line"
	server.sendmail("reverseshelldetector@gmail.com","bshear13@gmail.com", msg)
	server.quit()

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
