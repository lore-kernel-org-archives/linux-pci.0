Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:41677 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809Ab3EEALL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 4 May 2013 20:11:11 -0400
Message-ID: <1367712653.11982.19.camel@pasglop>
Subject: Resource assignment oddities
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Yinghai Lu <yinghai@kernel.org>
Date: Sun, 05 May 2013 10:10:53 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Once upon a time, our PCI resource assignment code use to be reasonably
straightforward... right now I'm having a hard time making any sense
of it.

Anyway, here's a machine where some oddities happen (see the log below).

Some memory resources fail to be assigned and I'm not entirely sure why,
though it *could* just be resource exhaustion, I'm not 100% sure. I'll
spend time in the next days or so trying to figure out what exactly
is going on in the kernel but I though maybe somebody here more familiar
with the code can spot it faster.

The "special" things about this machine are:

 - We have a custom pcibios_window_alignment which for most part will
return a minimum alignment of bridge windows of 0x800000 (8MB) to deal
with our address space segmentation (for our EEH/error isolation).

 - We have no IO space on that controller

 - Bus numbers have been assigned by the FW but BARs have been left
alone (and bridge windows are all closed)

 - There is a single 2GB MMIO region coming off the PHB (no "prefetchable")
space at this point, which is at high addresses in CPU space but corresponds
to 2G..4G in PCI space. It's located at offset 2G within an aligned 4G window
in the CPU space which means that the conversion is trivial: just chop the top
32-bit off and you get the PCI address.

Any help welcome, this is 3.9-rc8 based. I'll try to dig myself a bit more
during the next few days.

Log below...

Ben.

PCI: Probing PCI hardware
PCI: I/O resource not set for host bridge /pciex@3fffe40000000 (domain 0)
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [mem 0x3d00080000000-0x3d000fffeffff] (bus address [0x80000000-0xfffeffff])
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to ff
pci 0000:00:00.0: [1014:03dc] type 01 class 0x060400
pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
pci 0000:01:00.0: [1014:0339] type 00 class 0x010400
pci 0000:01:00.0: reg 10: [mem 0x00000000-0x0003ffff 64bit]
pci 0000:01:00.0: reg 18: [mem 0x00000000-0x00ffffff 64bit pref]
pci 0000:01:00.0: reg 30: [mem 0x00000000-0x0001ffff pref]
pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
pci 0000:00:00.0: PCI bridge to [bus 01]
pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 01
PCI: I/O resource not set for host bridge /pciex@3fffe40100000 (domain 1)
PCI host bridge to bus 0001:00
pci_bus 0001:00: root bus resource [mem 0x3d01080000000-0x3d010fffeffff] (bus address [0x80000000-0xfffeffff])
pci_bus 0001:00: root bus resource [bus 00-ff]
pci_bus 0001:00: busn_res: [bus 00-ff] end is updated to ff
pci 0001:00:00.0: [1014:03dc] type 01 class 0x060400
pci 0001:00:00.0: PME# supported from D0 D3hot D3cold
pci 0001:01:00.0: [10b5:8732] type 01 class 0x060400
pci 0001:01:00.0: reg 10: [mem 0x00000000-0x0003ffff]
pci 0001:01:00.0: PME# supported from D0 D3hot D3cold
pci 0001:00:00.0: PCI bridge to [bus 01-0d]
pci 0001:02:01.0: [10b5:8732] type 01 class 0x060400
pci 0001:02:01.0: PME# supported from D0 D3hot D3cold
pci 0001:02:08.0: [10b5:8732] type 01 class 0x060400
pci 0001:02:08.0: PME# supported from D0 D3hot D3cold
pci 0001:02:09.0: [10b5:8732] type 01 class 0x060400
pci 0001:02:09.0: PME# supported from D0 D3hot D3cold
pci 0001:01:00.0: PCI bridge to [bus 02-0d]
pci 0001:02:01.0: PCI bridge to [bus 03-07]
pci 0001:08:00.0: [1014:034a] type 00 class 0x010400
pci 0001:08:00.0: reg 10: [mem 0x00000000-0x0000ffff 64bit]
pci 0001:08:00.0: reg 18: [mem 0x00000000-0x0000ffff 64bit]
pci 0001:08:00.0: reg 30: [mem 0x00000000-0x0001ffff pref]
pci 0001:08:00.0: PME# supported from D0 D3hot D3cold
pci 0001:02:08.0: PCI bridge to [bus 08]
pci 0001:02:09.0: PCI bridge to [bus 09-0d]
pci_bus 0001:00: busn_res: [bus 00-ff] end is updated to 0d
PCI: I/O resource not set for host bridge /pciex@3fffe40400000 (domain 2)
PCI host bridge to bus 0002:00
pci_bus 0002:00: root bus resource [mem 0x3d04080000000-0x3d040fffeffff] (bus address [0x80000000-0xfffeffff])
pci_bus 0002:00: root bus resource [bus 00-ff]
pci_bus 0002:00: busn_res: [bus 00-ff] end is updated to ff
pci 0002:00:00.0: [1014:03dc] type 01 class 0x060400
pci 0002:00:00.0: PME# supported from D0 D3hot D3cold
pci 0002:00:00.0: PCI bridge to [bus 01-05]
pci_bus 0002:00: busn_res: [bus 00-ff] end is updated to 05
PCI: I/O resource not set for host bridge /pciex@3fffe40500000 (domain 3)
PCI host bridge to bus 0003:00
pci_bus 0003:00: root bus resource [mem 0x3d05080000000-0x3d050fffeffff] (bus address [0x80000000-0xfffeffff])
pci_bus 0003:00: root bus resource [bus 00-ff]
pci_bus 0003:00: busn_res: [bus 00-ff] end is updated to ff
pci 0003:00:00.0: [1014:03dc] type 01 class 0x060400
pci 0003:00:00.0: PME# supported from D0 D3hot D3cold
pci 0003:01:00.0: [10b5:8748] type 01 class 0x060400
pci 0003:01:00.0: reg 10: [mem 0x00000000-0x0003ffff]
pci 0003:01:00.0: PME# supported from D0 D3hot D3cold
pci 0003:00:00.0: PCI bridge to [bus 01-13]
pci 0003:02:01.0: [10b5:8748] type 01 class 0x060400
pci 0003:02:01.0: PME# supported from D0 D3hot D3cold
pci 0003:02:08.0: [10b5:8748] type 01 class 0x060400
pci 0003:02:08.0: PME# supported from D0 D3hot D3cold
pci 0003:02:09.0: [10b5:8748] type 01 class 0x060400
pci 0003:02:09.0: PME# supported from D0 D3hot D3cold
pci 0003:02:10.0: [10b5:8748] type 01 class 0x060400
pci 0003:02:10.0: PME# supported from D0 D3hot D3cold
pci 0003:02:11.0: [10b5:8748] type 01 class 0x060400
pci 0003:02:11.0: PME# supported from D0 D3hot D3cold
pci 0003:01:00.0: PCI bridge to [bus 02-13]
pci 0003:03:00.0: [104c:8241] type 00 class 0x0c0330
pci 0003:03:00.0: reg 10: [mem 0x00000000-0x0000ffff 64bit]
pci 0003:03:00.0: reg 18: [mem 0x00000000-0x00001fff 64bit]
pci 0003:03:00.0: supports D1 D2
pci 0003:03:00.0: PME# supported from D0 D1 D2 D3hot
pci 0003:02:01.0: PCI bridge to [bus 03]
pci 0003:02:08.0: PCI bridge to [bus 04-08]
pci 0003:09:00.0: [14e4:1657] type 00 class 0x020000
pci 0003:09:00.0: reg 10: [mem 0x00000000-0x0000ffff 64bit pref]
pci 0003:09:00.0: reg 18: [mem 0x00000000-0x0000ffff 64bit pref]
pci 0003:09:00.0: reg 20: [mem 0x00000000-0x0000ffff 64bit pref]
pci 0003:09:00.0: reg 30: [mem 0x00000000-0x0007ffff pref]
pci 0003:09:00.0: PME# supported from D0 D3hot D3cold
pci 0003:09:00.1: [14e4:1657] type 00 class 0x020000
pci 0003:09:00.1: reg 10: [mem 0x00000000-0x0000ffff 64bit pref]
pci 0003:09:00.1: reg 18: [mem 0x00000000-0x0000ffff 64bit pref]
pci 0003:09:00.1: reg 20: [mem 0x00000000-0x0000ffff 64bit pref]
pci 0003:09:00.1: reg 30: [mem 0x00000000-0x0007ffff pref]
pci 0003:09:00.1: PME# supported from D0 D3hot D3cold
pci 0003:09:00.2: [14e4:1657] type 00 class 0x020000
pci 0003:09:00.2: reg 10: [mem 0x00000000-0x0000ffff 64bit pref]
pci 0003:09:00.2: reg 18: [mem 0x00000000-0x0000ffff 64bit pref]
pci 0003:09:00.2: reg 20: [mem 0x00000000-0x0000ffff 64bit pref]
pci 0003:09:00.2: reg 30: [mem 0x00000000-0x0007ffff pref]
pci 0003:09:00.2: PME# supported from D0 D3hot D3cold
pci 0003:09:00.3: [14e4:1657] type 00 class 0x020000
pci 0003:09:00.3: reg 10: [mem 0x00000000-0x0000ffff 64bit pref]
pci 0003:09:00.3: reg 18: [mem 0x00000000-0x0000ffff 64bit pref]
pci 0003:09:00.3: reg 20: [mem 0x00000000-0x0000ffff 64bit pref]
pci 0003:09:00.3: reg 30: [mem 0x00000000-0x0007ffff pref]
pci 0003:09:00.3: PME# supported from D0 D3hot D3cold
pci 0003:02:09.0: PCI bridge to [bus 09]
pci 0003:02:10.0: PCI bridge to [bus 0a-0e]
pci 0003:02:11.0: PCI bridge to [bus 0f-13]
pci_bus 0003:00: busn_res: [bus 00-ff] end is updated to 13
pci 0001:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 03-07] add_size 1000
pci 0001:02:01.0: bridge window [mem 0x00800000-0x007fffff 64bit pref] to [bus 03-07] add_size 800000
pci 0001:02:01.0: bridge window [mem 0x00800000-0x007fffff] to [bus 03-07] add_size 800000
pci 0001:02:08.0: bridge window [io  0x1000-0x0fff] to [bus 08] add_size 1000
pci 0001:02:09.0: bridge window [io  0x1000-0x0fff] to [bus 09-0d] add_size 1000
pci 0001:02:09.0: bridge window [mem 0x00800000-0x007fffff 64bit pref] to [bus 09-0d] add_size 800000
pci 0001:02:09.0: bridge window [mem 0x00800000-0x007fffff] to [bus 09-0d] add_size 800000
pci 0001:02:01.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
pci 0001:02:08.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
pci 0001:02:09.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
pci 0001:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-0d] add_size 3000
pci 0001:02:01.0: res[9]=[mem 0x00800000-0x007fffff 64bit pref] get_res_add_size add_size 800000
pci 0001:02:09.0: res[9]=[mem 0x00800000-0x007fffff 64bit pref] get_res_add_size add_size 800000
pci 0001:01:00.0: bridge window [mem 0x00800000-0x00ffffff pref] to [bus 02-0d] add_size 1000000
pci 0001:02:01.0: res[8]=[mem 0x00800000-0x007fffff] get_res_add_size add_size 800000
pci 0001:02:09.0: res[8]=[mem 0x00800000-0x007fffff] get_res_add_size add_size 800000
pci 0001:01:00.0: bridge window [mem 0x00800000-0x00ffffff] to [bus 02-0d] add_size 1000000
pci 0001:01:00.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 3000
pci 0001:00:00.0: bridge window [io  0x1000-0x0fff] to [bus 01-0d] add_size 3000
pci 0001:01:00.0: res[9]=[mem 0x00800000-0x00ffffff pref] get_res_add_size add_size 1000000
pci 0001:00:00.0: bridge window [mem 0x00800000-0x00ffffff pref] to [bus 01-0d] add_size 1000000
pci 0001:01:00.0: res[8]=[mem 0x00800000-0x00ffffff] get_res_add_size add_size 1000000
pci 0001:00:00.0: bridge window [mem 0x00800000-0x017fffff] to [bus 01-0d] add_size 1000000
pci 0003:02:08.0: bridge window [io  0x1000-0x0fff] to [bus 04-08] add_size 1000
pci 0003:02:08.0: bridge window [mem 0x00800000-0x007fffff 64bit pref] to [bus 04-08] add_size 800000
pci 0003:02:08.0: bridge window [mem 0x00800000-0x007fffff] to [bus 04-08] add_size 800000
pci 0003:02:09.0: bridge window [io  0x1000-0x0fff] to [bus 09] add_size 1000
pci 0003:02:09.0: bridge window [mem 0x00800000-0x007fffff] to [bus 09] add_size 800000
pci 0003:02:10.0: bridge window [io  0x1000-0x0fff] to [bus 0a-0e] add_size 1000
pci 0003:02:10.0: bridge window [mem 0x00800000-0x007fffff 64bit pref] to [bus 0a-0e] add_size 800000
pci 0003:02:10.0: bridge window [mem 0x00800000-0x007fffff] to [bus 0a-0e] add_size 800000
pci 0003:02:11.0: bridge window [io  0x1000-0x0fff] to [bus 0f-13] add_size 1000
pci 0003:02:11.0: bridge window [mem 0x00800000-0x007fffff 64bit pref] to [bus 0f-13] add_size 800000
pci 0003:02:11.0: bridge window [mem 0x00800000-0x007fffff] to [bus 0f-13] add_size 800000
pci 0003:02:08.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
pci 0003:02:09.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
pci 0003:02:10.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
pci 0003:02:11.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
pci 0003:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-13] add_size 4000
pci 0003:02:08.0: res[9]=[mem 0x00800000-0x007fffff 64bit pref] get_res_add_size add_size 800000
pci 0003:02:10.0: res[9]=[mem 0x00800000-0x007fffff 64bit pref] get_res_add_size add_size 800000
pci 0003:02:11.0: res[9]=[mem 0x00800000-0x007fffff 64bit pref] get_res_add_size add_size 800000
pci 0003:01:00.0: bridge window [mem 0x00800000-0x00ffffff pref] to [bus 02-13] add_size 1800000
pci 0003:02:08.0: res[8]=[mem 0x00800000-0x007fffff] get_res_add_size add_size 800000
pci 0003:02:09.0: res[8]=[mem 0x00800000-0x007fffff] get_res_add_size add_size 800000
pci 0003:02:10.0: res[8]=[mem 0x00800000-0x007fffff] get_res_add_size add_size 800000
pci 0003:02:11.0: res[8]=[mem 0x00800000-0x007fffff] get_res_add_size add_size 800000
pci 0003:01:00.0: bridge window [mem 0x00800000-0x00ffffff] to [bus 02-13] add_size 2000000
pci 0003:01:00.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 4000
pci 0003:00:00.0: bridge window [io  0x1000-0x0fff] to [bus 01-13] add_size 4000
pci 0003:01:00.0: res[9]=[mem 0x00800000-0x00ffffff pref] get_res_add_size add_size 1800000
pci 0003:00:00.0: bridge window [mem 0x00800000-0x00ffffff pref] to [bus 01-13] add_size 1800000
pci 0003:01:00.0: res[8]=[mem 0x00800000-0x00ffffff] get_res_add_size add_size 2000000
pci 0003:00:00.0: bridge window [mem 0x00800000-0x017fffff] to [bus 01-13] add_size 2000000
pci 0000:00:00.0: BAR 8: assigned [mem 0x3d00080000000-0x3d000807fffff]
pci 0000:00:00.0: BAR 9: assigned [mem 0x3d00080800000-0x3d00081ffffff pref]
pci 0000:01:00.0: BAR 2: assigned [mem 0x3d00081000000-0x3d00081ffffff 64bit pref]
pci 0000:01:00.0: BAR 0: assigned [mem 0x3d00080000000-0x3d0008003ffff 64bit]
pci 0000:01:00.0: BAR 6: assigned [mem 0x3d00080800000-0x3d0008081ffff pref]
pci 0000:00:00.0: PCI bridge to [bus 01]
pci 0000:00:00.0:   bridge window [mem 0x3d00080000000-0x3d000807fffff]
pci 0000:00:00.0:   bridge window [mem 0x3d00080800000-0x3d00081ffffff pref]
pci 0001:00:00.0: res[8]=[mem 0x00800000-0x017fffff] get_res_add_size add_size 1000000
pci 0001:00:00.0: res[9]=[mem 0x00800000-0x00ffffff pref] get_res_add_size add_size 1000000
pci 0001:00:00.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 3000
pci 0001:00:00.0: BAR 8: assigned [mem 0x3d01080000000-0x3d01081ffffff]
pci 0001:00:00.0: BAR 9: assigned [mem 0x3d01082000000-0x3d010837fffff pref]
pci 0001:00:00.0: BAR 7: can't assign io (size 0x3000)
pci 0001:00:00.0: BAR 8: assigned [mem 0x3d01080000000-0x3d01080ffffff]
pci 0001:00:00.0: BAR 9: assigned [mem 0x3d01081000000-0x3d010817fffff pref]
pci 0001:00:00.0: BAR 8: reassigned [mem 0x3d01081800000-0x3d010837fffff]
pci 0001:00:00.0: BAR 9: reassigned [mem 0x3d01080000000-0x3d010817fffff pref]
pci 0001:00:00.0: BAR 7: can't assign io (size 0x3000)
pci 0001:01:00.0: res[8]=[mem 0x00800000-0x00ffffff] get_res_add_size add_size 1000000
pci 0001:01:00.0: res[9]=[mem 0x00800000-0x00ffffff pref] get_res_add_size add_size 1000000
pci 0001:01:00.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 3000
pci 0001:01:00.0: BAR 8: assigned [mem 0x3d01081800000-0x3d01082ffffff]
pci 0001:01:00.0: BAR 9: assigned [mem 0x3d01080000000-0x3d010817fffff pref]
pci 0001:01:00.0: BAR 0: assigned [mem 0x3d01083000000-0x3d0108303ffff]
pci 0001:01:00.0: BAR 7: can't assign io (size 0x3000)
pci 0001:01:00.0: BAR 8: assigned [mem 0x3d01081800000-0x3d01081ffffff]
pci 0001:01:00.0: BAR 9: assigned [mem 0x3d01080000000-0x3d010807fffff pref]
pci 0001:01:00.0: BAR 0: assigned [mem 0x3d01082000000-0x3d0108203ffff]
pci 0001:01:00.0: BAR 8: can't assign mem (size 0x800000)
pci 0001:01:00.0: failed to add 1000000 res[8]=[mem 0x3d01081800000-0x3d01081ffffff]
pci 0001:01:00.0: BAR 9: reassigned [mem 0x3d01080000000-0x3d010817fffff pref]
pci 0001:01:00.0: BAR 7: can't assign io (size 0x3000)
pci 0001:02:01.0: res[8]=[mem 0x00800000-0x007fffff] get_res_add_size add_size 800000
pci 0001:02:01.0: res[9]=[mem 0x00800000-0x007fffff 64bit pref] get_res_add_size add_size 800000
pci 0001:02:09.0: res[8]=[mem 0x00800000-0x007fffff] get_res_add_size add_size 800000
pci 0001:02:09.0: res[9]=[mem 0x00800000-0x007fffff 64bit pref] get_res_add_size add_size 800000
pci 0001:02:01.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
pci 0001:02:08.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
pci 0001:02:09.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
pci 0001:02:01.0: BAR 8: assigned [mem 0x3d01081800000-0x3d01081ffffff]
pci 0001:02:01.0: BAR 9: assigned [mem 0x3d01080000000-0x3d010807fffff 64bit pref]
pci 0001:02:08.0: BAR 8: can't assign mem (size 0x800000)
pci 0001:02:08.0: BAR 9: assigned [mem 0x3d01080800000-0x3d01080ffffff pref]
pci 0001:02:09.0: BAR 8: can't assign mem (size 0x800000)
pci 0001:02:09.0: BAR 9: assigned [mem 0x3d01081000000-0x3d010817fffff 64bit pref]
pci 0001:02:01.0: BAR 7: can't assign io (size 0x1000)
pci 0001:02:08.0: BAR 7: can't assign io (size 0x1000)
pci 0001:02:09.0: BAR 7: can't assign io (size 0x1000)
pci 0001:02:08.0: BAR 8: assigned [mem 0x3d01081800000-0x3d01081ffffff]
pci 0001:02:08.0: BAR 9: assigned [mem 0x3d01080000000-0x3d010807fffff pref]
pci 0001:02:09.0: BAR 8: can't assign mem (size 0x800000)
pci 0001:02:09.0: BAR 9: assigned [mem 0x3d01080800000-0x3d01080ffffff 64bit pref]
pci 0001:02:09.0: BAR 7: can't assign io (size 0x1000)
pci 0001:02:08.0: BAR 7: can't assign io (size 0x1000)
pci 0001:02:01.0: BAR 8: can't assign mem (size 0x800000)
pci 0001:02:01.0: BAR 9: assigned [mem 0x3d01081000000-0x3d010817fffff 64bit pref]
pci 0001:02:01.0: BAR 7: can't assign io (size 0x1000)
pci 0001:02:01.0: PCI bridge to [bus 03-07]
pci 0001:02:01.0:   bridge window [mem 0x3d01081000000-0x3d010817fffff 64bit pref]
pci 0001:08:00.0: BAR 6: assigned [mem 0x3d01080000000-0x3d0108001ffff pref]
pci 0001:08:00.0: BAR 0: assigned [mem 0x3d01081800000-0x3d0108180ffff 64bit]
pci 0001:08:00.0: BAR 2: assigned [mem 0x3d01081810000-0x3d0108181ffff 64bit]
pci 0001:02:08.0: PCI bridge to [bus 08]
pci 0001:02:08.0:   bridge window [mem 0x3d01081800000-0x3d01081ffffff]
pci 0001:02:08.0:   bridge window [mem 0x3d01080000000-0x3d010807fffff pref]
pci 0001:02:09.0: PCI bridge to [bus 09-0d]
pci 0001:02:09.0:   bridge window [mem 0x3d01080800000-0x3d01080ffffff 64bit pref]
pci 0001:01:00.0: PCI bridge to [bus 02-0d]
pci 0001:01:00.0:   bridge window [mem 0x3d01081800000-0x3d01081ffffff]
pci 0001:01:00.0:   bridge window [mem 0x3d01080000000-0x3d010817fffff pref]
pci 0001:00:00.0: PCI bridge to [bus 01-0d]
pci 0001:00:00.0:   bridge window [mem 0x3d01081800000-0x3d010837fffff]
pci 0001:00:00.0:   bridge window [mem 0x3d01080000000-0x3d010817fffff pref]
pci 0002:00:00.0: PCI bridge to [bus 01-05]
pci 0003:00:00.0: res[8]=[mem 0x00800000-0x017fffff] get_res_add_size add_size 2000000
pci 0003:00:00.0: res[9]=[mem 0x00800000-0x00ffffff pref] get_res_add_size add_size 1800000
pci 0003:00:00.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 4000
pci 0003:00:00.0: BAR 8: assigned [mem 0x3d05080000000-0x3d05082ffffff]
pci 0003:00:00.0: BAR 9: assigned [mem 0x3d05083000000-0x3d05084ffffff pref]
pci 0003:00:00.0: BAR 7: can't assign io (size 0x4000)
pci 0003:00:00.0: BAR 8: assigned [mem 0x3d05080000000-0x3d05080ffffff]
pci 0003:00:00.0: BAR 9: assigned [mem 0x3d05081000000-0x3d050817fffff pref]
pci 0003:00:00.0: BAR 8: reassigned [mem 0x3d05081800000-0x3d050847fffff]
pci 0003:00:00.0: BAR 9: reassigned [mem 0x3d05084800000-0x3d050867fffff pref]
pci 0003:00:00.0: BAR 7: can't assign io (size 0x4000)
pci 0003:01:00.0: res[8]=[mem 0x00800000-0x00ffffff] get_res_add_size add_size 2000000
pci 0003:01:00.0: res[9]=[mem 0x00800000-0x00ffffff pref] get_res_add_size add_size 1800000
pci 0003:01:00.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 4000
pci 0003:01:00.0: BAR 8: assigned [mem 0x3d05081800000-0x3d05083ffffff]
pci 0003:01:00.0: BAR 9: assigned [mem 0x3d05084800000-0x3d050867fffff pref]
pci 0003:01:00.0: BAR 0: assigned [mem 0x3d05084000000-0x3d0508403ffff]
pci 0003:01:00.0: BAR 7: can't assign io (size 0x4000)
pci 0003:01:00.0: BAR 8: assigned [mem 0x3d05081800000-0x3d05081ffffff]
pci 0003:01:00.0: BAR 9: assigned [mem 0x3d05084800000-0x3d05084ffffff pref]
pci 0003:01:00.0: BAR 0: assigned [mem 0x3d05082000000-0x3d0508203ffff]
pci 0003:01:00.0: BAR 8: can't assign mem (size 0x800000)
pci 0003:01:00.0: failed to add 2000000 res[8]=[mem 0x3d05081800000-0x3d05081ffffff]
pci 0003:01:00.0: BAR 9: reassigned [mem 0x3d05084800000-0x3d050867fffff pref]
pci 0003:01:00.0: BAR 7: can't assign io (size 0x4000)
pci 0003:02:08.0: res[8]=[mem 0x00800000-0x007fffff] get_res_add_size add_size 800000
pci 0003:02:08.0: res[9]=[mem 0x00800000-0x007fffff 64bit pref] get_res_add_size add_size 800000
pci 0003:02:09.0: res[8]=[mem 0x00800000-0x007fffff] get_res_add_size add_size 800000
pci 0003:02:10.0: res[8]=[mem 0x00800000-0x007fffff] get_res_add_size add_size 800000
pci 0003:02:10.0: res[9]=[mem 0x00800000-0x007fffff 64bit pref] get_res_add_size add_size 800000
pci 0003:02:11.0: res[8]=[mem 0x00800000-0x007fffff] get_res_add_size add_size 800000
pci 0003:02:11.0: res[9]=[mem 0x00800000-0x007fffff 64bit pref] get_res_add_size add_size 800000
pci 0003:02:08.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
pci 0003:02:09.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
pci 0003:02:10.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
pci 0003:02:11.0: res[7]=[io  0x1000-0x0fff] get_res_add_size add_size 1000
pci 0003:02:01.0: BAR 8: assigned [mem 0x3d05081800000-0x3d05081ffffff]
pci 0003:02:08.0: BAR 8: can't assign mem (size 0x800000)
pci 0003:02:08.0: BAR 9: assigned [mem 0x3d05084800000-0x3d05084ffffff 64bit pref]
pci 0003:02:09.0: BAR 8: can't assign mem (size 0x800000)
pci 0003:02:09.0: BAR 9: assigned [mem 0x3d05085000000-0x3d050857fffff pref]
pci 0003:02:10.0: BAR 8: can't assign mem (size 0x800000)
pci 0003:02:10.0: BAR 9: assigned [mem 0x3d05085800000-0x3d05085ffffff 64bit pref]
pci 0003:02:11.0: BAR 8: can't assign mem (size 0x800000)
pci 0003:02:11.0: BAR 9: assigned [mem 0x3d05086000000-0x3d050867fffff 64bit pref]
pci 0003:02:08.0: BAR 7: can't assign io (size 0x1000)
pci 0003:02:09.0: BAR 7: can't assign io (size 0x1000)
pci 0003:02:10.0: BAR 7: can't assign io (size 0x1000)
pci 0003:02:11.0: BAR 7: can't assign io (size 0x1000)
pci 0003:02:01.0: BAR 8: assigned [mem 0x3d05081800000-0x3d05081ffffff]
pci 0003:02:09.0: BAR 9: assigned [mem 0x3d05084800000-0x3d05084ffffff pref]
pci 0003:02:11.0: BAR 8: can't assign mem (size 0x800000)
pci 0003:02:11.0: BAR 9: assigned [mem 0x3d05085000000-0x3d050857fffff 64bit pref]
pci 0003:02:11.0: BAR 7: can't assign io (size 0x1000)
pci 0003:02:10.0: BAR 8: can't assign mem (size 0x800000)
pci 0003:02:10.0: BAR 9: assigned [mem 0x3d05085800000-0x3d05085ffffff 64bit pref]
pci 0003:02:10.0: BAR 7: can't assign io (size 0x1000)
pci 0003:02:09.0: BAR 8: can't assign mem (size 0x800000)
pci 0003:02:09.0: BAR 7: can't assign io (size 0x1000)
pci 0003:02:08.0: BAR 8: can't assign mem (size 0x800000)
pci 0003:02:08.0: BAR 9: assigned [mem 0x3d05086000000-0x3d050867fffff 64bit pref]
pci 0003:02:08.0: BAR 7: can't assign io (size 0x1000)
pci 0003:03:00.0: BAR 0: assigned [mem 0x3d05081800000-0x3d0508180ffff 64bit]
pci 0003:03:00.0: BAR 2: assigned [mem 0x3d05081810000-0x3d05081811fff 64bit]
pci 0003:02:01.0: PCI bridge to [bus 03]
pci 0003:02:01.0:   bridge window [mem 0x3d05081800000-0x3d05081ffffff]
pci 0003:02:08.0: PCI bridge to [bus 04-08]
pci 0003:02:08.0:   bridge window [mem 0x3d05086000000-0x3d050867fffff 64bit pref]
pci 0003:09:00.0: BAR 6: assigned [mem 0x3d05084800000-0x3d0508487ffff pref]
pci 0003:09:00.1: BAR 6: assigned [mem 0x3d05084880000-0x3d050848fffff pref]
pci 0003:09:00.2: BAR 6: assigned [mem 0x3d05084900000-0x3d0508497ffff pref]
pci 0003:09:00.3: BAR 6: assigned [mem 0x3d05084980000-0x3d050849fffff pref]
pci 0003:09:00.0: BAR 0: assigned [mem 0x3d05084a00000-0x3d05084a0ffff 64bit pref]
pci 0003:09:00.0: BAR 2: assigned [mem 0x3d05084a10000-0x3d05084a1ffff 64bit pref]
pci 0003:09:00.0: BAR 4: assigned [mem 0x3d05084a20000-0x3d05084a2ffff 64bit pref]
pci 0003:09:00.1: BAR 0: assigned [mem 0x3d05084a30000-0x3d05084a3ffff 64bit pref]
pci 0003:09:00.1: BAR 2: assigned [mem 0x3d05084a40000-0x3d05084a4ffff 64bit pref]
pci 0003:09:00.1: BAR 4: assigned [mem 0x3d05084a50000-0x3d05084a5ffff 64bit pref]
pci 0003:09:00.2: BAR 0: assigned [mem 0x3d05084a60000-0x3d05084a6ffff 64bit pref]
pci 0003:09:00.2: BAR 2: assigned [mem 0x3d05084a70000-0x3d05084a7ffff 64bit pref]
pci 0003:09:00.2: BAR 4: assigned [mem 0x3d05084a80000-0x3d05084a8ffff 64bit pref]
pci 0003:09:00.3: BAR 0: assigned [mem 0x3d05084a90000-0x3d05084a9ffff 64bit pref]
pci 0003:09:00.3: BAR 2: assigned [mem 0x3d05084aa0000-0x3d05084aaffff 64bit pref]
pci 0003:09:00.3: BAR 4: assigned [mem 0x3d05084ab0000-0x3d05084abffff 64bit pref]
pci 0003:02:09.0: PCI bridge to [bus 09]
pci 0003:02:09.0:   bridge window [mem 0x3d05084800000-0x3d05084ffffff pref]
pci 0003:02:10.0: PCI bridge to [bus 0a-0e]
pci 0003:02:10.0:   bridge window [mem 0x3d05085800000-0x3d05085ffffff 64bit pref]
pci 0003:02:11.0: PCI bridge to [bus 0f-13]
pci 0003:02:11.0:   bridge window [mem 0x3d05085000000-0x3d050857fffff 64bit pref]
pci 0003:01:00.0: PCI bridge to [bus 02-13]
pci 0003:01:00.0:   bridge window [mem 0x3d05081800000-0x3d05081ffffff]
pci 0003:01:00.0:   bridge window [mem 0x3d05084800000-0x3d050867fffff pref]
pci 0003:00:00.0: PCI bridge to [bus 01-13]
pci 0003:00:00.0:   bridge window [mem 0x3d05081800000-0x3d050847fffff]
pci 0003:00:00.0:   bridge window [mem 0x3d05084800000-0x3d050867fffff pref]
pci_bus 0000:00: resource 4 [mem 0x3d00080000000-0x3d000fffeffff]
pci_bus 0000:01: resource 1 [mem 0x3d00080000000-0x3d000807fffff]
pci_bus 0000:01: resource 2 [mem 0x3d00080800000-0x3d00081ffffff pref]
pci_bus 0001:00: resource 4 [mem 0x3d01080000000-0x3d010fffeffff]
pci_bus 0001:01: resource 1 [mem 0x3d01081800000-0x3d010837fffff]
pci_bus 0001:01: resource 2 [mem 0x3d01080000000-0x3d010817fffff pref]
pci_bus 0001:02: resource 1 [mem 0x3d01081800000-0x3d01081ffffff]
pci_bus 0001:02: resource 2 [mem 0x3d01080000000-0x3d010817fffff pref]
pci_bus 0001:03: resource 2 [mem 0x3d01081000000-0x3d010817fffff 64bit pref]
pci_bus 0001:08: resource 1 [mem 0x3d01081800000-0x3d01081ffffff]
pci_bus 0001:08: resource 2 [mem 0x3d01080000000-0x3d010807fffff pref]
pci_bus 0001:09: resource 2 [mem 0x3d01080800000-0x3d01080ffffff 64bit pref]
pci_bus 0002:00: resource 4 [mem 0x3d04080000000-0x3d040fffeffff]
pci_bus 0003:00: resource 4 [mem 0x3d05080000000-0x3d050fffeffff]
pci_bus 0003:01: resource 1 [mem 0x3d05081800000-0x3d050847fffff]
pci_bus 0003:01: resource 2 [mem 0x3d05084800000-0x3d050867fffff pref]
pci_bus 0003:02: resource 1 [mem 0x3d05081800000-0x3d05081ffffff]
pci_bus 0003:02: resource 2 [mem 0x3d05084800000-0x3d050867fffff pref]
pci_bus 0003:03: resource 1 [mem 0x3d05081800000-0x3d05081ffffff]
pci_bus 0003:04: resource 2 [mem 0x3d05086000000-0x3d050867fffff 64bit pref]
pci_bus 0003:09: resource 2 [mem 0x3d05084800000-0x3d05084ffffff pref]
pci_bus 0003:0a: resource 2 [mem 0x3d05085800000-0x3d05085ffffff 64bit pref]
pci_bus 0003:0f: resource 2 [mem 0x3d05085000000-0x3d050857fffff 64bit pref]


