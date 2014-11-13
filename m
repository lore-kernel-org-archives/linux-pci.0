Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:44894 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535AbaKMEPH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Nov 2014 23:15:07 -0500
Received: by mail-qc0-f178.google.com with SMTP id b13so11520638qcw.23
        for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2014 20:15:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <bug-88131-41252@https.bugzilla.kernel.org/>
References: <bug-88131-41252@https.bugzilla.kernel.org/>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 12 Nov 2014 21:14:44 -0700
Message-ID: <CAErSpo6Bfya60UMeN3cxSH3A+cesAAgPuZEb6b6FHnVBFsOxfA@mail.gmail.com>
Subject: Re: [Bug 88131] New: PCI device intel ixgbe and xhci with 64-bit bar
 address can NOT work on x86_32 PAE kernel.
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: Yinghai Lu <yinghai@kernel.org>, mapengyu@gmail.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci, Yinghai]

Thanks for the report!

On Wed, Nov 12, 2014 at 8:57 PM,  <bugzilla-daemon@bugzilla.kernel.org> wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=88131
>
>             Bug ID: 88131
>            Summary: PCI device intel ixgbe and xhci with 64-bit bar
>                     address can NOT work on x86_32 PAE kernel.
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 3.18-rc4
>           Hardware: i386
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: mapengyu@gmail.com
>         Regression: No
>
> Created attachment 157441
>   --> https://bugzilla.kernel.org/attachment.cgi?id=157441&action=edit
> dmesg
>
> PCI device intel ixgbe and xhci with 64-bit bar address can NOT work on x86_32
> kernel.
>
> The bar0 base address of intel ixgbe ethernet card and xhci are above 4G.
> The commit d56dbf5bab8ce44c5407bb099f71987f58d18bb4 try to map the resource
> above 4G.
> Enabled PAE and HIGHMEM64G, it should support 64-bit BAR, but failed on high
> bar address.

Can you also attach your .config to the bugzilla?

Is this a regression?  Did it work correctly before d56dbf5bab8c
("PCI: Allocate 64-bit BARs above 4G when possible")?

I assume this is the problem you're seeing (for igbe):

[    6.604741] pci 0000:03:00.0: [8086:1528] type 00 class 0x020000
[    6.610012] pci 0000:03:00.0: reg 0x10: [mem
0x383fffc00000-0x383fffdfffff 64bit pref]
[    6.617407] pci 0000:03:00.0: reg 0x18: [io  0x1020-0x103f]
[    6.622195] pci 0000:03:00.0: reg 0x20: [mem
0x383fffe04000-0x383fffe07fff 64bit pref]
[    6.638250] pci 0000:03:00.0: reg 0x184: [mem 0x91900000-0x91903fff 64bit]
[    6.644488] pci 0000:03:00.0: reg 0x190: [mem 0x91a00000-0x91a03fff 64bit]

[    6.702055] pci 0000:00:02.2: PCI bridge to [bus 03-04]
[    6.706434] pci 0000:00:02.2:   bridge window [io  0x1000-0x1fff]
[    6.711783] pci 0000:00:02.2:   bridge window [mem 0x91900000-0x91cfffff]
[    6.717906] pci 0000:00:02.2: can't handle 64-bit address space for bridge

[    7.498976] pci 0000:03:00.0: BAR 0: reserving [mem
0x383fffc00000-0x383fffdfffff flags 0x14220c] (d=0, p=0)
[    7.508491] pci 0000:03:00.0: can't claim BAR 0 [mem
0x383fffc00000-0x383fffdfffff 64bit pref]: no compatible bridge window
[    7.519460] pci 0000:03:00.0: BAR 2: reserving [io  0x1020-0x103f
flags 0x40101] (d=0, p=0)
[    7.527327] pci 0000:03:00.0: BAR 4: reserving [mem
0x383fffe04000-0x383fffe07fff flags 0x14220c] (d=0, p=0)
[    7.536842] pci 0000:03:00.0: can't claim BAR 4 [mem
0x383fffe04000-0x383fffe07fff 64bit pref]: no compatible bridge window
[    7.547808] pci 0000:03:00.0: BAR 7: reserving [mem
0x91900000-0x919fffff flags 0x140204] (d=0, p=0)
[    7.556547] pci 0000:03:00.0: BAR 10: reserving [mem
0x91a00000-0x91afffff flags 0x140204] (d=0, p=0)

[    8.791833] pci 0000:03:00.0: BAR 0: assigned [mem
0x380000000000-0x3800001fffff 64bit pref]
[    8.799815] pci 0000:03:00.1: BAR 0: assigned [mem
0x380000200000-0x3800003fffff 64bit pref]
[    8.807796] pci 0000:03:00.0: BAR 4: assigned [mem
0x380000400000-0x380000403fff 64bit pref]

[   12.390578] ixgbe 0000:03:00.0: Adapter removed
[   12.394247] ixgbe: probe of 0000:03:00.0 failed with error -5

And this is the one for xhci?

[    6.303167] pci 0000:00:14.0: [8086:8d31] type 00 class 0x0c0330
[    6.308435] pci 0000:00:14.0: reg 0x10: [mem
0x383ffff00000-0x383ffff0ffff 64bit]

[    7.640440] pci 0000:00:14.0: BAR 0: reserving [mem
0x383ffff00000-0x383ffff0ffff flags 0x140204] (d=0, p=0)

[   12.470777] xhci_hcd 0000:00:14.0: can't setup: -19
[   12.474768] xhci_hcd 0000:00:14.0: USB bus 1 deregistered
