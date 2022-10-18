## Transport-layer services
Transport services and protocols
- transport layer usually executing within the OS kernel
- provides logical communication between application processes running on different hosts (end systems)
- transport protocols actions in end systems:
  - sender: breaks application messages into segments, passes to network layer
  - receiver: reassembles segments into messages, passes to application layer
- two transport protocols available to Internet applications:
  1. TCP: provides reliable, in-order delivery, congestion control, flow control and connection setup
  2. UDP: provides unreliable and unordered delivery, it's an extension of best-effort IP
- The sender is passed an application-layer message, it then determines segment header fields values, create the segment and finally pass it to IP.
- The receiver receives segment from IP, checks header values, extracts appliation-layer message and finally demultiplexes message up to application via socket.

## Multiplexing and Demultiplexing
Multiplexing/demultiplexing:
- Multiplexing at sender handles data from multiple sockets and add transport header sending to different clients.
- Demultiplexing at receiver uses header information from different clients to deliver received segments to correct socket.

How demultiplexing works:
- host receives IP datagrams
  - each datagram has source IP address, destination IP address
  - each datagram carries one transport-layer segment
  - each segment has source, destination port number
- host uses IP addresses and port numbers to direct segment to appropriate socket

Connectionless demultiplexing (UDP):
- when creating datagram to send into UDP socket, must specify distination IP address and destination port number
- when receiving host receives UDP segment, checks destination port number in segment and directs UDP segment to socket with that port number
- in UDP, different source IP addresses and/or source port numbers will be directed to same socket at receiving host

Connection-oriented demultiplexing (TCP):
- TCP socket identified by 4-tuple:
  - source IP address
  - source port number
  - destination IP address
  - destination port number
- demultiplexing: receiver uses all four values to direct segment to appropriate socket
- server may support many simultaneous TCP sockets:
  - each socket identified by its own 4-tuple
  - each socket associated with a different connecting client
- there's a welcoming socket that all commmunications first go to it, and then each socket for each request
- also needs TCP handshake for the establishing connection, where client and server agree on sequence numbers to prevent packet lost

Summary for this part:
- multiplexing, demultiplexing: based on segment, datagram header field values
- UDP: demultiplexing using destination IP and port number
- TCP: demultiplexing using 4-tuple: source and destination IP addresses, and port numbers
- multiplexing and demultiplexing happen at all layers

For example, we have two processes running on the server, when sending some data to clients, both of them using the same transport layer, this is referred to as multiplexing.
Even though they come from the same sender, they will finally go to different destinations by using the same transport layer.

When the data come back, they need to be chained to the right process.

Connectless means they don't have to maintain the state of connection.

A single socket for two clients.

In connection-oriented demultiplexing, different sockets in the server are responsible for different clients.

With connection-oriented protocols, we can create multiple connections and we can open multiple sockets in the server so that each of these processes can have its own end-to-end connection.
This explains why we can have many windows in our desktop at the same time.

UDP demultiplexing uses destination IP and port number

TCP demultiplexing uses source and destination IP address and its port numbers

Remember that in TCP there's always a welcoming socket.

In the destination, the port number is the same but the socket number is different.

All the TCP sockets at the server have the same server-side port number when many clients are cimmultaneously communicating with a traditional TCP web server.

Different sockets can share the same port.
