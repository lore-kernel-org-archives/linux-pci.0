Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:41616 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751990Ab2AWR4I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 23 Jan 2012 12:56:08 -0500
Received: by lahc1 with SMTP id c1so1783304lah.19
        for <linux-pci@vger.kernel.org>; Mon, 23 Jan 2012 09:56:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4F1D9582.4030705@meinberg.de>
References: <bug-42606-41252@https.bugzilla.kernel.org/> <CAErSpo5r8J9DAwkzAD2zJr1qp01XwCa_X2odQCB98zOU==Derw@mail.gmail.com>
 <CAErSpo7Gpd4OwbRPRd8ePdKDRQpZKT6E-UyEVL92as6C1Tqj7Q@mail.gmail.com> <4F1D9582.4030705@meinberg.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 23 Jan 2012 10:55:43 -0700
Message-ID: <CAErSpo6B=NYZvCGJDLmYC=KoT0fBp7zkAyw6bEnmUaY4nXD==w@mail.gmail.com>
Subject: Re: Fwd: [Bug 42606] New: PCI I/O range not assigned under newer kernels
To: Martin Burnicki <martin.burnicki@meinberg.de>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 23, 2012 at 10:14 AM, Martin Burnicki
<martin.burnicki@meinberg.de> wrote:
> Bjorn Helgaas wrote:
> [...]
>
>> Here's the 3.1.4 dmesg:
>>
>>  ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7f])
>>  pci_root PNP0A08:00: host bridge window [io  0xf000-0xffff]
>>  ...
>>  ACPI: PCI Root Bridge [BR50] (domain 0000 [bus 80-fb])
>>  pci_root PNP0A08:01: host bridge window [io  0xf000-0xffff]
>>  pci 0000:80:07.0: PCI bridge to [bus 85-85]
>>  pci 0000:80:07.0:   bridge window [io  0xf000-0xffff]
>>  pci 0000:85:00.0: reg 10: [io  0xfc00-0xfcff]
>>  pci 0000:80:07.0: address space collision: [io  0xf000-0xffff]
>> conflicts with PCI Bus 0000:00 [io  0xf000-0xffff]
>>  pci 0000:85:00.0: no compatible bridge window for [io  0xfc00-0xfcff]
>>
>> The BIOS is telling us that [io  0xf000-0xffff] is routed to both root
>> buses (00 and 80), which Linux assumes is not possible.
>
> Hm, so this sounds like a BIOS bug?

That was my initial assumption, but appears not to be the case; see below.

> However, the strange thing here is that it actually *does* work if an older
> kernel is booted which doesn't do these checks, or even if a newer kernel is
> booted with "pci=nocrs".

The older kernels and newer kernels with "pci=nocrs" ignore the _CRS
information (the "host bridge window" lines in dmesg), so they
basically just use what the BIOS configured, which works in this case.

>> What are the device addresses that work and those that don't work?  My
>> guess is the working slots might be under PCI0 (buses 00-7f) and the
>> broken ones under BR50 (buses 80-fb).  Can you collect a dmesg log
>> with a working slot, too?
>
> The card does *not* work in the slots assigned to buses 83, 84, 85, and 86.
>
> The card *does* work in the slots assigned to buses 02, 03, and 04.

Thanks a lot.  That confirms my hypothesis that the card works under
PCI0 but not under BR50.

>> Can you boot with Windows with the card in the same slot (one that
>> doesn't work under Linux) and use AIDA64 (free trial version at
>> http://www.aida64.com/downloads) to collect a log?  This should show
>> where Windows puts the device.
>
> Done. See the attached file aida64-report.htm. The report has been generated
> with the default setting for a hardware report in Aida64.

Windows shows the [io  0xf000-0xffff] range as being available under
both host bridges, and the fact that those ports actually work under
both bridges means they must actually be routed both places.

It may be that Linux is being overly strict in rejecting that overlap.
 I'm not sure what would break if we changed that.  Linux has a very
hierarchical idea of resources and doesn't have a mechanism for
managing duplicates like that.

I'll add this info to the bugzilla
(https://bugzilla.kernel.org/show_bug.cgi?id=42606) if you haven't
already.

Bjorn
