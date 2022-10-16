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
- reduce content size for transfer
- change HTTP to make better use of available bandwidth
- change HTTP to avoid repeated transfers of the same content
- move content closer to the client (CDNs)
