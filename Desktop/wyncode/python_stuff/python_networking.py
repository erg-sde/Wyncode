import socket
import threading

bind_ip = "localhost"
bind_port = 9999
server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

server.bind((bind_ip, bind_port))

server.listen(5)

print "[*] Listening on %s:%d" % (bind_ip, bind_port)

def handle_client(client_socket):
    request = client_socket.recv(1024)
    print "[*] Received: %s" % request
    client_socket.send("Ack!")
    client_socket.close()

while True:
    client, addr = server.accept()
    print "[*] Accepted connection from %s:%d" %(addr[0], addr[1])
    client_handler = threading.Thread(target=handle_client, args = (client))
    client_handler.start
    print(client_handler)
    # handle_client(client)

#################################################################################    

# import socket

# target_host = "127.0.0.1"
# target_port = 1024

# client = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

# client.sendto("AAABBB", (target_host, target_port))

# data, addr = client.recvfrom(4096)

# print data