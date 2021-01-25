## Homework 14 - Web Development

### HTTP Requests and Responses:

1. The HTTP request and response process occurs in a **client-server**
   architecture.

2. An HTTP request is comprised of the following parts:
  * Request-Line (made up of the following parts):
    * Method (e.g. GET, POST, etc.)
    * Request-URI
    * HTTP-Version of the request
  * Headers
  * Body

3. The body of the request is optional.

4. An HTTP response is made up of the three following parts:
  * Status Code (2xx, 3xx, etc.)
  * Headers
  * Body

5. The 4xx and 5xx classes of status codes represent errors. 4xx status codes
   represent an error on the client side, while 5xx status codes represent an
   error on the server side.

6. The two most common request methods encountered by security professionals are
   `GET` and `POST`.

7. The `POST` HTTP method is used for sending data.

8. The body of the HTTP request contains data being sent to the server.

9. The browser receives the web code to generate and style a web page in the
   *body* of the response.

### Using cURL

10. Curl is advantageous over the browser for myriad reasons, but especially:
  * Set any desired headers
  * Spoof user-agent header
  * Specify any desired request method
  * View any and all headers on both the response and the request

11. The `curl` option `--request` (`-X`) can be used to change the request
  method.

12. The `curl` option `-H` can be used to set request headers.

13. The `curl` option `-I` can be used to view the response headers.

14. To determine which HTTP request methods a server will accept, an attacker
    might issue a request using the `OPTIONS` method.

### Sessions and Cookies

15. The `Set-Cookie` header sends a cookie to the client.

16. The `Cookie` request header will continue the client's session.

### Example HTTP Requests and Responses

17. The request method is POST.

18. The `Upgrade-Insecure-Requests` header expresses the client's preference for
    an encrypted response.

19. The request does not have a user session associated with it.

20. The kind of data being sent in this request body is `www-url-form-encoded`.

21. The response has a status code of 200 OK.

22. An Apache web server is handling this response.

23. This response **DOES** have a user session associated with it.

24. `[page content]` in the response body is likely to include HTML, CSS, and
    maybe some JavaScript.

25. N/A

### Monoliths and Microservices

26. The individual components of microservices are called **services**.

27. A service that writes to a database and communicates to other services is
    known as an API (Application Programming Interface).

28. The development of the **containerization** technology has enabled
    microservices to become scalable and reduntant.

### Deploying and Testing a Container Set

29. `docker-compose` can be used to deploy multiple containers at once.

30. `docker-compose` is configured using the YAML file format.

### Databases

31. To see all information within a table called `customers`, one could run the
    following SQL query:

```sql
SELECT * FROM customers;
```

32. To enter new data into a table, one could run a query as follows:

```sql
INSERT INTO customers (firstname, lastname, email) VALUES ('John', 'Smith', 'jsmith@example.com');
```

33. One should never run `DELETE FROM <table-name>;` by itself because it
    deletes the table itself, rather than associated data.

---

### Bonus

#### Step 3: Using Forms and a Cookie Jar

1. Command to issue a request that enters the form values for Ryan's login:

```bash
curl --form "log=Ryan" --form "pwd=123456" http://localhost:8080/wp-admin/login.php
```

In the output, `curl` indicated that several cookies had been set, indicating
the login was successful.

2. Same `curl` request, but using a cookie jar at `./ryancookies.txt`:

```bash
curl --cookie-jar ./ryancookies.txt --form "log=Ryan" --form "pwd=123456" http://localhost:8080/wp-admin/login.php
```

3. It appears that 4 separate cookies were set and are now stored in the
   `./ryancookies.txt` file.

#### Step 4: Log in Using Cookies

1. `curl` command that uses the `--cookie` option to log in:

```bash
curl --cookie ./ryancookies.txt http://localhost:8080/wp-admin/index.php
```

The command returned the HTML and JavaScript that are used to display the
dashboard, so it is obvious that we can access the dashboard.

2. After piping the previous command through `grep Dashboard`, the wording on
   the page seems familiar. We are successfully logged in to the Editor's
   dashboard.

#### Step 5: Test the Users.php Page

1. `curl` command using the same cookies (i.e. Ryan's) to attempt to access the
   `users.php` page:

```bash
curl --cookie ./ryancookies.txt http://localhost:8080/wp-admin/users.php
```

This time, the response was an error page indicating we do not have proper
authorization to view the `users.php` page.
