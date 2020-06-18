LS170 Networking Foundations > Lesson 2

---

The Transport Layer
===

Understanding the role of the Transport layer is key to comprehending how networked applications communicate with each other. If we want to create modern networked applications, there's a number of things that we need beyond what IP can provide. Two of the most important things are a direct connection between applications, and reliable network communication.

The Internet Protocol (IP) essentially provides the inter-network communication services necessary for what we might think of as a _minimum viable internet_.

An important thing to understand about the Internet Protocol, and its system of addressing, is that it is intended to provide communication between hosts, or devices. These hosts can potentially be on the same local network, or on different local networks halfway around the world from each other. Either way, we can use IP to get a message from one host to the other, but not any more than that.

As we know though, there are potentially many applications running on a single host. If IP can get us as far as the host, how do we provide communication between an application running on one host and an application running on another host (or potentially between two different applications or processes running on the same host)?

---

#### Multiplexing and Demultiplexing

As we've established, there might be many networked applications or processes running on a device at one time. These applications all want to be able to send and receive data simultaneously. For example, you might want to send an email while listening to Spotify or load a web page in your browser while chatting in Slack. We can perhaps think of these different applications or processes as distinct channels for communication on a host machine.

With IP addresses we only have a single channel between hosts. What we need is a way to transmit these multiple data inputs over this single host-to-host channel and then somehow separate them out at the other end.

In the context of a communication network, this idea of transmitting multiple signals over a single channel is known as **multiplexing**. 

Delivering received segments at receiver side to the correct app layer processes is called **demultiplexing**.

These are general concepts that can be applied in lots of contexts within communications networks; for example at the physical level we can think of optical fibres carrying multiple light signals at different angles of refraction, or radio waves carrying signals at different frequencies. Our focus in this assignment is the application of this concept at the Transport layer of our network communication model. This takes place through the use of network ports.

#### Ports

In simple terms a port is an identifier for a specific process running on a host. This identifier is an integer in the range 0-65535. Sections of this range are reserved for specific purposes:

* 0-1023 are well-known ports. These are assigned to processes that provide commonly used network services. For example HTTP is port 80, FTP is port 20 and 21, SMTP is port 25, and so on.
* 1024-49151 are registered ports. They are assigned as requested by private entities. For example, companies such as Microsoft, IBM, and Cisco have ports assigned that they use to provide specific services. On some operating systems, ports in this range are also used for allocation as ephemeral ports on the client side.
* 49152-65535 are dynamic ports (sometimes known as private ports). Ports in this range cannot be registered for a specific use. They can be used for customized services or for allocation as ephemeral ports.

Services running on servers will likely have a port in the well-known range assigned to them. A service running on a client machine, for example in a browser running on your laptop, won't use one of these well-known ports, but instead have an ephemeral or temporary port assigned to it by the operating system.

So we can use ports to identify specific services running on host machines, but how does that help us with multiplexing and demultiplexing? The answer is that the source and destination port numbers are included in the Protocol Data Units (PDU) for the transport layer. The name, and exact structure, of these PDUs varies according to the Transport Protocol used, but what they have in common is that they include these two pieces of information:

#### Source Port and Destination Port

The IP address and the port number together are what enables end-to-end communication between specific applications on different machines. The combination of IP address and port number information can be thought of as defining a communication end-point. This communication end-point is generally referred to as a socket. We'll talk more about sockets later, but for now you can just think of them as the combination of IP address and port number, for example `216.3.128.12:8080`.

Imagine an apartment building. It has numerous apartments, but the building itself has a single street address. The postal worker delivers a bunch of mail to the building. The concierge of the building then sorts the mail and posts the individual letters to the appropriate mailbox in the foyer, each mailbox being identified by a specific apartment number.

In this context we can think of the street address of the apartment building address as the IP address and the individual apartment numbers as port numbers. Furthermore, the postal service can be thought of as the Internet Protocol, and the building concierge as a Transport layer protocol (e.g. TCP or UDP).

#### Sockets

This term is used in slightly different ways depending on the context. At a conceptual level a socket is, an abstraction for an endpoint used for inter-process communication. At an implementation level it can be used to refer to different specific things:

* UNIX socket: a mechanism for inter-process communication between local processes running on the same machine.
* Internet sockets (such as a TCP/IP socket): a mechanism for inter-process communication between networked processes (usually on different machines).

We're primarily interested in is the concept of a socket and to a lesser extent the application of this concept for inter-network communication between networked applications, i.e. Internet Sockets. One important thing to be clear on is that there is a distinction between the concept of a network socket and its implementation in code.

#### Connection-Oriented Network vs Connectionless Network

In a _connectionless_ system we could have one socket object defined by the IP address of the host machine and the port assigned to a particular process running on that machine. That object could call a listen() method which would allow it to wait for incoming messages directed to that particular ip/port pair. Such messages could potentially come from any source, at any time, and in any order, but that isn't a concern in a connectionless system -- it would simply process any incoming messages as they arrived and send any responses as necessary.

A _connection-oriented_ system would work differently. You could have a socket object defined by the host IP and process port, just as in the connectionless system, also using a `listen()` method to wait for incoming messages; the difference in implementation would be in what happens when a message arrives. At this point we could instantiate a new socket object; this new socket object wouldn't just be defined by the local IP and port number, but also by the IP and port of the process/host which sent the message. This new socket object would then listen specifically for messages where all four pieces of information matched (source port, source IP, destination port, destination IP). The combination of these four pieces of information are commonly referred to as a four-tuple.

Any messages not matching this four-tuple would still be picked up by the original socket, which would then instantiate another socket object for the new connection.

Implementing communication in this way effectively creates a dedicated virtual connection for communication between a specific process running on one host and a specific process running on another host. The advantage of having a dedicated connection like this is that it more easily allows you to put in place rules for managing the communication such as the order of messages, acknowledgements that messages had been received, retransmission of messages that weren't received, and so on. The purpose of these types of additional communication rules is to add more reliability to the communication. 

---

### Network Reliability

A major characteristic of the communication protocols that are primarily used to provide the functionality for the lower layers in our network system is that they are inherently unreliable. We've seen that protocols such as Ethernet and the Internet Protocol include checksum data as part of their header or trailer so that the data transported as frames and packets can be tested to ensure it hasn't become corrupt during its journey. If the data is corrupt however, these protocols simply discard it (dropping the frame or packet); there is no provision within these protocols for enabling the replacement of lost data. The possibility of losing data and it not being replaced means that the network up to and including the Internet Protocol is effectively an unreliable communication channel.

We need to develop a system of rules, or a protocol, to ensure that all the data that is sent is received at the other end and in the correct order.

##### Pipelining for Performance

Non-pipelined: One of the main features of our protocol is that each message is sent one at a time, and an acknowledgement is received before the next message is sent. This type of protocol is known as a Stop-and-Wait protocol. It's the 'Wait' part that's the problem here. Within our system, much of the time is spent just waiting for an acknowledgement. This is not an efficient use of bandwidth.

Pipelined: To improve the throughput of our protocol, we could send multiple messages one after the other without waiting for acknowledgements. The receiver still sends acknowledgements, and retransmission can still occur, so our system is still reliable. The difference is that multiple messages are being transferred at any one time. The sender will implement a 'window' representing the maximum number of messages that can be in the 'pipeline' at any one time, once it has received the appropriate acknowledgements for the messages in the window, it moves the window on.

Finding a balance between reliability and performance is a major part of the implementation of the Transmission Control Protocol (TCP).

---

### Transmission Control Protocol (TCP)

One of the key characteristics of this protocol is the fact that it provides reliable data transfer. Reliability is listed as a key element of TCP operation as defined in RFC793.

* The TCP must recover from data that is damaged, lost, duplicated, or delivered out of order by the internet communication system.

TCP also provides data encapsulation and multiplexing through the use of TCP Segments.

#### TPC Segments (PDU)

A TCP Segment header contains a number of different fields. As we saw earlier in this Lesson, two of these fields -- Source Port and Destination Port -- provide the multiplexing capability of the protocol. Most of the other header fields are related to the way that TCP implements reliable data transfer. 

Some of the more important fields in the header in terms of implementing reliability are:

* CHECKSUM: The Checksum provides the Error Detection aspect of TCP reliability. It is an error checking value generated by the sender using an algorithm. The receiver generates a value using the same algorithm and if it doesn't match, it drops the Segment.  IPv6 headers don't include a Checksum, based on the assumption that checksums are implemented at either the Transport or Link/ Data Link layers (or both).
* SEQUENCE NUMBER and ACKNOWLEDGEMENT NUMBER: these two fields are used together to provide for the other elements of TCP reliability such as In-order Delivery, Handling Data Loss, and Handling Duplication.

#### TCP Connections

TCP is a connection-oriented protocol. It doesn't start sending application data until a connection has been established between application processes. In order to establish a connection TCP uses what is known as a Three-way Handshake' this is where the SYN and ACK flags come into play. 

A simplified version of the Three-way Handshake process would look something like this:

* The sender sends a SYN message (a TCP Segment with the SYN flag set to 1)
* Upon receiving this SYN message, the receiver sends back a SYN ACK message (a TCP Segment with the SYN and ACK flags set to 1)
* Upon receiving the SYN ACK, the sender then sends an ACK (a TCP Segment with the ACK flag set to 1)

Upon sending the ACK, the sender can immediately start sending application data. The receiver must wait until it has received the ACK before it can send any data back to the sender. One of the main reasons for this process is to synchronise (SYN) the sequence numbers that will be used during the connection.

One of the main take-aways should be that there's a certain amount of complexity involved in the way that TCP manages connection state. This fact is particularly pertinent to the initial establishment of a connection, where a key characteristic of the process is that the sender cannot send any application data until after it has sent the ACK Segment. What this means in practical terms, is that there is an entire round-trip of latency before any application data can be exchanged. Since this hand-shake process occurs every time a TCP connection is made, this clearly has an impact on any application which uses TCP at the transport layer.

TCP involves a lot of overhead in terms of establishing connections, and providing reliability through the retransmission of lost data. In order to mitigate against this additional overhead, it is important that the actual functioning of data transfer when using the protocol occurs as efficiently as possible. In order to help facilitate efficient data transfer once a connection is established, TCP provides mechanisms for flow control and congestion avoidance.

#### Flow Control

Flow control is a mechanism to prevent the sender from overwhelming the receiver with too much data at once. The receiver will only be able to process a certain amount of data in a particular time-frame. Data awaiting processing is stored in a 'buffer'. The buffer size will depend on the amount of memory allocated according to the configuration of the OS and the physical resources available.

Each side of a connection can let the other side know the amount of data that it is willing to accept via the WINDOW field of the TCP header. This number is dynamic, and can change during the course of a connection. If the receiver's buffer is getting full it can set a lower amount in the WINDOW field of a Segment it sends to the sender, the sender can then reduce the amount of data it sends accordingly.

Although flow control prevents the sender from overwhelming the receiver, it doesn't prevent either the sender or receiver from overwhelming the underlying network. For that task we need a different mechanism: Congestion Avoidance.

#### Congestion Avoidance

Network Congestion is a situation that occurs when there is more data being transmitted on the network than there is network capacity to process and transmit the data. You can perhaps think of it as similar to a gridlock of vehicles on a road network. Instead of things coming to a standstill however, the 'excess vehicles' are simply lost.

In the last lesson we looked at IP packets moving across the networks in a series of 'hops'. At each hop, the packet needs to be processed: the router at that hop runs a checksum on the packet data; it also needs to check the destination address and work out how to route the packet to the next hop on its journey to that destination. All of this processing takes time, and a router can only process so much data at once. Routers use a 'buffer' to store data that is awaiting processing, but if there is more data to be processed than can fit in the buffer, the buffer over-flows and those data packets are dropped.

As we've already seen, TCP retransmits lost data. If lots of data is lost that means lots of retransmitted data, which is inefficient. Ideally we want to keep retransmission to a minimum. TCP actually uses data loss as a feedback mechanism to detect, and avoid, network congestion; if lots of retransmissions are occurring, TCP takes this as a sign that the network is congested and reduces the size of the transmission window.

#### Disadvantages of TCP

Although TCP provides reliable data transfer, and also uses flow control and congestion avoidance techniques to try and do so efficiently, there are also drawbacks to using it. We've already seen that there is a latency overhead in establishing a TCP connection due to the handshake process. Another potential issue with using TCP is Head-of-Line (HOL) blocking.

Head-of-line blocking is a general networking concept, and isn't specific to TCP. In general terms it relates to how issues in delivering or processing one message in a sequence of messages can delay or 'block' the delivery or processing of the subsequent messages in the sequence.

With TCP, HOL blocking can occur as a result of the fact that TCP provides for in-order delivery of segments. Although this in order delivery is one aspect of TCP's reliability, if one of the segments goes missing and needs to be retransmitted, the segments that come after it in the sequence can't be processed, and need to be buffered until the retransmission has occurred. This can lead to increased queuing delay which, as we saw in an earlier assignment, is one of the elements of latency.

---

### User Datagram Protocol (UDP)

The Protocol Data Unit (PDU) of UDP is known as a Datagram. The header only has four fields: Source Port, Destination Port, UDP Length (the length, in bits, of the Datagram, including any encapsulated data), and a Checksum field to provide for error detection.

UDP defined by what it doesn't do:

* It provides no guarantee of message delivery
* It provides no guarantee of message delivery order
* It provides no built-in congestion avoidance or flow-control mechanisms
* It provides no connection state tracking, since it is a connectionless protocol

The advantage that UDP has over TCP is its simplicity. This simplicity provides two things to a software engineer: speed and flexibility.

UDP is a connectionless protocol. Applications using UDP at the Transport layer can just start sending data without having to wait for a connection to be established with the application process of the receiver. In addition to this, the lack of acknowledgements and retransmissions means that the actual data delivery itself is faster; once a datagram is sent it doesn't have to be sent again. Latency is less of an issue since without acknowledgements data essentially just flows one way: from sender to receiver. The lack of in-order delivery also removes the issue of Head-of-line blocking (at least at the Transport layer).

It's likely that someone building a UDP-based application will want to implement some of the services that UDP doesn't natively provide. Which services those would be, and the way they're implemented, would be up to whoever was building the application though. For example, you might want your application to have in-order delivery, but at the same time not be worried about the occasional piece of lost data. You could implement sequencing, but choose not to implement data retransmission. The specifics of which services to include are in left up to the software engineer and can be implemented at the application level, effectively using UDP as a 'base template' to build on top of.

An example of such an application would be a voice or video calling application. The occasional piece of dropped data leading to a slightly glitchy call or a few pixels of video not rendering properly is worth the trade off of the speed provided by the protocol which allows the application to work even over long distances where there is high latency. 

#### Summary

* Multiplexing and demultiplexing provide for the transmission of multiple signals over a single channel
* Multiplexing is enabled through the use of network ports
* Network sockets can be thought of as a combination of IP address and port number
* At the implementation level, sockets can also be socket objects
* The underlying network is inherently unreliable. If we want reliable data transport we need to implement a system of rules to enable it.
* TCP is a connection-oriented protocol. It establishes a connection using the Three-way-handshake
* TCP provides reliability through message acknowledgement and retransmission, and in-order delivery.
* TCP also provides Flow Control and Congestion Avoidance
* The main downsides of TCP are the latency overhead of establishing a connection, and the potential Head-of-line blocking as a result of in-order delivery.
* UDP is a very simple protocol compared to TCP. It provides multiplexing, but no reliability, no in-order delivery, and no congestion or flow control.
* UDP is connectionless, and so doesn't need to establish a connection before it starts sending data
* Although it is unreliable, the advantage of UDP is speed and flexibility.
