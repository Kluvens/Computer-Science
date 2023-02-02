## What is HTTP
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
