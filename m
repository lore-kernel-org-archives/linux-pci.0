Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:35921 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775AbbDNNGL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Apr 2015 09:06:11 -0400
Received: by qku63 with SMTP id 63so17866044qku.3
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2015 06:06:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAEkKNCc9BpCXNCw1RD2gngUhSs13_-P_rtk=w4tVDW+3QaR6xQ@mail.gmail.com>
References: <CAEkKNCc9BpCXNCw1RD2gngUhSs13_-P_rtk=w4tVDW+3QaR6xQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 14 Apr 2015 08:05:42 -0500
Message-ID: <CAErSpo5K9utm4Bt75L75jTY5HPZO8qTtHfy9OzVqzxjV3FAW4A@mail.gmail.com>
Subject: Re: PCI Out of Resources
To: moussa ba <musaba@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 13, 2015 at 8:00 PM, moussa ba <musaba@gmail.com> wrote:
> I am working on a system that has 20 PCie cards conencted via a series
> of PCi-Switches. While booting, the BIOS complains after 11 cards that
> it ran out of resources. Despite that, we are able to properly see all
> devices up to 16 devices once the OS boots.
>
> I am running centos 7 with a 3.10 kernel.
>
> Interestingly enough, we are able to see all devices under lspci, but
> the 4 missing devices have no memory allocated to any of the BAR
> spaces.
>
> My understanding is that we can allocate that memory via setpci.
>
> A working device looks as follows under lspci:
>
> 9a:00.0 Mass storage controller: *******
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0
> Interrupt: pin A routed to IRQ 139
> Region 2: Memory at fbb02000 (32-bit, non-prefetchable) [size=4K]
> Region 3: Memory at fbb03000 (32-bit, non-prefetchable) [size=4K]
> Region 4: I/O ports at c000 [size=16]
> Region 5: Memory at fbb00000 (32-bit, non-prefetchable) [size=8K]
> Capabilities: [40] Express (v2) Endpoint, MSI 00
> DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
>
>
>
>
> A missing device looks as follows:
>
> 05:00.0 Mass storage controller: *******
>         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin A routed to IRQ 26
>         Region 4: I/O ports at 0000
>         Capabilities: [40] Express (v2) Endpoint, MSI 00
>
>
>
>
> I was going to simply use:
> #setpci -s 0000:05:00.0 BASE_MEMORY_ADDRESS_2=0x..........
>
> Unfortunately I end up with a <ignored> message under lspci.  How do I
> determine the appropriate address to use to properly assign the
> resources (I have been looking at /proc/iomem)

1) Please try the same thing with a current kernel, e.g., v3.19 or
v4.0.  There have been many resource management changes since v3.10,
and I don't want to debug problems that have already been fixed.  If
you find that v4.0 works better, then it becomes a simpler problem of
figuring out whether to use a newer kernel or backport a fix to your
old kernel.

2) Please post a complete dmesg log, complete "lspci -vv" output,
contents of /proc/iomem, and a transcript of what you're doing with
setpci (remove vendor/device IDs if they are confidential, and you can
attach these to a kernel.org bugzilla if that's more convenient).
It's not quite clear what you mean by "seeing devices" -- there are
several ways a device can be present but not usable, and we need to
figure out which are relevant here.

3) If you set a BAR with "setpci", it affects the device, but not
Linux.  The kernel doesn't know you've changed the BAR, so as far as
it's concerned, there's still no address space assigned to the device,
so it will still decline to enable it.

4) From the source, it looks like lspci will print "<ignored>" if the
BAR contains zero.  In some systems that would be a valid assignment,
so this might be something we should change in lspci.  But we need to
know more about your system to figure out whether this is relevant to
you.

Bjorn
