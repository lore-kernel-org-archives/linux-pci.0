Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ia0-f169.google.com ([209.85.210.169]:38492 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754227Ab3DQGIV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 17 Apr 2013 02:08:21 -0400
Received: by mail-ia0-f169.google.com with SMTP id h23so1144825iae.0
        for <linux-pci@vger.kernel.org>; Tue, 16 Apr 2013 23:08:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130416171732.GA6356@google.com>
References: <20130416171732.GA6356@google.com>
Date: Tue, 16 Apr 2013 23:08:20 -0700
Message-ID: <CAE9FiQW+KcPc0BGf4nUHgOOO7ahoijAFsW-CVJmX=PNHT+VngQ@mail.gmail.com>
Subject: Re: Changes for v3.10 merge window
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 16, 2013 at 10:17 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Below are the patches currently in my "next" branch, planned for
> release in v3.10.  If I'm missing something important, let me know.

>       PCI: Fix __must_check annotation on pci_create_sysfs_dev_files()

You need to drop this one.

it cause kernel crash:

[    1.266127] pci 0000:00:00.0: Error adding device (-13)
[    1.268006] pci 0000:00:01.0: Error adding device (-13)
[    1.269404] pci 0000:00:01.1: Error adding device (-13)
[    1.270652] pci 0000:00:01.3: Error adding device (-13)
[    1.272004] pci 0000:00:02.0: Error adding device (-13)
[    1.273345] pci 0000:00:03.0: Error adding device (-13)
[    1.274472] ------------[ cut here ]------------
[    1.275707] kernel BUG at drivers/pci/bus.c:213!
[    1.276000] invalid opcode: 0000 [#1] SMP
[    1.276000] Modules linked in:
[    1.276000] CPU 0
[    1.276000] Pid: 1, comm: swapper/0 Not tainted
3.9.0-rc7-yh-01505-gcf7dc22 #1474 Bochs Bochs
[    1.276000] RIP: 0010:[<ffffffff8151edd9>]  [<ffffffff8151edd9>]
pci_bus_add_devices+0x79/0xb0
[    1.276000] RSP: 0000:ffff880119e85be8  EFLAGS: 00010246
[    1.276000] RAX: 000000000000002b RBX: ffff88019c7ba000 RCX: 0000000000000006
[    1.276000] RDX: 0000000000000000 RSI: ffff880119e988e8 RDI: ffff880119e98000
[    1.276000] RBP: ffff880119e85c08 R08: 0000000000000001 R09: 0000000000000000
[    1.276000] R10: 0000000000000000 R11: 0000000000000001 R12: ffff880119927028
[    1.276000] R13: ffff880119927000 R14: ffff88019c795080 R15: ffff88019c60e1e0
[    1.276000] FS:  0000000000000000(0000) GS:ffff88011ba00000(0000)
knlGS:0000000000000000
[    1.276000] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[    1.276000] CR2: ffff88019ffff000 CR3: 0000000002a14000 CR4: 00000000000006f0
[    1.276000] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    1.276000] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[    1.276000] Process swapper/0 (pid: 1, threadinfo ffff880119e84000,
task ffff880119e98000)
[    1.276000] Stack:
[    1.276000]  ffff88019c795000 ffff880119bb4b00 ffff88019c795000
ffff880119bb4b28
[    1.276000]  ffff880119e85c58 ffffffff81581756 ffff880119e85c58
000000088157b6bf
[    1.276000]  0000000000000000 ffffffff8157d720 ffff88011b404f00
ffff88019c795000
[    1.276000] Call Trace:
[    1.276000]  [<ffffffff81581756>] acpi_pci_root_add+0x376/0x3dc
[    1.276000]  [<ffffffff8157d720>] ? acpi_scan_match_handler+0x2f/0x71
[    1.276000]  [<ffffffff8157d7d3>] acpi_bus_device_attach+0x71/0xc8
[    1.276000]  [<ffffffff815a7d1a>] acpi_ns_walk_namespace+0x11a/0x254
[    1.276000]  [<ffffffff8157d762>] ? acpi_scan_match_handler+0x71/0x71
[    1.276000]  [<ffffffff8157d762>] ? acpi_scan_match_handler+0x71/0x71
[    1.276000]  [<ffffffff815a831a>] acpi_walk_namespace+0xee/0x137
[    1.276000]  [<ffffffff8157e5df>] acpi_bus_scan+0x8b/0x9f
[    1.276000]  [<ffffffff82dc0d42>] ? acpi_sleep_proc_init+0x2a/0x2a
[    1.276000]  [<ffffffff82dc0d42>] ? acpi_sleep_proc_init+0x2a/0x2a
[    1.276000]  [<ffffffff82dc116a>] acpi_scan_init+0x63/0x157
[    1.276000]  [<ffffffff82dc0d42>] ? acpi_sleep_proc_init+0x2a/0x2a
[    1.276000]  [<ffffffff82dc0f8b>] acpi_init+0x249/0x28b
[    1.276000]  [<ffffffff81000254>] do_one_initcall+0x64/0x160
[    1.276000]  [<ffffffff82d90fc6>] kernel_init_freeable+0x15d/0x1ef
[    1.276000]  [<ffffffff82d90790>] ? loglevel+0x31/0x31
[    1.276000]  [<ffffffff8206cb30>] ? rest_init+0xc0/0xc0
[    1.276000]  [<ffffffff8206cb3e>] kernel_init+0xe/0xf0
[    1.276000]  [<ffffffff820a445c>] ret_from_fork+0x7c/0xb0
[    1.276000]  [<ffffffff8206cb30>] ? rest_init+0xc0/0xc0
[    1.276000] Code: c0 e8 dc 58 24 00 0f 1f 40 00 48 8b 1b 4c 39 e3
75 c8 49 8b 5d 28 4c 39 e3 74 2d 0f 1f 80 00 00 00 00 f6 83 c9 08 00
00 04 75 07 <0f> 0b 0f 1f 44 00 00 48 8b 7b 18 48 85 ff 74 05 e8 72 ff
ff ff
[    1.276000] RIP  [<ffffffff8151edd9>] pci_bus_add_devices+0x79/0xb0
[    1.276000]  RSP <ffff880119e85be8>
[    1.280022] ---[ end trace eb3321925da6d1db ]---
[    1.284018] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
