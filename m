Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57405 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758041AbcBDPXN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Feb 2016 10:23:13 -0500
Date: Thu, 4 Feb 2016 09:23:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andreas Hartmann <andihartmann@01019freenet.de>
Cc: linux-pci@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux-foundation.org
Subject: Re: AMD-Vi: Unable to write to IOMMU perf counter.
Message-ID: <20160204152309.GA27351@localhost>
References: <56B365E0.4020100@01019freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56B365E0.4020100@01019freenet.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Joerg, iommu list]

Hi Andreas,

On Thu, Feb 04, 2016 at 03:53:20PM +0100, Andreas Hartmann wrote:
> Hello!
> 
> The following happens with Linux 4.4.1 during boot on an MSI A78M-E35
> board. Additionally, I attached the complete dmesg.

Thanks a lot for the report!  I cc'd some folks who know more about
this than I do.  Is this a regression?

> [    1.228987] ------------[ cut here ]------------
> [    1.228992] WARNING: CPU: 0 PID: 1 at
> ../drivers/iommu/amd_iommu_init.c:2301
> amd_iommu_pc_get_set_reg_val+0xa8/0xe0()
> [    1.228993] Modules linked in:
> [    1.228997] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.4.1-14-default #1
> [    1.228998] Hardware name: ARLT Computer-Produkte GmbH ARLT Mr.
> Whisper Ultimate II R1 (3080527A-U140-V30.5)/A78M-E35 (MS-7721), BIOS
> V30.5 10/20/2014
> [    1.229000]  ffffffff819a7f28 ffff88017ed7bd30 ffffffff812f7c89
> 0000000000000000
> [    1.229002]  ffff88017ed7bd68 ffffffff81066ae6 ffff88017ed4a000
> 0000000000000040
> [    1.229004]  0000000000000000 ffffffff81d3424e 0000000000000007
> ffff88017ed7bd78
> [    1.229006] Call Trace:
> [    1.229015]  [<ffffffff81009075>] try_stack_unwind+0x175/0x190
> [    1.229021]  [<ffffffff81007fa4>] dump_trace+0x64/0x3b0
> [    1.229024]  [<ffffffff810090dd>] show_trace_log_lvl+0x4d/0x60
> [    1.229026]  [<ffffffff81008402>] show_stack_log_lvl+0x112/0x180
> [    1.229029]  [<ffffffff81009135>] show_stack+0x25/0x50
> [    1.229032]  [<ffffffff812f7c89>] dump_stack+0x4b/0x72
> [    1.229036]  [<ffffffff81066ae6>] warn_slowpath_common+0x86/0xc0
> [    1.229039]  [<ffffffff81066bda>] warn_slowpath_null+0x1a/0x20
> [    1.229041]  [<ffffffff8140acf8>] amd_iommu_pc_get_set_reg_val+0xa8/0xe0
> [    1.229045]  [<ffffffff81d6f60d>] iommu_go_to_state+0x501/0x13c4
> [    1.229048]  [<ffffffff81d70543>] amd_iommu_init+0x13/0x253
> [    1.229051]  [<ffffffff81d34260>] pci_iommu_init+0x12/0x3c
> [    1.229053]  [<ffffffff81000403>] do_one_initcall+0xd3/0x1f0
> [    1.229057]  [<ffffffff81d2f079>] kernel_init_freeable+0x16d/0x1fa
> [    1.229060]  [<ffffffff815fb2ae>] kernel_init+0xe/0xe0
> [    1.229064]  [<ffffffff8160736f>] ret_from_fork+0x3f/0x70
> [    1.231707] DWARF2 unwinder stuck at ret_from_fork+0x3f/0x70
> 
> [    1.231709] Leftover inexact backtrace:
> 
> [    1.231713]  [<ffffffff815fb2a0>] ? rest_init+0x90/0x90
> [    1.231718] ---[ end trace 100b826816268f19 ]---
> [    1.231719] AMD-Vi: Unable to write to IOMMU perf counter.
> 
> 
> What does this mean?
> 
> Thanks,
> regards,
> Andreas Hartmann
> 
> 
> 
> lspci -v
> 00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1422
>         Subsystem: Micro-Star International Co., Ltd. Device 7721
>         Flags: bus master, fast devsel, latency 0
> 
> 00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Device 1423
>         Subsystem: Micro-Star International Co., Ltd. Device 7721
>         Flags: bus master, fast devsel, latency 0, IRQ 24
>         Capabilities: [40] Secure device <?>
>         Capabilities: [54] MSI: Enable+ Count=1/4 Maskable- 64bit+
>         Capabilities: [64] HyperTransport: MSI Mapping Enable+ Fixed+
> 
> 00:01.0 VGA compatible controller: Advanced Micro Devices, Inc.
> [AMD/ATI] Kaveri (prog-if 00 [VGA controller])
>         Subsystem: Micro-Star International Co., Ltd. Device 7721
>         Flags: bus master, fast devsel, latency 0, IRQ 34
>         Memory at c0000000 (64-bit, prefetchable) [size=256M]
>         Memory at d0000000 (64-bit, prefetchable) [size=8M]
>         I/O ports at f000 [size=256]
>         Memory at feb00000 (32-bit, non-prefetchable) [size=256K]
>         Expansion ROM at feb40000 [disabled] [size=128K]
>         Capabilities: [48] Vendor Specific Information: Len=08 <?>
>         Capabilities: [50] Power Management version 3
>         Capabilities: [58] Express Root Complex Integrated Endpoint, MSI 00
>         Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1
> Len=010 <?>
>         Capabilities: [270] #19
>         Capabilities: [2b0] Address Translation Service (ATS)
>         Capabilities: [2c0] #13
>         Capabilities: [2d0] #1b
>         Kernel driver in use: radeon
>         Kernel modules: radeon, amdgpu
> 
> 00:01.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Device 1308
>         Subsystem: Micro-Star International Co., Ltd. Device 7721
>         Flags: bus master, fast devsel, latency 0, IRQ 46
>         Memory at feb64000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: [48] Vendor Specific Information: Len=08 <?>
>         Capabilities: [50] Power Management version 3
>         Capabilities: [58] Express Root Complex Integrated Endpoint, MSI 00
>         Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1
> Len=010 <?>
>         Kernel driver in use: snd_hda_intel
>         Kernel modules: snd_hda_intel
> 
> 00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1424
>         Flags: fast devsel
> 
> 00:03.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1424
>         Flags: fast devsel
> 
> 00:03.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 1426
> (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>         I/O behind bridge: 0000e000-0000efff
>         Memory behind bridge: fea00000-feafffff
>         Prefetchable memory behind bridge: 00000000d0800000-00000000d08fffff
>         Capabilities: [50] Power Management version 3
>         Capabilities: [58] Express Root Port (Slot+), MSI 00
>         Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Capabilities: [b0] Subsystem: Micro-Star International Co., Ltd.
> Device 7721
>         Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
>         Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1
> Len=010 <?>
>         Capabilities: [270] #19
>         Kernel driver in use: pcieport
>         Kernel modules: shpchp
> 
> 00:04.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1424
>         Flags: fast devsel
> 
> 00:10.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB XHCI
> Controller (rev 09) (prog-if 30 [XHCI])
>         Subsystem: Micro-Star International Co., Ltd. Device 7721
>         Flags: bus master, fast devsel, latency 0
>         Memory at feb6a000 (64-bit, non-prefetchable) [size=8K]
>         Capabilities: [50] Power Management version 3
>         Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
>         Capabilities: [90] MSI-X: Enable+ Count=8 Masked-
>         Capabilities: [a0] Express Root Complex Integrated Endpoint, MSI 00
>         Capabilities: [100] Latency Tolerance Reporting
>         Kernel driver in use: xhci_hcd
>         Kernel modules: xhci_pci
> 
> 00:10.1 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB XHCI
> Controller (rev 09) (prog-if 30 [XHCI])
>         Subsystem: Micro-Star International Co., Ltd. Device 7721
>         Flags: bus master, fast devsel, latency 0
>         Memory at feb68000 (64-bit, non-prefetchable) [size=8K]
>         Capabilities: [50] Power Management version 3
>         Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
>         Capabilities: [90] MSI-X: Enable+ Count=8 Masked-
>         Capabilities: [a0] Express Root Complex Integrated Endpoint, MSI 00
>         Kernel driver in use: xhci_hcd
>         Kernel modules: xhci_pci
> 
> 00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA
> Controller [AHCI mode] (rev 40) (prog-if 01 [AHCI 1.0])
>         Subsystem: Micro-Star International Co., Ltd. Device 7721
>         Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 25
>         I/O ports at f140 [size=8]
>         I/O ports at f130 [size=4]
>         I/O ports at f120 [size=8]
>         I/O ports at f110 [size=4]
>         I/O ports at f100 [size=16]
>         Memory at feb71000 (32-bit, non-prefetchable) [size=2K]
>         Capabilities: [50] MSI: Enable+ Count=8/8 Maskable- 64bit+
>         Capabilities: [70] SATA HBA v1.0
>         Kernel driver in use: ahci
> 
> 00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB OHCI
> Controller (rev 11) (prog-if 10 [OHCI])
>         Subsystem: Micro-Star International Co., Ltd. Device 7721
>         Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 18
>         Memory at feb70000 (32-bit, non-prefetchable) [size=4K]
>         Kernel driver in use: ohci-pci
>         Kernel modules: ohci_pci
> 
> 00:12.2 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB EHCI
> Controller (rev 11) (prog-if 20 [EHCI])
>         Subsystem: Micro-Star International Co., Ltd. Device 7721
>         Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 17
>         Memory at feb6f000 (32-bit, non-prefetchable) [size=256]
>         Capabilities: [c0] Power Management version 2
>         Capabilities: [e4] Debug port: BAR=1 offset=00e0
>         Kernel driver in use: ehci-pci
>         Kernel modules: ehci_pci
> 
> 00:13.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB OHCI
> Controller (rev 11) (prog-if 10 [OHCI])
>         Subsystem: Micro-Star International Co., Ltd. Device 7721
>         Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 18
>         Memory at feb6e000 (32-bit, non-prefetchable) [size=4K]
>         Kernel driver in use: ohci-pci
>         Kernel modules: ohci_pci
> 
> 00:13.2 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB EHCI
> Controller (rev 11) (prog-if 20 [EHCI])
>         Subsystem: Micro-Star International Co., Ltd. Device 7721
>         Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 17
>         Memory at feb6d000 (32-bit, non-prefetchable) [size=256]
>         Capabilities: [c0] Power Management version 2
>         Capabilities: [e4] Debug port: BAR=1 offset=00e0
>         Kernel driver in use: ehci-pci
>         Kernel modules: ehci_pci
> 
> 00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller
> (rev 16)
>         Subsystem: Micro-Star International Co., Ltd. Device 7721
>         Flags: 66MHz, medium devsel
>         Kernel driver in use: piix4_smbus
>         Kernel modules: i2c_piix4
> 
> 00:14.2 Audio device: Advanced Micro Devices, Inc. [AMD] FCH Azalia
> Controller (rev 01)
>         Subsystem: Micro-Star International Co., Ltd. Device d721
>         Flags: bus master, slow devsel, latency 32, IRQ 16
>         Memory at feb60000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: [50] Power Management version 2
>         Kernel driver in use: snd_hda_intel
>         Kernel modules: snd_hda_intel
> 
> 00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge
> (rev 11)
>         Subsystem: Micro-Star International Co., Ltd. Device 7721
>         Flags: bus master, 66MHz, medium devsel, latency 0
> 
> 00:14.4 PCI bridge: Advanced Micro Devices, Inc. [AMD] FCH PCI Bridge
> (rev 40) (prog-if 01 [Subtractive decode])
>         Flags: bus master, VGA palette snoop, 66MHz, medium devsel,
> latency 64
>         Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
> 
> 00:14.5 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB OHCI
> Controller (rev 11) (prog-if 10 [OHCI])
>         Subsystem: Micro-Star International Co., Ltd. Device 7721
>         Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 18
>         Memory at feb6c000 (32-bit, non-prefetchable) [size=4K]
>         Kernel driver in use: ohci-pci
>         Kernel modules: ohci_pci
> 
> 00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 141a
>         Flags: fast devsel
> 
> 00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 141b
>         Flags: fast devsel
> 
> 00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 141c
>         Flags: fast devsel
>         Kernel modules: amd64_edac_mod
> 
> 00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 141d
>         Flags: fast devsel
>         Capabilities: [f0] Secure device <?>
>         Kernel driver in use: k10temp
>         Kernel modules: k10temp
> 
> 00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 141e
>         Flags: fast devsel
>         Kernel driver in use: fam15h_power
>         Kernel modules: fam15h_power
> 
> 00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 141f
>         Flags: fast devsel
> 
> 01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 0c)
>         Subsystem: Micro-Star International Co., Ltd. Device 7721
>         Flags: bus master, fast devsel, latency 0, IRQ 40
>         I/O ports at e000 [size=256]
>         Memory at fea00000 (64-bit, non-prefetchable) [size=4K]
>         Memory at d0800000 (64-bit, prefetchable) [size=16K]
>         Capabilities: [40] Power Management version 3
>         Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Capabilities: [70] Express Endpoint, MSI 01
>         Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
>         Capabilities: [d0] Vital Product Data
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [140] Virtual Channel
>         Capabilities: [160] Device Serial Number 01-00-00-00-68-4c-e0-00
>         Capabilities: [170] Latency Tolerance Reporting
>         Kernel driver in use: r8168
>         Kernel modules: r8169, r8168
> 
> 
> lscpu
> Architecture:          x86_64
> CPU op-mode(s):        32-bit, 64-bit
> Byte Order:            Little Endian
> CPU(s):                4
> On-line CPU(s) list:   0-3
> Thread(s) per core:    2
> Core(s) per socket:    2
> Socket(s):             1
> NUMA node(s):          1
> Vendor ID:             AuthenticAMD
> CPU family:            21
> Model:                 48
> Model name:            AMD A10-7800 Radeon R7, 12 Compute Cores 4C+8G
> Stepping:              1
> CPU MHz:               1400.000
> BogoMIPS:              6999.61
> Virtualization:        AMD-V
> L1d cache:             16K
> L1i cache:             96K
> L2 cache:              2048K
> NUMA node0 CPU(s):     0-3
> 


