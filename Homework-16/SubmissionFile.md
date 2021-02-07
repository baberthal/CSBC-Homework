## Week 16 Homework Submission File: Penetration Testing 1

#### Step 1: Google Dorking

- Using Google, can you identify who the Chief Executive Officer of Altoro Mutual is:

> Karl Fitzgerald (found via an annual report pdf).

- How can this information be helpful to an attacker:

> An attacker could use this information to perform social-engineering attacks
> on the CEO to gain access to sensitive information.

#### Step 2: DNS and Domain Discovery

Enter the IP address for `demo.testfire.net` into Domain Dossier and answer the following questions based on the results:

  1. Where is the company located: Sunnyvale, CA

  2. What is the NetRange IP address: `65.61.137.64` - `65.61.137.127`

  3. What is the company they use to store their infrastructure: Rackspace

  4. What are the nameservers:
    * `usw2.akam.net`
    * `usc2.akam.net`
    * `eur2.akam.net`
    * `ns1-99.akam.net`
    * `ns1-206.akam.net`
    * `asia3.akam.net`
    * `usc3.akam.net`
    * `eur5.akam.net`

#### Step 3: Shodan

- What open ports and running services did Shodan find:
  * Port 80 - Apache Tomcat/Coyote - HTTP
  * Port 443 - Apache Tomcat/Coyote - HTTPS
  * Port 8080 - Apache Tomcat/Coyote - HTTP

#### Step 4: Recon-ng

- Install the Recon module `xssed`.
- Set the source to `demo.testfire.net`.
- Run the module.

Is Altoro Mutual vulnerable to XSS:
> Yes.

### Step 5: Zenmap

Your client has asked that you help identify any vulnerabilities with their file-sharing server. Using the Metasploitable machine to act as your client's server, complete the following:

> NOTE: Andrew said we could just use command-line `nmap` rather than the
> `zenmap` GUI.

- Command for Zenmap to run a service scan against the Metasploitable machine:
```bash
nmap -sS 192.168.0.10
```

- Bonus command to output results into a new text file named `zenmapscan.txt`:
```bash
nmap -sS -oN zenmapscan.txt 192.168.0.10
```

- Zenmap vulnerability script command:
```bash
nmap -sC -p 139,445 --script smb-os-discovery 192.168.0.10
```

- Once you have identified this vulnerability, answer the following questions for your client:
1. What is the vulnerability:

The script determined the target machine is running Samba-3.0.20-Debian, which
is vulnerable to the following CVEs (all with CVE Score > 9.0):
* CVE-2007-2446
* CVE-2012-1182
* CVE-2007-4572
* CVE-2007-5398
* CVE-2007-6015

Of the above CVEs, the most dangerous is probably CVE-2007-2446 or
CVE-2012-1182.

2. Why is it dangerous: Both CVE-2007-2446 and CVE-2012-1182 allow a remote
   attacker to execute arbitrary code on the target machine. This is dangerous
   because an attacker can gain access to the underlying system. Arbitrary code
   execution is basically game-over for an attacker.

3. What mitigation strategies can you recommendations for the client to protect their server:
   The client should upgrade the version of samba they are running to the most
   recent version, which has patched the vulnerabilities described by
   CVE-2007-2446 and CVE-2012-1182.

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.
