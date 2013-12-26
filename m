Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:57151 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753258Ab3LZPFh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Dec 2013 10:05:37 -0500
Date: Thu, 26 Dec 2013 16:05:34 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Gregory =?UTF-8?B?Q2zDqW1lbnQ=?=
	<gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Issue with the emulated PCI bridge implementation
Message-ID: <20131226160534.36cc4203@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Jason,

I am contacting you regarding a design issue I have with the emulated
PCI bridge implementation that we have written to support the Marvell
PCI controllers.

I'm sure you remember that we emulate a bridge, and trap the writes to
this bridge to create/remove MBus windows as needed. But for I/O
regions, we also use these writes to do the appropriate
pci_ioremap_io() calls.

However, it turns how that the writes to the bridge registers are done
with IRQ disabled, and that pci_ioremap_io() can sleep (since it
essentially does an ioremap). Therefore, with the appropriate kernel
hacking options enabled, you get the following warning at boot time:

pci 0000:00:09.0: PCI bridge to [bus 02]
pci 0000:00:09.0:   bridge window [io  0x10000-0x10fff]
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at /home/thomas/projets/linux-2.6/kernel/locking/lockdep.c:2740 lockdep_trace_alloc+0x11c/0x120()
DEBUG_LOCKS_WARN_ON(irqs_disabled_flags(flags))
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.13.0-rc5-00002-gf197217 #450
[<c0014a9c>] (unwind_backtrace+0x0/0xf4) from [<c0011348>] (show_stack+0x10/0x14)
[<c0011348>] (show_stack+0x10/0x14) from [<c03b5318>] (dump_stack+0x98/0xb8)
[<c03b5318>] (dump_stack+0x98/0xb8) from [<c001cd94>] (warn_slowpath_common+0x6c/0x88)
[<c001cd94>] (warn_slowpath_common+0x6c/0x88) from [<c001cde0>] (warn_slowpath_fmt+0x30/0x40)
[<c001cde0>] (warn_slowpath_fmt+0x30/0x40) from [<c00533cc>] (lockdep_trace_alloc+0x11c/0x120)
[<c00533cc>] (lockdep_trace_alloc+0x11c/0x120) from [<c00885c8>] (__alloc_pages_nodemask+0x84/0x734)
[<c00885c8>] (__alloc_pages_nodemask+0x84/0x734) from [<c0088c88>] (__get_free_pages+0x10/0x24)
[<c0088c88>] (__get_free_pages+0x10/0x24) from [<c009dd14>] (__pte_alloc_kernel+0x18/0xb8)
[<c009dd14>] (__pte_alloc_kernel+0x18/0xb8) from [<c017b718>] (ioremap_page_range+0x194/0x1a8)
[<c017b718>] (ioremap_page_range+0x194/0x1a8) from [<c01abf68>] (mvebu_pcie_wr_conf+0x2c0/0x434)
[<c01abf68>] (mvebu_pcie_wr_conf+0x2c0/0x434) from [<c019b4dc>] (pci_bus_write_config_dword+0x5c/0x7c)
[<c019b4dc>] (pci_bus_write_config_dword+0x5c/0x7c) from [<c01a6b60>] (__pci_setup_bridge+0x1c0/0x250)
[<c01a6b60>] (__pci_setup_bridge+0x1c0/0x250) from [<c03b23c0>] (__pci_bus_assign_resources+0xfc/0x100)
[<c03b23c0>] (__pci_bus_assign_resources+0xfc/0x100) from [<c00131d0>] (pci_common_init_dev+0x23c/0x2d4)
[<c00131d0>] (pci_common_init_dev+0x23c/0x2d4) from [<c01ac4f4>] (mvebu_pcie_probe+0x3b4/0x61c)
[<c01ac4f4>] (mvebu_pcie_probe+0x3b4/0x61c) from [<c01dddc4>] (platform_drv_probe+0x18/0x48)
[<c01dddc4>] (platform_drv_probe+0x18/0x48) from [<c01dc564>] (really_probe+0x80/0x218)
[<c01dc564>] (really_probe+0x80/0x218) from [<c01dc7f0>] (__driver_attach+0xa0/0xa4)
[<c01dc7f0>] (__driver_attach+0xa0/0xa4) from [<c01dac34>] (bus_for_each_dev+0x60/0x94)
[<c01dac34>] (bus_for_each_dev+0x60/0x94) from [<c01dbdf8>] (bus_add_driver+0x148/0x1f0)
[<c01dbdf8>] (bus_add_driver+0x148/0x1f0) from [<c01dce28>] (driver_register+0x78/0xf8)
[<c01dce28>] (driver_register+0x78/0xf8) from [<c00088c8>] (do_one_initcall+0xf8/0x148)
[<c00088c8>] (do_one_initcall+0xf8/0x148) from [<c04fac48>] (kernel_init_freeable+0x13c/0x1dc)
[<c04fac48>] (kernel_init_freeable+0x13c/0x1dc) from [<c03b0924>] (kernel_init+0x8/0x120)
[<c03b0924>] (kernel_init+0x8/0x120) from [<c000e268>] (ret_from_fork+0x14/0x2c)
---[ end trace eebd66da7489756f ]---
pci 0000:00:09.0:   bridge window [mem 0xe0000000-0xe00fffff]

Do you have any idea to solve this?

For now, my only idea would be to do the pci_ioremap_io()
unconditionally for all PCIe interfaces when the PCIe host controller
driver is initialized. We know the maximum size of the I/O region for
each PCIe interface, and this size is small (64 KB). We can keep the
creation of the corresponding MBus window as something dynamic done by
the bridge.

Do you think that's a reasonable solution? Do you see other
possibilities?

Thanks!

Thomas Petazzoni
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
