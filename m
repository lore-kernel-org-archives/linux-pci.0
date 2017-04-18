Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62311 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751012AbdDROMc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2017 10:12:32 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms@verge.net.au>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Niklas =?ISO-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
Subject: Re: PCI / PM: Crashes in PME scan during system suspend
Date: Tue, 18 Apr 2017 16:06:27 +0200
Message-ID: <1776042.AWT4z5IEIn@aspire.rjw.lan>
In-Reply-To: <CAMuHMdUzYUGZT3gWzZ97rmbPXG3RqYLdvYx_ZdLdmCvxbrt4Hw@mail.gmail.com>
References: <CAMuHMdVf-NT_6oGQVba_QgFuW-fZMBDF1CtidfxSxnCr8+BGHg@mail.gmail.com> <20170416075535.GA6620@wunner.de> <CAMuHMdUzYUGZT3gWzZ97rmbPXG3RqYLdvYx_ZdLdmCvxbrt4Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, April 18, 2017 08:49:39 AM Geert Uytterhoeven wrote:
> Hi Lukas,
> 
> On Sun, Apr 16, 2017 at 9:55 AM, Lukas Wunner <lukas@wunner.de> wrote:
> > On Sat, Apr 15, 2017 at 12:27:31AM +0200, Rafael J. Wysocki wrote:
> >> On Friday, April 14, 2017 10:22:49 AM Lukas Wunner wrote:
> >> > Below is a tentative patch which moves PME polling to a freezable
> >> > workqueue, so it is frozen before the host bridge is suspended.
> >> > Geert, Laurent, could you test this?
> >> >
> >> > The patch may be problematic in that pci_pme_list_scan() acquires
> >> > pci_pme_list_mutex, which is also acquired by pci_pme_active(),
> >> > which gets called when devices are suspended -- *after* the worker
> >> > has been frozen.  I'm not really familiar with the freezer, can it
> >> > happen that the worker is frozen while holding the mutex?  If so
> >> > this would deadlock.  Rafael?
> >>
> >> That depends on the worker, precisely on where it calls try_to_freeze().
> >
> > pci_pme_list_scan() doesn't call try_to_freeze() at all, that's what had
> > me confused.  Neither do many other workers that are scheduled to
> > system_freezable_wq.
> >
> > However after familiarizing myself a bit more with the freezer it seems
> > that is fine.  The freezer prevents new workers from being scheduled and
> > then schedules the existing workers for up to 20 seconds to allow them
> > to finish.  The call to try_to_freeze() is thus only needed for long
> > running workers or for threads which are in some infinite loop.
> >
> > Below is the same patch with a proper commit message, it's mostly copied
> > and pasted from Geert's comprehensive report.  Still needs to be tested
> > by Geert and/or Laurent as I was unable reproduce the issue on my x86
> > laptop.  Perhaps on x86 the OS is not responsible for disabling the PCI
> > clock (but presumably the BIOS) or x86 doesn't emit this kind of fault.
> 
> Thanks, works fine (see below)!
> 
> > -- >8 --
> > Subject: [PATCH] PCI: Freeze PME scan before suspending devices
> >
> > Laurent Pinchart reported that the Renesas R-Car H2 Lager board
> > (r8a7790) crashes during suspend tests.  Geert Uytterhoeven managed to
> > reproduce the issue on an M2-W Koelsch board (r8a7791):
> >
> > It occurs when the PME scan runs, once per second.  During PME scan, the
> > PCI host bridge (rcar-pci) registers are accessed while its module clock
> > has already been disabled, leading to the crash.
> >
> > The issue only occurs during suspend tests, after writing either
> > "platform" or "processors" to /sys/power/pm_test.  It does not (or is
> > less likely) to happen during full system suspend ("core" or "none")
> > because system suspend also disables timers, and thus the workqueue
> > handling PME scans no longer runs.  Geert believes the issue may still
> > happen in the small window between disabling module clocks and disabling
> > timers.
> 
> It can also be reproduced easily by configuring s2ram to use s2idle instead
> of deep suspend, which is a real usecase:
> 
> # echo 0 > /sys/module/printk/parameters/console_suspend
> # echo s2idle > /sys/power/mem_sleep
> # echo mem > /sys/power/state
> 
> > Rafael Wysocki agrees that PME scans should be suspended before the host
> > bridge registers become inaccessible.  To that end, queue the task on a
> > workqueue that gets frozen before devices suspend.
> >
> > How to reproduce:
> >
> > # echo 0 > /sys/module/printk/parameters/console_suspend
> > # echo platform > /sys/power/pm_test    # Or "processors"
> > # echo mem > /sys/power/state
> >
> > Make sure CONFIG_PCI_RCAR_GEN2 and CONFIG_USB_OHCI_HCD_PCI are
> > enabled.
> >
> > PM: Syncing filesystems ... [   38.566237] done.
> > PM: Preparing system for sleep (mem)
> > Freezing user space processes ... [   38.579813] (elapsed 0.001 seconds) done.
> > Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> > PM: Suspending system (mem)
> > PM: suspend of devices complete after 152.456 msecs
> > PM: late suspend of devices complete after 2.809 msecs
> > PM: noirq suspend of devices complete after 29.863 msecs
> > suspend debug: Waiting for 5 second(s).
> > Unhandled fault: asynchronous external abort (0x1211) at 0x00000000
> > pgd = c0003000
> > [00000000] *pgd=80000040004003, *pmd=00000000
> > Internal error: : 1211 [#1] SMP ARM
> > Modules linked in:
> > CPU: 1 PID: 20 Comm: kworker/1:1 Not tainted
> > 4.9.0-rc1-koelsch-00011-g68db9bc814362e7f #3383
> > Hardware name: Generic R8A7791 (Flattened Device Tree)
> > Workqueue: events pci_pme_list_scan
> > task: eb56e140 task.stack: eb58e000
> > PC is at pci_generic_config_read+0x64/0x6c
> > LR is at rcar_pci_cfg_base+0x64/0x84
> > pc : [<c041d7b4>]    lr : [<c04309a0>]    psr: 600d0093
> > sp : eb58fe98  ip : c041d750  fp : 00000008
> > r10: c0e2283c  r9 : 00000000  r8 : 600d0013
> > r7 : 00000008  r6 : eb58fed6  r5 : 00000002  r4 : eb58feb4
> > r3 : 00000000  r2 : 00000044  r1 : 00000008  r0 : 00000000
> > Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> > Control: 30c5387d  Table: 6a9f6c80  DAC: 55555555
> > Process kworker/1:1 (pid: 20, stack limit = 0xeb58e210)
> > Stack: (0xeb58fe98 to 0xeb590000)
> > fe80:                                                       00000002 00000044
> > fea0: eb6f5800 c041d9b0 eb58feb4 00000008 00000044 00000000 eb78a000 eb78a000
> > fec0: 00000044 00000000 eb9aff00 c0424bf0 eb78a000 00000000 eb78a000 c0e22830
> > fee0: ea8a6fc0 c0424c5c eaae79c0 c0424ce0 eb55f380 c0e22838 eb9a9800 c0235fbc
> > ff00: eb55f380 c0e22838 eb55f380 eb9a9800 eb9a9800 eb58e000 eb9a9824 c0e02100
> > ff20: eb55f398 c02366c4 eb56e140 eb5631c0 00000000 eb55f380 c023641c 00000000
> > ff40: 00000000 00000000 00000000 c023a928 cd105598 00000000 40506a34 eb55f380
> > ff60: 00000000 00000000 dead4ead ffffffff ffffffff eb58ff74 eb58ff74 00000000
> > ff80: 00000000 dead4ead ffffffff ffffffff eb58ff90 eb58ff90 eb58ffac eb5631c0
> > ffa0: c023a844 00000000 00000000 c0206d68 00000000 00000000 00000000 00000000
> > ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > ffe0: 00000000 00000000 00000000 00000000 00000013 00000000 3a81336c 10ccd1dd
> > [<c041d7b4>] (pci_generic_config_read) from [<c041d9b0>]
> > (pci_bus_read_config_word+0x58/0x80)
> > [<c041d9b0>] (pci_bus_read_config_word) from [<c0424bf0>]
> > (pci_check_pme_status+0x34/0x78)
> > [<c0424bf0>] (pci_check_pme_status) from [<c0424c5c>] (pci_pme_wakeup+0x28/0x54)
> > [<c0424c5c>] (pci_pme_wakeup) from [<c0424ce0>] (pci_pme_list_scan+0x58/0xb4)
> > [<c0424ce0>] (pci_pme_list_scan) from [<c0235fbc>]
> > (process_one_work+0x1bc/0x308)
> > [<c0235fbc>] (process_one_work) from [<c02366c4>] (worker_thread+0x2a8/0x3e0)
> > [<c02366c4>] (worker_thread) from [<c023a928>] (kthread+0xe4/0xfc)
> > [<c023a928>] (kthread) from [<c0206d68>] (ret_from_fork+0x14/0x2c)
> > Code: ea000000 e5903000 f57ff04f e3a00000 (e5843000)
> > ---[ end trace 667d43ba3aa9e589 ]---
> >
> > Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Yinghai Lu <yinghai@kernel.org>
> > Fixes: df17e62e5bff ("PCI: Add support for polling PME state on suspended legacy PCI devices")
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> 
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

There is a small concern here that some wakeup events may be missed if they
are delivered via PME without a working IRQ, but that's fairly minor and it
cannot be avoided entirely, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks!
