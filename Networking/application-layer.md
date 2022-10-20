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

![image](https://user-images.githubusercontent.com/95273765/196856410-90b23b58-2c08-434c-b163-5afd85f0596f.png)

Persistent HTTP without pipelining: no need to set up TCP connection every time but still needs to request every file

![image](https://user-images.githubusercontent.com/95273765/196856770-ec94b605-a042-4e2f-b41a-cfa1bdacf1f2.png)

Persistent HTTP (HTTP 1.1):
- one RTT with initiating TCP connection
- one RTT for requesting file
- as little as one RTT for all the referenced objects for persistent connection via pipelining

![image](https://user-images.githubusercontent.com/95273765/196856579-99f8546b-6cc7-48ec-9b28-52ddcc146692.png)

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
- load distribution (many IP addresses correspond to one name)

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
- generally speaking, it behaves like a cache
- the record inside the local server has a TTL which means that if it's not reached by a certain number of times, it will be deleted

DNS name resolution:
- iterative query: client -> local -> root -> local -> TLD -> local -> authoritative -> local -> client
- recursive query: client -> local -> root -> TLD -> authoritative -> TLD -> root -> local -> client

DNS records (RR format (name, value, type, ttl)):
- type = A (name is hostname, value is IP address)
- type = NS (name is domain, value is hostname of authoritative name server for this domain)
- type = CHAME (name is alias, value is canonical name)
- type = MX (value is the name of mailserver associated with name)

Addresses:
- domain name: google.com
- host name: www.google.com
- IP address: 192.158.1.38

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
  
Distributed Hash Table (DHT):
- The main diffference is that the in CS, the server stores all the information whereas in P2P, the information is stored in many other peers
- a distributed P2P database
- database has pairs
- distribute the pairs over many pairs
- a peer queries DHT with key, DHT returns values that match the key
- peers can also insert pairs

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
  
Streaming video = encoding + DASH + playout buffering

To stream conent to hundreds of thousands of simultaneous users, we can store/server multiple copies of videos at multiple geographically distributed sites (CDN)
- enter deep: push CDN servers deep into many access networks (close to users)
- bring home: smaller number of larger clusters in POPs near access networks

Content distribution networks (CDNs)
- CDN: stores copies of content at CDN nodes
- subscriber requests content from CDN
  - directed to nearby copy, retrieves content
  - may choose different copy if network path congested
- the role of the CDN provider's authoritative DNS name server in a conent distribution network is described as to map the query for each CDN object to the CDN server closer to the requestor

Steps requesting a video by CDN (example is NetCinema):
- The user visits the web page at NetCinema
- When the user clicks on the link, the user's host sends a DNS query for video.netcinema.com
- The user's Local DNS Server replays the DNS query to an authoritative DNS server for NetCinema, which observes the string 'video' in the hostname video.netcinema.com.
- The DNS query enters into KingCDN's private DNS infrastructure. The user's LDNS then sneds a second query, now for the hostname in the KingCDN's domain, and KingCDN's DNS system eventually returns the IP addresses of a KingCDN content server to the LDNS. It is thus here, within the KingCDN's DNS system, that the CDN server from which the client will receive its content is specified
- The LDNS forwards the IP address of the content-serving CDN node to the user's host
- Once the client receives the IP address for a KingCDN content server, it establishes a direct TCP connection with the server at that IP address and issues an HTTP GET request for the video. If DASH is used, the server will first send to the client a manifest file with a list of URLs, one for each version of the video, and the client will dynamically select chunks from the different versions.

![image](https://user-images.githubusercontent.com/95273765/196329715-fea57b28-8e52-4fc7-8f2e-fc3429a681c0.png)

