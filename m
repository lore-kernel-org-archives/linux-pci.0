Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37977 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390AbaBNOv2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Feb 2014 09:51:28 -0500
Received: from dflxv15.itg.ti.com ([128.247.5.124])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id s1EEpRSe012450
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2014 08:51:27 -0600
Received: from DLEE70.ent.ti.com (dlee70.ent.ti.com [157.170.170.113])
	by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id s1EEpR4s029989
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2014 08:51:27 -0600
From: "Karicheri, Muralidharan" <m-karicheri2@ti.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: PCI memory BAR assigned by u-boot not honored when using recent
 kernel
Date: Fri, 14 Feb 2014 14:51:26 +0000
Message-ID: <3E54258959B69E4282D79E01AB1F32B704695360@DFLE11.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

All,

I am working to port our PCI driver from v3.10 to v3.13 as part of up-streaming. The end point is Marvel SATA controller and a SCSI drive. The BARs are setup by U-Boot and Kernel is expected to honor the BAR assignments. In v3.10 based driver, I see bridge window size is 2MB for pre-fetch and non prefetched memory,  where as in v3.13rc4 based driver, it assigns a window size of 1MB. There is nothing in my driver that sets up the maximum window size. Has this been changed in recent kernel (v3.13+)? Even setting pci=firmware doesn't honor the BAR settings w.r.t to the memory BAR of the EP? The driver works fine with a e1000e NIC device driver from Intel and both Ethernet ports are functional, in this case, kernel does the BAR assignments. W.r.t SATA + SCSI, if I mount the filesystem on hard disk after boot up and do some basic read write tests, it is working, however when kernel is boot with filesystem on the harddisk, then it doesn't boot. I have attached PCI BAR related logs at boot up below for your information. Do you know what could be causing this? I am assuming the problem is due to the memory BARs being re-assigned with a different range than what is setup by U-Boot causing this issue.

Logs from a non working v3.13-rc4 driver

[    0.303686] pci_bus 0000:00: root bus resource [mem 0x50000000-0x5fffffff]
[    0.303695] pci_bus 0000:00: root bus resource [io  0x0000-0x3fff]
[    0.303704] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
[    0.303733] pci 0000:00:00.0: [104c:8888] type 01 class 0x060400
[    0.303980] PCI: bus0: Fast back to back transfers disabled
[    0.304151] pci 0000:01:00.0: [1b4b:9125] type 00 class 0x010601
[    0.304176] pci 0000:01:00.0: reg 0x10: [io  0x1000-0x1007]
[    0.304195] pci 0000:01:00.0: reg 0x14: [io  0x1008-0x100b]
[    0.304213] pci 0000:01:00.0: reg 0x18: [io  0x1010-0x1017]
[    0.304231] pci 0000:01:00.0: reg 0x1c: [io  0x1018-0x101b]
[    0.304248] pci 0000:01:00.0: reg 0x20: [io  0x1020-0x102f]
[    0.304266] pci 0000:01:00.0: reg 0x24: [mem 0x50000000-0x500007ff]
[    0.304285] pci 0000:01:00.0: reg 0x30: [mem 0xd0000000-0xd000ffff pref]
[    0.304347] pci 0000:01:00.0: PME# supported from D3hot
[    0.304502] PCI: bus1: Fast back to back transfers disabled
[    0.304512] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    0.304524] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 01
[    0.304536] keystone-pcie: Ending PCI scan...
[    0.304550] keystone-pcie: keystone_pcie_map_irq: slot 0, pin 1
[    0.304555] keystone-pcie: keystone_pcie_map_irq: legacy_irq 512
[    0.304577] pci 0000:00:00.0: BAR 8: assigned [mem 0x50000000-0x500fffff]
[    0.304587] pci 0000:00:00.0: BAR 9: assigned [mem 0x50100000-0x501fffff pref]
[    0.304596] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
[    0.304608] pci 0000:01:00.0: BAR 6: assigned [mem 0x50100000-0x5010ffff pref]
[    0.304618] pci 0000:01:00.0: BAR 5: assigned [mem 0x50000000-0x500007ff]
[    0.304629] pci 0000:01:00.0: BAR 4: assigned [io  0x1000-0x100f]
[    0.304641] pci 0000:01:00.0: BAR 0: assigned [io  0x1010-0x1017]
[    0.304652] pci 0000:01:00.0: BAR 2: assigned [io  0x1018-0x101f]
[    0.304663] pci 0000:01:00.0: BAR 1: assigned [io  0x1020-0x1023]
[    0.304674] pci 0000:01:00.0: BAR 3: assigned [io  0x1024-0x1027]
[    0.304687] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.304696] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
[    0.304707] pci 0000:00:00.0:   bridge window [mem 0x50000000-0x500fffff]
[    0.304716] pci 0000:00:00.0:   bridge window [mem 0x50100000-0x501fffff pref]

Logs from a working v3.10 driver

[  105.763092] pci_bus 0000:00: root bus resource [mem 0x50000000-0x5fffffff]
[  105.763101] pci_bus 0000:00: root bus resource [io  0x0000-0x3fff]
[  105.763110] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
[  105.763137] pci 0000:00:00.0: [104c:8888] type 01 class 0x060400
[  105.763389] PCI: bus0: Fast back to back transfers disabled
[  105.763563] pci 0000:01:00.0: [1b4b:9125] type 00 class 0x010601
[  105.763587] pci 0000:01:00.0: reg 10: [io  0x1000-0x1007]
[  105.763606] pci 0000:01:00.0: reg 14: [io  0x1008-0x100b]
[  105.763623] pci 0000:01:00.0: reg 18: [io  0x1010-0x1017]
[  105.763640] pci 0000:01:00.0: reg 1c: [io  0x1018-0x101b]
[  105.763657] pci 0000:01:00.0: reg 20: [io  0x1020-0x102f]
[  105.763674] pci 0000:01:00.0: reg 24: [mem 0x50000000-0x500007ff]
[  105.763692] pci 0000:01:00.0: reg 30: [mem 0xd0000000-0xd000ffff pref]
[  105.763754] pci 0000:01:00.0: PME# supported from D3hot
[  105.763919] PCI: bus1: Fast back to back transfers disabled
[  105.763930] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[  105.763942] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 01
[  105.763954] keystone-pcie: Ending PCI scan...
[  105.763968] keystone-pcie: keystone_pcie_map_irq: slot 0, pin 1
[  105.763973] keystone-pcie: keystone_pcie_map_irq: legacy_irq 572
[  105.763996] pci 0000:00:00.0: BAR 8: assigned [mem 0x50000000-0x501fffff]
[  105.764006] pci 0000:00:00.0: BAR 9: assigned [mem 0x50200000-0x503fffff pref]
[  105.764015] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
[  105.764027] pci 0000:01:00.0: BAR 6: assigned [mem 0x50200000-0x5020ffff pref]
[  105.764037] pci 0000:01:00.0: BAR 5: assigned [mem 0x50000000-0x500007ff]
[  105.764048] pci 0000:01:00.0: BAR 4: assigned [io  0x1000-0x100f]
[  105.764060] pci 0000:01:00.0: BAR 0: assigned [io  0x1010-0x1017]
[  105.764071] pci 0000:01:00.0: BAR 2: assigned [io  0x1018-0x101f]
[  105.764082] pci 0000:01:00.0: BAR 1: assigned [io  0x1020-0x1023]
[  105.764092] pci 0000:01:00.0: BAR 3: assigned [io  0x1024-0x1027]
[  105.764105] pci 0000:00:00.0: PCI bridge to [bus 01]
[  105.764113] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
[  105.764124] pci 0000:00:00.0:   bridge window [mem 0x50000000-0x501fffff]
[  105.764133] pci 0000:00:00.0:   bridge window [mem 0x50200000-0x503fffff pref]


Murali Karicheri
Linux Kernel, Software Development


