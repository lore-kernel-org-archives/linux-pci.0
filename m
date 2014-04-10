Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 1wt.eu ([62.212.114.60]:3966 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759266AbaDJXO2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 10 Apr 2014 19:14:28 -0400
Date: Fri, 11 Apr 2014 01:13:36 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>,
	Neil Greatorex <neil@fatboyfat.co.uk>,
	Matthew Minter <matthew_minter@xyratex.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Gerlando Falauto <gerlando.falauto@keymile.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Gregory =?iso-8859-1?Q?Cl=E9ment?=
	<gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: Fixing PCIe issues on Armada XP
Message-ID: <20140410231336.GC30855@1wt.eu>
References: <20140410181953.50ccfcc3@skate> <20140410171000.GF25890@1wt.eu> <20140410200222.27cab16e@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140410200222.27cab16e@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Thomas,

On Thu, Apr 10, 2014 at 08:02:22PM +0200, Thomas Petazzoni wrote:
> > Really cool, I'm going to test that on a few PCIe cards and will report
> > the results here. How can we check the number of mbus windows in use ?
> 
> # cat /sys/kernel/debug/mvebu-mbus/devices

Thanks, so here we go :

XP-GP with igb, works perfectly :

root@xpgp:~# dmesg|grep igb
igb: Intel(R) Gigabit Ethernet Network Driver - version 5.0.5-k
igb: Copyright (c) 2007-2013 Intel Corporation.
igb 0000:02:00.0: added PHC on eth4
igb 0000:02:00.0: Intel(R) Gigabit Ethernet Network Connection
igb 0000:02:00.0: eth4: (PCIe:5.0Gb/s:Width x1) 00:30:18:a6:6c:6a
igb 0000:02:00.0: eth4: PBA No: FFFFFF-0FF
igb 0000:02:00.0: Using MSI interrupts. 1 rx queue(s), 1 tx queue(s)
igb 0000:02:00.1: added PHC on eth5
igb 0000:02:00.1: Intel(R) Gigabit Ethernet Network Connection
igb 0000:02:00.1: eth5: (PCIe:5.0Gb/s:Width x1) 00:30:18:a6:6c:6b
igb 0000:02:00.1: eth5: PBA No: FFFFFF-0FF
igb 0000:02:00.1: Using MSI interrupts. 1 rx queue(s), 1 tx queue(s)

root@xpgp:~# lspci -v -s 02:00 | egrep -i '^0|Memory'
02:00.0 Ethernet controller: Intel Corporation Device 1521 (rev 01)
        Memory at e0000000 (32-bit, non-prefetchable) [size=512K]
        Memory at e0200000 (32-bit, non-prefetchable) [size=16K]
02:00.1 Ethernet controller: Intel Corporation Device 1521 (rev 01)
        Memory at e0100000 (32-bit, non-prefetchable) [size=512K]
        Memory at e0204000 (32-bit, non-prefetchable) [size=16K]

root@xpgp:~# grep -v disabled /sys/kernel/debug/mvebu-mbus/devices 
[00] 00000000e8010000 - 00000000e8020000 : 0004:00f0 (remap 0000000000010000)
[08] 00000000fff00000 - 0000000100000000 : 0001:001d
[09] 00000000f0000000 - 00000000f1000000 : 0001:002f
[10] 00000000e0000000 - 00000000e0200000 : 0004:00f8
[11] 00000000e0200000 - 00000000e0300000 : 0004:00f8

So the areas are well covered, though #11 seems larger than needed
but I seem to remember that they're all rounded up by 1 MB anyway,
then if so, that's OK.

Now with igb + myricom :

root@xpgp:~# lspci -v -s 02:00 | egrep -i '^0|Memory'
02:00.0 Ethernet controller: Intel Corporation Device 1521 (rev 01)
        Memory at e1800000 (32-bit, non-prefetchable) [disabled] [size=512K]
        Memory at e1a00000 (32-bit, non-prefetchable) [disabled] [size=16K]
02:00.1 Ethernet controller: Intel Corporation Device 1521 (rev 01)
        Memory at e1900000 (32-bit, non-prefetchable) [disabled] [size=512K]
        Memory at e1a04000 (32-bit, non-prefetchable) [disabled] [size=16K]

root@xpgp:~# lspci -v -s 03:00 | egrep -i '^0|Memory'
03:00.0 Ethernet controller: MYRICOM Inc. Myri-10G Dual-Protocol NIC
        Memory at e0000000 (64-bit, prefetchable) [size=16M]
        Memory at e1000000 (64-bit, non-prefetchable) [size=1M]

root@xpgp:~# modprobe igb
igb: Intel(R) Gigabit Ethernet Network Driver - version 5.0.5-k
igb: Copyright (c) 2007-2013 Intel Corporation.
PCI: enabling device 0000:00:09.0 (0140 -> 0143)
PCI: enabling device 0000:02:00.0 (0140 -> 0142)
igb 0000:02:00.0: added PHC on eth4
igb 0000:02:00.0: Intel(R) Gigabit Ethernet Network Connection
igb 0000:02:00.0: eth4: (PCIe:5.0Gb/s:Width x1) 00:30:18:a6:6c:6a
igb 0000:02:00.0: eth4: PBA No: FFFFFF-0FF
igb 0000:02:00.0: Using MSI interrupts. 1 rx queue(s), 1 tx queue(s)
PCI: enabling device 0000:02:00.1 (0140 -> 0142)
igb 0000:02:00.1: added PHC on eth5
igb 0000:02:00.1: Intel(R) Gigabit Ethernet Network Connection
igb 0000:02:00.1: eth5: (PCIe:5.0Gb/s:Width x1) 00:30:18:a6:6c:6b
igb 0000:02:00.1: eth5: PBA No: FFFFFF-0FF
igb 0000:02:00.1: Using MSI interrupts. 1 rx queue(s), 1 tx queue(s)

root@xpgp:~# modprobe myri10ge
myri10ge: Version 1.5.3-1.534
PCI: enabling device 0000:00:0a.0 (0140 -> 0143)
myri10ge 0000:03:00.0: PCIE x4 Link
myri10ge 0000:03:00.0: Direct firmware load failed with error -2
myri10ge 0000:03:00.0: Falling back to user helper
myri10ge 0000:03:00.0: Unable to load myri10ge_eth_z8e.dat firmware image via hotplug
myri10ge 0000:03:00.0: hotplug firmware loading failed
myri10ge 0000:03:00.0: Successfully adopted running firmware
myri10ge 0000:03:00.0: Using firmware currently running on NIC.  For optimal
myri10ge 0000:03:00.0: performance consider loading optimized firmware
myri10ge 0000:03:00.0: via hotplug
myri10ge 0000:03:00.0: MSI IRQ 113, tx bndry 2048, fw adopted, WC Disabled

root@xpgp:~# grep -v disabled /sys/kernel/debug/mvebu-mbus/devices
[00] 00000000e8010000 - 00000000e8020000 : 0004:00f0 (remap 0000000000010000)
[08] 00000000fff00000 - 0000000100000000 : 0001:001d
[09] 00000000f0000000 - 00000000f1000000 : 0001:002f
[10] 00000000e1800000 - 00000000e1a00000 : 0004:00f8
[11] 00000000e1a00000 - 00000000e1b00000 : 0004:00f8
[12] 00000000e0000000 - 00000000e1000000 : 0008:00f8
[13] 00000000e1000000 - 00000000e1800000 : 0008:00f8

I noticed above that both igb ports share the same window #11. So I
tried to rmmod igb, remove both PCI devices, check mbus again (which
did not change), rescan PCI and modprobe igb again, and everything is
still operational with the same windows. I don't know if it is normal
that they're not unregistered when the device goes away (maybe there's
no refcount) ?

If we have to keep them forever, then maybe a further improvement
will consist in merging adjacent windows which sum up as a power of
two (eg: #10 and #11 may be merged).

I tried to add a 3rd NIC in the mix (broadcom tg3), which caused the
myri10ge to fail to load for an obscure reason after loading igb
properly :

root@xpgp:~# dmesg
tg3.c:v3.134 (Sep 16, 2013)
PCI: enabling device 0000:00:01.0 (0140 -> 0143)
tg3 0000:01:00.0 eth4: Tigon3 [partno(BCM95721A211) rev 4001] (PCI Express) MAC address 00:07:11:04:3e:e6
tg3 0000:01:00.0 eth4: attached PHY is 5750 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
tg3 0000:01:00.0 eth4: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
tg3 0000:01:00.0 eth4: dma_rwctrl[76180000] dma_mask[64-bit]
igb: Intel(R) Gigabit Ethernet Network Driver - version 5.0.5-k
igb: Copyright (c) 2007-2013 Intel Corporation.
PCI: enabling device 0000:00:09.0 (0140 -> 0143)
PCI: enabling device 0000:02:00.0 (0140 -> 0142)
igb 0000:02:00.0: added PHC on eth5
igb 0000:02:00.0: Intel(R) Gigabit Ethernet Network Connection
igb 0000:02:00.0: eth5: (PCIe:5.0Gb/s:Width x1) 00:30:18:a6:6c:6a
igb 0000:02:00.0: eth5: PBA No: FFFFFF-0FF
igb 0000:02:00.0: Using MSI interrupts. 1 rx queue(s), 1 tx queue(s)
PCI: enabling device 0000:02:00.1 (0140 -> 0142)
igb 0000:02:00.1: added PHC on eth6
igb 0000:02:00.1: Intel(R) Gigabit Ethernet Network Connection
igb 0000:02:00.1: eth6: (PCIe:5.0Gb/s:Width x1) 00:30:18:a6:6c:6b
igb 0000:02:00.1: eth6: PBA No: FFFFFF-0FF
igb 0000:02:00.1: Using MSI interrupts. 1 rx queue(s), 1 tx queue(s)
myri10ge: Version 1.5.3-1.534
PCI: enabling device 0000:00:0a.0 (0140 -> 0143)
myri10ge 0000:03:00.0: invalid sram_size -1B or board span 16777216B
root@xpgp:~# 

root@xpgp:~# lspci -v -s 01:00 | egrep -i '^0| at '
01:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5721 Gigabit Ethernet PCI Express (rev 01)
        Memory at e1800000 (64-bit, non-prefetchable) [size=64K]
        Expansion ROM at e1810000 [disabled] [size=64K]

root@xpgp:~# lspci -v -s 02:00 | egrep -i '^0| at '
02:00.0 Ethernet controller: Intel Corporation Device 1521 (rev 01)
        Memory at e1a00000 (32-bit, non-prefetchable) [size=512K]
        I/O ports at 10000 [disabled] [size=32]
        Memory at e1c00000 (32-bit, non-prefetchable) [size=16K]
        [virtual] Expansion ROM at e1a80000 [disabled] [size=512K]
02:00.1 Ethernet controller: Intel Corporation Device 1521 (rev 01)
        Memory at e1b00000 (32-bit, non-prefetchable) [size=512K]
        I/O ports at 10020 [disabled] [size=32]
        Memory at e1c04000 (32-bit, non-prefetchable) [size=16K]
        [virtual] Expansion ROM at e1b80000 [disabled] [size=512K]

root@xpgp:~# lspci -v -s 03:00 | egrep -i '^0| at '
03:00.0 Ethernet controller: MYRICOM Inc. Myri-10G Dual-Protocol NIC
        Memory at e0000000 (64-bit, prefetchable) [size=16M]
        Memory at e1000000 (64-bit, non-prefetchable) [size=1M]
        [virtual] Expansion ROM at e1100000 [disabled] [size=512K]
root@xpgp:~# 

root@xpgp:~# grep -v disabled /sys/kernel/debug/mvebu-mbus/devices
[00] 00000000e8010000 - 00000000e8020000 : 0004:00f0 (remap 0000000000010000)
[08] 00000000fff00000 - 0000000100000000 : 0001:001d
[09] 00000000f0000000 - 00000000f1000000 : 0001:002f
[10] 00000000e1800000 - 00000000e1900000 : 0004:00e8
[11] 00000000e1a00000 - 00000000e1c00000 : 0004:00f8
[12] 00000000e1c00000 - 00000000e1d00000 : 0004:00f8
[13] 00000000e0000000 - 00000000e1000000 : 0008:00f8
[14] 00000000e1000000 - 00000000e1800000 : 0008:00f8

At least nothing seems wrong anywhere, so for now we should probably
ignore it, unless someone has a good idea about something to look at.

Now I'm using a Realtek instead of TG3, so I have this :

root@xpgp:~# lspci -v -s 01:00 | egrep -i '^0| at '
01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 02)
        I/O ports at 10000 [disabled] [size=256]
        Memory at e1820000 (64-bit, non-prefetchable) [size=4K]
        Memory at e1800000 (64-bit, prefetchable) [size=64K]
        Expansion ROM at e1810000 [size=64K]

root@xpgp:~# lspci -v -s 02:00 | egrep -i '^0| at '
02:00.0 Ethernet controller: Intel Corporation Device 1521 (rev 01)
        Memory at e1a00000 (32-bit, non-prefetchable) [disabled] [size=512K]
        I/O ports at 20000 [disabled] [size=32]
        Memory at e1c00000 (32-bit, non-prefetchable) [disabled] [size=16K]
        [virtual] Expansion ROM at e1a80000 [disabled] [size=512K]
02:00.1 Ethernet controller: Intel Corporation Device 1521 (rev 01)
        Memory at e1b00000 (32-bit, non-prefetchable) [disabled] [size=512K]
        I/O ports at 20020 [disabled] [size=32]
        Memory at e1c04000 (32-bit, non-prefetchable) [disabled] [size=16K]
        [virtual] Expansion ROM at e1b80000 [disabled] [size=512K]

root@xpgp:~# lspci -v -s 03:00 | egrep -i '^0| at '
03:00.0 Ethernet controller: MYRICOM Inc. Myri-10G Dual-Protocol NIC
        Memory at e0000000 (64-bit, prefetchable) [size=16M]
        Memory at e1000000 (64-bit, non-prefetchable) [size=1M]
        [virtual] Expansion ROM at e1100000 [disabled] [size=512K]

I get similar results :

root@xpgp:~# dmesg
r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
PCI: enabling device 0000:00:01.0 (0140 -> 0143)
PCI: enabling device 0000:01:00.0 (0146 -> 0147)
r8169 0000:01:00.0 eth4: RTL8168c/8111c at 0xf0346000, 00:e0:4c:81:20:79, XID 1c4000c0 IRQ 119
r8169 0000:01:00.0 eth4: jumbo features [frames: 6128 bytes, tx checksumming: ko]
igb: Intel(R) Gigabit Ethernet Network Driver - version 5.0.5-k
igb: Copyright (c) 2007-2013 Intel Corporation.
PCI: enabling device 0000:00:09.0 (0140 -> 0143)
PCI: enabling device 0000:02:00.0 (0140 -> 0142)
igb 0000:02:00.0: added PHC on eth5
igb 0000:02:00.0: Intel(R) Gigabit Ethernet Network Connection
igb 0000:02:00.0: eth5: (PCIe:5.0Gb/s:Width x1) 00:30:18:a6:6c:6a
igb 0000:02:00.0: eth5: PBA No: FFFFFF-0FF
igb 0000:02:00.0: Using MSI interrupts. 1 rx queue(s), 1 tx queue(s)
PCI: enabling device 0000:02:00.1 (0140 -> 0142)
igb 0000:02:00.1: added PHC on eth6
igb 0000:02:00.1: Intel(R) Gigabit Ethernet Network Connection
igb 0000:02:00.1: eth6: (PCIe:5.0Gb/s:Width x1) 00:30:18:a6:6c:6b
igb 0000:02:00.1: eth6: PBA No: FFFFFF-0FF
igb 0000:02:00.1: Using MSI interrupts. 1 rx queue(s), 1 tx queue(s)
myri10ge: Version 1.5.3-1.534
PCI: enabling device 0000:00:0a.0 (0140 -> 0143)
myri10ge 0000:03:00.0: invalid sram_size -1B or board span 16777216B

root@xpgp:~# grep -v disabled /sys/kernel/debug/mvebu-mbus/devices
[00] 00000000e8010000 - 00000000e8020000 : 0004:00e0 (remap 0000000000010000)
[01] 00000000e8020000 - 00000000e8030000 : 0004:00f0 (remap 0000000000020000)
[08] 00000000fff00000 - 0000000100000000 : 0001:001d
[09] 00000000f0000000 - 00000000f1000000 : 0001:002f
[10] 00000000e1800000 - 00000000e1900000 : 0004:00e8
[11] 00000000e1a00000 - 00000000e1c00000 : 0004:00f8
[12] 00000000e1c00000 - 00000000e1d00000 : 0004:00f8
[13] 00000000e0000000 - 00000000e1000000 : 0008:00f8
[14] 00000000e1000000 - 00000000e1800000 : 0008:00f8
root@xpgp:~# 

Ah, interestingly if I load the NICs in the opposite order, they all load
properly (myri10ge, igb, r8169) :

root@xpgp:~# dmesg
myri10ge: Version 1.5.3-1.534
PCI: enabling device 0000:00:0a.0 (0140 -> 0143)
myri10ge 0000:03:00.0: PCIE x4 Link
myri10ge 0000:03:00.0: Direct firmware load failed with error -2
myri10ge 0000:03:00.0: Falling back to user helper
myri10ge 0000:03:00.0: Unable to load myri10ge_eth_z8e.dat firmware image via hotplug
myri10ge 0000:03:00.0: hotplug firmware loading failed
myri10ge 0000:03:00.0: Successfully adopted running firmware
myri10ge 0000:03:00.0: Using firmware currently running on NIC.  For optimal
myri10ge 0000:03:00.0: performance consider loading optimized firmware
myri10ge 0000:03:00.0: via hotplug
myri10ge 0000:03:00.0: MSI IRQ 114, tx bndry 2048, fw adopted, WC Disabled
igb: Intel(R) Gigabit Ethernet Network Driver - version 5.0.5-k
igb: Copyright (c) 2007-2013 Intel Corporation.
PCI: enabling device 0000:00:09.0 (0140 -> 0143)
PCI: enabling device 0000:02:00.0 (0140 -> 0142)
igb 0000:02:00.0: added PHC on eth5
igb 0000:02:00.0: Intel(R) Gigabit Ethernet Network Connection
igb 0000:02:00.0: eth5: (PCIe:5.0Gb/s:Width x1) 00:30:18:a6:6c:6a
igb 0000:02:00.0: eth5: PBA No: FFFFFF-0FF
igb 0000:02:00.0: Using MSI interrupts. 1 rx queue(s), 1 tx queue(s)
PCI: enabling device 0000:02:00.1 (0140 -> 0142)
igb 0000:02:00.1: added PHC on eth6
igb 0000:02:00.1: Intel(R) Gigabit Ethernet Network Connection
igb 0000:02:00.1: eth6: (PCIe:5.0Gb/s:Width x1) 00:30:18:a6:6c:6b
igb 0000:02:00.1: eth6: PBA No: FFFFFF-0FF
igb 0000:02:00.1: Using MSI interrupts. 1 rx queue(s), 1 tx queue(s)
r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
PCI: enabling device 0000:00:01.0 (0140 -> 0143)
PCI: enabling device 0000:01:00.0 (0146 -> 0147)
r8169 0000:01:00.0 eth7: RTL8168c/8111c at 0xf037e000, 00:e0:4c:81:20:79, XID 1c4000c0 IRQ 121
r8169 0000:01:00.0 eth7: jumbo features [frames: 6128 bytes, tx checksumming: ko]

root@xpgp:~# grep -v disabled /sys/kernel/debug/mvebu-mbus/devices
[00] 00000000e8020000 - 00000000e8030000 : 0004:00f0 (remap 0000000000020000)
[01] 00000000e8010000 - 00000000e8020000 : 0004:00e0 (remap 0000000000010000)
[08] 00000000fff00000 - 0000000100000000 : 0001:001d
[09] 00000000f0000000 - 00000000f1000000 : 0001:002f
[10] 00000000e0000000 - 00000000e1000000 : 0008:00f8
[11] 00000000e1000000 - 00000000e1800000 : 0008:00f8
[12] 00000000e1a00000 - 00000000e1c00000 : 0004:00f8
[13] 00000000e1c00000 - 00000000e1d00000 : 0004:00f8
[14] 00000000e1800000 - 00000000e1900000 : 0004:00e8

On the Mirabox, I don't see the igb NIC on lspci, but it's late and
I start to think slowly so I'll have to dig this out tomorrow. Hmmm
I'm seeing it after a rescan, it looks like the same issue that Neil
initially reported about the link up delay.

All the devices are detected now (including the USB3 controller) :

root@mirabox:~# lspci -v  | egrep -i '^0| at '
00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01) (prog-if 00 [Normal decode])
00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01) (prog-if 00 [Normal decode])
01:00.0 Ethernet controller: Intel Corporation Device 1521 (rev 01)
        Memory at e0200000 (32-bit, non-prefetchable) [size=512K]
        I/O ports at 10000 [disabled] [size=32]
        Memory at e0400000 (32-bit, non-prefetchable) [size=16K]
        [virtual] Expansion ROM at e0280000 [disabled] [size=512K]
01:00.1 Ethernet controller: Intel Corporation Device 1521 (rev 01)
        Memory at e0300000 (32-bit, non-prefetchable) [size=512K]
        I/O ports at 10020 [disabled] [size=32]
        Memory at e0404000 (32-bit, non-prefetchable) [size=16K]
        [virtual] Expansion ROM at e0380000 [disabled] [size=512K]
02:00.0 USB Controller: Device 1b73:1009 (rev 02) (prog-if 30)
        Memory at e0000000 (64-bit, non-prefetchable) [size=64K]
        Memory at e0010000 (64-bit, non-prefetchable) [size=4K]
        Memory at e0011000 (64-bit, non-prefetchable) [size=4K]

The nic properly loads :

root@mirabox:~# dmesg
igb: Intel(R) Gigabit Ethernet Network Driver - version 5.0.5-k
igb: Copyright (c) 2007-2013 Intel Corporation.
PCI: enabling device 0000:00:01.0 (0140 -> 0143)
PCI: enabling device 0000:01:00.0 (0000 -> 0002)
igb 0000:01:00.0: added PHC on eth2
igb 0000:01:00.0: Intel(R) Gigabit Ethernet Network Connection
igb 0000:01:00.0: eth2: (PCIe:2.5Gb/s:Width x1) 00:30:18:a6:6c:6a
igb 0000:01:00.0: eth2: PBA No: FFFFFF-0FF
igb 0000:01:00.0: Using MSI interrupts. 1 rx queue(s), 1 tx queue(s)
PCI: enabling device 0000:01:00.1 (0000 -> 0002)
igb 0000:01:00.1: added PHC on eth3
igb 0000:01:00.1: Intel(R) Gigabit Ethernet Network Connection
igb 0000:01:00.1: eth3: (PCIe:2.5Gb/s:Width x1) 00:30:18:a6:6c:6b
igb 0000:01:00.1: eth3: PBA No: FFFFFF-0FF
igb 0000:01:00.1: Using MSI interrupts. 1 rx queue(s), 1 tx queue(s)
root@mirabox:~# 

And the mbus windows match expectations :

root@mirabox:~# grep -v disabled /sys/kernel/debug/mvebu-mbus/devices
[00] 00000000e8010000 - 00000000e8020000 : 0004:00e0 (remap 0000000000010000)
[08] 00000000fff00000 - 0000000100000000 : 0001:00e0
[09] 00000000e0000000 - 00000000e0100000 : 0008:00e8
[10] 00000000e0200000 - 00000000e0400000 : 0004:00e8
[11] 00000000e0400000 - 00000000e0500000 : 0004:00e8

So overall, it's a big Ack from my side considering the huge improvements,
let's retry tomorrow with the link up workaround/fix to see if the detection
issue is related. Great work!

Best regards,
Willy

