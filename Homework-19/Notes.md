# Homework-19 - Notes

### Windows Server

#### Reports

* Count and Percent by Severity:
  - normal activity
    - informational:      4435    93.094039
    - high:               329     6.905961

  - attack logs
    - informational:      4383    79.777940
    - high:               1111    20.222060

  - changes:
    - "high" severity incidents increased from 329 to 1111, representing an
      increase of 237.7%.

* Successes and Failures:
  - normal activity
    - success:    4622     97.019312
    - failure:    142      2.980688

  - attack logs
    - success:    5856     98.436712
    - failure:    93       1.563288

  - changes
    - failures decreased from 142 to 93, representing a decrease of 34.5%.
      successes increased from 4622 to 5856, representing an increase of 26.7%.

#### Alerts

* Failed activity in one hour:
  - Suspicious volume of failed windows activity on Wednesday, March 25 at 8AM
  - Alert would have triggered (threshold was >15, 35 events detected)
  - Threshold is sufficient

* Successful logins:
  - Detected suspicious volume of account logins
  - Suspicious volume detected on March 25, 2020 in both 11AM and 12PM hours
  - Threshold was >30, 196 logins in 11AM hour, 77 logins in 12PM hour
  - Primary user was `user_j`
  - Alert would have triggered
  - Threshold is sufficient

* Deleted Accounts:
  - No suspicious volume detected

#### Dashboards

* Time Chart of Signatures
  - Suspicious Activity:
    - March 25 @ 1:00AM, 2AM - Suspicious amount of user account lockouts (805, 896)
    - March 25 @ 9:00AM - Suspicious amount of attempts to reset password (1,258)
    - March 25 @ 11:00AM - Suspicious amount of logins (196)

* Users
  - Suspicious activity:
    - March 25 @ 1:00AM, 2AM - Suspicious amount of activity from user_a (799, 984)
    - March 25 @ 9:00AM, 10AM - Suspicious amount of activity from user_k (1,256, 761)

* Events by Signature - Pie Chart
  - Suspicious activity:
    - 2,128 attempts to reset password (35.771% of activity)
    - 1,811 user lockouts (30.442% of activity)
    - 432 successful logins (7.262% of activity)
  - These results match the activity in the time charts

* Users - Pie Chart
  - Suspicious activity:
    - user_k - 2,118 events (35.603%)
    - user_a - 1,878 events (31.568%)
  - These results match the time charts

* Radail Gauge
  - Interestingly, the number of events classified as "failed" is still below
    the threshold we set, and is still within the agreed-upon "normal activity"
    range.

### Apache Server

#### Reports

* Methods
  - Suspicious activity
    - POST requests increased from 106 requests (1.06%) to 1,324 (29.441%)
    - POST requests are used to update data on the server

* Referer domains
  - Top 5 referer domains stayed the same
  - Suspicious activity
    - More traffic coming from google.com.br and google.co.uk
    - This is not necessarily suspicious in its own right

* HTTP Response Codes
  - Suspicious activity
    - 404 responses increased from 213 to 679
    - 200 responses decreased from 9126 to 3746
    - 304 responses decreased from 445 to 36

#### Alerts

* International Activity
  - Threshold was > 150
  - Suspicious activity
    - Suspicious volume of international requests on March 25 @ 8:00 PM
    - 1,369 international requests
    - Alert would have triggered
    - Threshold deemed to be sufficient

* HTTP Post Activity
  - Threshold was > 15
  - Suspicious activity
    - Suspicious amount of requests on March 25 @ 8:00 PM
    - 1,296 POST requests in that hour
    - Alert would have triggered
    - Threshold deemed to be sufficient

#### Dashboards

* Time Chart - HTTP Methods
  - Suspicious activity
    - 1,296 POST requests in 8:00 PM hour of March 25
    - 729 GET requests in 6:00 PM hour or March 25
    - POST method seems to have been used in the attack

* Cluster Map
  - Suspicious activity
    - Much more traffic coming from Eastern Europe area, specifically Kiev,
      Ukraine
    - 872 requests from Kiev

* URI Data
  - Suspicious activity
    - Virtually all traffic is for /VSI_Account_logon.php (1,323 requests)
    - This indicates a brute-force attack of the logon page
