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
- 4-bit header length: number of 32-bit words in the header
- 16-bit total length: number of bytes in the packet where the maximum size is 65535 bytes
- 8-bit type of service (TOS)
- 16-bit identification; 3-bit flags and 13-bit fragment offset: deal with IP fragmentation
- 8-bit TTL: to ensure that the datagram does not circulate forever
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
