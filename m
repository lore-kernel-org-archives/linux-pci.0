Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35905 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751AbbIOPcB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 11:32:01 -0400
Received: by wicgb1 with SMTP id gb1so34261642wic.1
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2015 08:32:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <bug-104431-41252@https.bugzilla.kernel.org/>
References: <bug-104431-41252@https.bugzilla.kernel.org/>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 15 Sep 2015 10:31:40 -0500
Message-ID: <CAErSpo6LpJRbhnwH-Mqu3zN-=gEVgJ2u+aonpWNXbtXKQ8xCKw@mail.gmail.com>
Subject: Re: [Bug 104431] New: second connected thunderbolt dock fails
To: Jarod Wilson <jarod@redhat.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci]

Hi Jarod,

On Fri, Sep 11, 2015 at 3:19 PM,  <bugzilla-daemon@bugzilla.kernel.org> wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=104431
>
>             Bug ID: 104431
>            Summary: second connected thunderbolt dock fails
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 4.2.0 + a handful of other patches
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: jarod@redhat.com
>         Regression: No
>
> I've been loaned a pair of thunderbolt docking peripherals. One is an Akitio
> Thunder Dock, which has usb3, esata and firewire 800 on it, the other is a
> StarTech Thunderbolt Docking Station, which has usb3, a usb audio device and an
> Intel i210 GbE device.
>
> Individually, each of the docks work fine (at least with the 4.3.x pciehp patch
> for my zbook and an igb patch I just sent upstream), hotplug and remove. They
> even work correctly if connected together -- i.e., connect the two docks
> together, then connect to the host, and both come up fine.
>
> However, when I connect one dock directly to the host, then the second dock,
> the second dock fails to function, with the following output upon connection:
>
> pciehp 0000:06:04.0:pcie24: pending interrupts 0x0008 from Slot Status
> pciehp 0000:06:04.0:pcie24: Card present on Slot(4-1)
> pciehp 0000:06:04.0:pcie24: pending interrupts 0x0100 from Slot Status
> pciehp 0000:06:04.0:pcie24: pciehp_check_link_active: lnk_status = 3041
> pciehp 0000:06:04.0:pcie24: slot(4-1): Link Up event
> pciehp 0000:06:04.0:pcie24: Link Up event ignored on slot(4-1): already
> powering on
> pciehp 0000:06:04.0:pcie24: pciehp_check_link_active: lnk_status = 3041
> pciehp 0000:06:04.0:pcie24: pciehp_check_link_status: lnk_status = 3041
> pci 0000:0b:00.0: [8086:1547] type 01 class 0x060400
> pci 0000:0b:00.0: supports D1 D2
> pci 0000:0b:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> No bus number available for hot-added bridge 0000:0b:00.0
> pcieport 0000:06:04.0: bridge window [io  0x1000-0x0fff] to [bus 0b] add_size
> 1000
> pcieport 0000:06:04.0: res[13]=[io  0x1000-0x0fff] res_to_dev_res add_size 1000
> min_align    1000
> pcieport 0000:06:04.0: res[13]=[io  0x1000-0x1fff] res_to_dev_res add_size 1000
> min_align    1000
> pcieport 0000:06:04.0: BAR 13: no space for [io  size 0x1000]
> pcieport 0000:06:04.0: BAR 13: failed to assign [io  size 0x1000]
> pcieport 0000:06:04.0: BAR 13: no space for [io  size 0x1000]
> pcieport 0000:06:04.0: BAR 13: failed to assign [io  size 0x1000]
> pcieport 0000:06:04.0: PCI bridge to [bus 0b]
> pcieport 0000:06:04.0:   bridge window [mem 0xb4700000-0xb49fffff]
> pcieport 0000:06:04.0:   bridge window [mem 0x90700000-0x909fffff 64bit pref]
>
> I'll attach full dmesg dumps from both simultaneous and one at a time
> connection attempts shortly.

Thanks for the report.  The logs only start from the hotplug, so they
don't show the initial enumeration at boot.  Can you also attach
"lspci -vv" output from the working case, so we can see which devices
are in which dock?  I started working it out from the logs, but that's
pretty tedious.

I *think* the second dock that fails is rooted at 0b:00.0, and it's
being added below 06:04.0  Since the 0b:00.0 tree wasn't present at
boot, we don't know how many bus numbers to reserve for 06:04.0, and
we only reserved one (bus 0b).  Obviously that's not enough for all
the devices in that dock.

For memory and I/O, we reserve default amounts of space
(pci_hotplug_mem_size and pci_hotplug_io_size), but I don't think we
do anything corresponding for bus numbers.  Maybe we should.

Bjorn
