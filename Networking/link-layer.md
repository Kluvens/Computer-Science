# Link-layer

## Overview
The basic service of the link layer is to 'move' a datagram from one node to an adjacent node over a single communication link.

Possible services that can be offered by a link-layer protocol include:
1. Framing and link access: encapsulates each network-layer datagram within a link-layer frame before transmission onto the link.
A data link protocol specifies the structure of the frame, as well as a channel access protocol that specifies the rules by which a frame is transmitted onto the link.
For a point-to-point links that have a single sneder on one end of the link and a single receiver at the other end of the link, the sender can send a frame whenever the link is idle.
When multiple nodes share a single broadcast link, the channel access protocol serves to coordinate the frame transmission of the many nodes
2. Reliable delivery: If a link-layer protocol provides the reliable-delivery service, then it guarantees to move each network-layer datagram across the link without error.
A link-layer reliable-delivery service is achieved with acknowledgements and retransmissions.
A link-layer reliable-delivery service is often used for links that are prone to high error rates, such as a wireless link, with the goal of correcting an error locally, 
on the link at which the error occurs, rather than forcing an edn-to-end retransmission of the data by transport or application layer protocol.
However, link-layer reliable delivery is often considered to be unnecessary overhead for low bit-error links, including fiber, coax, and many twisted-pair copper links.
For this reason, many of the most popular link-layer protocols do not provide a reliable-delivery service.
3. Flow control: The nodes on each side of a link have a limited amount of packet buffering capacity.
This is a potential problem, as a receiving node may receive frames at a rate faster than it can process the frames.
Without flow control, the receiver's buffer can overflow and frames can get lost.
Similar to the transport layer, a link-layer can provide flow control in order to prevent the sending node on onde side of a link from overwhelming the receiving node on the other side of the link.
4. Error detection: A node's receiver can incorrectly decide that a bit in a frame to be a zero when it was transmitted as a one.
These errors are introduced by signal attenuation and electromagnetic noise.
Because there is no need to forward a datagram that has an error, many link-layer protocols provide a mechanism for a node to detect the presence of one or more errors.
This is done by having the transmitting node set error detection bits in the frame, and having the receiving node perform an error check.
Error detection is a very common service among link-layer protocols.
Error detection in the link-layer is usually more sophisticated and implemented in hardware.
5. Error correction Error correction is similar to error detection, except that a receiver can not only detect whether errors have been introduced in the frame but can also determine exactly where in the frame the errors have occurred.
Some protocols provide link-layer error correction for the packet header rather than for the entire packet.
6. Half-Duplex and Full-Dulplex: With full-dulplex transmission, both nodes at the ends of a link may transmit packets at the same time.
With half-duplex transmission, a node cannot both transmit and receive at the same time.

Place where the link layer is implemented:
- in each-and-every host
- link layer implemented in network interface card (NIC) or on a chip
  - Ethernet, WiFi card or chip
  - implements link, physical layer
- attaches into host's system buses
- combination of hardware, software, firmware

On the sending side:
- encapsulates datagram in frame
- adds error checking bits, reliable data transfer, flow control, etc

On the receiving side:
- looks for errors, reliable data transfer, flow control, etc
- extracts datagram, passes to upper layer at receiving side

## Error Detection and Correction Techniques

### Parity Checks
Parity checking is a way of trying to establish if binary data has changed during transmission.
If the parity does not match the protocol, there will have been an error during transmission and the data will need to be resent.
Parity checks do not spot if two bits change.

Perhaps the simplest form of error detection is the use of a single parity bit.
Suppose that the information to be sent, has d bits.
In an even parity scheme, the sender simply includes one additional bit and chooses its value such that the total number of 1's in the d+1 bits is even.
For odd parity scheme, the parrity bit value is chosen such that there are an odd number of 1's.

![image](https://user-images.githubusercontent.com/95273765/202926484-776891be-300f-43f4-8758-63c14dd6b7f1.png)

Receiver operation is also simple with a single parity bit.
The receiver need only count the number of 1's in the receivered d+1 bits.
If an odd number of 1-valued bits are found with an even parity scheme, the receiver knows that at least one bit error has occurred.
More precisely, it knows that some odd number of bit errors have occurred.

But if there's an even number of bit errors, there may be an undetected error.
If the probability of bit errors is small and errors can be assumed to occur independently from one bit to the next, the probability of multiple bit errors in a packet would be extremely small.
In this case, a single parity bit might suffice.
However, measurements have shown that rather than occurring independently, errors are often clustered together in 'bursts'.
Under burst conditions, the probability of undetected errors in a frame protected by single-bit-parity can approach 50%.
Clearly, a more robust error detection scheme is needed.

Suppose now that a single bit error occurs in the original d bits of information. With this  two-dimensional parity scheme, the parity of both the column and the row containing the flipped bit will be in error. 
The receiver can thus not only detect the fact that a single bit error has occurred, but can use the column and row indices of the column and row with parity errors to actually identify the bit that was corrupted and correct that error
Although our discussion has focussed on the original d bits of information, a single error in the parity bits themselves is also detectable and correctable.
Two-dimentional parity can also detect but not correct any combination of two errors in a packet.

The ability of the receiver to both detect and correct errors is known as forward error correction (FEC).
These techniques are commonly used in audio storage and playback devices such as audio CD's.
In a network setting, FEC techniques can be used by themselves, or in conjunction with the ARQ techniques.
FEC techniques are valuable because they can decrease the number of sender retransmissions required.
More importantly, they allow for immediate correction of errors at the receiver.
This avoide having to wait the round-trip propagation delay needed for the sender to receive a NAK packet and for the retansmitted packet to propagate back to the receiver.

![image](https://user-images.githubusercontent.com/95273765/202929436-b20485a4-a9bb-417a-8088-34ba6d6f653b.png)

### Checksum Methods
In checksumming techniques, the d bits of data are treated as a sequence of k-bit integers.
One simple checksumming method is to simply sum these k-bit integers and use the resulting sum as the error detection bits.
The so-called Internet checksum is based on this approach - bytes of data are treated as 16-bit integers and their ones-complement sum forms th Internet checksum.
A receiver calculates the checksum it calculates over the received data and checks whether it matches the checksum carried in the received packet.

Checksum generation:
1. break the original message into 'k' number of blocks with 'n' bits in each block
2. sum all the 'k' data blocks
3. add the carry to the sum, if any
4. do 1's complement to the sum = checksum

Checksum on the receiver:
1. collect all the data blocks including the checksum
2. sum all the data blocks and checksum
3. if the result is all 1's, accept; else, reject

Goal: detect errors in transmitted segment

sender:
- treat contents of UDP segment as sequence of 16-bit integers
- checksum: addition (one's complement sum) of segment content
- checksum value put into UDP checksum field

receiver:
- compute checksum of received segment
- check if computed checksum equals checksum field value:
  - not equal - error detected
  - equal - no error detected, but not guarantee there's no error

Performance of checksum:
- the checksum detects all errors involving an odd number of bits
- it detects most errors involving an even number of bits
- if one or more bits of a segment are damaged and the corresponding bit or bits of opposite value in a second segment are also damaged, the sums of those columns will not change and the receiver will not detect the errors.

Video explanation: https://www.youtube.com/watch?v=AtVWnyDDaDI

### Cyclic redundancy check
An error detection technique used widely in today's computer networks is based on cyclic redundancy check (CRC) codes.
CRC codes are also known as polynomial codes, since it is possible to view the bit string to be sent as a polynomial whose coefficients are 0 and 1 values in the bit string, with operation on the bit string interpreted as polynomial arithmetic.

CRC codes operate as follows:
consider the d-bit piece of data, D, that the sending node wants to send to the receiving node.
The sender and receiver must first agree on a r+l bit pattern, known as a generator, which we will denote as G.
We will require that the most significant (leftmost) bit of G be a 1.
For a given piece of data D, the sender will choose r additional bits, R, and append them to D such that the resulting d+r bit pattern is exactly divisible by G using modulo 2 arithmetic.
The process of error checking with CRC's is thus simple:
the receiver divides the d+r received bits by G.
If the remainder is non-zero, the receiver knows that an error has occurred;
otherwise the data is accepted as being correct.

All CRC calculations are done in modulo 2 arithmetic without carries in addition or borrows in subtraction.
This means that addition and subtraction are identical, and both are equivalent to the bitwise exclusive-or of the operands.

Note: none of the Internet checksums, two-dimensional parity, cyclic redundancy check (CRC) can correct any bit errors.

This approach can detect all burst errors less than r+l bits.
In CRC, we want D*2^r XOR R = nG which is equivalent to D*2^r = nG XOR R.
This tells us that if we divide D\*2^r by G, the value of the remainder is precisely R.
In other words, we can calculate R as R = remainder(D\*2^r/G)

![image](https://user-images.githubusercontent.com/95273765/202930908-fa99451f-90fa-4d85-9dee-8c2664951e2a.png)

![image](https://user-images.githubusercontent.com/95273765/202930927-661ebbd5-b7a9-426e-83ae-fd6a37db93b9.png)

## Multiple Access Protocols and LANs
Multiple access protocol:
- distributed algorithm that determines how nodes share channel, i.e., determine when node can transmit
- communication about channel sharing must use channel itself
  - no out-of-band channel for coordination

An ideal multiple access protocol:
- given: multiple access channel (MAC) of rate R bps
- desired properties:
  - when one node wants to transmit, it can send at rate R.
  - when M nodes want to transmit, each can send at average rate R/M
  - fully decentralized
    - no special node to coordinate transmissions
    - no synchronization of clocks, slots
  - simple

MAC protocols: taxonomy
- channel partitioning
  - divide channel into smaller 'pieces' (time slots, frequency, code)
  - allocate piece to node for exclusive use
- random access
  - channel not divided, allow collisions
  - 'recover' from collisions
- 'talking turns'
  - nodes take turns, but nodes with more to send can take longer turns

- channel partitioning MAC protocols:
  - share channel efficiency and fairly at high load
  - inefficient at low load: delay in channel access, I/N bandwidth allocated even if only I active node
- random access MAC protocols
  - efficient at low load: single node can fully utilize channel
  - high load: collision overhead
- taking turns protocol
  - look for best of both worlds

### Channel partitioning MAC protocols: TDMA
- TDMA: time division multiple access
  - access to channel in 'rounds'
  - each node gets fixed length slot (length = packet transmission time) in each round
  - unused slots go idle
  - it eliminates collisions and is perfectly fair: each node gets a dedicated transmission rate of R/N bps during each slot time.
  - a node is limited to this rate of R/N bps over a slot's time even when it is the only node with frames to send.
  - Second drawback is that a node must always wait for its turn in the transmission sequence

### Channel paritioning MAC protocols: FDMA
- FDMA: frequency division multiple access
  - channel spectrum divided into frequency bands
  - each node assigned fixed frequency band
  - unused transmission time in frequency bands go idle
  - FDMA shares both the advantages and drawbacks of TDMA.
  - It avoids collisions and divide the bandwidth fairly among the N nodes.

### Code Division Multiple Access (CDMA)
While TDM and FDM assign times slots and frequencies, respectively, to the nodes, CDMA assigns a different code to each node. 
Each node then uses its unique code to encode the data bits it sends.
CDMA allows different nodes to transmit simultaneously and yet have their respective receivers correctly receive a sender's encoded data bits (assuming the receiver knows the sender's code) in spite of "interfering" transmissions by other nodes.

## Random Access Protocols
- when node has packet to send
  - transmit at full channel data rate R
  - no a priori coordination among nodes
- two or more transmitting node: 'collision'
- random access MAC protocol specifies:
  - how to detect collisions
  - how to recover from collisions
  - examples of random-access MAC protocols:
    - ALOHA, slotted ALOHA
    - CSMA, CSMA/CD, CSMA/CA

### Slotted ALOHA
In our description of slotted ALOHA, we assume the following:
- All frames consist of exactly L bits.
- Time is divided into slots of size L/R seconds (i.e., a slot equals the time to transmit one frame).
- Nodes start to transmit frames only at the beginnings of slots.
- The nodes are synchronized so that each node knows when the slots begin.
- If two or more frames collide in a slot, then all the nodes detect the collision event before the slot ends.

Let p be a probability, that is, a number between 0 and 1.
The operation of slotted ALOHA in each node is simple:
- When the node has a fresh frame to send, it waits until the beginning of the next slot and transmits the entire frame in the slot.
- If there isn't a collision, the node won't consider retransmitting the frame. (The node can prepare a new frame for transmission, if it has one.)
- If there is a collision, the node detects the collision before the end of the slot. The node retransmits its frame in each subsequent slot with probability p until the frame is transmitted without a collision.

By retransmitting with probability p, we mean that the node effectively tosses a biased coin:
the event heads corresponds to retransmit, which occurs with probability p.
The event tails corresponds to "skip the slot and toss the coin again in the next slot"; this occurs with probability (1-p).
Each of the nodes involved in the collision toss their coins independently.

![image](https://user-images.githubusercontent.com/95273765/203468449-29f16d6e-e754-4e6e-860c-1b7c057cfb25.png)

Advantages:
- allows a single active node to continuously transmit frames at the full rate of the channel
- is highly decentralized, as each node detects collisions and independently decides when to retransmit
- it is an extremely simple protocol

Drawbacks:
- collisions happen, wasting slots
- idle slots
- nodes may be able to detect collision in less than to transmit packet
- clock synchronization

Efficiency:
- long-run fraction of successful slots (many nodes, all with many frames to send
- suppose: N nodes with many frames to send, each transmits in slot with probability p
  - prob that given node has success in a slot = p(1-p)^(N-1)
  - prob that any node has a success = Np(1-p)^(N-1)
  - max efficiency: find p* that maximizes Np(1-p)^(N-1)
  - for many nodes, take limit of Np*(1-p*)^(N-1) as N goes to infinity, gives: max efficiency = 1/e = .37
  - at best: channel used for useful transmissions 37% of time!

In slotted Aloha:
- any station can transmit the data at the beginning of any time slot
- the time is discrete and globally synchronized
- vulnerable time in which collision may occur = Tfr
- probability of successful transmission of data packet = G\*e^(-G)
- maximum efficiency = 36.8%
- it reduces the number of collisions to half and doubles the efficiency of pure aloha

Video: https://www.youtube.com/watch?v=aqWTNk90zRA
  
### Pure ALOHA
- unslotted Aloha: simpler, no synchronization
  - when frame first arrives: transmit immediately
- collision probability increases with no synchronization:
  - frame sent at t0 collides with other frames sent in [t0-1,t0+1]
- pure Aloha efficiency: 18%

In Aloha:
- any station can transmit the data at any time
- the time is continuous and not globally synchronized
- vulnerable time in which collision may occur = 2\*Tfr
- probability of successful transmission of data packet = G*e(-2G)
- maximum efficiency = 18.4%
- main advantage is the simplicity in implementation

### CSMA - Carrier Sense Multiple Access
Simple CSMA: listen before transmit
- if channel sensed idle: transmit entire frame
- if channel sensed busy: defer transmission
- human analogy: don't interrupt others

CSMA/CD: CSMA with collision detection
- collisions detected within short time
- colliding transmissions aborted, reducing channel wastage
- collision detection easy in wired, difficult with wireless
- human analogy: the polite conversationalist

A node will refrain from transmitting whenever it senses that another node is transmitting.

CSMA/CD reduces the amount of time wasted in collisions and transmission aborted on collision detection

![image](https://user-images.githubusercontent.com/95273765/202983722-6b6e08f2-30a5-472d-b676-862067338013.png)

Ethernet CSMA/CD algorithm:
1. NIC receives datagram from network layer, creates frame
2. if NIC senses channel:
  - if idle: start frame transmission
  - if busy: wait until channel idle, then transmit
3. if NIC transmits entire frame without collision, NIC is done with frame
4. if NIC detects another transmission while sending: abort, send jam signal
5. after aborting, NIC enters binary backoff:
  - after mth collision, NIC chooses K at random from {0,1,2, ... , 2^m-1}. NIC waits K\*512 bit times, returns to Step 2
  - more collisions: longer backoff interval

CSMA/CD efficiency:
- Tprop = max prop delay between 2 nodes in LAN
- Trans = time to transmit max-size frame
- efficiency goes to 1
  - as Tprop goes to 0
  - as Ttrans goes to infinity
- better performance than ALOHA: and simple, cheap, decentralized

Taking turns MAC protocols:
- polling:
  - captain node invites other nodes to transmit in turn
  - typically used with dumb devices
  - concerns:
    - polling overhead
    - latency
    - single point of failure (captain)
- token passing:
  - control token passed from one node to next sequentially
  - token message
  - concerns:
    - token overhead
    - latency
    - single point of failure (token)

Summary of MAC protocols:
- channel partitioning, by time, frequency or code:
  - time division, frequency division
- random access (dynamic):
  - ALOHA, slotted-ALOHA, CSMA, CSMA/CD
  - carrier sensing: easy in some technologies (wired), hard in others (wireless)
  - CSMA/CD used in Ethernet
  - CSMA/CA used in 802.11
- taking turns
  - polling from central site, token passing
  - bluetooth, FDDI, token ring

## LAN addresses and ARP
MAC addresses:
- 32-bit IP address:
  - network-layer address for interface
  - used for network-layer forwarding
  - e.g.: 128.119.40.136
- MAC address:
  - function: used locally to get frame from one interface to another physically-connected interface
  - 48-bit MAC address burned in NIC ROM, also sometimes software settable
  - e.g.: 1A-2F-BB-76-09-AD

MAC addresses
- MAC address allocation administered by IEEE
- also referred to as a LAN address, a physical address and an Ethernet address
- manufacturer buys portion of MAC address space
- MAC flat address: portability
  - can move interface from one LAN to another
  - recall IP address not portable: depends on IP subnet to which node is attached

MAC address vs. IP address:
- MAC addresses used in link-layer
  - hard-coded in read-only memory when adapter is built
  - no two adapters have the same address
  - flat name space of 48-bits
  - portable, and can stay the same as the host moves
  - used to get packet between interfaces on same network
- IP addresses:
  - learned dynamically
  - hierarchical name space of 32 bits
  - not portable, and depends on where the host is attached
  - used to get a packet to destination IP subnet

Why we need MAC addresses:
- LANs are designed for arbitrary network-layer protocols, not just for IP. If adapters were to get assigned IP addresses rather than neutral LAN addresses, then the adapters would not be able to easily support other network-layer protocols.
- Secondly, if adapters were to use IP addresses instead of LAN addresses, the IP address would have to stored in adapter RAM and configured every time the adapter were moved.

## ARP: address resolution protocol
Every Internet  host and router on a LAN has an ARP module.
Each node has an IP address and each node's adapter has a lAN address.

ARP table: each IP node on LAN has table
- IP/MAC address mappings for some LAN nodes: <IP address; MAC address; TTL>
- TTL: time after which address mapping will be forgotten

ARP protocol in action:
- A broadcasts ARP query, containing B's IP address (all nodes on LAN receive ARP query)
- B replies to A with ARP response, giving its MAC address
- A receives B's reply, address B entry into local ARP table

APR is used to resolve the associated LAN address of an IP address.

In a lAN switch, packets can be flooded sometimes.

### Routing to another subnet: addressing
walkthrough: sending a datagram from A to B via R
- focus on addressing - at IP and MAC layer levels
- assume that:
  - A knows B's IP address
  - A knows IP address of first hop router, R
  - A knows R's MAC address
- A creates IP datagram with IP source A, destination B
- A creates link-layer frame containing A-to-B IP datagram
  - R's MAC address is frame's destination
- frame sent from A to R
- frame received at R, datagram removed, passed up to IP
- R determines outgoing interface, passes datagram with IP source A, destination B to link layer
- R creates link-layer frame containing A-to-B IP datagram. Frame destination address: B's MAC address
- transmits link-layer frame
- B receives frame, extracts IP datagram destination
- B passes datagarm up protocol stack to IP

Security Issues: ARP Cache Poisoning
- denial of service - hacker replies back to an ARP query for a router NIC with a fake MAC address
- Main-in-the-middle attack - Hacker can insert his/her machine along the path between victim machine and gateway router
- such attacks are generally hard to launch as hacker needs physical access to the network

## Ethernet
the dominant wired LAN technology:
- first widely used LAN technology
- simpler, cheap
- kept up with speed race: 10 Mbps – 400 Gbps
- single chip, multiple speeds

Ethernet: physical topology
- bus: popular through mid 90s
  - all nodes in same collision domain
- switched: prevails today
  - active link-layer 2 switch in center
  - each spoke runs a separate Ethernet protocol

![image](https://user-images.githubusercontent.com/95273765/203718484-c9a9661c-03c1-4d47-b1d1-3c8d9cfdeb66.png)

Ethernet frame structure:
sending interface encapsulates IP datagram (or other network layer protocol packet) in Ethernet frame.

![image](https://user-images.githubusercontent.com/95273765/203718693-a2cbb704-dd79-45ee-801c-ef2159c96a41.png)

- preamble:
  - used to synchronize receiver, sender clock rates
  - 7 bytes of 10101010 followed by one byte of 10101011
- addresses: 6 byte source, destination MAC addresses
  - if adapter receives frame with matching destination address, or with broadcast address, it passes data in frame to network layer protocol
  - otherwise, adapter discards frame
- type: indicates higher layer protocol
  - mostly IP but others possible
  - used to demultiplex up at receiver
- CRC: cyclic redundancy check at receiver
  - error detected: frame is dropped

Ethernet: unreliable, connectionless
- connectionless: no handshaking between sending and receiving NICs
- unreliable: receiving NIC doesn't send ACKs or NAKs to sending NIC
  - data in dropped frames recovered only if initial sender uses higher layer rdt, otherwise dropped data lost
- Ethernet's MAC protocol: unslotted CSMA/CD with binary backoff

## Ethernet switch
- switch is a link-layer device: it takes an active role
  - store, forward Ethernet frames
  - examine incoming frame's MAC address, selectively forward frame to one-or-more outgoing links when frame is to be forwarded on segment, uses CSMA/CD to access segment
- transparent: hosts unaware of presence of switches
- plug-and-paly, self-learning
  - switches do not need to be configured

Switch: multiple simultaneous transmissions
- hosts have dedicated, direct connection to switch
- switches buffer packets
- Ethernet protocol used on each incoming link, so:
  - no collisions; full duplex
  - each link is its own collision domain
- switching: A-to-A's and B-to-B's can transmit simultaneously, without collisions
  - but A-to-A's and C to A's can not happend simultaneously

Switch: self-learning
- switch learns which hosts can be reached through which interfaces
  - when frame received, switch learns location of sender: incoming LAN segment
  - records sender/location pair in switch table

If a LAN switch has flooded a packet, it means the switch did not know which LAN segment the packet destination is connected to.

Switches vs. routers
- both are store-and-forward
  - routers: network-layer devices
  - switches: link-layer devices
- both have forwarding tables:
  - routers: compute tables using routing algorithms, IP address
  - switches: learn forwarding table using flooding, learning, MAC addresses

## Wireless
Elements of a wireless network:
- wireless hosts:
  - laptop, smartphones, IoT
  - run applications
  - may be stationary or mobile
- base station:
  - typically connected to wired network
  - relay - responsible for sending packets between wired network and wireless hosts in its area
- wirelss link:
  - typically used to connect mobiles to base station, also used as backbone link
  - multiple access protocol coordinates link access
  - various transmission rates and distances, frequency bands
- infrastructure mode:
  - base station connects mobiles into wired network
  - handoff: mobile changes base station providing connection into wired network
- ad hoc mode
  - no base stations
  - nodes can only transmit to other nodes within link coverage
  - nodes organize themselves into a network: route among themselves

Wireless network taxonomy:

![image](https://user-images.githubusercontent.com/95273765/203726825-c4bf2825-fafd-4512-9989-695fe4d23c0e.png)

Wireless link characterristics:
- decreased signal strength: radio signal attenuates as it propagates through matter
- interference from other sources: wireless network frequencies shared by many devices
- multipath propagation: radio signal reflects off objects ground, arriving at destination at slightly different times
  - signals bounce off surface and interface with one another
  - self-inerference
- SNR: singal-to-noise ratio
  - larger SNR - easier to extract signal from noise
- SNR versus BER (bit error rate) tradeoffs
  - given physical layer: increase power -> increase SNR -> decrease BER
  - given SNR: choose physical layer that meets BER requirement, giving highest throughput
    - SNR may change with mobility: dynamically adopt physical layer
- multiple wireless senders, receivers create additional problems:
  - hidden terminal problem
  - signal attenuation
- exposed terminals
  - node B sends a packet to A; C hears this and decides not to send a packet to D
  - carrier sense would prevent a successful transmission

802.II LAN architecture
- wireless host communicates with base station
  - base station = access point (AP)
- Basic service set (BSS) in infrastructure mode contains:
  - wireless hosts
  - access point: base station
  - ad hoc mode: hosts only

802.II: Channels, association
- spectrum divided into channels at different frequencies
  - AP admin chooses frequency for AP
  - interference possible: channel can be same as that chosen by neighboring AP
- arriving host: must associate with an AP
  - scans channels, listening for beacon frames containing AP's name and MAC address
  - selects AP to associate with
  - then may perform authentication
  - then typically run DHCP to get IP address in AP's subnet

Passive scanning:
- beacon frames sent from APs
- association request from sent HI to selected AP
- association response frame sent from selected AP to HI

Active scanning:
- probe request frame broadcast from HI
- probe response frames sent from APs
- association request frame sent: HI to selected AP
- association response frame snet from selected AP to HI

IEEE 802.II: multiple access
- avoid collision: 2+ nodes transmitting at the same time
- 802.II: CSMA - sense before transmitting
  - don't collide with detected ongoing transmission by another node
- 802.11: no collision detection
  - difficult to sense collision: high transmitting signal, weak received signal due to fading
  - can't sense all collisions in any case: hidden terminal, fading
  - goal: avoid collisions: CSMA/Collision Avoidance

Multiple access: Key points
- no concept of a global collision
  - different receivers hear different signals
  - different senders reach different receivers
- collisions are at receiver, not sender
  - only care if receiver can hear the sender clearly
  - it does not matter if sender can hear someone else
  - as long as that signal does not interfere with receiver
- goal of protocol
  - detect if receiver can hear sender
  - tell senders who might interfere with receiver to shut up

![image](https://user-images.githubusercontent.com/95273765/203871010-d7e02141-5e4f-4150-903c-302badc73aa2.png)

Avoiding collisions:
- idea: sender reserves channel use for data frames using small reservation packets
- sender first transmits small request-to-send (RTS) packet to BS using CSMA
  - RTSs may still collide with each other but they are short
- BS broadcasts clear-to-send CTS in response to RTS
- CTS heard by all nodes
  - sender transmits data frame
  - other stations defer transmissions

![image](https://user-images.githubusercontent.com/95273765/203871357-93d8b2aa-ee62-444c-beb4-57c0a97d75ef.png)

![image](https://user-images.githubusercontent.com/95273765/203871805-6dd835cb-a81f-48c1-8290-754bb00ccb34.png)

802.11 frame: addressing
- Address 1: MAC address of wireless host or AP to receive this frame
- Address 2: MAC address of wireless host or AP transmitting this frame
- Address 3: MAC address of the router interface to which AP is attached
- Address 4: used only in ad hoc mode
- duration of reserved transmission time (RTS/CTS)
- frame sequence number (for reliable data transfer)
- frame type (RTS, CTS, ACK, data)

802.11: advanced capabilities (Rate adaptation)
- base station, mobile dynamically change transmission rate (physical layer modulation technique) as mobile moves, SNR varies
  - SNR decreases, BER increases as node moves away from base station
  - when BER becomes too high, switch to lower tranmission rate but with lower BER
