# HR: Questionnaire for Technical interviews


## Introduction

Hiring a junior Linux System Administrator can be a challenging task, especially if you are interviewing for someone who is above your own Linux skill set! How do you know for sure that they are going to be any good at what they say they can do? What are the best interview questions to ask a junior Linux System Admin? \\ \\
In our experience, the best way to gauge an employees skill set is to put them in front of a command line interface and have them execute a number of straightforward tasks. Oftentimes, candidates will say that they have strong skills in Linux, but when confronted with an actual problem, they don't have the "tools" to fix it themselves. So, what we look for is a candidate's ability to use tools, rather than their ability to fix a particular problem.
From: [Test To Give When Hiring or Interviewing a Junior Linux System Administrator](http://www.linux.org/threads/test-to-give-when-hiring-or-interviewing-a-junior-linux-system-administrator.355/)
\\ \\


------




## Linux System Administrator Fast Questions

 1.  What is your favourite shell and why?\
    - Answers may vary :-)
 3.  What do you need to do to start a service at startup? \\ Please provide multiple variants.\
    - Answers:
```
chkconfig "svc" on
systemctl enable "svc"
/etc/crontab, /etc/cron.d/, crontab -e -> @reboot (man 5 crontab)
/etc/rc.local
.....
```
 3.  What debugging steps will you take when your manager tells you that the website is slow?\
    - Answers may vary :-)
 4.  Choose the odd one out.
```
vi
emacs
vim
cd
nano
```
    - Answer: The odd one in the above list is ``cd`.\
`vi`, `vim`, `emacs` and `nano` are editors which is useful in editing files,\
 while `cd` command is used for changing directory.

 5.  How to get the number of active connections to the server's `ssh` service?\
Please provide simple one line commands sequence.\
    -  Simple answer #1
```
netstat -an | grep ':22 ' | grep ESTAB | wc -l
```
    -  Simple answer #2
```
netstat -anp | grep '/sshd' | grep ESTAB | wc -l
```
 6.  How to comment a code block in shell?\
Please provide multiple variants.\
    - Stupid answer.
```
# command1

# command2
# .....

# commandN
```
    - Smart answers.
```
<<COMMENT1
command1
ommand2
....
commandN
COMMENT1
```
```
: '
command1
ommand2
....
commandN
'
```
```
if false ; then
command1
ommand2
....
commandN
fi
```
 7.  A TCP connection on a network can be uniquely defined by 4 things. \\ What are those things?
    - Answer: `src_address:src_port `<-->` dst_address:dst_port`


## Linux System Administrator/DevOps Interview Questions

Stolen from [Github](https///github.com/chassing/linux-sysadmin-interview-questions) {{github-001.png?nolink&30}} :-)

A collection of linux sysadmin/devops interview questions.

### General Questions

 1.  What did you learn yesterday/this week?
 2.  Tell me please about your preferred development/administration environment. (OS, Editor, Browsers, Tools etc.)
 3.  Tell me please about the last major Linux project you finished.
 4.  Tell me please about the biggest mistake you've made in [some recent time period] and how you would do it differently today. What did you learn from this experience?
 5.  Why we must choose you?
 6.  Non-technical one:\
How do you think - are you "fast-learner" of new things?\
For example, how many time do you need to learn new linux distro? (1-5 days, 1-2 weeks, 1(+) month(s))\
Hint: you can give more than one answer here.\
For example:\
***1-3 days** to start using it.*\
***1-2 weeks** to start configure it for your needs.*\
 **3 months** - expert level*
 8.  What function does **DNS** play on a network?
 9.  What is **HTTP**?
    - [https://tools.ietf.org/html/rfc2616](https///tools.ietf.org/html/rfc2616)
    - [https://en.wikipedia.org/wiki/HTTP](https///en.wikipedia.org/wiki/HTTP)
 10.  What is an **HTTP proxy** and how does it work?
    - [https://en.wikipedia.org/wiki/HTTP_proxy](https///en.wikipedia.org/wiki/HTTP_proxy)
 11.  Describe briefly how **HTTPS** works.
    - [https://en.wikipedia.org/wiki/HTTPS](https///en.wikipedia.org/wiki/HTTPS)
 12.  What is **SMTP**? Give the basic scenario of how a mail message is delivered via **SMTP**.
    - [https://en.wikipedia.org/wiki/Simple_Mail_Transfer_Protocol](https///en.wikipedia.org/wiki/Simple_Mail_Transfer_Protocol)
    - FIXME
 13.  What is **RAID**? What is **RAID0**, **RAID1**, **RAID5**, **RAID10**?
    - [https://en.wikipedia.org/wiki/RAID](https///en.wikipedia.org/wiki/RAID)
 14.  What is a **level 0 backup**? What is an **incremental backup**?
    - [https://en.wikipedia.org/wiki/Backup](https///en.wikipedia.org/wiki/Backup)
    - [https://en.wikipedia.org/wiki/Incremental_backup](https///en.wikipedia.org/wiki/Incremental_backup)
 15.  Describe the general file system hierarchy of a Linux system.

### Simple Linux Questions

 1.  What is the name and the UID of the administrator user?
 2.  How to list all files, including hidden ones, in a directory?
    - `ls -a /path/to/directory`{bash}
 3.  What is the Unix/Linux command to remove a directory and its contents?
    - `rm -rf /path/to/directory`{bash}
 4.  Which command will show you free/used memory? \\ Does free memory exist on Linux?
    - `free`{bash}
    - FIXME
 5.  How to search for the string "you should hire me immediately!" in files of a directory recursively? \\ Please show exact command.
    - `grep -r "you should hire me immediately!" /path/to/directory/*`{bash}
 6.  How to connect to a remote server or what is **SSH**?
    - [https://en.wikipedia.org/wiki/Secure_Shell](https///en.wikipedia.org/wiki/Secure_Shell)
 7.  How to get all environment variables and how can you use them?
 8.  I get "command not found" when I run ''ifconfig -a'' \\ What can be wrong?
 9.  What happens if I type ''TAB-TAB''?
    - Depends :-) \\
```
# FreeBSD 9 - `bash` - default options - installed from `ports`

[root@freebsd-9] ~# `<TAB>``<TAB>`
Display all 1771 possibilities? (y or n)
```
```
# Ubuntu 16.x, CentOS 7

[root@centos] ~# `<TAB>``<TAB>`
....... nothing here ........
```
```
# CentOS 6

[root@testnode ~]# `<TAB>``<TAB>`
Display all 2137 possibilities? (y or n)
```
 10.  What command will show the available disk space on the Unix/Linux system?
    - `df`{bash}
 11.  What commands do you know that can be used to check **DNS** records?
    - `dig`{bash}
    - `host`{bash}
    - `nslookup`{bash}
 12.  What Unix/Linux commands will alter a files ownership, files permissions?
```
chown
chmod
```
 13.  What does ''chmod +x FILENAME'' do?
 14.  What does the permission ''0750'' on a file mean?
 15.  What does the permission ''0750'' on a directory mean?
 16.  How to add a new system user without login permissions?
 17.  How to add/remove a group from a user?
 18.  What is a bash alias?
    - [http://tldp.org/LDP/abs/html/aliases.html](http://tldp.org/LDP/abs/html/aliases.html)
 19.  How do you set the mail address of the *root* / *a user*?
 20.  What does CTRL-c do?
 21.  What is in ''/etc/services''?
 22.  How to redirect ''STDOUT'' and ''STDERR'' in bash? (''> /dev/null 2>&1'')
 23.  What is the difference between **UNIX** and **Linux**.
 24.  What is the difference between **Telnet** and **SSH**?
 25.  Explain the three load averages and what do they indicate. \\ What command can be used to view the load averages?
 26.  Can you name a lower-case letter that is not a valid option for GNU ''ls''?
```
# ls -e
ls: invalid option -- 'e'
Try 'ls --help' for more information.
```
```
# ls -E
ls: invalid option -- 'E'
Try 'ls --help' for more information.
```

### Medium Linux Questions

 1.  What do the following commands do and how would you use them?
```
    tee
    awk
    tr
    cat
    tac
    curl
    wget
    watch
    head
    tail
```
 2.  What does an ''&'' after a command do?
 3.  What does ''& disown'' after a command do?
 4.  What is a packet filter and how does it work?
    - [https://en.wikipedia.org/wiki/Firewall_(computing)](https///en.wikipedia.org/wiki/Firewall_(computing))
 5.  What is Virtual Memory?
    - [https://en.wikipedia.org/wiki/Virtual_memory](https///en.wikipedia.org/wiki/Virtual_memory)
 6.  What is **swap** and what is it used for?
    - [https://en.wikipedia.org/wiki/Paging](https///en.wikipedia.org/wiki/Paging)
 7.  DNS: What is an **A** record, **NS** record, **PTR** record, **CNAME** record, **MX** record?
 8.  Are there any other RRs and what are they used for?
 9.  What is a Split-Horizon DNS?
    - [https://en.wikipedia.org/wiki/Split-horizon_DNS](https///en.wikipedia.org/wiki/Split-horizon_DNS)
 10.  What is the sticky bit?
    - [https://en.wikipedia.org/wiki/Sticky_bit](https///en.wikipedia.org/wiki/Sticky_bit)
 11.  What does the immutable bit do to a file?
```
# man chattr

......
   A file with the 'i' attribute cannot be modified: it cannot be deleted or renamed,
   no link can be created  to  this file and no data can be written to the file.
   Only the superuser or a process possessing the CAP_LINUX_IMMUTABLE capability can set
   or clear this attribute.
```
 12.  What is the difference between hardlinks and symlinks? \\ What happens when you remove the source to a symlink/hardlink?
 13.  What is an inode and what fields are stored in an inode?
 14.  How to force/trigger a file system check on next reboot?
 15.  What is **SNMP** and what is it used for?
    - [https://en.wikipedia.org/wiki/Simple_Network_Management_Protocol](https///en.wikipedia.org/wiki/Simple_Network_Management_Protocol)
 16.  What is a runlevel and how to get the current runlevel?
    - [https://en.wikipedia.org/wiki/Runlevel](https///en.wikipedia.org/wiki/Runlevel)
 17.  What is SSH port forwarding?
    - [https://en.wikipedia.org/wiki/Port_forwarding](https///en.wikipedia.org/wiki/Port_forwarding)
 18.  What is the difference between local and remote port forwarding?
    - [https://en.wikipedia.org/wiki/Port_forwarding](https///en.wikipedia.org/wiki/Port_forwarding)
 19.  What are the steps to add a user to a system without using ''useradd'' / ''adduser''?
 20.  What is MAJOR and MINOR numbers of special files?
 21.  Describe the ''mknod'' command and when you'd use it.
 22.  Describe a scenario when you get a "filesystem is full" error, but ''df'' shows there is free space.
 23.  Describe a scenario when deleting a file, but ''df'' not showing the space being freed.
 24.  Describe how ''ps'' works.
 25.  What happens to a child process that dies and has no parent process to wait for it and what’s bad about this?
 26.  Explain briefly each one of the process states.
 27.  How to know which process listens on a specific port?
```
port_number="60734"
netstat -anp | grep ":${port_number}"
```
 28.  What is a zombie process and what could be the cause of it?
    - [https://en.wikipedia.org/wiki/Zombie_process](https///en.wikipedia.org/wiki/Zombie_process)
 29.  You run a bash script and you want to see its output on your terminal and save it to a file at the same time. \\ How could you do it?
    - `program 2>&1 | tee logfile`{bash}
 30.  Explain what ''echo "1" > /proc/sys/net/ipv4/ip_forward'' does.
 31.  Describe briefly the steps you need to take in order to create and install a valid certificate for the site ''https://foo.example.com''
 32.  Can you have several HTTPS virtual hosts sharing the same IP?
 33.  What is a wildcard certificate?
 34.  Which Linux file types do you know?
 35.  What is the difference between a process and a thread? \\ And parent and child processes after a fork system call?
 36.  What is the difference between ''exec'' and ''fork''?
    - [https://en.wikipedia.org/wiki/Exec_(system_call)](https///en.wikipedia.org/wiki/Exec_(system_call))
    - [https://en.wikipedia.org/wiki/Process_fork](https///en.wikipedia.org/wiki/Process_fork)
    - [https://en.wikipedia.org/wiki/Fork%E2%80%93exec](https///en.wikipedia.org/wiki/Fork%E2%80%93exec)
 37.  What is ''nohup'' used for?
    - [https://en.wikipedia.org/wiki/Nohup](https///en.wikipedia.org/wiki/Nohup)
 38.  What is the difference between these two commands?
```
myvar=hello
export myvar=hello
```
 39.  How many NTP servers would you configure in your local ntp.conf?
 40.  What does the column 'reach' mean in ''ntpq -p'' output?
 41.  You need to upgrade kernel at 100-1000 servers, how would you do this?
 42.  How can you get Host, Channel, ID, LUN of SCSI disk?
 43.  How can you limit process memory usage?
 44.  What is bash quick substitution/caret replace(^x^y)?
 45.  Do you know of any alternative shells? \\ If so, have you used any?
 46.  What is a tarpipe (or, how would you go about copying everything, including hardlinks and special files, from one server to another)?
 47.  How can you tell if the ''httpd'' package was already installed?
 48.  How can you list the contents of a package?
 49.  How can you determine which package is better: ''openssh-server-5.3p1-118.1.el6_8.x86_64'' or ''openssh-server-6.6p1-1.el6.x86_64'' ?

### Hard Linux Questions

 1.  What is a tunnel and how you can bypass a http proxy?
 2.  What is the difference between IDS and IPS?
 3.  What shortcuts do you use on a regular basis?
 4.  What is the Linux Standard Base?
 5.  What is an atomic operation?
 6.  Your freshly configured http server is not running after a restart, what can you do?
 7.  What kind of keys are in `~/.ssh/authorized_keys` and what this file is used for?
 8.  I've added my public ssh key into `~/.ssh/authorized_keys` but I'm still getting a password prompt.
What can be wrong?
     - First of all check the running `sshd` config
```
sshd -T | grep -i 'pubkeyauth'
```
 Should give:
```
pubkeyauthentication yes
```
     - File/directory permissions issue - the primary suspect Look at the `/var/log/secure` (RHEL/CentOS), `/var/log/auth.log` (Debian-based).
 9.  What should be the files/directories permissions for: `~`, `~/.ssh`, `~/.ssh/authorized_keys` ?
```
~# ls -ald /root
drwx------ 6 root root 4096 Aug 30 15:57 /root
~# ls -ald /root/.ssh
drwxrwxr-x 2 root root 4096 Nov  9  2016 /root/.ssh
~# ls -ald /root/.ssh/authorized_keys 
-rw------- 1 root root 765 Nov  9  2016 /root/.ssh/authorized_keys
```
 10.  Did you ever create RPM's, DEB's or solaris pkg's?
 11.  How do you catch a Linux signal in a script?
```
man sh
/trap
```
 12.  Can you catch a ''SIGKILL''?
    - NO
    - [https://stackoverflow.com/questions/3908694/sigkill-signal-handler](https///stackoverflow.com/questions/3908694/sigkill-signal-handler)
 13.  What's happening when the Linux kernel is starting the OOM killer and how does it choose which process to kill first?
 14.  Describe the linux boot process with as much detail as possible, starting from when the system is powered on and ending when you get a prompt.
 15.  What's a ''chroot'' jail?
    - `man chroot`
 16.  When trying to umount a directory it says it's busy, how to find out which PID holds the directory?
    - `fuser`
    - `lsof`
 17.  What's ''LD_PRELOAD'' and when it's used?
    - [https://rafalcieslak.wordpress.com/2013/04/02/dynamic-linker-tricks-using-ld_preload-to-cheat-inject-features-and-investigate-programs/](https///rafalcieslak.wordpress.com/2013/04/02/dynamic-linker-tricks-using-ld_preload-to-cheat-inject-features-and-investigate-programs/)
    - [https://blog.cryptomilk.org/2014/07/21/what-is-preloading/](https///blog.cryptomilk.org/2014/07/21/what-is-preloading/)
 18.  You ran a binary and nothing happened. How would you debug this?
    - `man strace`
 19.  What are ''cgroups''? \\ Can you specify a scenario where you could use them?
 20.  How can you remove/delete a file with file-name consisting of only non-printable/non-type-able characters?
 21.  How can you increase or decrease the priority of a process in Linux?
    - `man nice`
    - `man ionice`
 22.  What are run-levels in Linux?
    - [https://en.wikipedia.org/wiki/Runlevel](https///en.wikipedia.org/wiki/Runlevel)

### Expert Linux Questions

 1.  A running process gets ''EAGAIN: Resource temporarily unavailable'' on reading a socket. How can you close this bad socket/file descriptor without killing the process?

### Networking Questions

 1.  What is ''localhost'' and why would ''ping localhost'' fail?
 2.  What is the similarity between ''ping'' & ''traceroute'' ? How is ''traceroute'' able to find the hops.
 3.  What is the command used to show all open ports and/or socket connections on a machine?
 4.  Is ''300.168.0.123'' a valid IPv4 address?
    - No :-D
 5.  Which IP ranges/subnets are "private" or "non-routable" ([RFC 1918)](https///tools.ietf.org/html/rfc1918)?
 6.  What is a VLAN?
    - [https://en.wikipedia.org/wiki/Virtual_LAN](https///en.wikipedia.org/wiki/Virtual_LAN)
 7.  What is ARP and what is it used for?
    - [https://en.wikipedia.org/wiki/Address_Resolution_Protocol](https///en.wikipedia.org/wiki/Address_Resolution_Protocol)
 8.  What is the difference between TCP and UDP?
 9.  What is the purpose of a default gateway?
 10.  What is command used to show the routing table on a Linux box?
 11.  A TCP connection on a network can be uniquely defined by 4 things. What are those things?
    - `src_address:src_port `<-->` dst_address:dst_port`
 12.  When a client running a web browser connects to a web server, what is the source port and what is the destination port of the connection?
    - `client_address:src_port(usually > 1023) `<-->` webserver_address:80`
    - `client_address:src_port(usually > 1023) `<-->` webserver_address:443`
 13.  How do you add an IPv6 address to a specific interface?
 14.  You have added an IPv4 and IPv6 address to interface eth0. A ping to the v4 address is working but a ping to the v6 address gives yout the response sendmsg: operation not permitted. What could be wrong?
 15.  What is SNAT and when should it be used?
    - [https://en.wikipedia.org/wiki/Network_address_translation#SNAT](https///en.wikipedia.org/wiki/Network_address_translation#SNAT)
 16.  Explain how could you ssh login into a Linux system that DROPs all new incoming packets using a SSH tunnel.
 17.  How do you stop a DDoS attack?
 18.  How can you see content of an ip packet?
 19.  What is IPoAC (RFC 1149)?
    - [https://tools.ietf.org/html/rfc1149](https///tools.ietf.org/html/rfc1149) - relax :-) Just kidding !

### DevOps Questions

 1.  Can you describe your workflow when you create a script?
 2.  What is GIT?
 3.  What is a dynamically/statically linked file?
 4.  What does ''./configure && make && make install'' do?
 5.  What is puppet/chef/ansible used for?
 6.  What is Nagios/Zenoss/NewRelic used for?
 7.  What is Jenkins/TeamCity/GoCI used for?
 8.  What is the difference between Containers and VMs?
 9.  How do you create a new postgres user?
 10.  What is a virtual IP address? What is a cluster?
 11.  How do you print all strings of printable characters present in a file?
 12.  How do you find shared library dependencies?
 13.  What is **Automake** and **Autoconf** ?
 14.  ''./configure'' shows an error that libfoobar is missing on your system, how could you fix this, what could be wrong?
 15.  What are the advantages/disadvantages of script vs compiled program?
 16.  What's the relationship between continuous delivery and DevOps?
 17.  What are the important aspects of a system of continuous integration and deployment?

### Fun Questions

 1.  A careless sysadmin executes the following command: ''chmod 444 /bin/chmod'' - what do you do to fix this?
    - [https://www.reddit.com/r/linux/comments/1p3bk6/i_guess_i_broke_linux_i_ran_chmod_400_chmod_and/](https///www.reddit.com/r/linux/comments/1p3bk6/i_guess_i_broke_linux_i_ran_chmod_400_chmod_and/)
 2.  I've lost my ''root'' password, what can I do?
 3.  I've rebooted a remote server but after 10 minutes I'm still not able to ssh into it, what can be wrong?
 4.  If you were stuck on a desert island with only 5 command-line utilities, which would you choose?
 5.  You come across a random computer and it appears to be a command console for the universe. What is the first thing you type?
 6.  Tell me about a creative way that you've used SSH?
 7.  You have deleted by error a running script, what could you do to restore it?
 8.  What will happen on 19 January 2038?
 9.  How to reboot server when ''reboot'' command is not responding?

### Demo Time

 1.  Unpack `test.tar.gz`  without man pages or google.
    - `tar zxvf test.tar.gz -C /path/to/destination/directory`{bash}
 2.  Remove all `*.pyc`  files from testdir recursively?
    - `find /test/dir -name "*.pyc" -a -type f -delete`{bash}
 3.  Search for "my kung fu is the best" in all `*.py`  files.
    - `find / -name "*.py" -exec grep -H -r "my kung fu is the best" {} \;`{bash}
 4.  Replace the occurrence of "my kung fu is the best" with "I'm a linux jedi master" in all `*.txt`  files.
    - `find / -name "*.txt" -exec sed -i -e "s/my kung fu is the best/I'm a linux jedi master/g" {} \;`{bash}
 5.  Test if port 443 on a machine with IP address X.X.X.X is reachable.
    - `telnet ya.ru 443`{bash}
    - `nmap -sT -p 443 ya.ru`{bash}
 6.  Get ''[http://myinternal.webserver.local/test.html](http://myinternal.webserver.local/test.html)'' via telnet.
    - [http://www.esqsoft.com/examples/troubleshooting-http-using-telnet.htm](http://www.esqsoft.com/examples/troubleshooting-http-using-telnet.htm)
 7.  How to send an email without a mail client, just on the command line?
```
telnet smtp.server.address.or.hostname 25

MAIL FROM: putin@kremlin.ru
RSPT TO: trump@whitehouse.gov
DATA
Subject: How are you?

Hello, my friend :)
.`<ENTER>`
QUIT
```
 8.  Find all files which have been accessed within the last 30 days.
    - `find / -atime 30`{bash}
 9.  Explain the following command ''(date ; ps -ef | awk '{print $1}' | sort | uniq | wc -l ) >> Activity.log''
 10.  Write a script to list all the differences between two directories.
 11.  In a log file with contents as `<TIME> : [MESSAGE] : [ERROR_NO] - Human readable text` display summary/count of specific error numbers that occurred every hour or a specific hour.


\\ \\
------

## References

*Some questions are 'borrowed' from other great references like:*

 1.  [Linux Administration: Learning by example](http://www.linux-admins.net/2010/12/lpi-101-certification-practice-test.html)
 2.  [How to Interview Engineers](https///triplebyte.com/blog/how-to-interview-engineers)
 3.  [Linux Interview Questions](http://www.linux-admins.net/2012/06/linux-interview-questions.html)
 4.  [Linux System Administrator/DevOps Interview Questions](https///github.com/chassing/linux-sysadmin-interview-questions) - {{github-001.png?nolink&20}} Github
 5.  [Front-end Job Interview Questions](https///github.com/darcyclarke/Front-end-Developer-Interview-Questions) - {{github-001.png?nolink&20}} Github
 6.  [inux-sysadmin-interview-questions](https///github.com/kylejohnson/linux-sysadmin-interview-questions) - {{github-001.png?nolink&20}} Github
 7.  [Top 30 Linux System Admin Interview Questions & Answers](https///www.linuxtechi.com/experience-linux-admin-interview-questions/)
 8.  [25 Job Interview Questions for Linux System Administrators](http://www.aditiconsulting.com/25-job-interview-questions-for-linux-system-administrators/)
 9.  [40 Linux Interview Questions and Answers](http://www.careerride.com/Linux-Interview-Questions.aspx)
 10.  [10 Job Interview Questions for Linux System Administrators](https///www.linuxfoundation.org/blog/10-job-interview-questions-for-linux-system-administrators/)
 11.  [Top 50 Linux System Administrator Interview Questions](https///fossbytes.com/top-50-linux-system-administrator-interview-questions-answers/)
 12.  [Top 60 Linux Interview Questions & Answers](https///career.guru99.com/top-50-linux-interview-questions/)
 13.  [Top Linux Interview Questions And Answers](https///intellipaat.com/interview-question/linux-interview-questions/)
 14.  [11 Basic Linux Interview Questions and Answers](https///www.tecmint.com/basic-linux-interview-questions-and-answers/)


\\
----------------------------
`<WRAP lo>`
2016-2018
`</WRAP>`

