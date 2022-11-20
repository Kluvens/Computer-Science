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


