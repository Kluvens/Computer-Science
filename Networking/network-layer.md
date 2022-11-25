## Overview
Two key network-layer functions:
- forwarding: move packets from a router's input link to appropriate router output link
- routing: determine route taken by packets from source to destination
- routing algorithm determines end-end-path through network
- forwarding table determines local forwarding at this router

Two planes:
- data plane:
  - local, per-router function
  - determines how datagram arriving on router input port is forwarded to router output port
- control plane:
  - network-wide logic
  - determines how datagram is routed among routers along end-end path from source host to detinatio host
  - two control-plane approaches:
    - traditional routing algorithms: implemented in routers
    - software-defined networking (SDN): implemented in servers

## IP: Internet Protocol

### IP datagram format
IP datagram format:
- 4-bit version number: indicates the version of the IP protocol (IPv4 or IPv6)
- 4-bit header length: number of 32-bit words (a word equals four bytes) in the header
- 16-bit total length: number of bytes in the packet where the maximum size is 65535 bytes
- 8-bit type of service (TOS)
- 16-bit identification used to identify the packet
- 3-bit flags and if the flag is 0, it means this is the end of the fragmented packet
- 13-bit fragment offset: the position of fragment in the packet (payload in bytes/8)
- 8-bit TTL: number of hops to ensure that the datagram does not circulate forever
- 8-bit protocol: only used when an IP datagram reaches its final destination. This indicates the transport-layer protocol at the destination
- 16-bit checksum
- 32-bit source IP and destination IP

![image](https://user-images.githubusercontent.com/95273765/203475671-75c597f2-4118-49a5-9871-44b89b93df41.png)

### Fragmentation
IP fragmentation, reassembly:
- network links have MTU - largest possible link-level frame - different link types, different MTUs
- large IP datagram divided within net
  - one datagram becomes several datagrams
  - reassembled only at final destination
  - IP header bits used to identify, order related fragments
- fragment can be fragmented
- fragmentation increases the total number of bits to be transmitted for a given datagram
- if one of the fragments are corrupted, then all the fragments are discarded and requests for retransmission

IPv4 fragmentation procedure:
- fragmentation
  - router breaks up datagram in size that output link can support
  - copies IP header to pieces
  - adjust length on pieces
  - set offset to indicate position
  - set more fragments flag on pieces except the last
  - re-compute checksum
- re-assembly
  - receiving host uses identification field with more fragments and offsets to complete the datagram
- fragmentation of fragments also supported

Path MTU discovery procedure:
- Host:
  - sends a big packet to test whether all routers in path to the destination can support or not
  - set Do not fragment flag
- Routers:
  - drops the packet if it is too larget 
  - provides feedback to host with ICMP message telling the maximum supported size

### IPv4 addressing
IP addressing: introduction
- IP address: 32-bit identifier associated with each host or router interface
- interface: connection between host/router and physical link
  - router's typically have multiple interfaces
  - host typically have one or two interfaces

Wired Ethernet interfaces connected by Ethernet switches.
Wireless WiFi interfaces connected by WiFi base station.

### Subnets
- subnet is:
  - device interfaces that can physically reach each other without passing through an intervening router
- IP addresses have structure
  - subnet part: devices in same subnet have common high order bits
  - host part: remaining low order bits
- recipe for defining subnets:
  - detach each interface from its host or router, creating islands of isolated networks
  - each isolated network is called a subnet

### Network Mask
- Mast
  - used in conjunction with the network address to indicate how many higher order bits are used for the network part of the address
  - 223.1.1.0 with mask 255.255.255.0 (bitwise AND)
- Broadcast Address
  - host part is all 111’s
- Network Address
  - Host part is all 0000’s
- Both are typically not assigned to any host

### Class-ful addresses:

![image](https://user-images.githubusercontent.com/95273765/203484838-6871d54d-4146-4078-ab5f-d4c875dae6f4.png)

### Subnetting
- subnetting is the process of dividing the class A, B or C network into more manageable chunks that are suited to your network's size and structure
- subnetting allows 3 levels of hierarchy
  - netid, subnetid, hostid
- original netid remains the same and designates the site
- subnetting remains transparent outside the site
- the process of subnetting simply extends the point where the 1's of mask stop and 0's start
- that is, we are sacrifing some host ID bits to gain network ID bits

### Today's addressing: CIDR
CIDR: Classless InterDomain Routing
- network portion of address of arbitrary length
- address format: a.b.c.d/x where x is number of bits in network portion of address

![image](https://user-images.githubusercontent.com/95273765/203485420-1635740b-ebdf-4697-81b3-9276341ce489.png)

How does host get IP address
- hard-coded sysadmin in config file
- DHCP: Dynamic Host Configuration Protocol: dynamically get address from as server - 'plug-and-play'

### DHCP: dynamic host configuration protocol
Goal: host dynamically obtains IP address from network server when it joins network
- can renew its lease on address in use
- allows reuse of addresses
- support for mobile users who join/leave network

DHCP overview:
- host broadcasts DHCP discover msg
- DHCP server responds with DHCP offer msg
- host requests IP address: DHCP request msg
- DHCP server sends address: DHCP ack msg

DHCP client-server scenario:

![image](https://user-images.githubusercontent.com/95273765/203486866-96519df1-ea47-4915-823f-e0ae7d44f402.png)

DHCP: more than IP addresses
- DHCP can return more than just allocated IP address on subnet
  - address of first-hop router for client
  - name and IP address of DNS server
  - network mask

Hierarchical addressing: route aggregation
- hierarchical addressing allows efficient advertisement of routing information
- IP addresses are allocated as blocks and have geographical significance
- it is possible to determine the geographical location of an IP address
- longest prefix match
  - when looking for forwarding table entry for given destination address, use longest address prefix that matches destination address

### Network address translation
Private addresses cannot be routed
- anyone can use them in a private network
- typically used for NAT

NAT: all devices in local network share just one IPv4 address as far as outside world is concerned
- all datagrams leaving local network have same source NAT IP address, but different source port numbers
- datagrams with source or destination in this network have address for source, destination
- all devices in local network have 32-bit addresses in a private IP address space that can only be used in local network
- advantages:
  - just one IP address needed form provider ISP for all devices
  - can change addresses of host in local network without notifying outside world
  - can change ISP without changing addresses of devices in local network
  - security: devices inside local net not directly addressable, visible by outside world

Implementation: NAT router must:
- outgoing datagrams: replace (source IP address, port number) of every outgoing datagram to (NAT IP addresses, new port number)
  - remote clients/servers will respond using (NAT IP addresses, new port number) as destination address
- remember in NAT translation table every (source IP address, port number) to (NAT IP address, new port number) translation pair
- incoming datagrams: replace (NAT IP address, new port number) in destination fields of every incoming datagram with corresponding (source IP address, port number) stored in NAT table
- NAT has been controversial:
  - routers shoud only process up to layer 3
  - address shortage should be solved by IPv6
  - violates end-to-end argument
  - NAT traversal: what if client wants to connect to server behind NAT
- but NAT is here to stay:
  - extensively used in home and institutional nets, 4G/5G cellular nets

## Routing overview
Routing protocol goal: determine good paths, from sending hosts to receiving host, through network of routers
- path: sequence of routers packets traverse from given initial source host to final destination host
- good: least cost, fastest, least congested

Internet routing works at two levels:
- each AS runs an intra-domain routing protocol that establishes routes within its domain
  - AS - region of network under a single administrative entity
  - link state, e.g., open shortest path first (OSPF)
  - distance vector, e.g., routing information protocol (RIP)
- ASes participate in an inter-domain routing protocol that establishes routes between domains
  - path vector, e.g., border gateway protocol (BGP)

Routing algorithm classification:
- global: all routers have complete topology, link cost info (link state algorithms)
- decentralised: iterative process of computation, exchange of info with neighbors. routers initially only know link costs to attached neighbors (distance vector algorithms)
- static: routes change slowly over time
- dynamic: routes change more quickly; periodic updates or in response to link cost changes

## Routing protocols
Link state routing:
- each node maintains its local link state (LS)
  - i.e., a list of its directly attached links and their costs
- each node floods its local link state
  - on receiving a new LS message, a router forwards the message to all its neighbors other than the one it received the message from
- Eventually, each node learns the entire network topology
  - Can use Dijkstra’s to compute the shortest paths between nodes

Flooding LSAs
- routers transmit link state advertisement (LSA) on links
  - a neighboring router forwards out on all links except incoming
  - keep a copy locally; don't forward previously-seen LSAs
- challenges
  - packet loss
  - out of order arrival
- solutions
  - acknowledgements and retransmissions
  - sequence numbers
  - time-to-live for each packet

## Dijkstra's algorithm
Dijkstra's link-state routing algorithm:
- centralized: network topology, link costs known to all nodes
- computes least cost paths from one node (source) to all other nodes
- iterative: after k iterations, know least cost path to k destinations

![image](https://user-images.githubusercontent.com/95273765/203532788-22169979-292a-4362-8bc5-75464a6c7f21.png)

Dijkstra's algorithm: discussion
- algorithm complexity: n nodes
  - each of n iteration: need to check all nodes, w, not in N
  - n(n+1)/2 comparisons: O(n^2) complexity
  - more efficient implementation possible: O(n logn)
- message complexity:
  - each router must broadcast its link state information to other n routers
  - efficient broadcast algorithms: O(n) link crossings to disseminate a broadcast message from one source
  - each router's message crosses O(n) links: overall message complexity: O(n^2)

Dijkstra's algorithm: oscillations possible
- when link costs depend on traffic volume, route oscillations possible
- sample scenario:
  - routing to destination a, traffic entering at d, c, e with rate I, e < I, I
  - link costs are directional, and volume-dependent

## Distance vector algorithm (Bellman-Ford algorithm)
Based on Bellman-Ford equation (dynamic programming):

![image](https://user-images.githubusercontent.com/95273765/203701019-98b7f4ad-e69c-40d5-8879-5f60774ae7f1.png)

Key idea:
- from time-to-time, each node sends its own distance vector estimate to neighbors
- when x receives new distance vector estimate from any neighbor, it updates its own DV using B-F equation: Dx(y) ← minv{cx,v + Dv(y)}  for each node y ∊ N
- under minor, natural conditions, the estimate Dx(y) converge to the actual least cost dx(y).

Distance vector algorithm:
- iterative, asynchronous: each local iteration caused by:
  - local link cost change
  - DV update messages froom neighbor
- distributed, self-stopping: each node notifies neighbors only when its DV changes
  - neighbors then notify their neighbors - only if necessary
  - no notification received: no actions taken
- each node:
  - wait for change in local link cost or DV from neighbor
  - recompute DV estimates sing DV received from neighbor
  - if DV to any destination has changed, notify neighbors

Problems with distance vector:
- a number of problems occur in a network using distance vector algorithm
- most of these problems are caused by slow convergence or routers converging on incorrect information
- convergence is the time during which all routers come to an aggreement about the best paths through the internetwork
  - whenever topology changes there is a period of instability in the network as the routers converge
- reacts rapidly to good news, but leisurely to bad news

The poisoned reverse rule:
- heuristic to avoid count-to-infinity
- if B routes via C to get to A:
  - B tells C its distance to A is inifinite, so C won't route to A via B

Comparison of LS and DV algorithms:
- message comlexity:
  - LS: n routers, O(n^2) messages sent
  - DV: exchange between neighbors; convergence time varies
- speed of convergece:
  - LS: O(n^2) algorithm, O(n^2) messages may have oscillations
  - DV: convergence time varies
    - may have routing loops
    - count-to-infinity problem
- robustness: what happens if router malfunctions, or is compromised
  - LS: router can advertise incorrect link cost; each router computes only its own table
  - DV router can advertise incorrect path cost: black-holling; each router's table used by others: error propagate through network

Real protocols:
- Link State
  - open shortest path first (OSPF)
  - Intermediate system to intermediate system (IS-IS)
- Distance Vector:
  - Routing information protocol (RIP)
  - Interior gateway routing protocol (IGRP-Cisco)
  - Border Gateway Protocol (BGP)

## ICMP: Internet control message protocol
- used by hosts and routers to communicate network level information
  - error reporting: unreachable host, network, port
  - echo request/reply
- works above IP layer
  - ICMP messages carried in IP datagrams
- ICMP message: type, code plus IP header and first 8 bytes of IP datagram payload causing error
