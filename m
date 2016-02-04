Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout3.freenet.de ([195.4.92.93]:50146 "EHLO mout3.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965627AbcBDPCh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Feb 2016 10:02:37 -0500
Received: from [195.4.92.142] (helo=mjail2.freenet.de)
	by mout3.freenet.de with esmtpa (ID andihartmann@freenet.de) (port 25) (Exim 4.85 #1)
	id 1aRLJf-0007iA-H6
	for linux-pci@vger.kernel.org; Thu, 04 Feb 2016 15:55:27 +0100
Received: from localhost ([::1]:52413 helo=mjail2.freenet.de)
	by mjail2.freenet.de with esmtpa (ID andihartmann@freenet.de) (Exim 4.85 #1)
	id 1aRLJf-0001Hi-D2
	for linux-pci@vger.kernel.org; Thu, 04 Feb 2016 15:55:27 +0100
Received: from mx4.freenet.de ([195.4.92.14]:57249)
	by mjail2.freenet.de with esmtpa (ID andihartmann@freenet.de) (Exim 4.85 #1)
	id 1aRLHf-0005gO-Gq
	for linux-pci@vger.kernel.org; Thu, 04 Feb 2016 15:53:23 +0100
Received: from pd9eaf031.dip0.t-ipconnect.de ([217.234.240.49]:52559 helo=mail.maya.org)
	by mx4.freenet.de with esmtpsa (ID andihartmann@freenet.de) (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256) (port 587) (Exim 4.85 #1)
	id 1aRLHf-0000wr-3W
	for linux-pci@vger.kernel.org; Thu, 04 Feb 2016 15:53:23 +0100
Received: from [192.168.1.6] (dualc.maya.org [192.168.1.6])
	by mail.maya.org (8.14.7/8.13.8) with ESMTP id u14ErLOt022549
	for <linux-pci@vger.kernel.org>; Thu, 4 Feb 2016 15:53:21 +0100
To: linux-pci@vger.kernel.org
From: Andreas Hartmann <andihartmann@01019freenet.de>
Subject: AMD-Vi: Unable to write to IOMMU perf counter.
Message-ID: <56B365E0.4020100@01019freenet.de>
Date: Thu, 4 Feb 2016 15:53:20 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010304040509040700060803"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------010304040509040700060803
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hello!

The following happens with Linux 4.4.1 during boot on an MSI A78M-E35
board. Additionally, I attached the complete dmesg.


[    1.228987] ------------[ cut here ]------------
[    1.228992] WARNING: CPU: 0 PID: 1 at
../drivers/iommu/amd_iommu_init.c:2301
amd_iommu_pc_get_set_reg_val+0xa8/0xe0()
[    1.228993] Modules linked in:
[    1.228997] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.4.1-14-default #1
[    1.228998] Hardware name: ARLT Computer-Produkte GmbH ARLT Mr.
Whisper Ultimate II R1 (3080527A-U140-V30.5)/A78M-E35 (MS-7721), BIOS
V30.5 10/20/2014
[    1.229000]  ffffffff819a7f28 ffff88017ed7bd30 ffffffff812f7c89
0000000000000000
[    1.229002]  ffff88017ed7bd68 ffffffff81066ae6 ffff88017ed4a000
0000000000000040
[    1.229004]  0000000000000000 ffffffff81d3424e 0000000000000007
ffff88017ed7bd78
[    1.229006] Call Trace:
[    1.229015]  [<ffffffff81009075>] try_stack_unwind+0x175/0x190
[    1.229021]  [<ffffffff81007fa4>] dump_trace+0x64/0x3b0
[    1.229024]  [<ffffffff810090dd>] show_trace_log_lvl+0x4d/0x60
[    1.229026]  [<ffffffff81008402>] show_stack_log_lvl+0x112/0x180
[    1.229029]  [<ffffffff81009135>] show_stack+0x25/0x50
[    1.229032]  [<ffffffff812f7c89>] dump_stack+0x4b/0x72
[    1.229036]  [<ffffffff81066ae6>] warn_slowpath_common+0x86/0xc0
[    1.229039]  [<ffffffff81066bda>] warn_slowpath_null+0x1a/0x20
[    1.229041]  [<ffffffff8140acf8>] amd_iommu_pc_get_set_reg_val+0xa8/0xe0
[    1.229045]  [<ffffffff81d6f60d>] iommu_go_to_state+0x501/0x13c4
[    1.229048]  [<ffffffff81d70543>] amd_iommu_init+0x13/0x253
[    1.229051]  [<ffffffff81d34260>] pci_iommu_init+0x12/0x3c
[    1.229053]  [<ffffffff81000403>] do_one_initcall+0xd3/0x1f0
[    1.229057]  [<ffffffff81d2f079>] kernel_init_freeable+0x16d/0x1fa
[    1.229060]  [<ffffffff815fb2ae>] kernel_init+0xe/0xe0
[    1.229064]  [<ffffffff8160736f>] ret_from_fork+0x3f/0x70
[    1.231707] DWARF2 unwinder stuck at ret_from_fork+0x3f/0x70

[    1.231709] Leftover inexact backtrace:

[    1.231713]  [<ffffffff815fb2a0>] ? rest_init+0x90/0x90
[    1.231718] ---[ end trace 100b826816268f19 ]---
[    1.231719] AMD-Vi: Unable to write to IOMMU perf counter.


What does this mean?

Thanks,
regards,
Andreas Hartmann



lspci -v
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1422
        Subsystem: Micro-Star International Co., Ltd. Device 7721
        Flags: bus master, fast devsel, latency 0

00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Device 1423
        Subsystem: Micro-Star International Co., Ltd. Device 7721
        Flags: bus master, fast devsel, latency 0, IRQ 24
        Capabilities: [40] Secure device <?>
        Capabilities: [54] MSI: Enable+ Count=1/4 Maskable- 64bit+
        Capabilities: [64] HyperTransport: MSI Mapping Enable+ Fixed+

00:01.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] Kaveri (prog-if 00 [VGA controller])
        Subsystem: Micro-Star International Co., Ltd. Device 7721
        Flags: bus master, fast devsel, latency 0, IRQ 34
        Memory at c0000000 (64-bit, prefetchable) [size=256M]
        Memory at d0000000 (64-bit, prefetchable) [size=8M]
        I/O ports at f000 [size=256]
        Memory at feb00000 (32-bit, non-prefetchable) [size=256K]
        Expansion ROM at feb40000 [disabled] [size=128K]
        Capabilities: [48] Vendor Specific Information: Len=08 <?>
        Capabilities: [50] Power Management version 3
        Capabilities: [58] Express Root Complex Integrated Endpoint, MSI 00
        Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1
Len=010 <?>
        Capabilities: [270] #19
        Capabilities: [2b0] Address Translation Service (ATS)
        Capabilities: [2c0] #13
        Capabilities: [2d0] #1b
        Kernel driver in use: radeon
        Kernel modules: radeon, amdgpu

00:01.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Device 1308
        Subsystem: Micro-Star International Co., Ltd. Device 7721
        Flags: bus master, fast devsel, latency 0, IRQ 46
        Memory at feb64000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [48] Vendor Specific Information: Len=08 <?>
        Capabilities: [50] Power Management version 3
        Capabilities: [58] Express Root Complex Integrated Endpoint, MSI 00
        Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1
Len=010 <?>
        Kernel driver in use: snd_hda_intel
        Kernel modules: snd_hda_intel

00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1424
        Flags: fast devsel

00:03.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1424
        Flags: fast devsel

00:03.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 1426
(prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fea00000-feafffff
        Prefetchable memory behind bridge: 00000000d0800000-00000000d08fffff
        Capabilities: [50] Power Management version 3
        Capabilities: [58] Express Root Port (Slot+), MSI 00
        Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [b0] Subsystem: Micro-Star International Co., Ltd.
Device 7721
        Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
        Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1
Len=010 <?>
        Capabilities: [270] #19
        Kernel driver in use: pcieport
        Kernel modules: shpchp

00:04.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1424
        Flags: fast devsel

00:10.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB XHCI
Controller (rev 09) (prog-if 30 [XHCI])
        Subsystem: Micro-Star International Co., Ltd. Device 7721
        Flags: bus master, fast devsel, latency 0
        Memory at feb6a000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [50] Power Management version 3
        Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
        Capabilities: [90] MSI-X: Enable+ Count=8 Masked-
        Capabilities: [a0] Express Root Complex Integrated Endpoint, MSI 00
        Capabilities: [100] Latency Tolerance Reporting
        Kernel driver in use: xhci_hcd
        Kernel modules: xhci_pci

00:10.1 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB XHCI
Controller (rev 09) (prog-if 30 [XHCI])
        Subsystem: Micro-Star International Co., Ltd. Device 7721
        Flags: bus master, fast devsel, latency 0
        Memory at feb68000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [50] Power Management version 3
        Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
        Capabilities: [90] MSI-X: Enable+ Count=8 Masked-
        Capabilities: [a0] Express Root Complex Integrated Endpoint, MSI 00
        Kernel driver in use: xhci_hcd
        Kernel modules: xhci_pci

00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA
Controller [AHCI mode] (rev 40) (prog-if 01 [AHCI 1.0])
        Subsystem: Micro-Star International Co., Ltd. Device 7721
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 25
        I/O ports at f140 [size=8]
        I/O ports at f130 [size=4]
        I/O ports at f120 [size=8]
        I/O ports at f110 [size=4]
        I/O ports at f100 [size=16]
        Memory at feb71000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [50] MSI: Enable+ Count=8/8 Maskable- 64bit+
        Capabilities: [70] SATA HBA v1.0
        Kernel driver in use: ahci

00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB OHCI
Controller (rev 11) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd. Device 7721
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 18
        Memory at feb70000 (32-bit, non-prefetchable) [size=4K]
        Kernel driver in use: ohci-pci
        Kernel modules: ohci_pci

00:12.2 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB EHCI
Controller (rev 11) (prog-if 20 [EHCI])
        Subsystem: Micro-Star International Co., Ltd. Device 7721
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 17
        Memory at feb6f000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [c0] Power Management version 2
        Capabilities: [e4] Debug port: BAR=1 offset=00e0
        Kernel driver in use: ehci-pci
        Kernel modules: ehci_pci

00:13.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB OHCI
Controller (rev 11) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd. Device 7721
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 18
        Memory at feb6e000 (32-bit, non-prefetchable) [size=4K]
        Kernel driver in use: ohci-pci
        Kernel modules: ohci_pci

00:13.2 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB EHCI
Controller (rev 11) (prog-if 20 [EHCI])
        Subsystem: Micro-Star International Co., Ltd. Device 7721
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 17
        Memory at feb6d000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [c0] Power Management version 2
        Capabilities: [e4] Debug port: BAR=1 offset=00e0
        Kernel driver in use: ehci-pci
        Kernel modules: ehci_pci

00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller
(rev 16)
        Subsystem: Micro-Star International Co., Ltd. Device 7721
        Flags: 66MHz, medium devsel
        Kernel driver in use: piix4_smbus
        Kernel modules: i2c_piix4

00:14.2 Audio device: Advanced Micro Devices, Inc. [AMD] FCH Azalia
Controller (rev 01)
        Subsystem: Micro-Star International Co., Ltd. Device d721
        Flags: bus master, slow devsel, latency 32, IRQ 16
        Memory at feb60000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Kernel driver in use: snd_hda_intel
        Kernel modules: snd_hda_intel

00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge
(rev 11)
        Subsystem: Micro-Star International Co., Ltd. Device 7721
        Flags: bus master, 66MHz, medium devsel, latency 0

00:14.4 PCI bridge: Advanced Micro Devices, Inc. [AMD] FCH PCI Bridge
(rev 40) (prog-if 01 [Subtractive decode])
        Flags: bus master, VGA palette snoop, 66MHz, medium devsel,
latency 64
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64

00:14.5 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB OHCI
Controller (rev 11) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd. Device 7721
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 18
        Memory at feb6c000 (32-bit, non-prefetchable) [size=4K]
        Kernel driver in use: ohci-pci
        Kernel modules: ohci_pci

00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 141a
        Flags: fast devsel

00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 141b
        Flags: fast devsel

00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 141c
        Flags: fast devsel
        Kernel modules: amd64_edac_mod

00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 141d
        Flags: fast devsel
        Capabilities: [f0] Secure device <?>
        Kernel driver in use: k10temp
        Kernel modules: k10temp

00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 141e
        Flags: fast devsel
        Kernel driver in use: fam15h_power
        Kernel modules: fam15h_power

00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 141f
        Flags: fast devsel

01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 0c)
        Subsystem: Micro-Star International Co., Ltd. Device 7721
        Flags: bus master, fast devsel, latency 0, IRQ 40
        I/O ports at e000 [size=256]
        Memory at fea00000 (64-bit, non-prefetchable) [size=4K]
        Memory at d0800000 (64-bit, prefetchable) [size=16K]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [70] Express Endpoint, MSI 01
        Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
        Capabilities: [d0] Vital Product Data
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Virtual Channel
        Capabilities: [160] Device Serial Number 01-00-00-00-68-4c-e0-00
        Capabilities: [170] Latency Tolerance Reporting
        Kernel driver in use: r8168
        Kernel modules: r8169, r8168


lscpu
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                4
On-line CPU(s) list:   0-3
Thread(s) per core:    2
Core(s) per socket:    2
Socket(s):             1
NUMA node(s):          1
Vendor ID:             AuthenticAMD
CPU family:            21
Model:                 48
Model name:            AMD A10-7800 Radeon R7, 12 Compute Cores 4C+8G
Stepping:              1
CPU MHz:               1400.000
BogoMIPS:              6999.61
Virtualization:        AMD-V
L1d cache:             16K
L1i cache:             96K
L2 cache:              2048K
NUMA node0 CPU(s):     0-3


--------------010304040509040700060803
Content-Type: application/x-xz;
 name="dmesg.xz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg.xz"

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
--------------010304040509040700060803--
