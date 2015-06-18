Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:9998 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704AbbFRMGm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jun 2015 08:06:42 -0400
Message-ID: <5582B43F.4090303@huawei.com>
Date: Thu, 18 Jun 2015 20:06:23 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Rajat Jain <rajatxjain@gmail.com>, PCI <linux-pci@vger.kernel.org>
Subject: pciehp command complete timeout issue
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When I tried to unbind pciehp driver on a pcie root port(bound pciehp driver),
a lot timeout warning appeared.

The first timeout value is 102387672 msec :(
I debug and found that when pciehp complete pcie_enable_notification(), there was no command complete interrupt
be triggered, so cmd_busy always be set, and once another command post, a very long timeout warning noised.


 +-[0000:40]-+-00.0-[41]--
 |           +-01.0-[42-43]--+-00.0  Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection
 |           |               \-00.1  Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection
 |           +-03.0-[44-45]--+-00.0  Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection
 |           |               \-00.1  Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection

[root@hulk slots]# ls
0  0-1  0-2  0-3  0-4  0-5  1  10  11  12  13  14  15  16  2  3  4  5  6  7  8  9
[root@hulk slots]# cat 6/address
0000:44:00
[root@hulk slots]#

[root@hulk pciehp]# echo 0000:40:03.0:pcie04 > unbind
[root@hulk pciehp]#

...
[102413.749632] pciehp 0000:40:03.0:pcie04: unloading service driver pciehp
[102413.749638] pciehp_remove dev 0000:40:03.0, cmd_busy 1
[102413.754929] pcie_disable_notification: ctrl cmd busy 1
[102413.765903] pciehp 0000:40:03.0:pcie04: Timeout on hotplug command 0x11f1 (issued 102387672 msec ago)
[102413.775171] pcie_do_write_cmd: dev 0000:40:03.0, cmd_busy set to 1
[102415.377950] pciehp 0000:40:03.0:pcie04: Timeout on hotplug command 0x01c0 (issued 1600 msec ago)
...

-- 
Thanks!
Yijing

