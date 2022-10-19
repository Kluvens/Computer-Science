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
- different sockets can share the same port

Summary for this part:
- multiplexing, demultiplexing: based on segment, datagram header field values
- UDP: demultiplexing using destination IP and port number
- TCP: demultiplexing using 4-tuple: source and destination IP addresses, and port numbers
- multiplexing and demultiplexing happen at all layers

## Connectionless transport: UDP
UDP:
- best-effort service: UDP segments may be lost and delivered out-of-order to app
- connectonless:
  - no handshaking between UDP sender, receiver
  - each UDP segment handled independently of others

Then, why UDP?
- no connection establishment - faster
- simple: no connection state at sender and receiver
- small header size
- no congestion control

Applications that use UDP:
- steaming multimedia apps
- DNS
- SNMP (network management)
- HTTP/3
- gaming
- Routing updates (RIP)

UDP segment header:
- source port number
- destination port number
- length: in bytes of UDP segment including header
- checksum: to detect errors in transmitted segment, but this can't guarantee as two or more bits are changed and may result in the same
- application data (payload): data to/from application layer

Calculating checksum:
- adding two 16-bit integers: 1 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 + 1 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1
 -> 1 1 0 1 1 1 0 1 1 1 0 1 1 1 0 1 1
- wraparound the first number: 1 1 0 1 1 1 0 1 1 1 0 1 1 1 0 1 1 -> 1 0 1 1 1 0 1 1 1 0 1 1 1 1 0 0
- get the checksum: 1 0 1 1 1 0 1 1 1 0 1 1 1 1 0 0 -> 0 1 0 0 0 1 0 0 0 1 0 0 0 0 1 1

Summary for UDP:
- 'no frills' protocol:
  - segments may be lost, delivered out of order
  - best effort service: send and hope for the best
- UDP has its plusses:
  - no setup/handshaking needed
  - can function when network service is compromised
  - helps with reliability (checksum)
- build additional functionality on top of UDP in application layer (HTTP/3)

Reliable data transfer (RDT):
- rdt 1.0: reliable transfer over a reliable channel
  - underlying channel perfectly reliable
    - no bit errors
    - no loss of packets
  - nothing to do

![image](https://user-images.githubusercontent.com/95273765/196557570-f79ee0ba-01ad-4eaf-8401-332d55808632.png)

- rdt 2.0: channel with bit errors
  - underlying channel may flip bits in packet
    - checksum to detect bit errors
  - to recover from errors
    - acknowledgements (ACKs): receiver explicitly tells sender that packet received OK
    - negative acknowledgements (NAKs): receiver explicitly tells sender that packet had errors
    - sender retransmits packet on receipt of NAK
  - summary of new mechanisms in rdt2.0:
    - error detection
    - feedback: control messages (ACK, NAK) from receiver to sender
    - retransmission

![image](https://user-images.githubusercontent.com/95273765/196598479-718ea612-d430-4320-9869-cc066605247b.png)

rdt2.0 also has flaws:
- what happens if ACK/NAK corrupted
  - sender doesn't know what happened at receiver
  - can't just retransmit: possible duplicate
- handling duplicates:
  - sender retransmits current packet if ACK/NAK corrupted
  - sender adds sequence number to each packet
  - receiver discards duplicate packet

rdt2.1:
- sender
  - sequence number added to packet
  - two sequence numbers (0, 1) will suffice
  - must check if received ACK/NAK corrupted
  - twice as many states
    - state must remember whether expected packet should have sequence number of 0 or 1
- receiver
  - must check if received packet is duplicate
    - state indicates whether 0 or 1 is expected packet sequence number
  - receiver cannot know if its last ACK/NAK received OK at sender

![image](https://user-images.githubusercontent.com/95273765/196602330-5bda8bd9-34c3-4e1a-bade-2813ae8dee77.png)

rdt2.2: a NAK-free protocol
- same functionality as rdt2.1, using ACKs only
- instead of NAK, receiver sends ACK for last packet received OK
- duplicate ACK at sender results in same action as NAK: retransmit current packet

![image](https://user-images.githubusercontent.com/95273765/196603083-c7766746-ce30-4edd-bc4f-2b7f7cd33cd8.png)

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


