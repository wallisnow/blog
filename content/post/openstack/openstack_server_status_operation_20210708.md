---
title: "[openstack] 如何开关vm及类似操作命令"
draft: false
tags: ["openstack", "server"]
categories: ["openstack"]
author: "Jiang WU"

contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'

---

*1. 往往这些操作是需要特定权限的, 确保操作是你是有操作权限的.*

> 暂停/取消暂停
* 这种状态下VM的状态会保存到RAM中, CUP则不会, 取消后会继续暂停前的状态
```
$ openstack server pause myInstance
$ openstack server unpause myInstance
```
> 挂起/取消挂起
* 这种状态类似物理机休眠, 状态会保存在文件中, CUP和RAM会被释放出来
```
$ openstack server pause myInstance
$ openstack server resume myInstance
```
> 停机/启动
```
$ openstack server start myInstance
$ openstack server stop myInstance
```
> 检查机器状态
```
//简单查看, 即从所有实例中找目标机器
$ openstack server list | grep myInstance
+--------------------------------------+-------------+---------+----------------------------------------------------------------------------------------------
| ID                                   | Name        | Status  | Networks                                                                                     
+--------------------------------------+-------------+---------+----------------------------------------------------------------------------------------------
| 27b48f01-aed0-47e6-b3ab-c22e1d7064f4 | master-01   | SHUTOFF | internal-net-01=10.0.10.75, fd00::17:1111::2f7 
....

//详细信息
$ openstack server show master-01
+-------------------------------------+------------------------------------------------------------------+
| Field                               | Value                                                            |
+-------------------------------------+------------------------------------------------------------------+
| OS-DCF:diskConfig                   | MANUAL                                                           |
| OS-EXT-AZ:availability_zone         | nova                                                             |
| accessIPv4                          |                                                                  |
| accessIPv6                          |                                                                  |
| addresses                           | internal-net-01=10.0.10.75, fd00::17:1111::2f7                   |
| config_drive                        | True                                                             |
| created                             | 2021-07-08T08:48:53Z                                             |
| flavor                              | large                                                            |
| id                                  | f4bbcae1-5e7a-4b72-929a-f3fdbd06fdb9                             |
| image                               | N/A (booted from volume)                                         |
| key_name                            | None                                                             |
| name                                | master-01                                                        |
| progress                            | 0                                                                |
... ...
+-------------------------------------+------------------------------------------------------------------+
```

> [官方的server操作文档(pike)](https://docs.openstack.org/python-openstackclient/pike/cli/command-objects/server.html#server-suspend)