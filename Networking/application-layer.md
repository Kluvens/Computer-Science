## Web and HTTP
Web page consists of objects, each of which can be stored on different Web servers.

HTTP is a web's application layer protocol.

In the client/server model:
- client which is the browser, requests, receives, and displays web objects
- server sends objects in response to requests

HTTP uses TCP:
- client initiates TCP connection to server, port 80
- server accepts TCP connection from client
- HTTP messages exchanged between browser and web server
- TCP connection closed

Four important HTTP request messages:
- POST method
- GET method
- HEAD method
- DELETE  method

HTTP response status codes:
- 200 OK
- 301 Moved Permanently
- 400 Bad Rquest
- 404 Not Found
- 505 HTTP version not supported

HTTP is all text:
- makes the protocol simple
- it's not the most efficient as it may take more space
- non-text content needs to be encoded

Web sites and client browser use cookies to maintain some state between transactions
- subsequent HTTP requests from the same client to this site will contain a special cookie ID value, allowing site to identify and direct to database.
- but cookies can cause privacy concerns

Performance of HTTP:
- Page Load Time (PLT) is an important metric (it measures the time from click until user sees the page)
- depends on many factors, such as page content, protocols involved and network bandwidth and RTT

How to improve Page Load Time:
- reduce content size for transfer (compression)
- change HTTP to make better use of available bandwidth (persistent connections and pipelining)
- change HTTP to avoid repeated transfers of the same content (caching and web-proxies)
- move content closer to the client (CDNs)

A website consists of:
- an HTML file
- many other objects including photos

Non-persistent HTTP (HTTP 1.0): response time
- one RTT to initiate TCP connection
- one RTT for HTTP request and first few bytes of HTTP response to return
- file transmission time
- overall non-persistent HTTP response time = 2RTT + file transmission time

Persistent HTTP (HTTP 1.1):
- one RTT with initiating TCP connection
- one RTT for requesting file
- as little as one RTT for all the referenced objects for persistent connection via pipelining

Web caches (proxy servers):
- browser sends all HTTP requests to cache
  - if object in cache: cache returns object to client
  - else cache requests object from origin server, caches received object, then returns object to client
- that is cache can't directly return an object if it is in the cache, otherwise, it requests the origin server and pass it back to the client as a proxy
- web cache acts as both client and server
- typically, cache is installed by ISP
- it reduces response time for client request
- it reduces traffic on an institution's access link

## Electronic Mail
Three major components for E-mail:
- user agents - for example, outlook, iphone mail client
- mail servers
- simple mail transfer protocol: SMTP

Email sequence:
- a person wirtes an email and message to the target mailbox
- user agent sends message to his mail server and the message is placed in the message queue
- client side of SMTP opens TCP connection with the receiver's mail server
- SMTP client sends the composer's message over the TCP connection
- the receiver's mail server places the message in receiver's mailbox
- the receiver invokes his user agent to read the message

Mail access protocols:
- IMAP
- HTTP

## Domain Name Server
DNS services:
- hostname to IP address translation
- host aliasing
- mail server aliasing
- load distribution

Hierarchy:
- top of hierarchy: root server (root)
- next level: top-level domain servers (edu... com... uk... au...)
- bottom level: authoritative DNS servers (unsw... cse...)

Local Name Servers:
- doesn't strictly belong to hierarchy
- each ISP has one
- when host makes DNS query, query is sent to its local DNS server
  - has local cache of recent name-to-address translation pairs
  - acts as proxy, forwards query into hierarchy

DNS name resolution:
- iterative query: client -> local -> root -> local -> TLD -> local -> authoritative -> local -> client
- recursive query: client -> local -> root -> TLD -> authoritative -> TLD -> root -> local -> client

DNS records (RR format (name, value, type, ttl)):
- type = A (name is hostname, value is IP address)
- type = NS (name is domain, value is hostname of authoritative name server for this domain)
- type = CHAME (name is alias, value is canonical name)
- type = MX (value is the name of mailserver associated with name)

## P2P applications
Peer-to-peer architecture
- no always-on server
- arbitrary end systems directly communicate
- peers request server from other peers, provide service in return to other peers
- peers are intermittently connected and change IP addresses

File distribution time:
- client-server
  - server transmission: NF/us
  - slowest client download time: F/dmin
- P2P
  - server transmission: F/us
  - slowest client download time: F/dmin
  - clients as aggregate downloading and uploading: NF/(us+total of ui)

BitTorrent (a protocol for P2P):
- Torrent files contain address of trackers for the file
- torrent files contain a list of file chunks and their cryptographic hashes
- once peer has entire file, it may leave or remain in torrent

BitTorrent: requesting, sending file chunks
- requesting chunks:
  - at any given time, different peers have different subsets of file chunks
  - periodically, Alice asks each peer for list of chunks that they have
  - Alice requests missing chunks from peers, rarest first
- sending chunks: tit-for-tat
  - Alice sends chunks to those four peers currently sending her chunks at highest rate
  - every 30 seconds: randomly select another peer, starts sending chunks where newly chosen peer may join top 4
  
Distributed Hash Table (DHT):
- a distributed P2P database
- database has pairs
- distribute the pairs over many pairs
- a peer queries DHT with key, DHT returns values that match the key
- peers can also insert pairs

## Video streaming and content distribution networks

