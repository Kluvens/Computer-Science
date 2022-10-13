Transport layer provides logical communication between application processes running on different hosts (end systems).

Two principal Internet transport protocols:
1. TCP: provides reliable, in-order delivery, congestion control, flow control and connection setup
2. UDP: provides unreliable and unordered delivery, it's an extension of best-effort IP

## Multiplexing and Demultiplexing
If there are two clients trying to communicate with the server, how does it work?

Both has the same destination, but it has different sockets.

For example, we have two processes running on the server, when sending some data to clients, both of them using the same transport layer, this is referred to as multiplexing.
Even though they come from the same sender, they will finally go to different destinations by using the same transport layer.

When the data come back, they need to be chained to the right process.

Connectless means they don't have to maintain the state of connection.

A single socket for two clients.

In connection-oriented demultiplexing, different sockets in the server are responsible for different clients.
