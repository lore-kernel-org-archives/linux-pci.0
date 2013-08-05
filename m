Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:60826 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755371Ab3HEIzZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Aug 2013 04:55:25 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Rafael <rjw@sisk.pl>,
	Oliver Neukum <oneukum@suse.de>,
	Gu Zheng <guz.fnst@cn.fujitsu.com>,
	Paul Bolle <pebolle@tiscali.nl>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH -v5 0/6] Use PCI Serial Number to identify device change
Date: Mon, 5 Aug 2013 16:54:52 +0800
Message-ID: <1375692898-27476-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

v4->v5: update patch 6/6, correct some mistakes in this patch, thank Paul for help
		test this series.
v3->v4: introudce PCI VPD Sn support suggested by Bjorn, and other rework things.
		
v2->v3: add a wrap function pci_dsn_init, fix other typo error and git am error.
		Thanks for Don Dutile and Paul Bolle 's review,comments and test.
v1->v2: Modify pci_get_dsn to pci_device_serial_number,
	    power off slot before remove the old device during resume to avoid
		old .remove() method to touch new hardware.
		Fix other typo and fail check problems.
		split the list_empty() guard into new patch.
	    Thanks for Bjorn's review and comments.

I tested to apply this series to Linus 3.11-rc4 and Bjorn's pci-next branch, and
result is ok.

My test machine arch is IA64, it's the only one support pciehp.
But IA64 default does not support SUSPEND. So I modified my kernel to run pm suspend and resume test.

-+-[0000:40]-+-00.0-[0000:41]--
...............[snip]..............
 |           +-05.0-[0000:45]--
 |           +-07.0-[0000:46]--+-00.0  Intel Corporation 82576 Gigabit Network Connection
 |           |                 \-00.1  Intel Corporation 82576 Gigabit Network Connection

dmesg info after suspend->resume test:
......................................
pciehp 0000:40:03.0:pcie04: HPC vendor_id 8086 device_id 340a ss_vid 8086 ss_did 340a
pciehp 0000:40:03.0:pcie04: service driver pciehp loaded
pciehp 0000:40:04.0:pcie04: HPC vendor_id 8086 device_id 340b ss_vid 8086 ss_did 340b
pciehp 0000:40:04.0:pcie04: service driver pciehp loaded
pciehp 0000:40:05.0:pcie04: HPC vendor_id 8086 device_id 340c ss_vid 8086 ss_did 340c
pciehp 0000:40:05.0:pcie04: service driver pciehp loaded
pciehp 0000:40:07.0:pcie04: HPC vendor_id 8086 device_id 340e ss_vid 8086 ss_did 340e
pciehp 0000:40:07.0:pcie04: service driver pciehp loaded
pciehp: PCI Express Hot Plug Controller Driver version: 0.4
PM: Syncing filesystems ... done.
PM: Preparing system for mem sleep
Freezing user space processes ... (elapsed 0.003 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.004 seconds) done.
PM: Entering mem sleep
Suspending console(s) (use no_console_suspend to debug)
sd 5:0:0:0: [sdb] Synchronizing SCSI cache
mptbase: ioc1: pci-suspend: pdev=0xe000001f03611600, slot=0000:43:00.0, Entering operating state [D3]
mptbase: ioc0: pci-suspend: pdev=0xe000001f035de500, slot=0000:02:00.0, Entering operating state [D3]
pcieport 0000:40:07.0: System wakeup enabled by ACPI
GSI 61 (level, low) -> CPU 28 (0x3400) vector 128 unregistered
pcieport 0000:40:07.0: System wakeup enabled by ACPI
GSI 64 (level, low) -> CPU 25 (0x3100) vector 109 unregistered
GSI 40 (level, low) -> CPU 23 (0x2700) vector 89 unregistered
GSI 37 (level, low) -> CPU 12 (0x1400) vector 79 unregistered
PM: suspend of devices complete after 444.758 msecs
suspend debug: Waiting for 5 seconds.
pciehp_resume: bus 0x43, coming here!
usb usb3: root hub lost power or was reset
pciehp_resume: bus 0x44, coming here!
pciehp_resume: bus 0x45, coming here!
usb usb2: root hub lost power or was reset
usb usb1: root hub lost power or was reset
usb usb4: root hub lost power or was reset
usb usb5: root hub lost power or was reset
usb usb6: root hub lost power or was reset
pciehp_resume: bus 0x46, coming here!
GSI 37 (level, low) -> CPU 29 (0x3500) vector 79
mptbase: ioc0: pci-resume: pdev=0xe000001f035de500, slot=0000:02:00.0, Previous operating state [D0]
GSI 40 (level, low) -> CPU 30 (0x3600) vector 86
mptbase: ioc0: pci-resume: ioc-state=0x1,doorbell=0x10000000
GSI 64 (level, low) -> CPU 31 (0x3700) vector 101
ata4: SATA link down (SStatus 0 SControl 300)
ata3: SATA link down (SStatus 0 SControl 300)
usb 3-2: reset low-speed USB device number 3 using uhci_hcd
ata1.00: SATA link down (SStatus 0 SControl 300)
ata1.01: SATA link down (SStatus 0 SControl 300)
ata2.00: SATA link down (SStatus 0 SControl 300)
ata2.01: SATA link down (SStatus 0 SControl 300)
usb 4-2: reset full-speed USB device number 3 using uhci_hcd
pciehp_resume: status 0
pciehp_resume: status 1
pciehp_resume: status 0
pciehp_resume: status 1
pciehp_resume: device 0000:46:00.0, serial number changed!
mptbase: ioc1: pci-resume: pdev=0xe000001f03611600, slot=0000:43:00.0, Previous operating state [D0]
mptbase: ioc1: pci-resume: ioc-state=0x1,doorbell=0x10000000
atkbd serio0: keyboard reset failed on isa0060/serio0
atkbd serio1: keyboard reset failed on isa0060/serio1
igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
pciehp_unconfigure_device: device 0000:46:00.0, preparing remove!
igb 0000:46:00.0: removed PHC on eth17    ------------------------------->remove old device, because I change its PCIe DSN in pciehp_resume() for test situation which device serial number changed.
pciehp_unconfigure_device: device 0000:46:00.1, preparing remove!
igb 0000:46:00.1: removed PHC on eth16
pciehp_resume: remove device complete!
pci 0000:46:00.0: [8086:10c9] type 00 class 0x020000
pci 0000:46:00.0: reg 0x10: [mem 0x00000000-0x0001ffff]
pci 0000:46:00.0: reg 0x14: [mem 0x00000000-0x0001ffff]
pci 0000:46:00.0: reg 0x18: [io  0x0000-0x001f]
pci 0000:46:00.0: reg 0x1c: [mem 0x00000000-0x00003fff]
pci 0000:46:00.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
pci 0000:46:00.0: PME# supported from D0 D3hot D3cold
pci 0000:46:00.0: reg 0x184: [mem 0x00000000-0x0000ffff 64bit]
pci 0000:46:00.0: reg 0x190: [mem 0x00000000-0x0001ffff 64bit]
pci 0000:46:00.1: [8086:10c9] type 00 class 0x020000
pci 0000:46:00.1: reg 0x10: [mem 0x00000000-0x0001ffff]
pci 0000:46:00.1: reg 0x14: [mem 0x00000000-0x0001ffff]
pci 0000:46:00.1: reg 0x18: [io  0x0000-0x001f]
pci 0000:46:00.1: reg 0x1c: [mem 0x00000000-0x00003fff]
pci 0000:46:00.1: reg 0x30: [mem 0x00000000-0x0001ffff pref]
pci 0000:46:00.1: PME# supported from D0 D3hot D3cold
pci 0000:46:00.1: reg 0x184: [mem 0x00000000-0x0000ffff 64bit]
pci 0000:46:00.1: reg 0x190: [mem 0x00000000-0x0001ffff 64bit]
pci 0000:46:00.0: reg 0x184: [mem 0x00000000-0x0000ffff 64bit]
pci 0000:46:00.0: reg 0x190: [mem 0x00000000-0x0001ffff 64bit]
pci 0000:46:00.0: reg 0x184: [mem 0x00000000-0x0000ffff 64bit]
pci 0000:46:00.0: reg 0x190: [mem 0x00000000-0x0001ffff 64bit]
pci 0000:46:00.0: reg 0x184: [mem 0x00000000-0x0000ffff 64bit]
pci 0000:46:00.0: reg 0x190: [mem 0x00000000-0x0001ffff 64bit]
pci 0000:46:00.0: reg 0x184: [mem 0x00000000-0x0000ffff 64bit]
pci 0000:46:00.0: reg 0x190: [mem 0x00000000-0x0001ffff 64bit]
pci 0000:46:00.0: reg 0x184: [mem 0x00000000-0x0000ffff 64bit]
pci 0000:46:00.0: reg 0x190: [mem 0x00000000-0x0001ffff 64bit]
pci 0000:46:00.0: reg 0x184: [mem 0x00000000-0x0000ffff 64bit]
pci 0000:46:00.0: reg 0x190: [mem 0x00000000-0x0001ffff 64bit]
pci 0000:46:00.0: reg 0x184: [mem 0x00000000-0x0000ffff 64bit]
pci 0000:46:00.1: reg 0x184: [mem 0x00000000-0x0000ffff 64bit]
pci 0000:46:00.0: reg 0x190: [mem 0x00000000-0x0001ffff 64bit]
pci 0000:46:00.0: reg 0x184: [mem 0x00000000-0x0000ffff 64bit]
pci 0000:46:00.1: reg 0x190: [mem 0x00000000-0x0001ffff 64bit]
pci 0000:46:00.0: reg 0x190: [mem 0x00000000-0x0001ffff 64bit]
pci 0000:46:00.0: reg 0x184: [mem 0x00000000-0x0000ffff 64bit]
pci 0000:46:00.0: BAR 0: assigned [mem 0x80000000-0x8001ffff]
pci 0000:46:00.0: BAR 1: assigned [mem 0x80020000-0x8003ffff]
pci 0000:46:00.0: BAR 6: assigned [mem 0x80700000-0x8071ffff pref]
pci 0000:46:00.0: reg 0x190: [mem 0x00000000-0x0001ffff 64bit]
pci 0000:46:00.0: BAR 10: can't assign mem (size 0x100000)
pci 0000:46:00.1: BAR 0: assigned [mem 0x80040000-0x8005ffff]
pci 0000:46:00.1: BAR 1: assigned [mem 0x80060000-0x8007ffff]
pci 0000:46:00.1: BAR 6: assigned [mem 0x80720000-0x8073ffff pref]
pci 0000:46:00.1: reg 0x190: [mem 0x00000000-0x0001ffff 64bit]
pci 0000:46:00.1: BAR 10: can't assign mem (size 0x100000)
pci 0000:46:00.0: reg 0x184: [mem 0x00000000-0x0000ffff 64bit]
pci 0000:46:00.0: BAR 7: assigned [mem 0x80080000-0x800fffff 64bit]
pci 0000:46:00.1: reg 0x184: [mem 0x00000000-0x0000ffff 64bit]
pci 0000:46:00.1: BAR 7: can't assign mem (size 0x80000)
pci 0000:46:00.0: BAR 3: can't assign mem (size 0x4000)
pci 0000:46:00.1: BAR 3: can't assign mem (size 0x4000)
pci 0000:46:00.0: BAR 2: assigned [io  0x9000-0x901f]
pci 0000:46:00.1: BAR 2: assigned [io  0x9020-0x903f]
pcieport 0000:40:07.0: PCI bridge to [bus 46]
pcieport 0000:40:07.0:   bridge window [io  0x9000-0xafff]
pcieport 0000:40:07.0:   bridge window [mem 0x80000000-0x800fffff]
pcieport 0000:40:07.0:   bridge window [mem 0x80700000-0x809fffff 64bit pref]
PCI: No. 2 try to assign unassigned res
release child resource [mem 0x80000000-0x8001ffff]
release child resource [mem 0x80020000-0x8003ffff]
release child resource [mem 0x80040000-0x8005ffff]
release child resource [mem 0x80060000-0x8007ffff]
release child resource [mem 0x80080000-0x800fffff 64bit]
pcieport 0000:40:07.0: resource 14 [mem 0x80000000-0x800fffff] released
pcieport 0000:40:07.0: PCI bridge to [bus 46]
pcieport 0000:40:07.0: bridge window [mem 0x00100000-0x001fffff] to [bus 46] add_size 400000
pcieport 0000:40:07.0: res[14]=[mem 0x00100000-0x001fffff] get_res_add_size add_size 400000
pcieport 0000:40:07.0: BAR 14: assigned [mem 0x81600000-0x81afffff]
pci 0000:46:00.0: reg 0x184: [mem 0x80080000-0x8008ffff 64bit]
pci 0000:46:00.0: reg 0x190: [mem 0x00000000-0x0001ffff 64bit]
pci 0000:46:00.0: reg 0x184: [mem 0x80080000-0x8008ffff 64bit]
pci 0000:46:00.0: reg 0x190: [mem 0x00000000-0x0001ffff 64bit]
pci 0000:46:00.0: reg 0x184: [mem 0x80080000-0x8008ffff 64bit]
pci 0000:46:00.0: reg 0x190: [mem 0x00000000-0x0001ffff 64bit]
pci 0000:46:00.0: reg 0x184: [mem 0x80080000-0x8008ffff 64bit]
pci 0000:46:00.0: reg 0x190: [mem 0x00000000-0x0001ffff 64bit]
pci 0000:46:00.0: reg 0x184: [mem 0x80080000-0x8008ffff 64bit]
pci 0000:46:00.1: reg 0x184: [mem 0x00000000-0x0000ffff 64bit]
pci 0000:46:00.0: reg 0x190: [mem 0x00000000-0x0001ffff 64bit]
pci 0000:46:00.0: reg 0x184: [mem 0x80080000-0x8008ffff 64bit]
pci 0000:46:00.1: reg 0x190: [mem 0x00000000-0x0001ffff 64bit]
pci 0000:46:00.0: reg 0x190: [mem 0x00000000-0x0001ffff 64bit]
pci 0000:46:00.0: reg 0x184: [mem 0x80080000-0x8008ffff 64bit]
pci 0000:46:00.0: res[10]=[mem 0x00000000-0xffffffffffffffff 64bit] get_res_add_size add_size 100000
pci 0000:46:00.1: res[10]=[mem 0x00000000-0xffffffffffffffff 64bit] get_res_add_size add_size 100000
pci 0000:46:00.0: res[7]=[mem 0x00000000-0xffffffffffffffff 64bit] get_res_add_size add_size 80000
pci 0000:46:00.1: res[7]=[mem 0x00000000-0xffffffffffffffff 64bit] get_res_add_size add_size 80000
pci 0000:46:00.0: BAR 0: assigned [mem 0x81600000-0x8161ffff]
pci 0000:46:00.0: BAR 1: assigned [mem 0x81620000-0x8163ffff]
pci 0000:46:00.0: reg 0x190: [mem 0x00000000-0x0001ffff 64bit]
pci 0000:46:00.0: BAR 10: assigned [mem 0x81640000-0x8173ffff 64bit]
pci 0000:46:00.1: BAR 0: assigned [mem 0x81740000-0x8175ffff]
pci 0000:46:00.1: BAR 1: assigned [mem 0x81760000-0x8177ffff]
pci 0000:46:00.1: reg 0x190: [mem 0x00000000-0x0001ffff 64bit]
pci 0000:46:00.1: BAR 10: assigned [mem 0x81780000-0x8187ffff 64bit]
pci 0000:46:00.0: reg 0x184: [mem 0x80080000-0x8008ffff 64bit]
pci 0000:46:00.0: BAR 7: assigned [mem 0x81880000-0x818fffff 64bit]
pci 0000:46:00.1: reg 0x184: [mem 0x00000000-0x0000ffff 64bit]
pci 0000:46:00.1: BAR 7: assigned [mem 0x81900000-0x8197ffff 64bit]
pci 0000:46:00.0: BAR 3: assigned [mem 0x81980000-0x81983fff]
pci 0000:46:00.1: BAR 3: assigned [mem 0x81984000-0x81987fff]
pcieport 0000:40:07.0: PCI bridge to [bus 46]
pcieport 0000:40:07.0:   bridge window [io  0x9000-0xafff]
pcieport 0000:40:07.0:   bridge window [mem 0x81600000-0x81afffff]
pcieport 0000:40:07.0:   bridge window [mem 0x80700000-0x809fffff 64bit pref]
igb 0000:46:00.0: enabling device (0100 -> 0102)
igb 0000:46:00.0: added PHC on eth4
igb 0000:46:00.0: Intel(R) Gigabit Ethernet Network Connection
igb 0000:46:00.0: eth4: (PCIe:2.5Gb/s:Width x4) 00:0e:0c:ff:ff:ff
igb 0000:46:00.0: eth4: PBA No: FFFFFF-0FF
igb 0000:46:00.0: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
igb 0000:46:00.1: enabling device (0100 -> 0102)
GSI 61 (level, low) -> CPU 0 (0x1000) vector 128
igb 0000:46:00.1: added PHC on eth5
igb 0000:46:00.1: Intel(R) Gigabit Ethernet Network Connection
igb 0000:46:00.1: eth5: (PCIe:2.5Gb/s:Width x4) 00:0e:0c:ff:ff:fe
igb 0000:46:00.1: eth5: PBA No: FFFFFF-0FF
igb 0000:46:00.1: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
mptbase: ioc1: Sending mpt_do_ioc_recovery
mptbase: ioc1: Initiating bringup
mptbase: ioc0: Sending mpt_do_ioc_recovery
mptbase: ioc0: Initiating bringup
ioc1: LSISAS1064E B2: Capabilities={Initiator}
ioc0: LSISAS1064E B2: Capabilities={Initiator}
pcieport 0000:40:07.0: System wakeup disabled by ACPI
pcieport 0000:40:07.0: System wakeup disabled by ACPI
mptbase: ioc1: pci-resume: success
mptbase: ioc0: pci-resume: success
PM: resume of devices complete after 17542.954 msecs
PM: Finishing wakeup.
Restarting tasks ... done.


Yijing Wang (6):
  PCI,pciehp: avoid add a device already exist before suspend during
    resume
  PCI: introduce PCIe Device Serial Number Capability support
  PCI: Introduce Vital Product Data Serial Number capability support
  PCI: add pci_serial_number_changed() for device change identification
  PCI: add inspection of device change in pci_scan_single_device
  PCI,pciehp: identify device change during suspend

 drivers/pci/access.c              |   13 +-----
 drivers/pci/hotplug/pciehp_core.c |   37 ++++++++++++++++-
 drivers/pci/pci.c                 |   77 +++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h                 |   14 ++++++-
 drivers/pci/probe.c               |    4 ++
 drivers/pci/vpd.c                 |   70 +++++++++++++++++++++++++++++++++
 include/linux/pci.h               |    4 ++
 7 files changed, 205 insertions(+), 14 deletions(-)


