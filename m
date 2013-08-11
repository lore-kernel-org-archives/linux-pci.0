Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:38097 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919Ab3HKV0P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 11 Aug 2013 17:26:15 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
Cc: linux-pci@vger.kernel.org, Greg KH <gregkh@linux.com>,
	Oliver Neukum <oneukum@suse.de>
Subject: Re: acpiphp and pciehp not working together on Thinkpad X200s
Date: Sun, 11 Aug 2013 23:36:38 +0200
Message-ID: <11028683.ZZQRkho7yW@vostro.rjw.lan>
In-Reply-To: <5207FFB8.3080202@message-id.googlemail.com>
References: <520747B6.8010309@message-id.googlemail.com> <1880950.SYaKzZm9j7@vostro.rjw.lan> <5207FFB8.3080202@message-id.googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sunday, August 11, 2013 11:18:48 PM Stefan Seyfried wrote:
> Hi Rafael,
> 
> Am 11.08.2013 23:25, schrieb Rafael J. Wysocki:
> > On Sunday, August 11, 2013 10:13:42 AM Stefan Seyfried wrote:
> 
> >>  kernel: pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
> >>  kernel: pci 0000:00:1c.1: PCI bridge to [bus 03]
> >>  kernel: pci 0000:00:1c.1:   bridge window [mem 0xf2500000-0xf25fffff]
> >> -kernel: acpiphp: Slot [1] registered
> >>  kernel: pci 0000:00:1c.3: PCI bridge to [bus 05-0c]
> >>  kernel: pci 0000:00:1c.3:   bridge window [io  0x2000-0x2fff]
> >>  kernel: pci 0000:00:1c.3:   bridge window [mem 0xf0000000-0xf1ffffff]
> 
> >>  kernel: pciehp 0000:00:1c.1:pcie04: HPC vendor_id 8086 device_id 2942 ss_vid 17aa ss_did 20f3
> >>  kernel: pciehp 0000:00:1c.1:pcie04: service driver pciehp loaded
> >>  kernel: pciehp 0000:00:1c.3:pcie04: HPC vendor_id 8086 device_id 2946 ss_vid 17aa ss_did 20f3
> >> -kernel: pciehp 0000:00:1c.3:pcie04: pci_hp_register failed with error -16
> >> -kernel: pciehp 0000:00:1c.3:pcie04: Slot already registered by another hotplug driver
> >> +kernel: pciehp 0000:00:1c.3:pcie04: service driver pciehp loaded
> 
> >> Greg told me to report the issue here, so I'm doing that :-)
> >>
> >> If you need more information (would a complete dmesg of both cases
> >> be useful?), just let me know.
> > 
> > Which kernel is that?
> 
> That's 3.11rc4, openSUSE Kernel:HEAD repository.

OK

Please use the acpiphp.disable=1 workaround for how.  The problem is kind of
known and we'll address it some time in the future, but it is hard to say
when that's going to happen and this point.

There's some ACPIPHP rework material queued up for 3.12 in linux-next, but
I doubt it'll make a difference on your machine.  Anyway, if you want to
try it, you can just pull the linux-next branch of my linux-pm.git tree
(to avoid pulling all of the other linux-next material in addition to it).

Thanks,
Rafael

