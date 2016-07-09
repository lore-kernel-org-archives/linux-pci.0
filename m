Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([80.244.247.6]:36320 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756620AbcGITQG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 9 Jul 2016 15:16:06 -0400
Date: Sat, 9 Jul 2016 21:16:00 +0200
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: linux-pci@vger.kernel.org, vfio-users@redhat.com
Cc: Alex Williamson <alex.williamson@redhat.com>, tglx@linutronix.de
Subject: The same IOMMU group for igb and its igbvf siblings
Message-ID: <20160709191600.GA26115@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I am trying to use SR-IOV on a IGB card with PCI ID 8086:1521. After
| echo 7 > /sys/devices/pci0000:00/0000:00:01.1/0000:02:00.0/sriov_numvfs
I have them all on one iommu group:

|# find /sys/kernel/iommu_groups/ -type l|grep /1/
|/sys/kernel/iommu_groups/1/devices/0000:00:01.0
|/sys/kernel/iommu_groups/1/devices/0000:00:01.1
|/sys/kernel/iommu_groups/1/devices/0000:02:00.0
|/sys/kernel/iommu_groups/1/devices/0000:02:00.1
|/sys/kernel/iommu_groups/1/devices/0000:03:10.0
|/sys/kernel/iommu_groups/1/devices/0000:03:10.4
|/sys/kernel/iommu_groups/1/devices/0000:03:11.0
|/sys/kernel/iommu_groups/1/devices/0000:03:11.4
|/sys/kernel/iommu_groups/1/devices/0000:03:12.0
|/sys/kernel/iommu_groups/1/devices/0000:03:12.4
|/sys/kernel/iommu_groups/1/devices/0000:03:13.0

lspci -t
|-[0000:00]-+-00.0
|           +-01.0-[01]--
|           +-01.1-[02-03]--+-[0000:03]-+-10.0
|           |               |           +-10.4
|           |               |           +-11.0
|           |               |           +-11.4
|           |               |           +-12.0
|           |               |           +-12.4
|           |               |           \-13.0
|           |               \-[0000:02]-+-00.0
|           |                           \-00.1

lspci for those devices:
|00:00.0 Host bridge: Intel Corporation Device 1918 (rev 07)
|00:01.0 PCI bridge: Intel Corporation Device 1901 (rev 07)
|00:01.1 PCI bridge: Intel Corporation Device 1905 (rev 07)
|02:00.0 Ethernet controller: Intel Corporation I350 Gigabit Network Connection (rev 01)
|02:00.1 Ethernet controller: Intel Corporation I350 Gigabit Network Connection (rev 01)
|03:10.0 Ethernet controller: Intel Corporation I350 Ethernet Controller Virtual Function (rev 01)
|03:10.4 Ethernet controller: Intel Corporation I350 Ethernet Controller Virtual Function (rev 01)
|03:11.0 Ethernet controller: Intel Corporation I350 Ethernet Controller Virtual Function (rev 01)
|03:11.4 Ethernet controller: Intel Corporation I350 Ethernet Controller Virtual Function (rev 01)
|03:12.0 Ethernet controller: Intel Corporation I350 Ethernet Controller Virtual Function (rev 01)
|03:12.4 Ethernet controller: Intel Corporation I350 Ethernet Controller Virtual Function (rev 01)
|03:13.0 Ethernet controller: Intel Corporation I350 Ethernet Controller Virtual Function (rev 01)

and qemu won't pass the virtual-function NICs to a guest. Shouldn't each
VF device be in its own IOMMU group?

>From the ACS capabilities I see:
|00:00.0 Host bridge: Intel Corporation Device 1918 (rev 07)
|        Subsystem: Super Micro Computer Inc Device 0909
|        Flags: bus master, fast devsel, latency 0
|        Capabilities: [e0] Vendor Specific Information: Len=10 <?>
|
|00:01.0 PCI bridge: Intel Corporation Device 1901 (rev 07) (prog-if 00 [Normal decode])
|        Flags: bus master, fast devsel, latency 0
|        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
|        Capabilities: [88] Subsystem: Super Micro Computer Inc Device 0909
|        Capabilities: [80] Power Management version 3
|        Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
|        Capabilities: [a0] Express Root Port (Slot+), MSI 00
|        Capabilities: [100] Virtual Channel
|        Capabilities: [140] Root Complex Link
|        Kernel driver in use: pcieport
|
|00:01.1 PCI bridge: Intel Corporation Device 1905 (rev 07) (prog-if 00 [Normal decode])
|        Flags: bus master, fast devsel, latency 0
|        Bus: primary=00, secondary=02, subordinate=03, sec-latency=0
|        I/O behind bridge: 0000e000-0000efff
|        Memory behind bridge: df100000-df3fffff
|        Capabilities: [88] Subsystem: Super Micro Computer Inc Device 0909
|        Capabilities: [80] Power Management version 3
|        Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
|        Capabilities: [a0] Express Root Port (Slot+), MSI 00
|        Capabilities: [100] Virtual Channel
|        Capabilities: [140] Root Complex Link
|        Capabilities: [d94] #19
|        Kernel driver in use: pcieport
|02:00.0 Ethernet controller: Intel Corporation I350 Gigabit Network Connection (rev 01)
|        Subsystem: Super Micro Computer Inc Device 0652
|…
|        Capabilities: [1d0 v1] Access Control Services
|        ACSCap: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
|        ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
|        Kernel driver in use: igb
|
|03:10.0 Ethernet controller: Intel Corporation I350 Ethernet Controller Virtual Function (rev 01)
|        Subsystem: Super Micro Computer Inc Device 0652
|        Flags: fast devsel
|…
|        Capabilities: [1d0 v1] Access Control Services
|                ACSCap: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
|                ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-

I *think* the problem is that the root port lacks ACS caps. Could this
be the poblem? If so do I need to wait for a BIOS update or is there an
other option?
I tried v4.7-rc6. I noticed that the IGB device is part of the quirk
table in pci_dev_acs_enabled but somehow it is not used.
Any suggestions?

Sebastian
