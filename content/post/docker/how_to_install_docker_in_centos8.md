---
title: "centos8 安装docker"
date: 2021-07-19T11:16:26+03:00
draft: false
tags: ["docker", "centos8"]
categories: ["docker"]
comments: true
---

# 1. 前置条件
准备一台centos 8 的机器, 我这里用的是vagrant安装的centos8镜像

# 2. 安装过程

```
//测试是否链接外网
[vagrant@localhost ~]$ ping google.com
PING google.com (216.58.211.14) 56(84) bytes of data.
64 bytes from muc03s13-in-f14.1e100.net (216.58.211.14): icmp_seq=1 ttl=63 time=11.5 ms
64 bytes from muc03s13-in-f14.1e100.net (216.58.211.14): icmp_seq=2 ttl=63 time=12.1 ms
^C
--- google.com ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 2ms
rtt min/avg/max/mdev = 11.476/11.781/12.086/0.305 ms


//删除旧的docker
[vagrant@localhost ~]$ sudo yum remove docker \
>                   docker-client \
>                   docker-client-latest \
>                   docker-common \
>                   docker-latest \
>                   docker-latest-logrotate \
>                   docker-logrotate \
>                   docker-engine
No match for argument: docker
No match for argument: docker-client
No match for argument: docker-client-latest
No match for argument: docker-common
No match for argument: docker-latest
No match for argument: docker-latest-logrotate
No match for argument: docker-logrotate
No match for argument: docker-engine
No packages marked for removal.
Dependencies resolved.
Nothing to do.
Complete!

//安装需要的依赖包
[vagrant@localhost ~]$ sudo yum install -y yum-utils
CentOS Linux 8 - AppStream                                                                                                                               7.4 MB/s | 8.1 MB     00:01    
CentOS Linux 8 - BaseOS                                                                                                                                  4.7 MB/s | 3.6 MB     00:00    
CentOS Linux 8 - Extras                                                                                                                                   38 kB/s | 9.8 kB     00:00    
Package yum-utils-4.0.17-5.el8.noarch is already installed.
Dependencies resolved.
=========================================================================================================================================================================================
 Package                                                 Architecture                          Version                                       Repository                             Size
=========================================================================================================================================================================================
Upgrading:
 dnf-plugins-core                                        noarch                                4.0.18-4.el8                                  baseos                                 69 k
 python3-dnf-plugins-core                                noarch                                4.0.18-4.el8                                  baseos                                234 k
 yum-utils                                               noarch                                4.0.18-4.el8                                  baseos                                 71 k

Transaction Summary
=========================================================================================================================================================================================
Upgrade  3 Packages

Total download size: 375 k
Downloading Packages:
(1/3): yum-utils-4.0.18-4.el8.noarch.rpm                                                                                                                 1.3 MB/s |  71 kB     00:00    
(2/3): dnf-plugins-core-4.0.18-4.el8.noarch.rpm                                                                                                          1.2 MB/s |  69 kB     00:00    
(3/3): python3-dnf-plugins-core-4.0.18-4.el8.noarch.rpm                                                                                                  3.5 MB/s | 234 kB     00:00    
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                                                                    858 kB/s | 375 kB     00:00     
warning: /var/cache/dnf/baseos-31c79d9833c65cf7/packages/dnf-plugins-core-4.0.18-4.el8.noarch.rpm: Header V3 RSA/SHA256 Signature, key ID 8483c65d: NOKEY
CentOS Linux 8 - BaseOS                                                                                                                                  1.6 MB/s | 1.6 kB     00:00    
Importing GPG key 0x8483C65D:
 Userid     : "CentOS (CentOS Official Signing Key) <security@centos.org>"
 Fingerprint: 99DB 70FA E1D7 CE22 7FB6 4882 05B5 55B3 8483 C65D
 From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
Key imported successfully
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                                                                                                 1/1 
  Upgrading        : python3-dnf-plugins-core-4.0.18-4.el8.noarch                                                                                                                    1/6 
  Upgrading        : dnf-plugins-core-4.0.18-4.el8.noarch                                                                                                                            2/6 
  Upgrading        : yum-utils-4.0.18-4.el8.noarch                                                                                                                                   3/6 
  Cleanup          : yum-utils-4.0.17-5.el8.noarch                                                                                                                                   4/6 
  Cleanup          : dnf-plugins-core-4.0.17-5.el8.noarch                                                                                                                            5/6 
  Cleanup          : python3-dnf-plugins-core-4.0.17-5.el8.noarch                                                                                                                    6/6 
  Running scriptlet: python3-dnf-plugins-core-4.0.17-5.el8.noarch                                                                                                                    6/6 
  Verifying        : dnf-plugins-core-4.0.18-4.el8.noarch                                                                                                                            1/6 
  Verifying        : dnf-plugins-core-4.0.17-5.el8.noarch                                                                                                                            2/6 
  Verifying        : python3-dnf-plugins-core-4.0.18-4.el8.noarch                                                                                                                    3/6 
  Verifying        : python3-dnf-plugins-core-4.0.17-5.el8.noarch                                                                                                                    4/6 
  Verifying        : yum-utils-4.0.18-4.el8.noarch                                                                                                                                   5/6 
  Verifying        : yum-utils-4.0.17-5.el8.noarch                                                                                                                                   6/6 

Upgraded:
  dnf-plugins-core-4.0.18-4.el8.noarch                         python3-dnf-plugins-core-4.0.18-4.el8.noarch                         yum-utils-4.0.18-4.el8.noarch                        

Complete!

//添加docker repo库
[vagrant@localhost ~]$ sudo yum-config-manager \
>     --add-repo \
>     https://download.docker.com/linux/centos/docker-ce.repo
Adding repo from: https://download.docker.com/linux/centos/docker-ce.repo


//安装docker
[vagrant@localhost ~]$ sudo yum install docker-ce docker-ce-cli containerd.io
Docker CE Stable - x86_64                                                                                                                                 81 kB/s |  14 kB     00:00    
Dependencies resolved.
=========================================================================================================================================================================================
 Package                                           Architecture                Version                                                       Repository                             Size
=========================================================================================================================================================================================
Installing:
 containerd.io                                     x86_64                      1.4.6-3.1.el8                                                 docker-ce-stable                       34 M
 docker-ce                                         x86_64                      3:20.10.7-3.el8                                               docker-ce-stable                       27 M
 docker-ce-cli                                     x86_64                      1:20.10.7-3.el8                                               docker-ce-stable                       33 M
Upgrading:
 libsemanage                                       x86_64                      2.9-6.el8                                                     baseos                                165 k
 policycoreutils                                   x86_64                      2.9-14.el8                                                    baseos                                373 k
Installing dependencies:
 checkpolicy                                       x86_64                      2.9-1.el8                                                     baseos                                348 k
 container-selinux                                 noarch                      2:2.162.0-1.module_el8.4.0+830+8027e1c4                       appstream                              52 k
 docker-ce-rootless-extras                         x86_64                      20.10.7-3.el8                                                 docker-ce-stable                      9.2 M
 docker-scan-plugin                                x86_64                      0.8.0-3.el8                                                   docker-ce-stable                      4.2 M
 fuse-overlayfs                                    x86_64                      1.4.0-3.module_el8.4.0+830+8027e1c4                           appstream                              72 k
 fuse3                                             x86_64                      3.2.1-12.el8                                                  baseos                                 50 k
 fuse3-libs                                        x86_64                      3.2.1-12.el8                                                  baseos                                 94 k
 libcgroup                                         x86_64                      0.41-19.el8                                                   baseos                                 70 k
 libslirp                                          x86_64                      4.3.1-1.module_el8.4.0+575+63b40ad7                           appstream                              69 k
 policycoreutils-python-utils                      noarch                      2.9-14.el8                                                    baseos                                252 k
 python3-audit                                     x86_64                      3.0-0.17.20191104git1c2f876.el8                               baseos                                 86 k
 python3-libsemanage                               x86_64                      2.9-6.el8                                                     baseos                                127 k
 python3-policycoreutils                           noarch                      2.9-14.el8                                                    baseos                                2.2 M
 python3-setools                                   x86_64                      4.3.0-2.el8                                                   baseos                                626 k
 slirp4netns                                       x86_64                      1.1.8-1.module_el8.4.0+641+6116a774                           appstream                              51 k
Enabling module streams:
 container-tools                                                               rhel8                                                                                                    

Transaction Summary
=========================================================================================================================================================================================
Install  18 Packages
Upgrade   2 Packages

Total download size: 111 M
Is this ok [y/N]: y
Downloading Packages:
(1/20): container-selinux-2.162.0-1.module_el8.4.0+830+8027e1c4.noarch.rpm                                                                               792 kB/s |  52 kB     00:00    
(2/20): libslirp-4.3.1-1.module_el8.4.0+575+63b40ad7.x86_64.rpm                                                                                          1.0 MB/s |  69 kB     00:00    
(3/20): fuse-overlayfs-1.4.0-3.module_el8.4.0+830+8027e1c4.x86_64.rpm                                                                                    1.0 MB/s |  72 kB     00:00    
(4/20): slirp4netns-1.1.8-1.module_el8.4.0+641+6116a774.x86_64.rpm                                                                                       4.0 MB/s |  51 kB     00:00    
(5/20): fuse3-libs-3.2.1-12.el8.x86_64.rpm                                                                                                               587 kB/s |  94 kB     00:00    
(6/20): checkpolicy-2.9-1.el8.x86_64.rpm                                                                                                                 1.9 MB/s | 348 kB     00:00    
(7/20): fuse3-3.2.1-12.el8.x86_64.rpm                                                                                                                    261 kB/s |  50 kB     00:00    
(8/20): libcgroup-0.41-19.el8.x86_64.rpm                                                                                                                 1.6 MB/s |  70 kB     00:00    
(9/20): policycoreutils-python-utils-2.9-14.el8.noarch.rpm                                                                                               3.2 MB/s | 252 kB     00:00    
(10/20): python3-audit-3.0-0.17.20191104git1c2f876.el8.x86_64.rpm                                                                                        1.3 MB/s |  86 kB     00:00    
(11/20): python3-libsemanage-2.9-6.el8.x86_64.rpm                                                                                                        2.6 MB/s | 127 kB     00:00    
(12/20): python3-setools-4.3.0-2.el8.x86_64.rpm                                                                                                          5.9 MB/s | 626 kB     00:00    
(13/20): python3-policycoreutils-2.9-14.el8.noarch.rpm                                                                                                   5.1 MB/s | 2.2 MB     00:00    
(14/20): docker-ce-20.10.7-3.el8.x86_64.rpm                                                                                                              7.1 MB/s |  27 MB     00:03    
(15/20): docker-ce-rootless-extras-20.10.7-3.el8.x86_64.rpm                                                                                              4.1 MB/s | 9.2 MB     00:02    
(16/20): docker-scan-plugin-0.8.0-3.el8.x86_64.rpm                                                                                                       4.0 MB/s | 4.2 MB     00:01    
(17/20): libsemanage-2.9-6.el8.x86_64.rpm                                                                                                                3.5 MB/s | 165 kB     00:00    
(18/20): policycoreutils-2.9-14.el8.x86_64.rpm                                                                                                           3.6 MB/s | 373 kB     00:00    
(19/20): docker-ce-cli-20.10.7-3.el8.x86_64.rpm                                                                                                          4.4 MB/s |  33 MB     00:07    
(20/20): containerd.io-1.4.6-3.1.el8.x86_64.rpm                                                                                                          3.7 MB/s |  34 MB     00:09    
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                                                                     11 MB/s | 111 MB     00:10     
warning: /var/cache/dnf/docker-ce-stable-fa9dc42ab4cec2f4/packages/containerd.io-1.4.6-3.1.el8.x86_64.rpm: Header V4 RSA/SHA512 Signature, key ID 621e9f35: NOKEY
Docker CE Stable - x86_64                                                                                                                                 18 kB/s | 1.6 kB     00:00    
Importing GPG key 0x621E9F35:
 Userid     : "Docker Release (CE rpm) <docker@docker.com>"
 Fingerprint: 060A 61C5 1B55 8A7F 742B 77AA C52F EB6B 621E 9F35
 From       : https://download.docker.com/linux/centos/gpg
Is this ok [y/N]: y
Key imported successfully
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                                                                                                 1/1 
  Running scriptlet: docker-scan-plugin-0.8.0-3.el8.x86_64                                                                                                                           1/1 
  Installing       : docker-scan-plugin-0.8.0-3.el8.x86_64                                                                                                                          1/22 
  Running scriptlet: docker-scan-plugin-0.8.0-3.el8.x86_64                                                                                                                          1/22 
  Installing       : docker-ce-cli-1:20.10.7-3.el8.x86_64                                                                                                                           2/22 
  Running scriptlet: docker-ce-cli-1:20.10.7-3.el8.x86_64                                                                                                                           2/22 
  Upgrading        : libsemanage-2.9-6.el8.x86_64                                                                                                                                   3/22 
  Upgrading        : policycoreutils-2.9-14.el8.x86_64                                                                                                                              4/22 
  Running scriptlet: policycoreutils-2.9-14.el8.x86_64                                                                                                                              4/22 
  Installing       : python3-libsemanage-2.9-6.el8.x86_64                                                                                                                           5/22 
  Installing       : python3-setools-4.3.0-2.el8.x86_64                                                                                                                             6/22 
  Installing       : python3-audit-3.0-0.17.20191104git1c2f876.el8.x86_64                                                                                                           7/22 
  Running scriptlet: libcgroup-0.41-19.el8.x86_64                                                                                                                                   8/22 
  Installing       : libcgroup-0.41-19.el8.x86_64                                                                                                                                   8/22 
  Running scriptlet: libcgroup-0.41-19.el8.x86_64                                                                                                                                   8/22 
  Installing       : fuse3-libs-3.2.1-12.el8.x86_64                                                                                                                                 9/22 
  Running scriptlet: fuse3-libs-3.2.1-12.el8.x86_64                                                                                                                                 9/22 
  Installing       : fuse3-3.2.1-12.el8.x86_64                                                                                                                                     10/22 
  Installing       : fuse-overlayfs-1.4.0-3.module_el8.4.0+830+8027e1c4.x86_64                                                                                                     11/22 
  Running scriptlet: fuse-overlayfs-1.4.0-3.module_el8.4.0+830+8027e1c4.x86_64                                                                                                     11/22 
  Installing       : checkpolicy-2.9-1.el8.x86_64                                                                                                                                  12/22 
  Installing       : python3-policycoreutils-2.9-14.el8.noarch                                                                                                                     13/22 
  Installing       : policycoreutils-python-utils-2.9-14.el8.noarch                                                                                                                14/22 
  Running scriptlet: container-selinux-2:2.162.0-1.module_el8.4.0+830+8027e1c4.noarch                                                                                              15/22 
  Installing       : container-selinux-2:2.162.0-1.module_el8.4.0+830+8027e1c4.noarch                                                                                              15/22 
  Running scriptlet: container-selinux-2:2.162.0-1.module_el8.4.0+830+8027e1c4.noarch                                                                                              15/22 
  Installing       : containerd.io-1.4.6-3.1.el8.x86_64                                                                                                                            16/22 
  Running scriptlet: containerd.io-1.4.6-3.1.el8.x86_64                                                                                                                            16/22 
  Installing       : libslirp-4.3.1-1.module_el8.4.0+575+63b40ad7.x86_64                                                                                                           17/22 
  Installing       : slirp4netns-1.1.8-1.module_el8.4.0+641+6116a774.x86_64                                                                                                        18/22 
  Installing       : docker-ce-rootless-extras-20.10.7-3.el8.x86_64                                                                                                                19/22 
  Running scriptlet: docker-ce-rootless-extras-20.10.7-3.el8.x86_64                                                                                                                19/22 
  Installing       : docker-ce-3:20.10.7-3.el8.x86_64                                                                                                                              20/22 
  Running scriptlet: docker-ce-3:20.10.7-3.el8.x86_64                                                                                                                              20/22 
  Running scriptlet: policycoreutils-2.9-9.el8.x86_64                                                                                                                              21/22 
  Cleanup          : policycoreutils-2.9-9.el8.x86_64                                                                                                                              21/22 
  Cleanup          : libsemanage-2.9-3.el8.x86_64                                                                                                                                  22/22 
  Running scriptlet: container-selinux-2:2.162.0-1.module_el8.4.0+830+8027e1c4.noarch                                                                                              22/22 
  Running scriptlet: libsemanage-2.9-3.el8.x86_64                                                                                                                                  22/22 
  Verifying        : container-selinux-2:2.162.0-1.module_el8.4.0+830+8027e1c4.noarch                                                                                               1/22 
  Verifying        : fuse-overlayfs-1.4.0-3.module_el8.4.0+830+8027e1c4.x86_64                                                                                                      2/22 
  Verifying        : libslirp-4.3.1-1.module_el8.4.0+575+63b40ad7.x86_64                                                                                                            3/22 
  Verifying        : slirp4netns-1.1.8-1.module_el8.4.0+641+6116a774.x86_64                                                                                                         4/22 
  Verifying        : checkpolicy-2.9-1.el8.x86_64                                                                                                                                   5/22 
  Verifying        : fuse3-3.2.1-12.el8.x86_64                                                                                                                                      6/22 
  Verifying        : fuse3-libs-3.2.1-12.el8.x86_64                                                                                                                                 7/22 
  Verifying        : libcgroup-0.41-19.el8.x86_64                                                                                                                                   8/22 
  Verifying        : policycoreutils-python-utils-2.9-14.el8.noarch                                                                                                                 9/22 
  Verifying        : python3-audit-3.0-0.17.20191104git1c2f876.el8.x86_64                                                                                                          10/22 
  Verifying        : python3-libsemanage-2.9-6.el8.x86_64                                                                                                                          11/22 
  Verifying        : python3-policycoreutils-2.9-14.el8.noarch                                                                                                                     12/22 
  Verifying        : python3-setools-4.3.0-2.el8.x86_64                                                                                                                            13/22 
  Verifying        : containerd.io-1.4.6-3.1.el8.x86_64                                                                                                                            14/22 
  Verifying        : docker-ce-3:20.10.7-3.el8.x86_64                                                                                                                              15/22 
  Verifying        : docker-ce-cli-1:20.10.7-3.el8.x86_64                                                                                                                          16/22 
  Verifying        : docker-ce-rootless-extras-20.10.7-3.el8.x86_64                                                                                                                17/22 
  Verifying        : docker-scan-plugin-0.8.0-3.el8.x86_64                                                                                                                         18/22 
  Verifying        : libsemanage-2.9-6.el8.x86_64                                                                                                                                  19/22 
  Verifying        : libsemanage-2.9-3.el8.x86_64                                                                                                                                  20/22 
  Verifying        : policycoreutils-2.9-14.el8.x86_64                                                                                                                             21/22 
  Verifying        : policycoreutils-2.9-9.el8.x86_64                                                                                                                              22/22 

Upgraded:
  libsemanage-2.9-6.el8.x86_64                                                             policycoreutils-2.9-14.el8.x86_64                                                            

Installed:
  checkpolicy-2.9-1.el8.x86_64                        container-selinux-2:2.162.0-1.module_el8.4.0+830+8027e1c4.noarch      containerd.io-1.4.6-3.1.el8.x86_64                         
  docker-ce-3:20.10.7-3.el8.x86_64                    docker-ce-cli-1:20.10.7-3.el8.x86_64                                  docker-ce-rootless-extras-20.10.7-3.el8.x86_64             
  docker-scan-plugin-0.8.0-3.el8.x86_64               fuse-overlayfs-1.4.0-3.module_el8.4.0+830+8027e1c4.x86_64             fuse3-3.2.1-12.el8.x86_64                                  
  fuse3-libs-3.2.1-12.el8.x86_64                      libcgroup-0.41-19.el8.x86_64                                          libslirp-4.3.1-1.module_el8.4.0+575+63b40ad7.x86_64        
  policycoreutils-python-utils-2.9-14.el8.noarch      python3-audit-3.0-0.17.20191104git1c2f876.el8.x86_64                  python3-libsemanage-2.9-6.el8.x86_64                       
  python3-policycoreutils-2.9-14.el8.noarch           python3-setools-4.3.0-2.el8.x86_64                                    slirp4netns-1.1.8-1.module_el8.4.0+641+6116a774.x86_64     

Complete!
```

# 3. 验证

```
[vagrant@localhost ~]$ docker ps
Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?
[vagrant@localhost ~]$ sudo systemctl start docker
[vagrant@localhost ~]$ sudo docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
b8dfde127a29: Pull complete 
Digest: sha256:df5f5184104426b65967e016ff2ac0bfcd44ad7899ca3bbcf8e44e4461491a9e
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

# 4. Ref:
https://docs.docker.com/engine/install/centos/

# 赠瓶肥宅快乐水吧
<img src="/img/wechat_qr.jpg" alt="drawing" width="400"/>
