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

## Principles of reliable data transfer
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
- there's no timer in 2.2 to check timeout

![image](https://user-images.githubusercontent.com/95273765/196603083-c7766746-ce30-4edd-bc4f-2b7f7cd33cd8.png)

rdt3.0: channels with errors and loss
- New channel assumption: underlying channel can also lose packets
  - checksum, sequence numbers, ACKs, retransmissions will be of help.. but not quite enough
- to handle lost sender-to-receiver words in conversation, sender waits reasonable amount of time for ACK
  - retransmits if no ACK received in this time
  - if packet just delayed but not lost:
    - retransmission will be duplicate, but sequence numbers already handles this
    - receiver must specify sequence number of packet being acknoledged
  - use contdown timer to interrupt after reasonable amount of time
  - no retransmission on duplicate ACKs
  
![image](https://user-images.githubusercontent.com/95273765/196606334-7059c4b9-096b-46c7-ac47-b0bf1c62df63.png)

![image](https://user-images.githubusercontent.com/95273765/196606396-52c1ec51-3c38-417d-9977-954e512fd9f1.png)

Performance of rdt3.0
- utilization of sender - fraction of time sender busy sending - (L/R)/((L/R)+RTT)
- stop-and-wait operation: L/R << RTT

![image](https://user-images.githubusercontent.com/95273765/196608016-6b3fa1c1-f829-4703-8c1e-568cc5272894.png)

- pipelined protocols operation
  - pipelining: sender allows multiple, in-flight, yet-to-be-acknowledged packets
    - range of sequence numbers must be increased
    - buffering at sender and/or receiver
    - Go Back N, Selective Repeat
  - utilization of sender = (n*(L/R))/(RTT+(L/R))

![image](https://user-images.githubusercontent.com/95273765/196608673-b49148d5-ccac-4115-a82a-9b0e64d0158c.png)

Go-Back-N: sender
- sender: window of up to N, where window is the pipeline and N is the number of packets in the pipeline, consecutive transmitted but unACKed packets
  - k-bit sequence number in packet header
- cumulative ACK: ACK(n): ACKs all packets up to, including sequence number n
  - on receiving ACK(n): move window forward to begin at n+1
- timer for oldest in-flight packet - there's a single timer needed for Go-Back-N
- timeout(n): retransmit packet n and all higher sequence number packets in window

Selective repeat:
- receiver individually acknowledges all correctly received packets
  - buffers packets, as needed, for eventual in-order delivery to upper layer
- sender times-out/retransmits individually for unACKed packets
  - sender maintains timer for each unACKed packet
- sender window
  - N consecutive sequence numbers
  - limits sequence numbers of sent, unACKed packets
- sender:
  - data from above:
    - if next available sequence number in window, send packet
  - timeout
    - resend packet n, restart timer
  - ACK(n) in in [sendbase,sendbase+N]:
    - mark packet n as received
    - if n smallest unACKed packet, advance window base to next unACKed sequence number
- receiver:
  - packet n in [rcvbase, rcvbase+N-1]:
    - send ACK(n)
    - out-of-order: buffer
    - in-order: deliver, advance window to next not-yet received packet
  - packet n in  [rcvbase-N,rcvbase-1]:
    - ACK(n)
  - otherwise:
    - ignore
- sender window size <= 1/2 of sequence number space

Animation for Go-back-n and selective repeat: https://www2.tkn.tu-berlin.de/teaching/rn/animations/gbn_sr/

Summary for componenets of a solution:
- checksums (for error detection)
- timers (for loss detection)
- acknoledgements
  - cumulative - GBN
  - selective - selective repreat
- sequence numbers (duplicate, windows)
- sliding windows (for efficiency) - GBN and selective repeat
- reliability protocols use the above to decide when and what to retransmit or acknowledge

## Connection-oriented transport: TCP
TCP:
- checksum (same as UDP)
- sequence numbers are byte offsets (based on bytes) = first byte in segment = ISN (random) + k
- ACK sequence number = next expected byte = sequence number + length(data)
- receiver sends cumulative acknowledgements (like GBN)
- receivers can buffer out-of-sequence packets (like SR)
- sender maintains a single retransmission timer (like GBN) and restransmits on timeout
- introduces fast retransmit: optimisation that uses duplicate ACKs to trigger early retransmission

ACKing and Sequence Numbers:
- sender sends packet
  - data starts with sequence number X
  - packet contains B bytes [x, x+1, x+2, ... x+b+1]
- upon receipt of packet, receiver sends an ACK
  - if all data prior to X already received:
    - ACK acknowledges X+B (because that is next expected byte)
  - if highest in-order byte received is Y such that (Y+1) < X
    - ACK acknowledges Y+1
    - Even if this has been ACKed before

![image](https://user-images.githubusercontent.com/95273765/196660180-04afcb75-e6b5-4323-ade4-c576c0dac60a.png)

![image](https://user-images.githubusercontent.com/95273765/196665544-e29ccb38-5975-48d5-8209-1f3d01bb94ce.png)

Piggybacking
- usually both sides of a connection send some data

![image](https://user-images.githubusercontent.com/95273765/196662223-65385e5f-d57a-4190-b4dc-3e4ef8cf8aee.png)

TCP round trip time, timeout:
- EstimatedRTT = (1 - alpha)*EstimatedRTT + alpha*SampleRTT
- exponential weighted moving average (EWMA)
- influence of past sample decreases exponentially fast
- typical value: a = 0.125
- timeout interval: EstimatedRTT plus “safety margin”
  - large variation in EstimatedRTT: want a larger safety margin
  - TimeoutInterval = EstimatedRTT + 4*DevRTT
- DevRTT: EWMA of SampleRTT deviation from EstimatedRTT
  - DevRTT = (1-b)*DevRTT + b*|SampleRTT-EstimatedRTT|
- the sample RTT is calculated from the original request until we receive its ACK

![image](https://user-images.githubusercontent.com/95273765/196671064-344c5440-7ab2-4d50-b927-626c42ea91c5.png)

![image](https://user-images.githubusercontent.com/95273765/196672095-b3c5ecd1-49e4-4790-ac62-cbc0b26de444.png)

TCP fast retransmit:
- if sender receives 3 additional ACKs for same data, resend unACKed segment with smallest sequence number

TCP flow control:
- TCP receiver “advertises” free buffer space in rwnd field in TCP header
  - RcvBuffer size set via socket options
  - many operating systems autoadjust RcvBuffer
- sender limits amount of unACKed data to received rwnd
- guarantees receive buffer will not overflow
- stored in the reveive window field in the TCP segment format
- what if rwnd = 0
  - sender would stop sending data
  - eventually the receive buffer would have space when the application process reads some bytes
- sender keeps sending TCP segments with one data type to the receiver
- these segments are dropped but acknowledged by the receiver with a zero-window size
- Eventually when the buffer empties, non-zero window is advertised

![image](https://user-images.githubusercontent.com/95273765/196676309-8c8a9493-a725-4b14-98a2-a84fdd588f1c.png)

TCP 3-way handshake:
![image](https://user-images.githubusercontent.com/95273765/196677688-b0fa593d-28f2-4af8-9ceb-593bf7fae9e0.png)

TCP: closing a connection
- client, server each close their side of connection
  - send TCP segment with FIN bit = 1
- respond to received FIN with ACK
  - on receiving FIN, ACK can be combined with own FIN
- simultaneous FIN exchanges can be handled

Types of termination:
- one at a time

![image](https://user-images.githubusercontent.com/95273765/196678694-6f5c59a9-7efa-41a4-8530-a56907c28eaa.png)

- both together

![image](https://user-images.githubusercontent.com/95273765/196679113-8d471ecd-bec1-46de-b7bd-de90804813c9.png)

- simultaneous closure

![image](https://user-images.githubusercontent.com/95273765/196679320-89d65acf-2540-410c-89af-d335353d1202.png)

- abrupt termination

![image](https://user-images.githubusercontent.com/95273765/196679727-ef62f6b9-d40c-40e3-b2ad-24be105e3a06.png)

SYN:
- Short for synchronize, SYN is a TCP packet sent to another computer requesting that a connection be established between them.
- If the SYN is received by the second machine, an SYN/ACK is sent back to the address requested by the SYN.
- Lastly, if the original computer receives the SYN/ACK, a final ACK is sent.
- The SYN flag synchronizes sequence numbers to initiate a TCP connection.
- Remember that the FIN flag indicates the end of data transmission to finish a TCP connection.

## Principles of congestion control
congestion:
- informally: too many sources sending too much data too fast for network to handle
- increases delays - if delays > RTO, sender retransmists
- increases loss rate - dropped packets also retransmitted
- increases retransmissions, many unnecessary
- increases congestion, cycle continues

Cost of congestion:
- Knee - point after which
  - throughput increases slowly
  - delay increases fast
- cliff - point after which
  - throughput starts to drop to zero
  - delay approaches infinity

![image](https://user-images.githubusercontent.com/95273765/196822296-beacd383-b0b4-4d9c-b0c5-1c11821cce50.png)

Approaches towards congestion control:
- end-end congestion control:
  - no explicit feedback from network
  - congestion inferred from end-system observed loss
  - approach taken by TCP
- network-assisted congestion control:
  - routers provide feedback to end systems
  - single bit indicating congestion
  - explicit rate for sender to send at

## TCP congestion control
TCP's approach in a nutshell:
- TCP connection maintains a window (controls number of packets in flight)
- TCP sending rate is roughly cwnd/RTT
- vary window size to control sending rate

All the windows:
- congestion window: CWND
  - how many bytes can be sent without overflowing routers
  - computed by the sender using congestion control algorithm
- flow control window: Advertised/receive window (RWND)
  - How many bytes can be sent without overflowing receiver’s buffers
  - Determined by the receiver and reported to the sender
- sender-side window = minimum(CWND, RWND)

For example, we have two processes running on the server, when sending some data to clients, both of them using the same transport layer, this is referred to as multiplexing.
Even though they come from the same sender, they will finally go to different destinations by using the same transport layer.

When the data come back, they need to be chained to the right process.

Connectless means they don't have to maintain the state of connection.

A single socket for two clients.

In connection-oriented demultiplexing, different sockets in the server are responsible for different clients.

With connection-oriented protocols, we can create multiple connections and we can open multiple sockets in the server so that each of these processes can have its own end-to-end connection.
This explains why we can have many windows in our desktop at the same time.

In the destination, the port number is the same but the socket number is different.

All the TCP sockets at the server have the same server-side port number when many clients are cimmultaneously communicating with a traditional TCP web server.


