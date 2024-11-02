import os
import sys
import traceback
from dotenv import load_dotenv
from datetime import datetime, timedelta
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

load_dotenv()

sender_email = os.getenv('SENDER_EMAIL')
app_password = os.getenv('APP_PASSWORD')
receiver_email = os.getenv('RECEIVER_EMAIL')
pc_name = os.getenv('COMPUTERNAME')


action = sys.argv[1] if len(sys.argv) > 1 else "Power Down"
alert_timedelta = int(sys.argv[2]) if len(sys.argv) > 2 else 2

alert_time = datetime.now() + timedelta(minutes = alert_timedelta)
alert_time = alert_time.replace(microsecond=0).strftime("%H:%M:%S %Y-%m-%d")

msg = MIMEMultipart()
msg['From'] = sender_email
msg['To'] = receiver_email
msg['Subject'] = f"Alert: About to {action.lower()} - {pc_name} in {alert_timedelta} minutes" 

body = f"""
<html>
    <body>
        <p>Hello,</p>
        <p>The device <i>{pc_name}</i> is scheduled to <b>{action.lower()}</b> in approximately {alert_timedelta} minutes, at <b>{alert_time}</b>.</p>
        <p>Please save any ongoing work to prevent data loss before the scheduled action.</p>
        <br>
        <p>Thank you,<br>Command Palette</p>
    </body>
</html>
"""
msg.attach(MIMEText(body, 'html')) 

try:
    with smtplib.SMTP_SSL('smtp.gmail.com', 465, local_hostname="localhost") as server:
        server.login(sender_email, app_password)
        server.sendmail(sender_email, receiver_email, msg.as_string())
    print("Email sent!")

except Exception as e:
    print(f"Error: {e}")
    traceback.print_exc()
    sys.exit(1)
