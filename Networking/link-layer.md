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

