import socket
import subprocess
#from energenie import switch_on, switch_off

plug = 1

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

s.bind(('',8000))

def switch_on(plug):
    subprocess.call("sudo heyu on " + plug, shell= True)

def switch_off(plug):
    subprocess.call("sudo heyu off " + plug, shell=True)

s.listen(5)

while True:
#    try:
#    while True:
	conn, addr = s.accept()

	data = conn.recv(1024)
	data = data.split(' ')
	print data
	if data[0] == "on":
		switch_on(data[1])
	elif data[0] == "off":
		switch_off(data[1])
	else:
		pass

	conn.close()
#     except:
#         s.shutdown(1)
#         s.close()
#         break
