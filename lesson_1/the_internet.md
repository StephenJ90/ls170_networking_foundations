LS170 Networking Foundations > Lesson 1

---

The Internet
===

##### What is the Internet and How does it work?

The Internet may be conceived of a vast network of networks. At the most basic level, this means a large interconnected system of computers, switches, and routers communicating with each other. The physical channels of communication include wires and radio waves. The Internet is designed in such a way that it is fully distributed with no central control deciding how information is routed or where pieces of the network are built, or even who interconnects those various pieces.

Like any system of communication, the Internet employs rules for how communication should occur over the network. Machines and software need to be able to speak the same language in order for orderly communication to take place. A protocol is the name for a set of rules used for network communication. The Internet employs different protocols for different aspects of network communication or for different purposes within the same aspect of network communication. Some protocols are concerned with the flow and order of messages (e.g. TCP), whereas other protocols are concerned with the structure of those messages (e.g. HTTP).

Thus, the Internet can be thought of as a vast network of networks through which orderly communication between devices takes place in accordance with a set of protocols.

How do we ensure that all the different types of devices, of different makes and models, and different software and applications, are able to connect and run on the internet? The answer is protocols, which are a system of rules that govern the transmission of data. 

##### Why are there so many different protocols for network communication? Two of the main reasons are:

1. Different protocols were developed to address different aspects of network communication.
* structure of a message in a request
* flow and order of all the messages in a request
2. Different protocols were developed to address the same aspect of network communication, but in a different way or for a specific use-case.

TCP and UDP would be examples of two protocols that address the same basic aspect of communication, the _transfer_ of messages between applications, but do so in different ways. TCP and HTTP would be examples of two protocols that address different aspects of communication; TCP the transfer of messages between applications, and HTTP the _structure_ of those messages.

Different aspects of network communication work together to create an overall network communication system.

---

### A Layered System

The _Internet Protocol Suite_ divides the layers in terms of the scope of communications within each layer (within a local network, between networks, etc). The _Open Systems Interconnection_ (OSI) model divides the layers in terms of the functions that each layer provides (physical addressing, logical addressing and routing, encryption, compression, etc).

OSI and Internet Protocol Suite Models
There are two main models that have been constructed in order to help us understand at a much deeper level what is going on "under the hood" of the Internet. Those two models are the Open Systems Interconnection (OSI) model and the Internet Protocol Suite model (also known as the TCP/IP model or DoD model). Both models break network communication down into separate layers (7 in the OSI model and 4 in the TCP/IP model):

###### OSI Model Layers (from the topmost layer):

* Application
* Presentation
* Session
* Transport
* Network
* Data Link
* Physical

###### TCP/IP Model Layers (from the topmost layer):

* Application
* Transport
* Internet
* Link

The top three layers of the OSI Model mostly map to the topmost layer of the TCP/IP Model. The Transport layer of both models are roughly equivalent, as are the Network and Internet layers of the respective models. The Datalink and Physical layers of the OSI model mostly map to the Link layer of the TCP/IP model.

Separating network communication into these separate layers allows us to group the various protocols according to the layer of communication to which they apply. The idea is that at each layer, protocols determine how the data moving across the network must be structured. At each layer, data is encapsulated within a data unit according to the rules defined by a specific protocol, and consequently hiding the data from the layer below it.

##### Protocol Data Units (PDU's)

Within our network models, a Protocol Data Unit (PDU) is an amount or block of data transferred over a network. Different protocols or protocol layers refer to PDUs by different names.

In all cases, the basic concept is effectively the same; the PDU consists of a header, a data payload, and in some cases a trailer or footer.

###### Purpose of the Header and Trailer 

To provide protocol-specific metadata about the PDU. For example, an Internet Protocol (IP) packet header would include fields for the Source IP Address and the Destination IP Address, which would be used to correctly route the packet.

###### Data Payload

The data payload portion of a PDU is simply the data that we want to transport over the network using a specific protocol at a particular network layer.

The data payload is the key to the way encapsulation is implemented. The entire PDU from a protocol at one layer is set as the data payload for a protocol at the layer below. For example, a HTTP Request at the Application layer could be set as the payload for a TCP segment at the transport layer.

This means that a protocol at one layer doesn't need to know anything about how a protocol at another layer is implemented in order for those protocols to interact. 

A TCP segment isn't really concerned whether its data payload is an HTTP request, an SMTP command, or some other sort of Application layer data. It just knows it needs to encapsulate some data from the layer above and provide the result of this encapsulation to the layer below.

---

### The Physical Network

Underlying everything at the most basic level is a 'physical' network made of tangible pieces such as networked devices, cables, and wires. The functionality at this level is essentially concerned with the transfer of bits (binary data). In order to be transported, these bits are converted into signals. Depending on the transportation medium used, bits are converted to electrical signals, light signals, or radio waves.

* Electricity loses it's signal strength over just a few hundred feet. (Ethernet Cables)
* Fibre Optics (Light) is very fast and doesn't lose signal strength but it is expensive and hard to work with.
* Radio waves have given us wireless connections (mobile) but has a relatively short range. 

Everything (photos, videos, messages, music etc) is sent over the internet as 1's and 0's (binary code) via light pulses, electrical signals and radio waves. Because the Internet is comprised of physical devices and connections it faces physical constraints.

##### The Main Characteristics of a Physical Network

_Latency_ is a measure of the time it takes for some data to get from one point in a network to another point in a network. _Bandwidth_ is the amount of data that can be sent at one time.

##### The Elements of Latency

* Latency is a measure of delay. Data starts at one location at a certain point in time. At a later point in time, it reaches another location. The difference between those two points in time is the delay. There are actually different types of delay that go together to determine the overall latency of a network connection.
* **Propagation delay**: this is the amount of time it takes for a message to travel from the sender to the receiver, and can be calculated as the ratio between distance and speed.
* **Transmission delay**: the journey of data from point A to point B on a network typically won't be made over one single cable. Instead, the data will travel across many different wires and cables that are all inter-connected by switches, routers, and other network devices. Each of these elements within the network can be thought of as an individual 'link' within the overall system. Transmission delay is the amount of time it takes to push the data onto the link.
* **Processing delay**: Data travelling across the physical network doesn't directly cross from one link to another, but is processed in various ways.
* **Queuing delay**: Network devices such as routers can only process a certain amount of data at one time. If there is more data than the device can handle, then it queues, or buffers, the data. The amount of time the data is waiting in the queue to be processed is the queuing delay.
* The total latency between two points, such as a client and a server, is the sum of all the delays above. This value is usually given in milliseconds (ms).
* **Last-mile latency**: a lot of the delays described above can take place within the parts of the network which are closest to the end points. This is often referred to as 'last-mile latency' and relates to the delays involved in getting the network signal from your ISP's network to your home or office network. The 'hops' within the core part of the network are longer with less interruptions for transmission, processing, and queuing. At the network edge, there are more frequent and shorter hops as the data is directed down the network hierarchy to the appropriate sub-network. You can think of the network edge as the 'entry point' into a network like a home or corporate LAN.
* **Round-trip Time (RTT)**: A latency calculation often used in networking is Round-trip Time (RTT). This is the length of time for a signal to be sent, added to the length of time for an acknowledgement or response to be received.

###### Network Hops:

The journey of a piece of data on the network isn't direct from the start point to the end point but will consist of several 'hops', or journeys, between nodes on the network. You can think of the nodes as routers that process the data and forward it to the next node on the path.

##### Bandwidth

* Bandwidth varies across the network, and isn't going to be at a constant level between the start point and the end point of our data's journey. For example, the capacity of the core network is going to be much higher than the part of the network infrastructure that ultimately connects to your home or office building. The bandwidth that a connection receives is the lowest amount at a particular point in the overall connection. A point at which bandwidth changes from relatively high to relatively low is generally referred to as a bandwidth bottleneck.

---

### The Link / Data Link Layer

The protocols operating at this layer are primarily concerned with the identification of devices on the physical network and moving data over the physical network between the devices that comprise it, such as hosts (e.g. computers), switches, and routers. We can think of what happens at this layer as an interface between the workings of the physical network and the more logical layers above. 

The most commonly used protocol at this layer is the Ethernet protocol.

###### Ethernet Frames

Ethernet Frames are a Protocol Data Unit, and encapsulate data from the Internet/ Network layer above. The Link/ Data Link layer is the lowest layer at which encapsulation takes place. At the physical layer, the data is essentially a stream of bits in one form or another without any logical structure. An Ethernet Frame adds logical structure to this binary data. The data in the frame is still in the form of bits, but the structure defines which bits are actually the data payload, and which are metadata to be used in the process of transporting the frame. An Ethernet-compliant network device is able to identify the different parts of a frame due to the fact that different 'fields' of data have specific lengths in bytes and appear in a set order.

These are the two main fields of the frame that we need to know about:

* **Source and Destination MAC address**: The next two fields, each six bytes (48 bits) long, are the source and destination MAC addresses. The source address is the address of the device which created the frame (as we'll see later on in this assignment, this can change at various points along the data's journey). The destination MAC address is the address of the device for which the data is ultimately intended. MAC Addresses are a key part of the Ethernet protocol; we'll look at them in more detail shortly.

* **Data Payload**: the data payload field can be between 42 and 1497 bytes in length. It contains the data for the entire Protocol Data Unit (PDU) from the layer above, an IP Packet for example.

###### MAC Addresses

Every network-enabled device, e.g. a Network Interface Card (NIC) that you would find in a PC or laptop, is assigned a unique MAC Address when it is manufactured. Since this address is linked to the specific physical device, and (usually) doesn't change, it is sometimes referred to as the physical address or burned-in address. MAC Addresses are formatted as a sequence of six two-digit hexadecimal numbers, e.g. 00:40:96:9d:68:0a, with different ranges of addresses being assigned to different network hardware manufacturers.

Like a hub, a switch is a piece of hardware to which you connect devices to create a network. Unlike a hub however, a switch uses the destination address in order to direct a frame _only_ to the device for which it is intended. A hub would check the destination address against every device address. If the Addresses don't match, then it the device will ignore the frame. The frame will get directed to every device on the network until a matching address is found. Very inefficient which is why switches are more commonly used.

A switch directs the frames to the correct device by keeping and updating a record of the MAC addresses of the devices connected to it, and associating each address with the Ethernet port to which the device is connected on the switch. It keeps this data in a MAC Address Table, a simple representation of which might look something like this:

| Switch Port | MAC Address       |
| :---------- | :---------------- |
| 1           | 00:40:96:9d:68:0a |
| 2           | 00:A0:C9:14:C8:29 |
| 3           | D8:D3:85:EB:12:E3 |
| 4           | 00:1B:44:11:3A:B7 |

###### A Problem of Scale

The MAC Addressing system works well for local networks, where all the devices are connected to a switch that can keep a record of each device's address. In theory, we could conduct inter-network communication just using MAC addresses. For example, we could design routers that kept records of which MAC Addresses could be accessed via other routers on the wider network. In practice however, there's an issue that prevents us from doing this: scale. This approach isn't scalable due to certain characteristics of MAC addresses:

* They are physical rather than logical. Each MAC Address is tied (burned in) to a specific physical device
* They are flat rather than hierarchical. The entire address is a single sequence of values and can't be broken down into sub-divisions.

Imagine your laptop is connected to a local network in New York. You then take that laptop to Tokyo and plug it into a local network there. In both locations, the physical MAC address would be the same. Keeping track of which MAC Addresses were part of which local networks would be an impossible task. Even if we were able to do this, the fact that the addresses are non-hierarchical means that routing devices would need a record of each single address that existed somewhere in the world; that would mean storing impossibly large tables.

If we want to solve these problems, we need a different system of rules that doesn't have these limitations and that can scale in such a way that we can build a network of networks which spans the entire globe. The Internet Protocol provides just such a set of rules.

___

### The Internet/Network Layer

The primary function of protocols at this layer is to facilitate communication between hosts (e.g. computers) on different networks. The Internet Protocol (IP) is the predominant protocol used at this layer for inter-network communication. The primary features of both versions(IPv4 and IPv6) are the same:

* Routing capability via IP addressing
* Encapsulation of data into packets

###### Data Packets

The Protocol Data Unit (PDU) within the IP Protocol is referred to as a packet. A packet is comprised of a Data Payload and a Header. Just as with Ethernet Frames, the Data Payload of an IP Packet is the PDU from the layer above (the Transport layer). It will generally be a TCP segment or a UDP datagram. The Header is split into logical fields which provide metadata used in transporting the packet. Again, as with Ethernet Frames, the data in the IP Packet is in bits. The logical separation of those bits into header fields and payload is determined by the set size of each field in bits and the order within the packet.

We won't describe every field in the header, but some of the more important ones to be aware of are:

* **Version**: this indicates the version of the Internet Protocol used, e.g. IPv4
* **ID, Flags, Fragment Offset**: these fields are related to fragmentation. If the Transport layer PDU is too large to be sent as a single packet, it can be fragmented, sent as multiple packets, and then reassembled by the recipient.
* **TTL**: every packet has a Time to Live (TTL) value. This is to ensure that any packets which don't reach their destination for some reason aren't left to endlessly bounce around the network. The TTL indicates the maximum number of network 'hops' a packet can take before being dropped. At each hop, the router which processes and forwards the packet will decrement the TTL value by one.
* **Protocol**: this indicates the protocol used for the Data Payload, e.g. TCP, UDP, etc.
* **Checksum**: this is an error checking value generated via an algorithm. The destination device generates a value using the same algorithm and if it doesn't match, it drops the packet. IP doesn't manage retransmission of dropped packets. This is left to the layers above to implement.
* **Source Address**: the 32-bit IP address of the source (sender) of the packet
* **Destination Address**: the 32-bit IP address of the destination (intended recipient) of the packet

###### IP Addresses (IPv4)

Unlike MAC Addresses, IP Addresses are logical in nature. This means that they are not tied to a specific device, but can be assigned as required to devices as they join a network. The IP address that the device is assigned must fall within a range of addresses available to the local network that the device is connected to. This range is defined by a network hierarchy, where an overall network is split into logical subnetworks, with each defined by the range of IP addresses available to it.

IPv4 addresses are 32 bits in length and are divided into four sections of eight bits each. When converted from binary to decimal, each of those sections provides a range of numbers between 0 and 255 (since 2 to the power of 8 equals 256). For example 109.156.106.57.

A basic example of this hierarchy in action would be if all the addresses in the range 109.156.106.0 to 109.156.106.255 were assigned to a single local network. Each network defines the address at the start of the range, e.g. 109.156.106.0, as the network address, and the address at the end of the range, e.g. 109.156.106.255, as the broadcast address. Addresses between the network and broadcast address, 109.156.106.1 to 109.156.106.254, can be allocated to individual devices on the network.

The network address of the range is used to identify a specific network segment. What this means is that a router that wants to forward an IP packet to any address in the entire range only needs to keep a record of which router on the network controls access to the segment with that network address. This logic is what creates the hierarchical structure, and means that routers don't need to keep records of every single device within an addressable range.

This splitting of a network into parts is referred to as sub-netting. By dividing IP address ranges further, subnets can be split into smaller subnets to create even more tiers within the hierarchy.

###### Routing and Routing Tables

All routers on the network store a local routing table. When an IP packet is received by a router, the router examines the destination IP address and matches it against a list of network addresses in its routing table. As explained above, these network addresses define a range of addresses within a particular subnet. The matching network address will determine where in the network hierarchy the subnet exists. This will then be used to select the best route for the IP packet to travel.

###### IPv6

The structure of IPv4 addresses means that there is a logical maximum of around 4.3 billion addresses. Due to the popularity of the internet, it is anticipated that this pool of addresses will eventually be depleted. Since the late 1990s, the Internet Engineering Task Force (IETF) have been working on a new version of the Internet Protocol called IPv6. Since IPv6 uses 128-bit addresses (eight 16-bit blocks), this increases the theoretical number of possible addresses to approximately 340 undecillion (340 billion billion billion billion).

Whereas the Ethernet protocol provides communication between devices on the same local network, the Internet Protocol enables communication between two networked devices anywhere in the world. We can send a message from one device on the internet and it can reach another device on the internet.

If we want to create networked applications however, communication between devices isn't sufficient. A single client device can have many applications running on it, such as a web browser, an email client, etc. Similarly a server can have many services running on it, such as a web server, a file server, or a mail server. Being able to transport data from one device to the other isn't sufficient to ensure that a specific application on the client can access the correct service on the server.

In the next lesson, we'll look at what Transport layer protocols such as TCP and UDP add to the picture to enable communication between specific applications.

##### How Data is sent over the internet - Link/Network Layer

A switch directs the frames to the correct device by keeping and updating a record of the MAC addresses of the devices connected to it, and associating each address with the Ethernet port to which the device is connected on the switch. It keeps this data in a MAC Address Table. These devices could be computers or a router(default gateway) out of this network. Remember, a network will have a gateway that data must pass through to get in and out of it's network. 

Data sent out in a frame from a computer will go to the switch. The switch will check the header of that frame for a MAC address. The switch will compare the destination MAC address against it's MAC Address Table. If it finds the destination MAC address in it's table, it will send the frame out the port the corresponds with device that has that destination MAC address, which for our case will be the default gateway(router). The frame is now at the default gateway(router). The router will then look at the header of this frame and sees that the destination MAC address matches it's MAC address and knows that this data is meant for it and needs to examine it further, so the router decapsulates the frame to look at the packet header. All routers on the network store a local routing table. When an IP packet is received by a router, the router examines the destination IP address and matches it against a list of network addresses in its routing table. So the router looks at the destination IP address and says "I know where that is!". It encapsulates the packet into a new frame with a new Source and Destination MAC address. It gets the Source MAC address from a protocal called ARP which we do not need to worry about. We have our new frame, so now the router sends it off to network where the final destination resides. This network will most likely have multiple devices in it, so the frame has to make a stop at the switch of the network to get final directions to the destination. The switch looks at the frame header and sees the Destination MAC address and says "I know where that is!" because the switch has a MAC Address Table that lists all of the devices that are in it's network. Each of these devices corresponds to a certain port, so the switch finds the port that corresponds with the Destination MAC address and sends the frame out of thar port to the final destination(host). The Host will then look at the frame header and see that Destination MAC address matches it's MAC address and know that this data is meant for it. It will then look at the packet and see that the Destination IP address matches the it's IP address and will also know who sent it(source IP address).








