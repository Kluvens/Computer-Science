## An introduction of HTTP
HTTP is a protocol for fetching resources such as HTML documents.
It is the foundation of any data exchange on the Web and it is a **client-server protocol**, which means requests are initiated by the recipent,
usually the Web browser.
**A complete document is reconstructed from the different subdocuments** fetched,
for instance, text, layout description, images, videos, scripts and more.

Clients and servers communicate by exchanging individual messages.
The messages sent by the client, are called **requests** and the messages sent by the server as an answer are called **responses**.

It is an application layer protocol that is sent over **TCP**.

Due to its extensibility, it is used to not only fetch hypertext documents, but also images and videos or to post content to servers,
like with HTML form results.
HTTP can also be used to fetch parts of document to update Web pages on demand.

Between the client and the server there are numerous entities, collectively called **proxies**,
which perform different operations and act as gateways or caches, for example.

In reality, there are more computers between a browser and the server handling the request:
there are routers, modems, and more.
HTTP is on top, at the **application layer**.

The user-agent is any tool that acts on behalf of the user.
This role is primarily performed by the Web browser,
but it may also be performed by programs used by engineers and Web developers to debug their applications.

To display a Web page, the browser sends an orginal request to fetch the HTML document that represents the page.
It then parses this file, making additional requests corresponding to execution scripts, layout information to display,
and sub-resources contained within the age.
The web browser then combines these resources to present the complete document, the Web page.
Scripts executed by the browser can fetch more resources in later phases and the browser updates the Web page accordingly.

A web page is a hypertext document.
This means some parts of the displayed content are links, which can be activated to fetch a new web page,
allowing the user to direct their user-agent and navigate through the Web.
The browser translates these directions into HTTP requests, and further interprets the HTTP responses to present the user with a claer response.

A server is not necessarily a single machine, but several server software instances can be hosted on the same machine.
They may share the same IP address.

Proxies may perform numerous functions:
- caching
- filtering (like an antivirus scan or parental controls)
- load balancing (to allow multiple servers to server different requests)
- authentication (to control access to different resources)
- logging (allowing the storage of historical information)

HTTP is **stateless**: there is no link between two request being successively carried out on the same connection.
But while the core of HTTP itself is stateless, **HTTP cookies allow the use of stateful sessions**.
Using header extensibility, HTTP cookies are added to the workflow, allowing session creation on each HTTP request to share the same context, or the same state.

A connection is controlled at the transport layer, and therefore fundamentally out of scope for HTTP.
HTTP doesn't require the underlying transport protocol to be connection-based;
it only requires it to be reliable, or not lose messages.

Before a client and server can exchange an HTTP request/response pair, they must establish a TCP connection, a process which requires several round-trips.

HTTP/1.1 introduced pipelining and persistent connections:
the underlying TCP connection can be partially controlled using the Connection header.

HTTP/2 went a step further by multiplexing messages over a single connection, helping keep the connection warm and more efficient.

Common features controllable with HTTP:
- Caching: how documents are cached can be controlled by HTTP. The server can instruct proxies and clients about what to cache and for how long. The client can instruct intermediate cache proxies to ignore the stored document
- Authentication: some pages may be protected so that only specific users can access them.
- Sessions: using HTTP cookies allows us to link requests with the state of the server. This create sessions, despite basic HTTP being a stateless protocol
- Proxy and tunneling: servers or clients are often located on intranets and hide their true IP address from other computers. HTTP then go through proxies to cross this network barrier.

## HTTP and HTTPS
HTTP has no data encryption implemented while HTTPS surpports encrypted connections.

HTTP remains focused on presenting the information, but cares less about the way this information travels from one place to another.
Unfortunately, this means that HTTP can be intercepted and potentially altered, making both the information and information receiver vulnerable.

HTTPS is an extension of HTTP.
HTTPS is powered by Transport Layer Security (TLS), the standard security technology that establishes an encrypted connection between a web server and a browser.

## API, Socket and Port

## Cookie and Session
