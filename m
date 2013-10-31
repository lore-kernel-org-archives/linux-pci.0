Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:49399 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750882Ab3JaJOA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 31 Oct 2013 05:14:00 -0400
Date: Thu, 31 Oct 2013 10:13:57 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: mvebu - Support a bridge with no IO port window
Message-ID: <20131031101357.5a56e2d0@skate>
In-Reply-To: <1381868182-8544-1-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1381868182-8544-1-git-send-email-jgunthorpe@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Gunthorpe,

On Tue, 15 Oct 2013 14:16:22 -0600, Jason Gunthorpe wrote:
> Make pcie-io-aperture and the IO port MBUS ID in ranges optional.
> If not provided the bridge reports to Linux that IO space mapping is
> not supported and refuses to configure an IO mbus window.
> 
> This allows both complete disable (do not specify pcie-io-aperture) and
> per-port disable (do not specify a IO target ranges entry for the port)
> 
> Most PCIE devices these days do not require IO support to function,
> so having an option to disable it in the driver is useful.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

Sorry for the delay in testing this, I was busy with kernel summit /
ELCE. Unfortunately, this patch still causes problems here: it breaks
usage of I/O region. I have a modified version of the e1000e driver
that makes it access an I/O region, that I have used for testing that
I/O handling is at least minimally working. Without your patch, it
works fine:

e1000e: Intel(R) PRO/1000 Network Driver - 2.3.2-k
e1000e: Copyright(c) 1999 - 2013 Intel Corporation.
PCI: enabling device 0000:00:01.0 (0140 -> 0143)
PCI: enabling device 0000:01:00.0 (0146 -> 0147)
e1000e 0000:01:00.0: ==> e1000e: I/O start 0x10000, len 0x20
e1000e 0000:01:00.0: 1. 0x0 0x0 0xffffffff 0xffffffff
e1000e 0000:01:00.0: 2. 0x38 0x8100 0xffffffff 0xffffffff

(the last three messages are the one indicating that the I/O region is
working).

With your patch, it completely blows up when accessing the region:

e1000e: Intel(R) PRO/1000 Network Driver - 2.3.2-k
e1000e: Copyright(c) 1999 - 2013 Intel Corporation.
PCI: enabling device 0000:00:01.0 (0140 -> 0143)
PCI: enabling device 0000:01:00.0 (0146 -> 0147)
e1000e 0000:01:00.0: ==> e1000e: I/O start 0x10000, len 0x20
Unable to handle kernel paging request at virtual address fee10000
pgd = ee9a0000
[fee10000] *pgd=00000000
Internal error: Oops: 15 [#1] SMP ARM
Modules linked in:
CPU: 3 PID: 1 Comm: swapper/0 Not tainted 3.12.0-rc7-00005-g1fa02be #166
task: ef049c40 ti: ef05c000 task.ti: ef05c000
PC is at e1000_probe+0x108/0xd54
LR is at e1000_probe+0xfc/0xd54
pc : [<c0239f54>]    lr : [<c0239f48>]    psr: 60000013
sp : ef05de30  ip : 00000000  fp : 00000000
r10: 00010000  r9 : ef05c000  r8 : fee10000
r7 : 00000001  r6 : c04037a8  r5 : ef2dac68  r4 : ef2dac00
r3 : 000003cd  r2 : c07f6570  r1 : 20000093  r0 : 0000003c
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7d  Table: 2e9a006a  DAC: 00000015
Process swapper/0 (pid: 1, stack limit = 0xef05c240)
Stack: (0xef05de30 to 0xef05e000)
de20:                                     ef049c40 00000000 eeb5ad08 ef2d7508
de40: ef050000 c00f8890 ef2dac68 c003cae8 00000000 ef2dac68 c0809e0c ef2dac00
de60: 00000000 c0809dd8 ef05c000 c0516458 00000000 c01821d4 c083c148 ef2dac68
de80: 00000000 c0809e0c c052bf10 c01b8fc0 00000000 ef2dac68 c0809e0c ef2dac9c
dea0: 00000000 c01b9168 00000000 c0809e0c c01b90dc c01b7620 ef09b11c ef2d59f4
dec0: c0809e0c eeb587c0 c07fe8c8 c01b86c8 c0809e54 ef05deec c0809e0c 00000006
dee0: c0538528 c0818700 c052bf10 c01b97a0 c0809dd8 c0540198 00000006 c0008878
df00: 00000099 c2058488 c04961f4 00000081 00000000 c04f2f14 00000063 ef05df30
df20: c0035e14 c0035e38 00000113 ffffffff c20584c8 c03e8428 00000099 c0036000
df40: c04f2704 00000006 c20584f1 00000006 c07f5aa0 c0540198 00000006 c0538528
df60: c0818700 00000099 c0538534 c0516458 00000000 c0516b90 00000006 00000006
df80: c0516458 000000a2 00000000 c03ccc4c 00000000 00000000 00000000 00000000
dfa0: 00000000 c03ccc54 00000000 c000e3f8 00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 08d8a360 34d44910
[<c0239f54>] (e1000_probe+0x108/0xd54) from [<c01821d4>] (pci_device_probe+0x64/0x88)
[<c01821d4>] (pci_device_probe+0x64/0x88) from [<c01b8fc0>] (driver_probe_device+0xf4/0x210)
[<c01b8fc0>] (driver_probe_device+0xf4/0x210) from [<c01b9168>] (__driver_attach+0x8c/0x90)
[<c01b9168>] (__driver_attach+0x8c/0x90) from [<c01b7620>] (bus_for_each_dev+0x54/0x88)
[<c01b7620>] (bus_for_each_dev+0x54/0x88) from [<c01b86c8>] (bus_add_driver+0xd4/0x258)
[<c01b86c8>] (bus_add_driver+0xd4/0x258) from [<c01b97a0>] (driver_register+0x78/0xf4)
[<c01b97a0>] (driver_register+0x78/0xf4) from [<c0008878>] (do_one_initcall+0xe4/0x140)
[<c0008878>] (do_one_initcall+0xe4/0x140) from [<c0516b90>] (kernel_init_freeable+0xfc/0x1c8)
[<c0516b90>] (kernel_init_freeable+0xfc/0x1c8) from [<c03ccc54>] (kernel_init+0x8/0xe4)
[<c03ccc54>] (kernel_init+0x8/0xe4) from [<c000e3f8>] (ret_from_fork+0x14/0x3c)
Code: ebfdef04 e594a198 e7f3805a e2488612 (e5982000) 
---[ end trace 0b6062d8d91eb05b ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

CPU2: stopping
CPU: 2 PID: 0 Comm: swapper/2 Tainted: G      D      3.12.0-rc7-00005-g1fa02be #166
[<c001580c>] (unwind_backtrace+0x0/0xf8) from [<c0011790>] (show_stack+0x10/0x14)
[<c0011790>] (show_stack+0x10/0x14) from [<c03d082c>] (dump_stack+0x70/0x8c)
[<c03d082c>] (dump_stack+0x70/0x8c) from [<c001418c>] (handle_IPI+0xfc/0x130)
[<c001418c>] (handle_IPI+0xfc/0x130) from [<c0008584>] (armada_370_xp_handle_irq+0x84/0xac)
[<c0008584>] (armada_370_xp_handle_irq+0x84/0xac) from [<c0012240>] (__irq_svc+0x40/0x50)
Exception stack(0xef079fa0 to 0xef079fe8)
9fa0: c206b7d8 00000000 000005ca 000005ca ef078000 c08185ec c07f0460 c08185ec
9fc0: ef078000 c03d7764 00000001 ef078000 00000510 ef079fe8 c000f570 c00510b0
9fe0: 60000113 ffffffff
[<c0012240>] (__irq_svc+0x40/0x50) from [<c00510b0>] (cpu_startup_entry+0x54/0x128)
[<c00510b0>] (cpu_startup_entry+0x54/0x128) from [<00008644>] (0x8644)
CPU1: stopping
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D      3.12.0-rc7-00005-g1fa02be #166
[<c001580c>] (unwind_backtrace+0x0/0xf8) from [<c0011790>] (show_stack+0x10/0x14)
[<c0011790>] (show_stack+0x10/0x14) from [<c03d082c>] (dump_stack+0x70/0x8c)
[<c03d082c>] (dump_stack+0x70/0x8c) from [<c001418c>] (handle_IPI+0xfc/0x130)
[<c001418c>] (handle_IPI+0xfc/0x130) from [<c0008584>] (armada_370_xp_handle_irq+0x84/0xac)
[<c0008584>] (armada_370_xp_handle_irq+0x84/0xac) from [<c0012240>] (__irq_svc+0x40/0x50)
Exception stack(0xef077fa0 to 0xef077fe8)
7fa0: c20637d8 00000000 000012ac 000012ac ef076000 c08185ec c07f0460 c08185ec
7fc0: ef076000 c03d7764 00000001 ef076000 00000510 ef077fe8 c000f570 c00510b0
7fe0: 60000113 ffffffff
[<c0012240>] (__irq_svc+0x40/0x50) from [<c00510b0>] (cpu_startup_entry+0x54/0x128)
[<c00510b0>] (cpu_startup_entry+0x54/0x128) from [<00008644>] (0x8644)
CPU0: stopping
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D      3.12.0-rc7-00005-g1fa02be #166
[<c001580c>] (unwind_backtrace+0x0/0xf8) from [<c0011790>] (show_stack+0x10/0x14)
[<c0011790>] (show_stack+0x10/0x14) from [<c03d082c>] (dump_stack+0x70/0x8c)
[<c03d082c>] (dump_stack+0x70/0x8c) from [<c001418c>] (handle_IPI+0xfc/0x130)
[<c001418c>] (handle_IPI+0xfc/0x130) from [<c0008584>] (armada_370_xp_handle_irq+0x84/0xac)
[<c0008584>] (armada_370_xp_handle_irq+0x84/0xac) from [<c0012240>] (__irq_svc+0x40/0x50)
Exception stack(0xc07e9f70 to 0xc07e9fb8)
9f60:                                     c205b7d8 00000000 00000d2c 00000d2c
9f80: c07e8000 c08185ec c07f0460 c08185ec c07e8000 c03d7764 00000001 c07e8000
9fa0: 00000510 c07e9fb8 c000f570 c00510b0 60000113 ffffffff
[<c0012240>] (__irq_svc+0x40/0x50) from [<c00510b0>] (cpu_startup_entry+0x54/0x128)
[<c00510b0>] (cpu_startup_entry+0x54/0x128) from [<c0516a40>] (start_kernel+0x2a0/0x2f4)
[<c0516a40>] (start_kernel+0x2a0/0x2f4) from [<00008074>] (0x8074)

After debugging, it turns out that the following change is the problem:

-	if (port->bridge.iolimit < port->bridge.iobase ||
+	if (port->bridge.iolimit <= port->bridge.iobase ||


with this change, the mvebu_pcie_handle_iobase_change() always
considers the I/O region settings as "invalid", and therefore the I/O
window is never created and the pci_ioremap_io() function is never
called. Reverting this change makes your patch works fine for me.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
