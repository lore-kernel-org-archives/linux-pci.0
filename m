Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from office2.cesnet.cz ([195.113.144.244]:39528 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeILVQW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Sep 2018 17:16:22 -0400
From: =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [BISECTED] Regression: Solidrun Clearfog Base won't boot since "PCI: =?iso-8859-1?Q?mvebu:_Only_remap_I/O_space_if_configured"?=
Date: Wed, 12 Sep 2018 18:11:01 +0200
MIME-Version: 1.0
Message-ID: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,
since commit ee1604381a371b3ea6aec7d5e43b6e3f5e153854 ("PCI: mvebu: Only=20
remap I/O space if configured"), my board (Solidrun Clearfog Base) won't=20
finish booting with 4.18-rc3 won't boot:

> [    1.741458] Internal error: Oops - undefined instruction: 0 [#1] SMP ARM=

> [    1.748182] CPU: 1 PID: 72 Comm: kworker/1:2 Tainted: G        W        =
 4.19.0-rc3 #1
> [    1.756120] Hardware name: Marvell Armada 380/385 (Device Tree)
> [    1.762063] Workqueue: events deferred_probe_work_func
> [    1.767222] PC is at ioremap_page_range+0x114/0x1a4
> [    1.772117] LR is at mvebu_pcie_probe+0x134/0xa60
> [    1.776832] pc : [<c06e643c>]    lr : [<c03e9d5c>]    psr: a0000013
> [    1.783115] sp : ee30dd88  ip : 000f0000  fp : c0837b38
> [    1.788352] r10: 00000243  r9 : e9200000  r8 : 00000103
> [    1.793590] r7 : ef6f8000  r6 : fee10000  r5 : fee00000  r4 : ef6f8004
> [    1.800133] r3 : ef6f8000  r2 : e8000243  r1 : fee0ffff  r0 : c0004000
> [    1.806678] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment=
 none
> [    1.813832] Control: 10c5387d  Table: 0000404a  DAC: 00000051
> [    1.819592] Process kworker/1:2 (pid: 72, stack limit =3D 0x(ptrval))
> [    1.825874] Stack: (0xee30dd88 to 0xee30e000)
> [    1.830244] dd80:                   fee10000 e9200000 fee0ffff ffe00000 =
c0007fb8 ee33e224
> [    1.838445] dda0: 00000000 ee33e010 00000000 ef575610 ee33e224 00000000 =
c0a30ac4 00000002
> [    1.846646] ddc0: ef9f827c c03e9d5c c0ab6d30 ef9ed434 ee342898 ee342898 =
ee33e1d0 ee33e1dc
> [    1.854848] dde0: ee342898 00000000 c0a03bc8 c07fcabc 00000001 ef575610 =
ef577000 c02a72b4
> [    1.863050] de00: 00000000 ee342898 ef6744d0 ef6744d0 ee342898 ef577000 =
c07fcabc 5d6fd1e4
> [    1.871252] de20: c0a30ac4 ef575610 00000000 c0a30ac4 00000000 00000000 =
c0a30ac4 00000002
> [    1.879454] de40: ef9e40c0 c043dba4 c0ab3144 ef575610 c0ab3150 c043c4e4 =
ef575610 c0a30ac4
> [    1.887656] de60: c043cb2c c0a03bc8 00000001 c0a5cf50 00000000 c043c958 =
ef575610 c0a30ac4
> [    1.895858] de80: ef575610 00000000 ee30ded4 c043cb2c c0a03bc8 00000001 =
c0a5cf50 00000000
> [    1.904059] dea0: ef9e40c0 c043af7c c0a5cf50 ef484d6c ef66d8b8 5d6fd1e4 =
ef575610 ef575610
> [    1.912261] dec0: c0a03bc8 ef575644 c0a371c4 c043c7c0 00000003 ef575610 =
00000001 5d6fd1e4
> [    1.920462] dee0: ef575610 ef575610 c0a373f0 c0a371c4 00000000 c043b160 =
ef575610 c0a371a8
> [    1.928663] df00: c0a371a8 c043bdf8 c0a371e0 ee2f9880 ef9e40c0 ef9e5300 =
00000000 c01388b4
> [    1.936864] df20: ef9e40c0 ef9e40c0 ee30c000 ee2f9880 ef9e40c0 ee2f9894 =
c0a02d00 ef9e40d8
> [    1.945064] df40: ffffe000 00000008 ef9e40c0 c0138e4c ffffe000 c0a5ca32 =
c07d2f68 00000000
> [    1.953265] df60: ffffe000 eee5e0c0 ee2fa4c0 00000000 ee30c000 ee2f9880 =
c0138ba4 ef4d5ea4
> [    1.961466] df80: eee5e0dc c013e448 00000001 ee2fa4c0 c013e2fc 00000000 =
00000000 00000000
> [    1.969668] dfa0: 00000000 00000000 00000000 c01010e8 00000000 00000000 =
00000000 00000000
> [    1.977869] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
> [    1.986069] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 =
00000000 00000000
> [    1.994277] [<c06e643c>] (ioremap_page_range) from [<c03e9d5c>] (mvebu_p=
cie_probe+0x134/0xa60)
> [    2.002917] [<c03e9d5c>] (mvebu_pcie_probe) from [<c043dba4>] (platform_=
drv_probe+0x48/0x98)
> [    2.011382] [<c043dba4>] (platform_drv_probe) from [<c043c4e4>] (really_=
probe+0x1d0/0x2bc)
> [    2.019671] [<c043c4e4>] (really_probe) from [<c043c958>] (driver_probe_=
device+0x60/0x160)
> [    2.027961] [<c043c958>] (driver_probe_device) from [<c043af7c>] (bus_fo=
r_each_drv+0x58/0xb8)
> [    2.036511] [<c043af7c>] (bus_for_each_drv) from [<c043c7c0>] (__device_=
attach+0xd0/0x138)
> [    2.044800] [<c043c7c0>] (__device_attach) from [<c043b160>] (bus_probe_=
device+0x84/0x8c)
> [    2.053002] [<c043b160>] (bus_probe_device) from [<c043bdf8>] (deferred_=
probe_work_func+0x60/0x8c)
> [    2.061991] [<c043bdf8>] (deferred_probe_work_func) from [<c01388b4>] (p=
rocess_one_work+0x218/0x508)
> [    2.071152] [<c01388b4>] (process_one_work) from [<c0138e4c>] (worker_th=
read+0x2a8/0x5c0)
> [    2.079355] [<c0138e4c>] (worker_thread) from [<c013e448>] (kthread+0x14=
c/0x154)
> [    2.086774] [<c013e448>] (kthread) from [<c01010e8>] (ret_from_fork+0x14=
/0x2c)
> [    2.094015] Exception stack(0xee30dfb0 to 0xee30dff8)
> [    2.099079] dfa0:                                     00000000 00000000 =
00000000 00000000
> [    2.107280] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
> [    2.115481] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    2.122115] Code: e2844004 e5972000 e3520000 0affffee (e7f001f2)=20
> [    2.128225] ---[ end trace 7a77412d00a47123 ]---
> [    2.132853] Kernel panic - not syncing: Fatal exception
> [    2.138094] CPU0: stopping
> [    2.140811] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D W         4.=
19.0-rc3 #1
> [    2.148489] Hardware name: Marvell Armada 380/385 (Device Tree)
> [    2.154430] [<c01109fc>] (unwind_backtrace) from [<c010c894>] (show_stac=
k+0x10/0x14)
> [    2.162198] [<c010c894>] (show_stack) from [<c06e29c4>] (dump_stack+0x88=
/0x9c)
> [    2.169443] [<c06e29c4>] (dump_stack) from [<c010f71c>] (handle_IPI+0x38=
c/0x3ac)
> [    2.176863] [<c010f71c>] (handle_IPI) from [<c03b4af4>] (gic_handle_irq+=
0x8c/0x90)
> [    2.184457] [<c03b4af4>] (gic_handle_irq) from [<c0101a0c>] (__irq_svc+0=
x6c/0x90)
> [    2.191960] Exception stack(0xc0a01f18 to 0xc0a01f60)
> [    2.197024] 1f00:                                                       =
00000000 00001db4
> [    2.205226] 1f20: ef9d1398 c0119260 ffffe000 c0a03bf0 c0a03c30 00000001 =
00000000 c0a03bc8
> [    2.213426] 1f40: c0968980 00000000 00000000 c0a01f68 c0108e68 c0108e6c =
60000013 ffffffff
> [    2.221631] [<c0101a0c>] (__irq_svc) from [<c0108e6c>] (arch_cpu_idle+0x=
38/0x3c)
> [    2.229051] [<c0108e6c>] (arch_cpu_idle) from [<c014cf4c>] (do_idle+0x1e=
0/0x210)
> [    2.236469] [<c014cf4c>] (do_idle) from [<c014d218>] (cpu_startup_entry+=
0x18/0x20)
> [    2.244065] [<c014d218>] (cpu_startup_entry) from [<c0900f48>] (start_ke=
rnel+0x42c/0x454)
> [    2.252268] [<c0900f48>] (start_kernel) from [<00000000>] (  (null))
> [    2.258642] Rebooting in 10 seconds..

I cannot easily revert that commit now due to some followup changes. I'll=20
be happy to test patches which attempt to fix this.

The DTS file in use on this board is armada-388-clearfog-base.dts in case=20
it matters (we have some DT add-on patches on top of that, but nothing PCI-=20=

or MBUS-related).

With kind regards,
Jan
