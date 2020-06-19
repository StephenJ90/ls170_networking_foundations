LS170 Networking Foundations > Lesson 5

---

Transport Layer Security (TLS)
===

HTTP on its own doesn't provide any means of secure message transfer. Using TLS adds a level of security that HTTP lacks. TLS is a complex topic and could take up a whole course on its own!

* Understand that TLS provides for secure message exchange over an unsecure channel
* Learn that there are multiple aspects to security

The Transport Layer Security (TLS) protocol started life as a protocol called SSL (Secure Sockets Layer). This was a proprietary protocol developed by Netscape. Although it was standardized and renamed as TLS in 1999 by the IETF, the terms are often still used interchangeably. You'll commonly still hear people talk about SSL Certificates rather than referring to them as TLS Certificates or Public Key Certificates. When you hear SSL being mentioned, just bear in mind that the person saying it is probably referring to TLS, unless they are speaking historically.

There are three important security services that are provided by TLS: Encryption, Authentication, and Integrity. Each of these services are important in their own right, but when combined they provide for very secure message exchange over what is essentially an unsecure channel.

* **Encryption**: a process of encoding a message so that it can only be read by those with an authorized means of decoding the message
* **Authentication**: a process to verify the identity of a particular party in the message exchange
* **Integrity**: a process to detect whether a message has been interfered with or faked

It isn't mandatory for an application which uses TLS that all three of these services are used simultaneously.

---

## TLS Encryption

Encryption is a major component of the security provided by TLS. The way in which TLS sets up an encrypted connection is via a process known as the TLS Handshake.

#### Symmetric Key Encryption

A system whereby the sender and receiver share a common encryption key.

Alice and Bob want to exchange messages securely. They both agree on a secret key and keep a copy of it. Alice can then encrypt a message using the key and send it to Bob. Bob can decrypt the message using the same key. The same process can be carried out in the other direction for messages that Bob sends to Alice.

In order to work securely, this system relies on the sender and receiver both having access to the key and no one else being able to access it. This raises the question: how do sender and receiver exchange encryption keys in the first place?

We can't just send the key in a readable format to the other party in our message exchange; if the key was intercepted by a third-party, they could then use it to decrypt any subsequent messages between the sender and receiver. What we need is a mechanism whereby we can encrypt the encryption key itself, so that even if it is intercepted it can't be used.

#### Asymmetric Key Encryption

Asymmetric key encryption, also known as public key encryption, uses a pair of keys: a public key, and a private key. Unlike the symmetric system where the same key is used to encrypt and decrypt messages, in the asymmetric system the keys in the pair are non-identical: the public key is used to encrypt and the private key to decrypt.

The important thing to understand is that messages encrypted with the public key can only be decrypted with the private key. The public key is made openly available but the private key is kept in the sole possession of the message receiver.

Alice wants to receive encrypted messages. She generates a public key and a private key. She makes the public key available but keeps the private key to herself. Bob uses Alice's public key to encrypt a message and send it to Alice. Alice decrypts Bob's message using her private key.

An important thing to note here is that this encryption is primarily intended to work in one direction. 

#### The TLS Handshake

* The TLS Handshake is used to agree which version of TLS to use.
* The TLS Handshake is used to exchange the symmetric encryption key.
* The TLS Handshake is used to agree the Cipher Suite.
* TLS uses asymmetric key encryption for the initial key exchange, and then symmetric key encryption for actual message transfer.

To securely send messages via HTTP we want both the request and the response to be encrypted in a such a way that they can only be decrypted by the intended recipient. The most efficient way to do this is via symmetric key cryptography. If we want to use symmetric keys however, we also need a way to securely exchange the symmetric key.

The clever thing about TLS is the way that it uses a combination of symmetric and asymmetric cryptography. The bulk of the message exchange is conducted via symmetric key encryption, but the initial symmetric key exchange is conducted using asymmetric key encryption. The process by which the initial secure connection is set up is conducted during what is known as the TLS handshake.

TLS assumes TCP is being used at the Transport layer, and the TLS Handshake takes place after the TCP Handshake. A step-by-step description of the TLS Handshake process might look something like this:

1. The TLS Handshake begins with a `ClientHello` message which is sent immediately after the TCP `ACK`. Among other things, this message contains the maximum version of the TLS protocol that the client can support, and a list of Cipher Suites that the client is able to use (we'll discuss Ciper Suites a little later on).
2. On receiving the `ClientHello` message, the server responds with a message of its own. This message includes a `ServerHello`, which sets the protocol version and Cipher Suite, as well as other related information. As part of this message the server also sends its certificate (which contains its public key), and a `ServerHelloDone` marker which indicates to the client that it has finished with this step of the handshake.
3. Once the client has received the `ServerHelloDone` marker, it will initiate the key exchange process. It's this key exchange process that ultimately enables both the client and server to securely obtain a copy of the symmetric encryption key that will be used for the bulk of the secure message transfer between the two parties. The exact process for generating the symmetric keys will vary depending on which key exchange algorithm was selected as part of the Cipher Suite (e.g. RSA, Diffie-Hellman, etc). You don't need to worry about the distinctions between these key exchange mechanisms, but as an example RSA works in the following way:
 * The client generates what's known as a 'pre-master secret', encrypts it using the server's public key, and sends it to the server.
 * The server will receive the encrypted 'pre-master secret' and decrypt it using its private key.
 * Both client and server will use the 'pre-master' secret, along with some other pre-agreed parameters, to generate the same symmetric key.
 * As part of the communication which includes the `ClientKeyExchange` message (e.g. the pre-master secret), the client also sends a `ChangeCipherSpec` flag, which tells the server that encrypted communications should now start using the symmetric keys. Additionally this communication includes a `Finished` flag to indicate that the client is now done with the TLS Handshake.
4. The server also sends a message with `ChangeCipherSpec` and `Finished` flags. The client and server can now begin secure communication using the symmetric key.

The key points to remember about the TLS Handshake process is that it is used to:

* Agree which version of TLS to be used in establishing a secure connection.
* Agree on the various algorithms that will be included in the cipher suite.
* Enable the exchange of symmetric keys that will be used for message encryption.

#### Cipher Suites

A cipher is a cryptographic algorithm; in other words they are sets of steps for performing encryption, decryption, and other related tasks. A cipher suite is a suite, or set, of ciphers.

TLS uses different ciphers for different aspects of establishing and maintaining a secure connection. There are many algorithms which can be used for the performing the key exchange process, as well as for carrying out authentication, symmetric key encryption, and checking message integrity.

The algorithms for performing each of these tasks, when combined, form the cipher suite. The suite to be used is agreed as part of the TLS Handshake. As part of the ClientHello message, the client sends a list of algorithms it supports for each required task, and the server chooses from these according to which algorithms it also supports.

---

### TLS Authentication

* TLS Authentication uses digital certificates as a means of identification.
* TLS Authentication relies on a 'chain of trust'.
* TLS Authentication is extremely reliable, but not 100%. It still ultimately relies on trust of the CA's

Being able to transfer data in an encrypted form is all well and good, but what if the source of that encrypted data is malicious? For example, you could be communicating with what you think is your bank, but is in fact a third-party impersonating your bank. We need a means of identifying the other party in our message exchange.

During the TLS Handshake, as part of its response to the ClientHello message, the server provides its certificate. As outlined in the Encryption section, part of the function of this certificate is so that the client can use the Public Key contained within it during the key exchange process. Another function of this certificate is to provide a means of identification for the party providing it.

The certificate will contain various pieces of information, including who the owner is. The certificate, and the Public Key it contains, are only one part of an overall system of authentication.

The exact way that the Public Key is used during this process varies depending on the Authentication algorithm selected as part of the Cipher Suite. Generally however, this process will be something along the following lines:

* The server sends its certificate, which includes its public key.
* The server creates a 'signature' in the form of some data encrypted with the server's private key.
* The signature is transmitted in a message along with the original data from which the signature was created.
* On receipt of the message, the client decrypts the signature using the server's public key and compares the decrypted data to the original version.
* If the two versions match then the encrypted version could only have been created by a party in possession of the private key.

Following a process such as this we can identify that the server which provided the certificate during the initial part of the TLS Handshake as being in possession of the private key, and therefore the actual owner of the certificate.

There's still an issue here though. What's to stop a malicious third-party creating their own key pair and certificate identifying them as, say, a well-known bank? Just as it's possible to create a fake ID card in the real world, it's possible to create a fake digital certificate. How are we to know if a certificate is genuine or not?

#### Certificate Authorities and the Chain of Trust

* CAs digitally sign the certificates they issue, generating a signature using their own private key.
* Before issuing a certificate, CAs verify that whoever is requesting the certificate is who they claim to be.
* Certificates are generally signed by one CA. An Intermediate CA will sign an end-user's certificate, and a Root CA will sign the Intermediate CA's certificate. This creates the 'chain' in the chain of trust.
* There are actually many CAs. Most of them are Intermediate CAs, with a small, trusted group of Root CAs.

If you are presented with a piece of identification, you are much more likely to accept it as genuine if it has been issued by a trustworthy source. When it comes to digital certificates, the trustworthy sources are called _Certificate Authorities_ (CAs).

When a CA issues a certificate, it does a couple of important things:

  1. Verifies that the party requesting the certificate is who they say they are. The way that this is done is up to the CA and will depend to an extent on the type of certificate being issued. In the case of a domain validated server certificate, for example, it can involve proving that you own the domain by uploading a specific file to a server that is accessible by the domain for which the certificate is being issued.

  2. Digitally signs the certificate being issued. This is often done by encrypting some data with the CA's own private key and using this encrypted data as a 'signature'. The unencrypted version of the data is also added to the certificate. In order to verify that the certificate was issued by the CA, the signature can be decrypted using the CA's public key and checked for a match against the unencrypted version.

So who exactly are these Certificate Authorities, and why should we trust them? There are different 'levels' of CA. An 'Intermediate CA' can be any company or body authorised by a 'Root CA' to issue certificates on its behalf.

Example: 'chain of trust' from google.com to Google Internet Authority to GlobalSign.

GlobalSign is a root CA and its certificate is what's known as a Root Certificate. Root Certificates are 'self-signed', and are essentially the end-point of the chain of trust.

Client software, such as browsers, store a list of these authorities along with their Root Certificates (which includes their public key). When receiving a certificate for checking, the browser can go up the chain to the Root Certificate stored in its list.

The purpose of this chain-like structure is the level of security it provides. The private keys of the Root CAs are kept behind many layers of security in order to be kept as inaccessible as possible. As such they don't issue end-user certificates, but leave that up to the Intermediate CAs. Additionally, if the private key of an Intermediate CA somehow became compromised, the root CA can revoke the certificate for Intermediate, therefore invalidating all of the certificates down the chain from it, and simply issue a new one.

It is necessary that such a 'chain of trust' would need to have an end-point, but if no-one is authenticating the Root CAs other than themselves, how do we know we can trust them? The answer to this is simply their reputation gained through prominence and longevity. Root CAs are essentially a small group of organisations approved by browser and operating system vendors.

---

### TLS Integrity

#### TLS Encapsulation

The OSI model defines TLS as a Session layer protocol, and so existing in between Application layer (where HTTP resides) and the Transport layer (where TCP resides).

TLS sends messages in a certain format. This format can vary depending on the the particular function that TLS is performing, but when it is transporting application data TLS encapsulates that data in the same way that we've seen with other Protocol Data Units. The main field from the meta-data that interests us in terms of providing message integrity is the `MAC` field.

#### Message Authentication Code (MAC)

* It is an algorithmically generated code included in TLS record to provide a means of checking the integrity of the record payload.

The `MAC` field is similar in concept to the checksum fields we've already seen in other PDUs. The checksum field in, say, a TCP Segment is intended for error detection (i.e. to test if some data was corrupted during transport). The intention of the MAC field in a TLS record is to add a layer of security by providing a means of checking that the message hasn't been altered or tampered with in transit.

The way this is implemented is through the use of a hashing algorithm. It works something like this:

  1. The sender will create what's called a digest of the data payload. This is effectively a small amount of data derived from the actual data that will be sent in the message. The digest is created using a specific hashing algorithm combined with a pre-agreed hash value. This hashing algorithm to be used and hash value will have been agreed as part of the TLS Handshake process when the Cipher Suite is negotiated.
  2. The sender will then encrypt the data payload using the symmetric key (as described earlier in the Encryption section), encapsulate it into a TLS record, and pass this record down to the Transport layer to be sent to the other party.
  3. Upon receipt of the message, the receiver will decrypt the data payload using the symmetric key. The receiver will then also create a digest of the payload using the same algorithm and hash value. If the two digests match, this confirms the integrity of the message.

#### Summary

* HTTP Requests and Responses are transferred in plain text; as such they are essentially insecure.
* We can use the Transport Layer Security (TLS) Protocol to add security to HTTP communications.
* TLS encryption allows us to encode messages so that they can only be read by those with an authorized means of decoding the message
* TLS encryption uses a combination of Symmetric Key Encryption and Asymmetric Key Encryption. Encryption of the initial key exchange is performed asymmetrically, and subsequent communications are symmetrically encrypted.
* The TLS Handshake is the process by which a client and a server exchange encryption keys.
* The TLS Handshake must be performed before secure data exchange can begin; it involves several round-trips of latency and therefore has an impact on performance.
* A cipher suite is the agreed set of algorithms used by the client and server during the secure message exchange.
* TLS authentication is a means of verifying the identity of a participant in a message exchange.
* TLS Authentication is implemented through the use of Digital Certificates.
* Certificates are signed by a Certificate Authority, and work on the basis of a Chain of Trust which leads to one of a small group of highly trusted Root CAs.
* Certificates are exchanged during the TLS Handshake process.
* TLS Integrity provides a means of checking whether a message has been altered or interfered with in transit.
* TLS Integrity is implemented through the use of a Message Authentication Code (MAC).
* TLS lets us verify the the identity of a particular party in a message exchange.
* TLS allows us to encode messages so that they can only be read by those with an authorized means of decoding them.
* TLS lets us detect whether a message has been interfered with or faked.