## Application layer overview
two predominant architectural paradigms:
- client and server: there's a always on server, which services requests from many other clients
- peer to peer: no always on server, a peer can be a server uploading a file and can be a client downloading a file

An application layer protocol defines:
- the types of messages exchanged, e.g., request messages and response messages;
- the syntax of the various message types, i.e., the fields in the message and how the fields are delineated;
- the semantics of the fields, i.e., the meaning of the information in the fields;
- rules for determining when and how a process sends message and responds to message.

### Processes communicating across a network
An application involves two processes in two different hosts communicating with each other over a network.
The two processes communicate with each other by sending and receiving messages through their sockets.
A process's socket can be thought of as the process's door:
a process sends messages into, and receives message from, the network through its socket.
The process assume that there is a transportation infrastructure on the other side of the door that will transport the message to the door of the destination process.
A socket is the interface between the application layer and the transport layer within a host.
It is also referred to as the API between the application and the network, since the socket is the programming interface with which networked applications are built in the Internet.

### Addressing processes
In order for a process on one host to send a message to a process on another host, the sending process must identify the receiving process.
To identify the receiving process, one must typically specify two pieces of information:
1. the name or address of the host machine
2. an identifier that specifies the identity of the receiving process on the destination host

The destination host is specified by its IP address.
In addition to knowing the address of the end system to which a message is destined, a sending application must also specify information that will allow the receiving end system to direct the message to the appropriate process on that system.
A receive-side port number serves this purpose in the Internet.
When a developer create a new network application, the application must be assigned a new port number.

### User agents
The user agent is an interface between the user and the network application.
For example, web broswer is a user agent.

### Services needed
- data loss: some applications can tolerant data loss whereas some can't
- bandwidth: Some applications must be able to transmit data at a certain rate in order to be 'effective'.
- timing: some applications are time sensitive whereas some aren't.

## Web and HTTP
Web page consists of objects, each of which can be stored on different Web servers.
More specifically, a webpage consists of an index html file and urls to each object, when transferring a webpage, we firstly transfer the index file, then all its embedded objects.

HTTP is a web's application layer protocol.
It defines how web clients request web pages from servers and how servers transfer web pages to clients.

In the client/server model:
- client which is the browser, requests, receives, and displays web objects
- server sends objects in response to requests

HTTP uses TCP:
- client initiates TCP connection to server, port 80
- server accepts TCP connection from client
- HTTP messages exchanged between browser and web server
- TCP connection closed
- HTTP is pull-based
- HTTP is stateless, which means the server maintains no information about past client requests

Four important HTTP request messages:
- POST method
- GET method
- HEAD method
- DELETE  method

![image](https://user-images.githubusercontent.com/95273765/197364559-18bf975b-1079-45be-8820-8270322488ae.png)

HTTP response status codes:
- 200 OK
- 301 Moved Permanently
- 400 Bad Rquest
- 404 Not Found
- 505 HTTP version not supported

![image](https://user-images.githubusercontent.com/95273765/197364585-18211739-0006-4666-a56d-f60ff2ee7198.png)

HTTP is all text:
- each character in the text consumes one byte
- makes the protocol simple
- it's not the most efficient as it may take more space
- non-text content needs to be encoded

Web sites and client browser use cookies to maintain some state between transactions
- subsequent HTTP requests from the same client to this site will contain a special cookie ID value, allowing site to identify and direct to database.
- but cookies can cause privacy concerns

Performance of HTTP:
- Page Load Time (PLT) is an important metric (it measures the time from click until user sees the page)
- depends on many factors, such as page content, protocols involved and network bandwidth and RTT
- Round-trip time (RTT) is the time it takes for a small packet to travel from client to server and then back to the client.

How to improve Page Load Time:
- reduce content size for transfer (compression)
- change (improve) HTTP to make better use of available bandwidth (persistent connections and pipelining)
- change HTTP to avoid repeated transfers of the same content (caching and web-proxies)
- move content closer to the client (CDNs)

A website consists of:
- an HTML file
- many other objects including photos
- the time required to fetch one object = time to setup TCP connection + RTT for sending GET request and receiving response + time to tear down TCP connection

Non-persistent HTTP (HTTP 1.0): response time
- at most one object sent over TCP connection and then the connection is closed
- one RTT to initiate TCP connection
- one RTT for HTTP request and first few bytes of HTTP response to return
- file transmission time
- overall non-persistent HTTP response time (every connection) = 2RTT + file transmission time
- one TCP connection to fetch one web resource
- multiple TCP slow-start phases (Non-persistent means you're establishing a new connection for each HTTP request.  A TCP connection always starts in slow-start.  So naturally if each request requires a new connection, and each connection starts in slow-start, then non-persistent will result in multiple slow-start phases.)

![image](https://user-images.githubusercontent.com/95273765/196856410-90b23b58-2c08-434c-b163-5afd85f0596f.png)

Persistent HTTP without pipelining: no need to set up TCP connection every time but still needs to request every file

![image](https://user-images.githubusercontent.com/95273765/196856770-ec94b605-a042-4e2f-b41a-cfa1bdacf1f2.png)

Persistent HTTP (HTTP 1.1):
- one RTT with initiating TCP connection
- one RTT for requesting file
- one RTT for each referenced object without pipelining
- as little as one RTT for all the referenced objects for persistent connection via pipelining

![image](https://user-images.githubusercontent.com/95273765/196856579-99f8546b-6cc7-48ec-9b28-52ddcc146692.png)

Web caches (proxy servers):
- browser sends all HTTP requests to cache
  - if object in cache: cache returns object to client
  - else cache requests object from origin server, caches received object, then returns object to client
- that is cache can't directly return an object if it is in the cache, otherwise, it requests the origin server and pass it back to the client as a proxy
- web cache acts as both client and server at the same time
- typically, cache is installed by ISP
- it reduces response time for client request
- it reduces traffic on an institution's access link

This is how a web cache is working:
1. the browser establishes a TCP connection to the proxy server and sends an HTTP request for the object to the web cache
2. the web cache checks to see if it has a copy of the object stored locally. If it does, the web cache forwards the object within an HTTP response message to the client browser.
3. If the web cache does not have the object, the web cache opens a TCP connection to the origin server. The web cache then sends an HTTP request for the object into the TCP connection. After receiving this request, the origin server sends the object within an HTTP response to the web cache.
4. When the web cache receives the object, it stores a copy in its local storage and forwards a copy, within an HTTP response message, to the client browser.

Conditional GET:
- cache: specify data of cached copy in HTTP request - If-modified-since: <date>
- E-tag: usually used for dynamic content. The value is often a cryptographic hash of the content
- server: response contains no object if cached copy is up-to-data: HTTP/1.0 304 Not Modified

![image](https://user-images.githubusercontent.com/95273765/197366122-bb02e5a2-2cba-4763-824a-012521706722.png)
  
HTTPS:
- HTTP is insecure
- HTTPS: HTTP over a connection encrypted by Transport Layer Security (TLS)
- provides authentication and bidirectional encryption
- widely used in place of plain vanilla HTTP

## Electronic Mail
Three major components for E-mail:
- user agents - for example, outlook, iphone mail client
- mail servers
  - mailbox contains incoming messages for user
  - message queue of outgoing mail messages
  - SMTP protocol between mail servers to send email messages
- simple mail transfer protocol: SMTP
  
  
About E-mail:
- uses TCP to transfer email message on port 25
- direct transfer: sending server to receiving server
- Three phases of transferring e-mails:
  - handshaking
  - transfer of messages
  - closure
- command/response interaction
  - commands: ASCII text
  - response: status code and phrase
- messages must be in 7-bit ASCII

Email sequence:
- a person wirtes an email and message to the target mailbox
- user agent sends message to his mail server and the message is placed in the message queue
- client side of SMTP opens TCP connection with the receiver's mail server
- SMTP client sends the composer's message over the TCP connection on port 25
- the receiver's mail server places the message in receiver's mailbox
- the receiver invokes his user agent to read the message

Mail access protocols:
- IMAP
- HTTP

how do we send pictures/videos/files via email:
- encode these objects as ASCII

SMTP:
- push based
- has ASCII command/response interaction
- multiple objects sent in multipart message
- uses persistent connection
- requires message to be in 7-bit ASCII
- SMTP server uses CRLF to determine end of message

Mail message format:
- header
  - to
  - from
  - subject
- body: the message, ASCII characters only
  
## Domain Name Server
The DNS is:
1. a distributed database implemented in a herarchy of name servers
2. an application-layer protocol that allows hosts and name servers to communicate in order to provide the translation service.
  
DNS services:
- hostname to IP address translation
- host aliasing
- mail server aliasing
- load distribution (many IP addresses correspond to one name)

Hierarchy:
- top of hierarchy: root server (root)
- next level: top-level domain servers (edu... com... uk... au...)
- bottom level: authoritative DNS servers (unsw... cse...)
- each server stores a small subset of the total DNS database
- an authoritative DNS server stores resource records for all DNS names in the domain that it has authority for
- each server can discover the servers that are responsible for the other portions of the hierarchy

Local Name Servers:
- doesn't strictly belong to hierarchy
- each ISP has one
- when host makes DNS query, query is sent to its local DNS server
  - has local cache of recent name-to-address translation pairs
  - acts as proxy, forwards query into hierarchy
- generally speaking, it behaves like a cache
- the record inside the local server has a TTL which means that if it's not reached by a certain number of times, it will be deleted

DNS name resolution:
- iterative query: client -> local -> root -> local -> TLD -> local -> authoritative -> local -> client
- recursive query: client -> local -> root -> TLD -> authoritative -> TLD -> root -> local -> client

Caching, updating DNS records
- once name server learns mapping, it caches mapping
  - cache entries timeout after some time (TTL)
  - TLD servers typically cached in local name servers, thus root name servers not often visited
- cached entries may be out-of-date, if name host changes IP address, may not be known Internet-wide until all TTLs expire

DNS records (RR format (name, value, type, ttl)):
- type = A (name is hostname, value is IP address)
- type = NS (name is domain, value is hostname of authoritative name server for this domain)
- type = CHAME (name is alias, value is canonical name)
- type = MX (value is the name of mailserver associated with name)

DNS protocol messages:
- DNS query and replay messages, both have same format

![image](https://user-images.githubusercontent.com/95273765/197368025-eb4b682a-cad4-4576-8eff-1fa8608e2f84.png)

- identification: 16 bit # for query, reply to query uses same #
- flags:
  - query or reply
  - recursion desired
  - recursion available
  - reply is authoritative
- questions is name, type fields for a query
- answers is RRs in response to query
- authority is records for authoritative servers
- additional info is additional helpful info taht may be used
  
Inserting records into DNS (Example: new startup "newwork utopia"):
- register name networkutopia.com at DNS registrar
  - provide names, IP addresses of authoritative name server
  - registrar inserts NS, A RRs into .com TLD server: (networkutopia.com, dns1.networkutopia.com, NS) and (dns1.networkutopia.com, 212.212.212.1, A)
- create authoritative server locally with IP address 212.212.212.1
  - containing type A record for www.networkutopia.com
  - containing type MX record for networkutopia.com
  
Updating DNS records
- Remember that old records may be cached in other DNS servers (for up to TTL)
- General guidelines
  - record the current TTL value of the record
  - lower the TTL of the record to a low value
  - wait the length of the prevous TTL
  - update the record
  - wait for some time
  - change the TTL back to your previous time

Addresses:
- domain name: google.com
- host name: www.google.com
- IP address: 192.158.1.38

Reliability:
- DNS servers are replicated
  - name service available if at least one replicate is up
  - queries can be load-balanced between replicates
- usually, UDP used for queries
  - still needs reliability, must implement this on top of UDP
  - spec supports TCP too, but not always implemented
- DNS uses port 53
- try alternate servers on timeout
- same identifier for all queries - don't care which server responds

A web browser needs to contact a website, the minimum number of DNS request is 0 as the domain IP mapping could be saved in host, that is, the message is already in the end system so there's no need for a DNS request.

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
- breaks down files into small chunks
- there's a server called tracker which tracks peers participating in torrent
- torrent is a group of peers exhausting chunks of a file
- Torrent files contain address of trackers for the file
- torrent files contain a list of file chunks and their cryptographic hashes
- churn: peers may come and go
- once peer has entire file, it may leave or remain in torrent
- BitTorrent typically uses TCP as its transport protocol for exchanging pieces

BitTorrent: requesting, sending file chunks
- requesting chunks:
  - at any given time, different peers have different subsets of file chunks
  - periodically, Alice asks each peer for list of chunks that they have
  - Alice requests missing chunks from peers, rarest first
- sending chunks: tit-for-tat
  - tit-for-tat is when there's no server and everyone's trying maximise their own outcome. That's we are using resources from someone else.
  - if we give more resources others will also give us more resources; if we give less, they will give less
  - BitTorrent uses tit-for-tat to determine to which peers to upload chunks
  - Alice sends chunks to those four peers currently sending her chunks at highest rate
  - every 30 seconds: randomly select another peer, starts sending chunks where newly chosen peer may join top 4
- a peer can stay and continue to upload chunks once they have the full file, but tit-fot-tat won't be useful for that peer
  
Distributed Hash Table (DHT):
- The main diffference is that the in CS, the server stores all the information whereas in P2P, the information is stored in many other peers
- a distributed P2P database
- database has pairs
- distribute the pairs over many pairs
- a peer queries DHT with key, DHT returns values that match the key
- peers can also insert pairs
- in DHT, a hash function converts a string to an integer
- P2P networks use DHT to help new peers join the network

Assign keys to peers:
- rule: assign key to the peer that has the closest ID
- common convention: closest is the immediate successor of the key

Example 1:
- each peer maintains 2 neighbours
- worst case: N messages, Average: N/2 messages

![image](https://user-images.githubusercontent.com/95273765/196302149-a2e79840-ea70-4619-ade9-4835212ba548.png)

Example 2:
- each peer keeps track of IP address of predecessor, successor and a shortcut
- possible to design shortcuts so O(log N) neighbours, O(log N) messages in query

![image](https://user-images.githubusercontent.com/95273765/196302957-ab19e748-df16-45fa-ae6f-a1dc98f73ce9.png)

Peer churn:
- peers may come and go (churn)
- each peer knows address of successors
- each peer periodically pings its two successors to check aliveness
- if immediate successor leaves, choose next successor as new imeediate successor

## Video streaming and content distribution networks
Streaming multimedia: DASH
- server:
  - divides video file into multiple chunks
  - each chunk stored, encoded at different rates
  - manifest file: provides URLs for different chunks
- client:
  - periodically measures server-to-client bandwidth
  - caonsulting manifest, requests one chunk at a time
    - chooses maximum coding rate sustainable given current bandwidth
    - can choose different coding rates at different points in time
- client determines:
  - when to request chunk
  - what encoding rate to request
  - where to request chunk
- Streaming video = encoding + DASH + playout buffering

To stream conent to hundreds of thousands of simultaneous users, we can store/server multiple copies of videos at multiple geographically distributed sites (CDN)
- enter deep: push CDN servers deep into many access networks (close to users)
- bring home: smaller number of larger clusters in POPs near access networks

Content distribution networks (CDNs)
- CDN: stores copies of content at CDN nodes
- subscriber requests content from CDN
  - directed to nearby copy, retrieves content
  - may choose different copy if network path congested
- the role of the CDN provider's authoritative DNS name server in a content distribution network is described as to map the query for each CDN object to the CDN server closer to the requestor

Steps requesting a video by CDN (example is NetCinema):
- The user visits the web page at NetCinema
- When the user clicks on the link, the user's host sends a DNS query for video.netcinema.com
- The user's Local DNS Server replays the DNS query to an authoritative DNS server for NetCinema, which observes the string 'video' in the hostname video.netcinema.com.
- The DNS query enters into KingCDN's private DNS infrastructure. The user's LDNS then sneds a second query, now for the hostname in the KingCDN's domain, and KingCDN's DNS system eventually returns the IP addresses of a KingCDN content server to the LDNS. It is thus here, within the KingCDN's DNS system, that the CDN server from which the client will receive its content is specified
- The LDNS forwards the IP address of the content-serving CDN node to the user's host
- Once the client receives the IP address for a KingCDN content server, it establishes a direct TCP connection with the server at that IP address and issues an HTTP GET request for the video. If DASH is used, the server will first send to the client a manifest file with a list of URLs, one for each version of the video, and the client will dynamically select chunks from the different versions.

![image](https://user-images.githubusercontent.com/95273765/196329715-fea57b28-8e52-4fc7-8f2e-fc3429a681c0.png)

