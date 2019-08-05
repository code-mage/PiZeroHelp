import smtplib, ssl

port = 465  # For SSL
password = "password"

message = """From: Monitoring Alert <a@gmail.com>
To: B <b@gmail.com>
Subject: Help Alert

The device has detected a call for help. 
Please verify!
If this was a false alarm, reply to this mail, and I'll attempt to modify the code.
"""

# Create a secure SSL context
context = ssl.create_default_context()

with smtplib.SMTP_SSL("smtp.gmail.com", port, context=context) as server:
	server.login("a@gmail.com", password)
	sender_email = "a@gmail.com"
	receiver_email = ["b@gmail.com","c@gmail.com"]
	server.sendmail(sender_email, receiver_email, message)
