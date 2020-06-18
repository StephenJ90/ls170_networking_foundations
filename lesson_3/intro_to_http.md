LS170 Networking Foundations > Lesson 3

---

Intro to HTTP
===

* At its core, HTTP is a set of rules concerned with the syntax and structure of messages exchanged between applications. Working with HTTP is ultimately about understanding what those rules mean, and knowing how and when to apply them. 
* One of the fundamental aspects of HTTP is its Request-Response behavior.
*  HTTP is essentially a set of rules for structuring messages between two participants in a message exchange. It's up to the participants, for example a web browser and web server, to implement those rules. Ultimately it is the way that the rules are implemented which determines whether or not a message can be interpreted and also how messages are interpreted.

### The Application Layer

The application layer is not the application itself, but rather a set of protocols which provide communication services to applications.

One thing both models have in common however is that the protocols which exist at the Application layer are the ones with which the application most directly interacts. That's not to say that networked applications are limited to interacting with only Application layer protocols. However, it is much less common to build applications which interact directly with protocols below the Transport layer.

The protocols we've looked at within other layers, in both the OSI and TCP/IP models, have mainly been concerned with managing the establishment and flow of communications; in other words, the rules around how messages get from one point to another. Application layer protocols rely on the protocols at the layers below them to ensure that a message gets to where it is supposed to, and focus instead on the structure of that message and the data that it should contain.

We can perhaps think of Application layer protocols as being the rules for how applications talk to each other at a syntactical level. Different types of applications have different requirements with regards to how they communicate at a syntactical level, and so as a result there are many different protocols which exist at the application layer. For example, the rules for how an email client communicates with an email server will be different from the rules for how a web browser communicates with a web server, because emails and web pages are fundamentally different things serving different purposes.

---

### HTTP and the Web

HTTP is the primary protocol used for communication on the Web. The World Wide Web, or web for short, is a service that can be accessed via the internet. In simple terms it is a vast information system comprised of resources which are navigable by means of a URL (Uniform Resource Locator). HTTP is closely tied, both historically and functionally, to the web as we know it. It is the primary means by which applications interact with the resources which make up the web.

A **Uniform Resource Identifier (URI)**, is a string of characters which identifies a particular resource. It is part of a system by which resources should be uniformly addressed on the Web. On the W3C website, the purpose of a URI is described in the following way:

* The Web is an information space. Human beings have a lot of mental machinery for manipulating, imagining, and finding their way in spaces. URIs are the points in that space.

**Hypertext Transfer Protocol (HTTP)** is the set of rules which provide uniformity to the way resources on the web are transferred between applications.

---

### Book - Introduction to HTTP

HTTP is a system of rules, a protocol, that serve as a link between applications and the transfer of hypertext documents. Stated differently, it's an agreement, or message format, of how machines communicate with each other. HTTP follows a simple model where a client makes a request to a server and waits for a response. Hence, it's referred to as a **request response protocol**. Think of the request and the response as text messages, or strings, which follow a standard format that the other machine can understand.

#### How the Internet Works

An IP Address acts as the identifier for a device or server, and can contain hundreds or thousands of ports, each used for a different communication purpose to that device or server.

How does your computer know what IP address it's mapped to? When we wish to connect to Google's main page, we do not type in the IP Address, we type in its URL.

#### DNS 

This mapping from URL to IP address is handled by the Domain Name System or DNS. DNS is a distributed database which translates computer names like `http://www.google.com` to an IP address and maps the request to a remote server. Stated differently, it keeps track of URLs and their corresponding IP addresses on the Internet. So an address like `http://www.google.com` might be resolved to an IP address 197.251.230.45.

DNS databases are stored on computers called **DNS servers**. It is important to know that there is a very large world-wide network of hierarchically organized DNS servers, and no single DNS server contains the complete database. If a DNS server does not contain a requested domain name, the DNS server routes the request to another DNS server up the hierarchy. Eventually, the address will be found in the DNS database on a particular DNS server, and the corresponding IP address will be used to receive the request.

The main thing you must understand is that when your browser issues a request, it's simply sending some text to an IP address. Because the client (web browser) and the server (recipient of the request) have an agreement, or protocol, in the form of HTTP, the server can take apart the request, understand its components and send a response back to the web browser. The web browser will then process the response strings into content that you can understand.

How is DNS used in conjunction with IP?
* We use DNS to look up what is typed into a browser, to find a specific domain. DNS uses the domain in the URL typed into the browser to look up the IP address associated with that domain. The IP address is then used to look up the requested resource.

#### Clients and Servers

The most common client is an application you interact with on a daily basis called a Web Browser. Web browsers are responsible for issuing HTTP requests and processing the HTTP response in a user-friendly manner onto your screen. Web browsers aren't the only clients around, as there are many tools and applications that can also issue HTTP requests.

The content you're requesting is located on a remote computer called a server. Servers are nothing more than machines or devices capable of handling inbound requests, and their job is to issue a response back. Often, the response they send back contains relevant data as specified in the request.

#### Resources

Resource is a generic term for things you interact with on the Internet via a URL. This includes images, videos, web pages and other files. Resources are not limited to files and web pages. Resources can also be in the form of software that lets you trade stock or play a video game.

#### Statelessness

A protocol is said to be stateless when it's designed in such a way that each request/response pair is completely independent of the previous one. It is important to be aware of HTTP as a stateless protocol and the impact it has on server resources and ease of use. In the context of HTTP, it means that the server does not need to hang on to information, or state, between requests. As a result, when a request breaks en route to the server, no part of the system has to do any cleanup.

The key concept to remember is that even though you may feel the application is stateful, underneath the hood, the web is built on HTTP, a stateless protocol. It's what makes the web so resilient, distributed, and hard to control. It's also what makes it so difficult to secure and build on top of.

---

### What is a URL?

When you see a URL, such as "http://www.example.com:88/home?item=book", it is comprised of several components. We can break this URL into 5 parts:

* `http`: The **scheme**. It always comes before the colon and two forward slashes and tells the web client how to access the resource. In this case it tells the web client to use the Hypertext Transfer Protocol or HTTP to make a request. Other popular URL schemes are `ftp`, `mailto` or `git`.
* `www.example.com`: The **host**. It tells the client where the resource is hosted or located.
* `:88` : The **port** or port number. It is only required if you want to use a port other than the default.
* `/home/`: The **path**. It shows what local resource is being requested. This part of the URL is optional.
* `?item=book` : The **query string**, which is made up of **query parameters**. It is used to send data to the server. This part of the URL is also optional.

Sometimes, we may want to include a port number which the host uses to listen to HTTP requests. A URL in the form of: http://localhost:3000/profile is using the port number 3000 to listen to HTTP requests. The default port number for HTTP is port 80. Even though this port number is not always specified, it's assumed to be part of every URL. **Unless a different port number is specified, port 80 will be used by default in normal HTTP requests**. To use anything other than the default, one has to specify it in the URL.

#### Query Strings/Parameters

`http://www.example.com?search=ruby&results=10`

| Query String Component |  Description                                       |
|:-----------------------|:---------------------------------------------------|
| ?                      | This is a reserved character that marks the start  |        |                        | of the query string                                |
| search=ruby            | This is a parameter name/value pair.               |
| &                      | This is a reserved character, used when adding     |        |                        | more parameters to the query string                |
| results=10             | This is also a parameter name/value pair.          |

Because query strings are passed in through the URL, they are only used in HTTP GET requests. Whenever you type in a URL into the address bar of your browser, you're issuing HTTP GET requests. Most links also issue HTTP GET requests, though there are some minor exceptions.

* Query strings have a maximum length. Therefore, if you have a lot of data to pass on, you will not be able to do so with query strings.
* The name/value pairs used in query strings are visible in the URL. For this reason, passing sensitive information like username or password to the server in this manner is not recommended.
* Space and special characters like & cannot be used with query strings. They must be URL encoded, which we'll talk about next.

#### URL Encoding

URLs are designed to accept only certain characters in the standard 128-character ASCII character set. Reserved or unsafe ASCII characters which are not being used for their intended purpose, as well as characters not in this set, have to be encoded. URL encoding serves the purpose of replacing these non-conforming characters with a `%`symbol followed by two hexadecimal digits that represent the ASCII code of the character.

Some popular encoded characters and example URLs:

| Character | ASCII code | URL                                                      |
|:----------|:-----------|:---------------------------------------------------------|
| Space     | 20         | http://www.thedesignshop.com/shops/tommy%20hilfiger.html |
| !         | 21         | http://www.thedesignshop.com/moredesigns%21.html         |
| +         | 2B         | http://www.thedesignshop.com/shops/spencer%2B.html       |
| #         | 23         | http://www.thedesignshop.com/%23somequotes%23.html       |

Characters must be encoded if:

1. They have no corresponding character within the standard ASCII character set.
2. The use of the character is unsafe because it may be misinterpreted, or even possibly modified by some systems. For example `%` is unsafe because it can be used for encoding other characters. Other unsafe characters include spaces, quotation marks, the `#` character, `<` and `>`, `{` and `}`, `[` and `]`, and `~`, among others.
3. The character is reserved for special use within the URL scheme. Some characters are reserved for a special meaning; their presence in a URL serve a specific purpose. Characters such as `/`, `?`, `:`, `@`, and `&` are all reserved and must be encoded. For example `&` is reserved for use as a query string delimiter. `:` is also reserved to delimit host/port components and user/password.

So what characters can be used safely within a URL? Only alphanumeric and special characters `$-_.+!'()"`, and reserved characters when used for their reserved purposes can be used unencoded within a URL. As long as a character is not being used for its reserved purpose, it has to be encoded.

---

### Using Paw and Inspector

#### Request Methods

Information displayed in the Method column is known as the **HTTP Request Method**. You can think of this as the verb that tells the server what action to perform on a resource. The two most common HTTP request methods you'll see are `GET` and `POST`. When you think about retrieving information, think `GET`, which is the most used HTTP request method. 

The important thing to understand is that every request gets a response, even if the response is an error -- that's still a response. (That's not 100% technically true as some requests can time out)

What is a HTTP method?
* A HTTP method specifies the kind of request we are sending. Some common methods include `GET`, `POST`, `PATCH/PUT`, and `DELETE`.

What is an HTTP `GET` request used for, and what is an HTTP `POST` request used for?
* We use HTTP `GET` requests to "get" information. When you load the home page of your favorite site, you're using a `GET` request to access that page. We use HTTP `POST` requests to send data to the server. Examples of an HTTP `POST` request are search queries and sending form information (such as login forms) to a server.

#### GET Requests

`GET` requests are initiated by clicking a link or via the address bar of a browser. When you type an address like `https://www.reddit.com` into the address bar of your browser, you're making a `GET` request. You're asking the web browser to go retrieve the resource at that address.

The primary concepts are:

* GET requests are used to retrieve a resource, and most links are GETs.
* The response from a GET request can be anything, but if it's HTML and that HTML references other resources, your browser will automatically request those referenced resources. A pure HTTP tool will not.

#### POST Requests

What if you need to send or submit data to the server? `POST` is used when you want to initiate some action on the server, or send data to a server. 

Typically from within a browser, you use `POST` when submitting a form. `POST` requests allow us to send much larger and sensitive data to the server, such as images or videos. For example, say we need to send our username and password to the server for authentication. We could use a `GET` request and send it through query strings. The flaw with this approach is obvious: our credentials become exposed instantly in the URL; that isn't what we want. Using a `POST` request in a form fixes this problem. `POST` requests also help sidestep the query string size limitation that you have with `GET` requests. With `POST` requests, we can send significantly larger forms of information to the server.

How is the data we're sending being submitted to the server since it's not being sent through the URL? The answer to that is the HTTP **body**. The body contains the data that is being transmitted in an HTTP message and is optional. In other words, an HTTP message can be sent with an empty body. When used, the body can contain HTML, images, audio and so on. You can think of the body as the letter enclosed in an envelope, to be posted.

The most important components to understand about an HTTP request are:

* HTTP method
* path
* headers
* message body (for POST requests)

---

### Processing Responses

#### Status Code

The `status code` is a three-digit number that the server sends back after receiving a request signifying the status of the request.

| Status Code | Status Text           | Meaning                                       |
| :---------- | :-------------------- |:--------------------------------------------- |
| 200         | OK                    | The request was handled successfully.         |
| 302         | Found                 | The requested resource has changed temporarily.||             |                       | Usually results in a redirect to another URL. |
| 404         | Not Found             | The requested resource cannot be found.       |
| 500         | Internal Server Error | The server has encountered a generic error.   |

#### 302 Found

What happens when a resource is moved? The most common strategy is to re-route the request from the original URL to a new URL. The general term for this kind of re-routing is called a `redirect`. When your browser sees a response status code of 302, it knows that the resource has been moved, and will automatically follow the new re-routed URL in the `Location` response header.

3xx codes don't indicate an error. Instead they are generally used in relation to redirection, and indicate to the client that it must take some additional action in order to complete the request. 

#### 404 Not Found

4xx level response codes indicate an error or issue on the client side, i.e. with the request. A 400 error is a general indication that there is a problem with the structure of the request; in other words the server did not understand the request due to its syntax. This is basically the server saying to the client 'I don't understand what you just asked me'.

The server returns this status code when the requested resource cannot be found.

#### 5xx Codes

5xx level response codes indicate an error or issue on server side. 

#### Response Headers

Response headers offer more information about the resource being sent back. Some common response headers are:

      | Header Name      | Description                             | Example                                |
      | :--------------- | :-------------------------------------- | :------------------------------------- |
      | Content-Encoding | The type of encoding used on the data.  | Content-Encoding: gzip                 |
      | Server           | Name of the server.                     | Server:thin 1.5.0 codename Knife       |
      | Location         | Notify client of new resource location. | Location: https://www.github.com/login |
      | Content-Type     | The type of data the response contains. | Content-Type:text/html; charset=UTF-8  |

Just understand that response headers contain additional meta-information about the response data being returned.

HTTP is nothing more than an agreement in the form of formatted text that dictates how a client and server communicate.

---

### Stateful Web Applications

How might we go about simulating a “stateful” application?
* It's possible to send simple, limited data via URL parameters; this is one way in which we can simulate a stateful application. We can also persist data in the form of cookies. Cookies are temporary pieces of information that we can send back and forth via the HTTP requests and responses. We can also use session data to keep track of a user for a given web domain.

We already know that the HTTP protocol is stateless. In other words, the server does not hang on to information between each request/response cycle. Each request made to a resource is treated as a brand new entity, and different requests are not aware of each other. This statelessness is what makes HTTP and the internet so distributed and difficult to control.

As we look around the internet and use familiar applications, we feel that the application somehow has a certain state. For example, when we log in to Facebook or Twitter, we see our username at the top, signifying our authenticated status. If we click around (which generates new requests to Facebook's servers) we are not suddenly logged out; the server response contains HTML that still shows our username, and the application seems to maintain its state.


When you login to Facebook or Reddit, how does the server know to remember your username and dynamically display it on the page even after sending a new request? Sessions...

#### Sessions

It's obvious the stateless HTTP protocol is somehow being augmented to maintain a sense of statefulness. With some help from the client (i.e., the browser), HTTP can be made to act as if it were maintaining a stateful connection with the server, even though it's not. One way to accomplish this is by having the server send some form of a unique token to the client. Whenever a client makes a request to that server, the client appends this token as part of the request, allowing the server to identify clients. In web development, we call this unique token that gets passed back and forth the session identifier.

This mechanism of passing a session id back and forth between the client and server creates a sense of persistent connection between requests. Web developers leverage this faux statefulness to build sophisticated applications. Each request, however, is technically stateless and unaware of the previous or the next one.

This sort of faux statefulness has several consequences. First, every request must be inspected to see if it contains a session identifier. Second, if this request does, in fact, contain a session id, the server must check to ensure that this session id is still valid. The server needs to maintain some rules with regards to how to handle session expiration and also decide how to store its session data. Third, the server needs to retrieve the session data based on the session id. And finally, the server needs to recreate the application state (e.g., the HTML for a web request) from the session data and send it back to the client as the response.

This means that the server has to work very hard to simulate a stateful experience, and every request still gets its own response, even if most of that response is identical to the previous response. Instead of regenerating a new page everytime you make a new request, the client uses **cookies** to compare against the session data on from the server. 

#### Cookies

A cookie is a piece of data that's sent from the server and stored in the client during a request/response cycle. Cookies or HTTP cookies, are small files stored in the browser and contain the session information. By default, most browsers have cookies enabled. When you access any website for the first time, the server sends session information and sets it in your browser cookie on your local computer. Note that the actual session data is stored on the server. The client side cookie is compared with the server-side session data on each request to identify the current session. This way, when you visit the same website again, your session will be recognized because of the stored cookie with its associated information.

When you visit a website you have previously never visited before, there will be no reference to cookies in the Request Headers, because there has been no previous session with this page before. If we look at the Response Headers, we'll see `set-cookie` headers that add cookie data to the response. This happens on the first visit to a website. If we make a request to the same address and look at the Request Headers, we'll see the cookie header set.  It contains the cookie data sent previously by the `set-cookie` response header. This piece of data will be sent to the server each time you make a request and uniquely identifies you -- or more precisely, it identifies your client, which is your browser. The browser on your computer stores these cookies. Now, if you were to close your browser and shut down your computer, the cookie information would still persist.

How does any web application, keeps track of the fact that we maintain our authenticated status even though we issue request after request. Remember, each request is unrelated to each other and are not aware of each other - how does the app "remember" we're authenticated? 

After logging in to say Reddit, you should notice a unique session in the second to last row(Inspector on chrome). That session id(reddit-session) is saved into a cookie in your browser, and is attached along with every future request that you make to reddit.com.

With the session id now being sent with every request, the server can now uniquely identify this client. When the server receives a request with a session id, the server will look for the associated data based on that id, and in that associated session data is where the server "remembers" the state for that client, or more precisely, for that session id.

The most important thing is to understand that the session id is stored on the client in the cookies, and it is used as a "key" to the session data stored server side. That's how web applications work around the statelessness of HTTP.

To recap, we've seen that the session data is generated and stored on the server-side and the session id is sent to the client in the form of a cookie. We've also looked at how web applications take advantage of this to mimic a stateful experience on the web.

#### AJAX

AJAX is short for Asynchronous JavaScript and XML. Its main feature is that it allows browsers to issue requests and process responses without a full page refresh. For example, if you're logged into Facebook, the server has to generate the initial page you see, and the response is a pretty complex and expensive HTML page that your browser displays. The Facebook server has to add up all the likes and comments for every photo and status, and present it in a timeline for you. As we described earlier, it's a very expensive page to re-generate for every request (remember, every action you take -- clicking a link, submitting a form -- issues a new request).

When AJAX is used, all requests sent from the client are performed asynchronously, which just means that the page doesn't refresh. Let's see an example by performing some search on google. Make a request to `https://www.google.com` and open the browser's inspector network tab. You'll notice the network tab is empty:

As soon as you start your search, you'll see the network tab gets flooded with requests.

No doubt you've performed searches many times and notice the page doesn't refresh. The Network tab however gives us some new insight into what's happening: every letter you type is issuing a new request, which means that an AJAX request is triggered with every key-press. The responses from these requests are being processed by some callback. You can think of a `callback` as a piece of logic you pass on to some function to be executed after a certain event has happened. In this case, the callback is triggered when the response is returned. You can probably guess that the callback that's processing these asynchronous requests and responses is updating the HTML with new search results.

The main thing to remember is that AJAX requests are just like normal requests: they are sent to the server with all the normal components of an HTTP request, and the server handles them like any other request. The only difference is that instead of the browser refreshing and processing the response, the response is processed by a callback function, which is usually some client-side JavaScript code.

---

### Security

#### Secure HTTP (HTTPS)

As the client and server send requests and responses to each other, all information in both requests and responses are being sent as strings. If a malicious hacker was attached to the same network, they could employ packet sniffing techniques to read the messages being sent back and forth. As we learned previously, requests can contain the session id, which uniquely identifies you to the server, so if someone else copied this session id, they could craft a request to the server and pose as your client, and thereby automatically being logged in without even having access to your username or password.

With HTTPS every request/response is encrypted before being transported on the network. This means if a malicious hacker sniffed out the HTTP traffic, the information would be encrypted and useless.

HTTPS sends messages through a cryptographic protocol called TLS for encryption. Earlier versions of HTTPS used SSLor Secure Sockets Layer until TLS was developed. These cryptographic protocols use certificates to communicate with remote servers and exchange security keys before data encryption happens.

#### Same-Origin Policy

The same-origin policy is an important concept that permits unrestricted interaction between resources originating from the same origin, but restricts certain interactions between resources originating from different origins. What we mean by origin here is the combination of a url's scheme, hostname, and port. The same-origin policy is an important concept that permits unrestricted interaction between resources originating from the same origin, but restricts certain interactions between resources originating from different origins. What we mean by origin here is the combination of a url's scheme, hostname, and port. So `http://mysite.com/doc1` would be considered to have the same origin as `http://mysite.com/doc2`, but a different origin to `https://mysite.com/doc2` (different scheme), `http://mysite.com:4000/doc2` (different port), and `http://anothersite.com/doc2` (different host).

Same-origin policy doesn't restrict all cross-origin requests. Requests such as linking, redirects, or form submissions to different origins are typically allowed. Also typically allowed is the embedding of resources from other origins, such as scripts, css stylesheets, images and other media, fonts, and iframes. What is typically restricted are cross-origin requests where resources are being accessed programmatically using APIs such as XMLHttpRequest or fetch (the details of which are beyond the scope of this book).

While secure, same-origin policy is an issue for web developers who have a legitimate need for making these restricted kinds of cross-origin requests. Cross-origin resource sharing or CORS was developed to deal with this issue. CORS is a mechanism that allows interactions that would normally be restricted cross-origin to take place. It works by adding new HTTP headers, which allow servers to serve resources cross-origin to certain specified origins.

The same-origin policy is an important guard against session hijacking (see next section) attacks and serves as a cornerstone of web application security.

#### Session Hijacking

We've already seen that the session plays an important role in keeping HTTP stateful. We also know that a session id serves as that unique token used to identify each session. Usually, the session id is implemented as a random string and comes in the form of a cookie stored on the computer. With the session id in place on the client side now every time a request is sent to the server, this data is added and used to identify the session. In fact, this is what many web applications with authentication systems do. When a user's username and password match, the session id is stored on their browser so that on the next request they won't have to re-authenticate.

#### Countermeasures for Session Hijacking

* One popular way of solving session hijacking is by resetting sessions. With authentication systems, this means a successful login must render an old session id invalid and create a new one. With this in place, on the next request, the victim will be required to authenticate. At this point, the altered session id will change, and the attacker will not be able to have access. Most websites implement this technique by making sure users authenticate when entering any potentially sensitive area, such as charging a credit card or deleting the account.
* Another useful solution is by setting an expiration time on sessions. Sessions that do not expire give an attacker an infinite amount of time to pose as the real user. Expiring sessions after, say 30 minutes, gives the attacker a far narrower window to access the app.
* Finally, as we have already covered, another approach is to use HTTPS across the entire app to minimize the chance that an attacker can get to the session id.

#### Cross-Site Scripting (XSS)

This type of attack happens when you allow users to input HTML or JavaScript that ends up being displayed by the site directly.

For example, the form below allows you to add comments, which will then be displayed on the site.

Because it's just a normal HTML `<textarea>`, users are free to input anything into the form. This means users can add raw HTML and JavaScript into the text area and submit it to the server as well.

If the server side code doesn't do any sanitization of input, the user input will be injected into the page contents, and the browser will interpret the HTML and JavaScript and execute it. In this case an alert message will pop up, which is definitely not the desired outcome. Attackers can craft ingeniously malicious HTML and JavaScript and be very destructive to both the server as well as future visitors of this page. For example, an attacker can use JavaScript to grab the session id of every future visitor of this site and then come back and assume their identity. It could happen silently without the victims ever knowing about it. Note that the malicious code would bypass the same-origin policy because the code lives on the site.

#### Potential solutions for cross-site scripting

* One way to prevent this kind of attack is by making sure to always sanitize user input. Eliminate problematic input, such as `<script>` tags, or disallowing HTML and JavaScript input altogether in favor of a safer format, like Markdown.
* The second way to guard against XSS is to escape all user input data when displaying it. If you do need to allow users to input HTML and JavaScript, then when you print it out, make sure to escape it so that the browser does not interpret it as code.

#### Escaping 

We mention the term "escaping" above. To escape a character means to replace an HTML character with a combination of ASCII characters, which tells the client to display that character as is, and to not process it; this helps prevent malicious code from running on a page. These combinations of ASCII characters are called HTML entities.

Consider the following HTML: `<p>Hello World!<\p>`. Let's say we don't want the browser to read this as HTML. To accomplish this, we can escape special characters that the browser uses detect when HTML starts and ends, namely < and >, with HTML entities. If we write the following: `&lt;p&gt;Hello World!&lt;\p&gt;`, then that HTML will be displayed as plain text instead.

---

#### Client-Server

Large server infrastructures run into the hundreds or thousands of machines. Yet taken together as unified concept, the server-side infrastructure in its entirety is the "server" to the client. The word "server" is severely overloaded, so it's important to keep in mind what exactly we're talking about at every turn.

We'll keep it simple for now and introduce the 3 primary server-side infrastructure pieces represented in the above zoomed-in diagram: a web server, an application server and a data store. 

* A `web server` is typically a server that responds to requests for static assets: files, images, css, javascript, etc. These requests don't require any data processing, so can be handled by a simple web server.
* An `application server`, on the other hand, is typically where application or business logic resides, and is where more complicated requests are handled. This is where your server-side code lives when deployed.
* The application server will often consult a persistent `data store`, like a relational database, to retrieve or create data. Data stores can also be simple files, key/value stores, document stores and many other variations, as long as it can save data in some format for later retrieval and processing.

#### HTTP Layer on top of TCP/IP

HTTP is actually relying on a TCP/IP connection (most of the time). As we've already discussed in this course, HTTP, TCP, and IP are all separate protocols operating at different 'layers' of a conceptual model of the network.

In summary, HTTP operates at the application layer and is concerned with structuring the messages that are exchanged between applications; it's actually TCP/IP that's doing all the heavy lifting and ensuring that the request/response cycle gets completed between your browser and the server.

---

### URLs

A URL refers to:

* the subset of URIs that, in addition to identifying a resource, provide a means of locating the resource by describing its primary access mechanism (e.g., its network "location").

What is the relationship between a scheme and a protocol in the context of a URL?
* The scheme identifies which protocol should be used.

What are the principal components of a URL?
* scheme
* host
* port
* path
* query parameters
* the port and query parameters are optional

In what ways can we pass information to the application server via the URL?
* The path typically identifies a resource on a website or web application. We can also pass information about the request to the application server via the path or via query parameters.

#### Schemes and Protocols

When looking at URL Components, we described the component that prepends the colon and two forward slashes at the start of a URL as the scheme.

You'll often hear this URL component incorrectly referred to as the protocol. The source of this confusion is that, although referring to this component as the protocol is technically incorrect, in the context of a URL there is a relationship between the two things in that the scheme identifies which protocol should be used to access the resource. It should be noted that 'protocol' in this sense refers to a 'family' of protocols, rather than a specific protocol version, e.g. HTTP rather than HTTP 1.0 or HTTP 1.1. In the more general context of a URI, a scheme name is defined as "a specification for assigning identifiers within that scheme", and isn't related to a particular protocol. 

#### The Request-Response Cycle Video

What are the required components of an HTTP request? What are the additional optional components?
* The HTTP method and the path are required, and form part of what is known as the start-line or request-line. As of HTTP 1.0, the HTTP version also forms part of the request-line. The Host header is a required component since HTTP 1.1. Parameters, all other headers, and message body are optional.
* Technically speaking the 'path' portion of the request-line is known as the 'request-URI', and incorporates the actual path to the resource and the optional parameters if present. In practice, most people simply refer to this part of the request-line as the 'path'.

What are the required components of an HTTP response? What are the additional optional components?
* Status code is required. Headers and body are optional.

What determines whether a request should use GET or POST as its HTTP method?

* `GET` **requests should only retrieve content from the server**. They can generally be thought of as "read only" operations, however, there are some subtle exceptions to this rule. For example, consider a webpage that tracks how many times it is viewed. GET is still appropriate since the main content of the page doesn't change.
* `POST` **requests involve changing values that are stored on the server**. Most HTML forms that submit their values to the server will use POST. Search forms are a noticeable exception to this rule: they often use GET since they are not changing any data on the server, only viewing it.

What are HTTP headers?
* HTTP headers are name-value pairs included in a HTTP request or response. Headers act as metadata that provides supplemental information about the request or response to aid the server or client in processing the request or response.

#### Summary

* The Domain Name System (DNS) is a distributed database which translates a domain name such as `google.com` to an _IP Address_ such as `216.58.213.14`.
* A URI is an identifier for a particular resource within an information space.
* A URL is a subset of URI, but the two terms are often used interchangeably.
* URL components include the scheme, host (or hostname), port, path, and query string.
* Query strings are used to pass additional data to the server during an HTTP Request. They take the form of name/value pairs separated by an `=` sign. Multiple name/value pairs are separated by an `&` sign. The start of the query string is indicated by a `?`.
* URL encoding is a technique whereby certain characters in a URL are replaced with an ASCII code.
* URL encoding is used if a character has no corresponding character in the ASCII set, is unsafe because it is used for encoding other characters, or is reserved for special use within the url.
* A single HTTP message exchange consists of a Request and a Response. The exchange generally takes place between a Client and a Server. The client sends a Request to the server and the server sends back a Response.
* An HTTP Request consists of a request line, headers, and an optional body.
* An HTTP Response consists of a status line, optional headers, and an optional body.
* Status codes are part of the status line in a Response. They indicate the status of the request. There are various categories of status code.
* HTTP is a stateless protocol. This means that each Request/ Response cycle is independent of Request and Responses that came before or those that come after.
* Statefulness can be simulated through techniques which use session IDs, cookies, and AJAX.
* HTTP is inherently insecure. Security can be increased by using HTTPS, enforcing Same-origin policy, and using techniques to prevent Session Hijacking and Cross-site Scripting.
* HTTP is a text-based protocol. HTTP Request and Responses involve sending text between the client and server
* In order for the protocol to work, the Request and Response must be structured in such a way that both the client and the server can understand them.
* With HTTP/1.1, the end of the headers is indicated by an empty line.
* The Content-Length header can be used to indicate the size of the body. This can help determine where the HTTP message should end.
