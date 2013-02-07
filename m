Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:55642 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755579Ab3BGKZX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Feb 2013 05:25:23 -0500
Date: Thu, 7 Feb 2013 11:24:59 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130207112459.5f382ad4@skate>
In-Reply-To: <20130129092006.GA16377@avionic-0098.mockup.avionic-design.de>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
	<5106F9F9.3010905@wwwdotorg.org>
	<20130129094143.1aad9377@skate>
	<20130129092006.GA16377@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Thierry Reding,

On Tue, 29 Jan 2013 10:20:06 +0100, Thierry Reding wrote:

> > I didn't test recently, but with my first version of the patch set,
> > having an initialization as late as module_init() was too late. Some
> > PCI fixup code was being executed *before* we get the opportunity of
> > initializing the PCI driver, and it was crashing the kernel. I can
> > provide more details if you want.
> 
> Does this patch perhaps fix this crash?
> 
> 	http://patchwork.ozlabs.org/patch/210870/

I investigated a bit more, and managed to reproduce my crash even with
your patch applied. And indeed, my crash is really unrelated to the
pcibios function disappearing. Here is the kernel panic (and a short
analysis afterwards) :

Unhandled fault: external abort on non-linefetch (0x1008) at 0xe0910010
Internal error: : 1008 [#1] SMP ARM
Modules linked in:
CPU: 0    Not tainted  (3.8.0-rc5-00029-g80e55fd-dirty #1303)
PC is at quirk_usb_handoff_xhci+0x5c/0x284
LR is at ioremap_pte_range+0x84/0xdc
pc : [<c022717c>]    lr : [<c0150944>]    psr: a0000013
sp : df82bce8  ip : df81c000  fp : c0e09dac
r10: 00008000  r9 : 00000000  r8 : de935000
r7 : e0910000  r6 : c03f0ce0  r5 : de935000  r4 : de935000
r3 : 01c801c8  r2 : 00000000  r1 : 42007e13  r0 : e0910000
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 1e95c019  DAC: 00000015
Process swapper/0 (pid: 1, stack limit = 0xdf82a238)
Stack: (0xdf82bce8 to 0xdf82c000)
bce0:                   de935060 c01702f4 de935000 de935000 de935000 c03f0ce0
bd00: c0e220dc c02277f8 de935060 c02277d4 c03f0ce0 c0227858 c03f0ce0 c0178d98
bd20: c01a855c c0312dd0 00000000 00000000 de936f6c c0312ed0 c0e0f7cc de935000
bd40: de936c14 de936c00 df82bde8 00000001 de916668 c016a958 00000000 de935000
bd60: de936c14 c016ab5c de935800 de910014 de936c00 c016abcc 00000000 00000001
bd80: de910000 c016d234 de916668 de9166d0 de916640 00000000 df82be14 c017a93c
bda0: de916668 df82be14 df82bde8 c0012ef8 f3cec23f c0251c90 c0019da0 df805340
bdc0: f3cec23f df82bde8 c0e426e8 df82be14 df802b00 de912a90 00000060 df89e400
bde0: 00000002 c00131dc df82bde8 df82bde8 c0e454f0 00000000 de9166d0 de912af0
be00: df802b00 c0442010 df89e410 00000000 00000000 c0e0fcac 00000001 df82be54
be20: c04420b4 c017a90c 00000000 00000000 00000000 c0442054 c1000000 c8ffffff
be40: c124b5f0 00000200 00000000 00000000 00000000 de9166d0 df89e410 c0e43e48
be60: c0e0fc6c df89e410 00000000 c0e0fc6c c04563d4 c017a7c4 00000000 c01a8c24
be80: c01a8c0c c01a78e8 df89e410 c0e0fc6c df89e444 00000000 c043023c c01a7bd8
bea0: c0e0fc6c 00000000 c01a7b4c c01a632c df8067d8 df85a474 c0e0fc6c c0e170c8
bec0: de916740 c01a7228 c03d28bc c0e0fc6c c0e0fc6c df82a000 c0e220c0 00000000
bee0: c043023c c01a80d8 00000000 c0e0fc58 df82a000 c0e220c0 00000000 c043023c
bf00: c017a7c4 c01a8e1c c044fc80 df82a000 c0e220c0 c00086d4 c040e208 00000006
bf20: 0000007b c017a7c4 0000007b 00000006 00000006 c043023c c124bb15 00000000
bf40: c0e08194 c044fc80 00000006 c044fc60 c0e220c0 c043023c c04563d4 0000007b
bf60: 00000000 c04308b0 00000006 00000006 c043023c 00000000 c0456128 c0456128
bf80: 00000000 00000000 00000000 00000000 00000000 c0430958 00000000 00000000
bfa0: c03156c8 c03156d0 00000000 c000dfd8 00000000 00000000 00000000 00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 2254c9ef c6885425
[<c022717c>] (quirk_usb_handoff_xhci+0x5c/0x284) from [<c02277d4>] (quirk_usb_early_handoff.part.1+0xc0/0xe4)
[<c02277d4>] (quirk_usb_early_handoff.part.1+0xc0/0xe4) from [<c0178d98>] (pci_do_fixups+0xc4/0x17c)
[<c0178d98>] (pci_do_fixups+0xc4/0x17c) from [<c016a958>] (pci_bus_add_device+0x14/0x60)
[<c016a958>] (pci_bus_add_device+0x14/0x60) from [<c016ab5c>] (pci_bus_add_devices+0x44/0x128)
[<c016ab5c>] (pci_bus_add_devices+0x44/0x128) from [<c016abcc>] (pci_bus_add_devices+0xb4/0x128)
[<c016abcc>] (pci_bus_add_devices+0xb4/0x128) from [<c016d234>] (pci_scan_root_bus+0x7c/0xcc)
[<c016d234>] (pci_scan_root_bus+0x7c/0xcc) from [<c017a93c>] (mvebu_pcie_scan_bus+0x30/0x3c)
[<c017a93c>] (mvebu_pcie_scan_bus+0x30/0x3c) from [<c0012ef8>] (pcibios_init_hw+0x5c/0x15c)
[<c0012ef8>] (pcibios_init_hw+0x5c/0x15c) from [<c00131dc>] (pci_common_init+0x44/0xc4)
[<c00131dc>] (pci_common_init+0x44/0xc4) from [<c0442010>] (mvebu_pcie_probe+0x360/0x3a4)
[<c0442010>] (mvebu_pcie_probe+0x360/0x3a4) from [<c01a8c24>] (platform_drv_probe+0x18/0x1c)
[<c01a8c24>] (platform_drv_probe+0x18/0x1c) from [<c01a78e8>] (really_probe+0x60/0x1e0)
[<c01a78e8>] (really_probe+0x60/0x1e0) from [<c01a7bd8>] (__driver_attach+0x8c/0x90)
[<c01a7bd8>] (__driver_attach+0x8c/0x90) from [<c01a632c>] (bus_for_each_dev+0x50/0x7c)
[<c01a632c>] (bus_for_each_dev+0x50/0x7c) from [<c01a7228>] (bus_add_driver+0x168/0x22c)
[<c01a7228>] (bus_add_driver+0x168/0x22c) from [<c01a80d8>] (driver_register+0x78/0x144)
[<c01a80d8>] (driver_register+0x78/0x144) from [<c01a8e1c>] (platform_driver_probe+0x18/0xac)
[<c01a8e1c>] (platform_driver_probe+0x18/0xac) from [<c00086d4>] (do_one_initcall+0x34/0x174)
[<c00086d4>] (do_one_initcall+0x34/0x174) from [<c04308b0>] (do_basic_setup+0x90/0xc4)
[<c04308b0>] (do_basic_setup+0x90/0xc4) from [<c0430958>] (kernel_init_freeable+0x74/0x10c)
[<c0430958>] (kernel_init_freeable+0x74/0x10c) from [<c03156d0>] (kernel_init+0x8/0xe4)
[<c03156d0>] (kernel_init+0x8/0xe4) from [<c000dfd8>] (ret_from_fork+0x14/0x3c)
Code: e3a02000 ebf7c092 e2507000 0afffff7 (e5973010) 
---[ end trace 834a6081748c17ef ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Basically, the problem comes from the fact that the USB XHCI code has
an early PCI fixup, that ioremap() the PCI device memory BAR and makes
access to it. Unfortunately, this fixup is called during
pcibios_init_hw(), at a point where the Marvell PCIe driver haven't yet
had a chance to set up the address decoding windows (the Linux PCI core
hasn't even configured the emulated PCI-to-PCI bridges, so I don't know
where the PCI devices will sit).

Due to this, the first access to the PCI device memory by this early
fixup triggers an exception, and the kernel panics.

For some reason, moving the Marvell PCIe driver initialization at the
subsys_initcall() level works around the problem, but I'm not sure why,
since it is actually the driver initialization that ends up calling the
PCI fixup code. But clearly, with the PCIe initialization done at
subsys_initcall() time, the PCIe is initialized, and then a lot later
the PCI fixup is executed.

Ideas welcome.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
