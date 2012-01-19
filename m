Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:39639 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932876Ab2ASUBx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 19 Jan 2012 15:01:53 -0500
Received: by lahc1 with SMTP id c1so190364lah.19
        for <linux-pci@vger.kernel.org>; Thu, 19 Jan 2012 12:01:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <bug-42606-41252@https.bugzilla.kernel.org/>
References: <bug-42606-41252@https.bugzilla.kernel.org/>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 19 Jan 2012 13:01:30 -0700
Message-ID: <CAErSpo5r8J9DAwkzAD2zJr1qp01XwCa_X2odQCB98zOU==Derw@mail.gmail.com>
Subject: Re: [Bug 42606] New: PCI I/O range not assigned under newer kernels
To: bugzilla-daemon@bugzilla.kernel.org
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 19, 2012 at 4:22 AM,  <bugzilla-daemon@bugzilla.kernel.org> wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=42606

> Observed a problem with a PCI Express card in a certain server PC with 8 PCI
> Express slots on the mainboard. There are no other PCI slots than the PCIe
> ones, and all slots are empty except the one with the card under test, which
> requires a legacy I/O address range for base address 0.
>
> In some of the slots the card works properly, but in some other slots on the
> same
> machine the card doesn't work since it is not accessible by the associated
> kernel
> driver. In case it doesn't work lspci -v says for the I/O base address 0:
>
>  Region 0: I/O ports at <ignored>
>
> Found out that this problem did *not* occur with kernels 2.6.32.6 and earlier,
> but *does* occur with kernels 2.6.36.1 and later, up to at least 3.4.1, on the
> same hardware.

The 2.6.32.6 dmesg is truncated and doesn't include the parts of
interest (the early part that contains PCI enumeration).  But this
looks related to "pci=use_crs" being turned on by default, which I
think happened in 2.6.34.  That means that booting with "pci=nocrs"
might be a workaround while we figure out a better solution.

Here's the 3.1.4 dmesg:

  ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7f])
  pci_root PNP0A08:00: host bridge window [io  0xf000-0xffff]
  ...
  ACPI: PCI Root Bridge [BR50] (domain 0000 [bus 80-fb])
  pci_root PNP0A08:01: host bridge window [io  0xf000-0xffff]
  pci 0000:80:07.0: PCI bridge to [bus 85-85]
  pci 0000:80:07.0:   bridge window [io  0xf000-0xffff]
  pci 0000:85:00.0: reg 10: [io  0xfc00-0xfcff]
  pci 0000:80:07.0: address space collision: [io  0xf000-0xffff]
conflicts with PCI Bus 0000:00 [io  0xf000-0xffff]
  pci 0000:85:00.0: no compatible bridge window for [io  0xfc00-0xfcff]

The BIOS is telling us that [io  0xf000-0xffff] is routed to both root
buses (00 and 80), which Linux assumes is not possible.  In the posted
dmesg, it looks like your device is at 85:00.0, and it doesn't work.
This is because we think the [io  0xf000-0xffff] area is already
consumed by host bridge PCI0 and hence not available for bridge BR50.

What are the device addresses that work and those that don't work?  My
guess is the working slots might be under PCI0 (buses 00-7f) and the
broken ones under BR50 (buses 80-fb).  Can you collect a dmesg log
with a working slot, too?

Can you boot with Windows with the card in the same slot (one that
doesn't work under Linux) and use AIDA64 (free trial version at
http://www.aida64.com/downloads) to collect a log?  This should show
where Windows puts the device.
