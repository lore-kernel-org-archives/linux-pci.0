Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:34163 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbdBNJbl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2017 04:31:41 -0500
MIME-Version: 1.0
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Feb 2017 10:31:38 +0100
Message-ID: <CAMuHMdVf-NT_6oGQVba_QgFuW-fZMBDF1CtidfxSxnCr8+BGHg@mail.gmail.com>
Subject: PCI / PM: Crashes in PME scan during system suspend
To: Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yinghai Lu <yinghai@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon Horman <horms@verge.net.au>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

Laurent Pinchart reported that r8a7790/Lager crashes during suspend tests.

I managed to reproduce the issue on r8a7791/koelsch:
  - It only happens during suspend tests, after writing either "platform"
    or "processors" to /sys/power/pm_test,
  - It does not (or is less likely) to happen during full system suspend
    ("core" or "none").

More investigation shows this happens when the PME scan runs, once per
second.  During PME scan, the PCI host bridge (rcar-pci) registers are
accessed while the host bridge's module clock has already been disabled,
leading to a crash.

With "core" or "none", system suspend also disables timers, and thus the
workqueue handling PME scan no longer runs.  I believe the issue can still
happen, as there's a small window between disabling module clocks and
disabling timers.

Lukas' patch "[PATCH v2] PCI: pciehp: Don't enable PME on runtime suspend"
(http://lkml.iu.edu/hypermail/linux/kernel/1702.0/03245.html) is not
sufficient to fix the issue.

Note that the issue was not introduced by commit 68db9bc81436 ("PCI:
pciehp: Add runtime PM support for PCIe hotplug ports"):  I managed to
trigger it on 68db9bc81436^ too, albeit not at first try.

Do you have a clue?
Shall I bisect it? I have no idea when the issue appeared first, or if it ever
worked.
Thanks!

How to reproduce:

# echo 0 > /sys/module/printk/parameters/console_suspend
# echo platform > /sys/power/pm_test    # Or "processors"
# echo mem > /sys/power/state

Make sure CONFIG_PCI_RCAR_GEN2 and CONFIG_USB_OHCI_HCD_PCI are
enabled.

PM: Syncing filesystems ... [   38.566237] done.
PM: Preparing system for sleep (mem)
Freezing user space processes ... [   38.579813] (elapsed 0.001 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
PM: Suspending system (mem)
PM: suspend of devices complete after 152.456 msecs
PM: late suspend of devices complete after 2.809 msecs
PM: noirq suspend of devices complete after 29.863 msecs
suspend debug: Waiting for 5 second(s).
Unhandled fault: asynchronous external abort (0x1211) at 0x00000000
pgd = c0003000
[00000000] *pgd=80000040004003, *pmd=00000000
Internal error: : 1211 [#1] SMP ARM
Modules linked in:
CPU: 1 PID: 20 Comm: kworker/1:1 Not tainted
4.9.0-rc1-koelsch-00011-g68db9bc814362e7f #3383
Hardware name: Generic R8A7791 (Flattened Device Tree)
Workqueue: events pci_pme_list_scan
task: eb56e140 task.stack: eb58e000
PC is at pci_generic_config_read+0x64/0x6c
LR is at rcar_pci_cfg_base+0x64/0x84
pc : [<c041d7b4>]    lr : [<c04309a0>]    psr: 600d0093
sp : eb58fe98  ip : c041d750  fp : 00000008
r10: c0e2283c  r9 : 00000000  r8 : 600d0013
r7 : 00000008  r6 : eb58fed6  r5 : 00000002  r4 : eb58feb4
r3 : 00000000  r2 : 00000044  r1 : 00000008  r0 : 00000000
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 30c5387d  Table: 6a9f6c80  DAC: 55555555
Process kworker/1:1 (pid: 20, stack limit = 0xeb58e210)
Stack: (0xeb58fe98 to 0xeb590000)
fe80:                                                       00000002 00000044
fea0: eb6f5800 c041d9b0 eb58feb4 00000008 00000044 00000000 eb78a000 eb78a000
fec0: 00000044 00000000 eb9aff00 c0424bf0 eb78a000 00000000 eb78a000 c0e22830
fee0: ea8a6fc0 c0424c5c eaae79c0 c0424ce0 eb55f380 c0e22838 eb9a9800 c0235fbc
ff00: eb55f380 c0e22838 eb55f380 eb9a9800 eb9a9800 eb58e000 eb9a9824 c0e02100
ff20: eb55f398 c02366c4 eb56e140 eb5631c0 00000000 eb55f380 c023641c 00000000
ff40: 00000000 00000000 00000000 c023a928 cd105598 00000000 40506a34 eb55f380
ff60: 00000000 00000000 dead4ead ffffffff ffffffff eb58ff74 eb58ff74 00000000
ff80: 00000000 dead4ead ffffffff ffffffff eb58ff90 eb58ff90 eb58ffac eb5631c0
ffa0: c023a844 00000000 00000000 c0206d68 00000000 00000000 00000000 00000000
ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
ffe0: 00000000 00000000 00000000 00000000 00000013 00000000 3a81336c 10ccd1dd
[<c041d7b4>] (pci_generic_config_read) from [<c041d9b0>]
(pci_bus_read_config_word+0x58/0x80)
[<c041d9b0>] (pci_bus_read_config_word) from [<c0424bf0>]
(pci_check_pme_status+0x34/0x78)
[<c0424bf0>] (pci_check_pme_status) from [<c0424c5c>] (pci_pme_wakeup+0x28/0x54)
[<c0424c5c>] (pci_pme_wakeup) from [<c0424ce0>] (pci_pme_list_scan+0x58/0xb4)
[<c0424ce0>] (pci_pme_list_scan) from [<c0235fbc>]
(process_one_work+0x1bc/0x308)
[<c0235fbc>] (process_one_work) from [<c02366c4>] (worker_thread+0x2a8/0x3e0)
[<c02366c4>] (worker_thread) from [<c023a928>] (kthread+0xe4/0xfc)
[<c023a928>] (kthread) from [<c0206d68>] (ret_from_fork+0x14/0x2c)
Code: ea000000 e5903000 f57ff04f e3a00000 (e5843000)
---[ end trace 667d43ba3aa9e589 ]---

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
