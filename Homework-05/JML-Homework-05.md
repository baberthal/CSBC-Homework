## Week 5 Homework Submission File: Archiving and Logging Data

Please edit this file by adding the solution commands on the line below the prompt.

Save and submit the completed file for your homework submission.

---

### Step 1: Create, Extract, Compress, and Manage tar Backup Archives

1. Command to **extract** the `TarDocs.tar` archive to the current directory:
```bash
tar -xf TarDocs.tar
```


2. Command to **create** the `Javaless_Doc.tar` archive from the `TarDocs/`
   directory, while excluding the `TarDocs/Documents/Java` directory:
```bash
# In ~/Projects
tar --exclude=TarDocs/Documents/Java -cf Javaless_Docs.tar TarDocs
```


3. Command to ensure `Java/` is not in the new `Javaless_Docs.tar` archive:
```bash
tar -tf Javaless_Docs.tar | grep -i java
```

**Bonus**
- Command to create an incremental archive called `logs_backup_tar.gz` with only changed files to `snapshot.file` for the `/var/log` directory:
```bash
sudo tar -czf logs_backup.tar.gz --listed-incremental=snapshot.file --level=0 /var/log
```

#### Critical Analysis Question

- Why wouldn't you use the options `-x` and `-c` at the same with `tar`?
- Because they perform opposite operations. `tar -x` ***extracts*** an archive,
while `tar -c` ***creates*** an archive.

---

### Step 2: Create, Manage, and Automate Cron Jobs

1. Cron job for backing up the `/var/log/auth.log` file:
**Note**: This must be added to the crontab for `root` to properly run.
```cron
0 6 * * 3 tar -czf /auth_backup.tgz /var/log/auth.log
```

---

### Step 3: Write Basic Bash Scripts

1. Brace expansion command to create the four subdirectories:
```bash
mkdir -p ~/backups/{freemem,diskuse,openlist,freedisk}
```

2. Paste your `system.sh` script edits below:

    ```bash
    #!/bin/bash
    # Free memory
    free -h > ~/backups/freemem/free_mem.txt

    # Disk usage. Could also be run as:
    # du -h -d 1 / > ~/backups/diskuse/disk_usage.txt
    # to only show a depth of 1 directory, or
    # du -hs 1 / > ~/backups/diskuse/disk_usage.txt
    # to only show a summary.
    du -h / > ~/backups/diskuse/disk_usage.txt

    # List open files
    lsof > ~/backups/openlist/open_list.txt

    # Free disk space
    df -h > ~/backups/freedisk/free_disk.txt
    ```

3. Command to make the `system.sh` script executable:
```bash
# Assuming it is in your current working directory...
chmod +x ./system.sh
```

**Optional**
- Commands to test the script and confirm its execution:
```bash
cd ~/backup
cat freemem/free_mem.txt
cat diskuse/disk_usage.txt
cat openlist/open_list.txt
cat freedisk/free_disk.txt
```

**Bonus**
- Command to copy `system` to system-wide cron directory:
```bash
sudo cp ~/system.sh /etc/cron.weekly
```

---

### Step 4. Manage Log File Sizes

1. Run `sudo nano /etc/logrotate.conf` to edit the `logrotate` configuration file.

    Configure a log rotation scheme that backs up authentication messages to the `/var/log/auth.log`.

    - Add your config file edits below:

    ```bash
    /var/log/auth.log {
      weekly
      rotate 7
      notifempty
      delaycompress
      missingok
    }
    ```
---

### Bonus: Check for Policy and File Violations

1. Command to verify `auditd` is active:
```bash
systemctl status auditd
```

2. Command to set number of retained logs and maximum log file size:

    - Add the edits made to the configuration file below:

    ```bash
    max_log_file = 35
    num_logs = 7
    ```

3. Command using `auditd` to set rules for `/etc/shadow`, `/etc/passwd` and `/var/log/auth.log`:

    - Add the edits made to the `rules` file below:

  ```bash
  -w /etc/shadow -p wra -k hashpass_audit
  -w /etc/passwd -p wra -k userpass_audit
  -w /var/log/auth.log -p wra -k authlog_audit
  ```

4. Command to restart `auditd`:
```bash
sudo systemctl restart auditd
```

5. Command to list all `auditd` rules:
```bash
sudo auditctl -l
```

6. Command to produce an audit report:
```bash
sudo aureport -au
```

7. Create a user with `sudo useradd attacker` and produce an audit report that lists account modifications:
```bash
sudo aureport -m
```

8. Command to use `auditd` to watch `/var/log/cron`:
```bash
sudo auditctl -w /var/log/cron
```

9. Command to verify `auditd` rules:
```bash
sudo auditctl -l
```

---

### Bonus (Research Activity): Perform Various Log Filtering Techniques

1. Command to return `journalctl` messages with priorities from emergency to error:
```bash
journalctl -b -p 0..3
```

1. Command to check the disk usage of the system journal unit since the most recent boot:
```bash
journalctl -b -u systemd-journald --disk-usage
```

1. Comand to remove all archived journal files except the most recent two:
```bash
sudo journalctl --vacuum-files=2
```

1. Command to filter all log messages with priority levels between zero and two, and save output to `/home/sysadmin/Priority_High.txt`:
```bash
sudo journalctl -p 0..2 >> /home/sysadmin/Priority_High.txt
```

1. Command to automate the last command in a daily cronjob. Add the edits made to the crontab file below:

    ```bash
@daily journalctl -p 0..2 >> /home/sysadmin/Priority_High.txt
    ```

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.
