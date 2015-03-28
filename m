Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:11617 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbbC1KCS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 28 Mar 2015 06:02:18 -0400
Message-ID: <55167C1C.6010001@huawei.com>
Date: Sat, 28 Mar 2015 18:02:04 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: PCI <linux-pci@vger.kernel.org>,
	"Herui (Ray)" <Ray.herui@huawei.com>
Subject: Assign mem resource fail after remove and rescan
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Yinghai, Bjorn
   I found a memory resource assignment fail after I did remove and rescan a bridge device,
I don't know whether this is a kernel bug, I hope could get some advice from you, thanks!

My pci tree:
-[0000:00]-+-00.0  Intel Corporation 2nd Generation Core Processor Family DRAM Controller
...
           +-1c.0-[02-21]----00.0-[03-21]--+-01.0-[04-12]----00.0-[05-12]----19.0-[06-12]----00.0  PLX Technology, Inc. Device 1009
           |                               +-05.0-[13]--
           |                               +-07.0-[14-20]----00.0-[15-20]--+-08.0-[16]--+-00.0  NVIDIA Corporation GT218 [GeForce 210]
           |                               |                               |            \-00.1  NVIDIA Corporation High Definition Audio Controller
           |                               |                               +-14.0-[17]----00.0  Intel Corporation Device 0953
           |                               |                               \-19.0-[18-20]----00.0  PLX Technology, Inc. Device 1009
           |                               \-09.0-[21]--


Reproduce action:
1. echo 1 > /sys/bus/pci/devices/0000:05:19.0/remove
2. echo 1 > /sys/bus/pci/rescan

After above operations, I found the memory resource assigned fail.

Fail log:
[  105.905480] pci_bus 0000:06: busn_res: [bus 06-12] is released
[  125.771655] pci_bus 0000:01: busn_res: [bus 01] end is updated to 01
[  125.772519] pci 0000:05:19.0: [10b5:9797] type 01 class 0x060400
[  125.772846] pci 0000:05:19.0: PME# supported from D0 D3hot D3cold
[  125.778576] pci_bus 0000:06: busn_res: can not insert [bus 06-ff] under [bus 05-12] (conflicts with (null) [bus 05-12])
[  125.778638] pci 0000:06:00.0: [10b5:1009] type 00 class 0x088000
[  125.778693] pci 0000:06:00.0: reg 0x10: [mem 0xe8000000-0xe87fffff]
[  125.778761] pci 0000:06:00.0: reg 0x18: [mem 0xe4000000-0xe7ffffff 64bit]
[  125.782315] pci 0000:05:19.0: PCI bridge to [bus 06-ff]
[  125.782345] pci 0000:05:19.0:   bridge window [mem 0xe4000000-0xe87fffff]
[  125.782366] pci_bus 0000:06: busn_res: [bus 06-ff] end is updated to 12
[  125.782380] pci_bus 0000:05: busn_res: [bus 05-12] end is updated to 12
[  125.782393] pci_bus 0000:04: busn_res: [bus 04-12] end is updated to 12
[  125.782422] pci_bus 0000:13: busn_res: [bus 13] end is updated to 13
[  125.782674] pci_bus 0000:16: busn_res: [bus 16] end is updated to 16
[  125.782721] pci_bus 0000:17: busn_res: [bus 17] end is updated to 17
[  125.782751] pci_bus 0000:18: busn_res: [bus 18-20] end is updated to 20
[  125.782763] pci_bus 0000:15: busn_res: [bus 15-20] end is updated to 20
[  125.782775] pci_bus 0000:14: busn_res: [bus 14-20] end is updated to 20
[  125.782802] pci_bus 0000:21: busn_res: [bus 21] end is updated to 21
[  125.782812] pci_bus 0000:03: busn_res: [bus 03-21] end is updated to 21
[  125.782822] pci_bus 0000:02: busn_res: [bus 02-21] end is updated to 21
[  125.782845] pci_bus 0000:22: busn_res: [bus 22] end is updated to 22
[  125.786433] pci_bus 0000:24: busn_res: [bus 24] end is updated to 24
[  125.786450] pci_bus 0000:23: busn_res: [bus 23-24] end is updated to 24
[  125.786749] pci 0000:05:19.0: BAR 14: no space for [mem size 0x06000000]
[  125.786754] pci 0000:05:19.0: BAR 14: failed to assign [mem size 0x06000000]
[  125.786760] pci 0000:06:00.0: BAR 2: no space for [mem size 0x04000000 64bit]
[  125.786764] pci 0000:06:00.0: BAR 2: failed to assign [mem size 0x04000000 64bit]
[  125.786769] pci 0000:06:00.0: BAR 0: no space for [mem size 0x00800000]
[  125.786773] pci 0000:06:00.0: BAR 0: failed to assign [mem size 0x00800000]
[  125.786777] pci 0000:05:19.0: PCI bridge to [bus 06-12]
[  125.786819] pci 0000:23:00.0: PCI bridge to [bus 24]

System boot log:

...
[    0.122097] pci 0000:05:19.0: [10b5:9797] type 01 class 0x060400
[    0.122373] pci 0000:05:19.0: PME# supported from D0 D3hot D3cold
[    0.122481] pci 0000:04:00.0: PCI bridge to [bus 05-ff]
[    0.122501] pci 0000:04:00.0:   bridge window [mem 0xe4000000-0xe87fffff]
[    0.122708] pci 0000:06:00.0: [10b5:1009] type 00 class 0x088000
[    0.122749] pci 0000:06:00.0: reg 0x10: [mem 0xe8000000-0xe87fffff]
[    0.122816] pci 0000:06:00.0: reg 0x18: [mem 0xe4000000-0xe7ffffff 64bit]
[    0.123323] pci 0000:05:19.0: PCI bridge to [bus 06-ff]
[    0.123346] pci 0000:05:19.0:   bridge window [mem 0xe4000000-0xe87fffff]
...

I compared above log and found after we did remove and rescan, the bridge requested resource size extended to 0x06000000,
and when system boot up, it requested only 0x4800000.

In hotplug(remove and rescan) path, we would call calculate_mem_align() function which would align the resource at 0x2000000.

I wonder is this a resource assignment bug ?


Thanks!
Yijing.





-- 
Thanks!
Yijing

