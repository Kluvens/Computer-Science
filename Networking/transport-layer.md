Transport layer provides logical communication between application processes running on different hosts (end systems).

Two principal Internet transport protocols:
1. TCP: provides reliable, in-order delivery, congestion control, flow control and connection setup
2. UDP: provides unreliable and unordered delivery, it's an extension of best-effort IP

The sender is passed an application-layer message, it then determines segment header fields values, create the segment and finally pass it to IP.

The receiver receives segment from IP, checks header values, extracts appliation-layer message and finally demultiplexes message up to application via socket.

## Multiplexing and Demultiplexing
Multiplexing at sender handles data from multiple sockets and add transport header sending to different clients.

Demultiplexing at receiver uses header information from different clients to deliver received segments to correct socket.

For example, we have two processes running on the server, when sending some data to clients, both of them using the same transport layer, this is referred to as multiplexing.
Even though they come from the same sender, they will finally go to different destinations by using the same transport layer.

When the data come back, they need to be chained to the right process.

Connectless means they don't have to maintain the state of connection.

A single socket for two clients.

In connection-oriented demultiplexing, different sockets in the server are responsible for different clients.

With connection-oriented protocols, we can create multiple connections and we can open multiple sockets in the server so that each of these processes can have its own end-to-end connection.
This explains why we can have many windows in our desktop at the same time.

TCP socket identified by 4-tuple:
- source IP address
- source port number
- destination IP address
- destination port number

UDP demultiplexing uses destination IP and port number

TCP demultiplexing uses source and destination IP address and its port numbers

Remember that in TCP there's always a welcoming socket.

In the destination, the port number is the same but the socket number is different.

All the TCP sockets at the server have the same server-side port number when many clients are cimmultaneously communicating with a traditional TCP web server.

Different sockets can share the same port.
