Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34819 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbbJSQAk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2015 12:00:40 -0400
Received: by pasz6 with SMTP id z6so34063059pas.2
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2015 09:00:39 -0700 (PDT)
From: Roland Dreier <roland@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Running out of IO space because of innocuous-looking DSDT change
Date: Mon, 19 Oct 2015 09:00:36 -0700
Message-Id: <1445270436-3797-1-git-send-email-roland@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I recently ran into an interesting issue with IO space allocation, and
I'm looking for opinions on whether this is a BIOS issue, a kernel
issue, both, or neither ;)

What happened is that a BIOS update for my system changed the DSDT
from having three ranges in PCI0:

        WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
            0x0000,             // Granularity
            0x0000,             // Range Minimum
            0x03AF,             // Range Maximum
            0x0000,             // Translation Offset
            0x03B0,             // Length
            ,, , TypeStatic)
        WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
            0x0000,             // Granularity
            0x03E0,             // Range Minimum
            0x0CF7,             // Range Maximum
            0x0000,             // Translation Offset
            0x0918,             // Length
            ,, , TypeStatic)
        WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
            0x0000,             // Granularity
            0x03B0,             // Range Minimum
            0x03DF,             // Range Maximum
            0x0000,             // Translation Offset
            0x0030,             // Length
            ,, , TypeStatic)

to a single range:

        WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
            0x0000,             // Granularity
            0x0000,             // Range Minimum
            0x0CF7,             // Range Maximum
            0x0000,             // Translation Offset
            0x0CF8,             // Length
            ,, , TypeStatic)

Naively it seems like this shouldn't make a difference, since in the
end we've covered the space 0...0xCF7.  However because of the code

	min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;

	/* First, try exact prefetching match.. */
	ret = pci_bus_alloc_resource(bus, res, size, align, min,
				     IORESOURCE_PREFETCH,
				     pcibios_align_resource, dev);

in pci_bus_alloc_resource(), the single range ultimately means we end
up running out of IO space for our devices (we have various devices
asking for IO space as well as quite a few downstream PCI switch ports
that get allocated IO space).

What happens is that PCIBIOS_MIN_IO is 0x1000, so that code means with
the new BIOS we can't allocate any IO in the range 0...0xCF7; with the
old BIOS we only ruled out the range 0...0x3AF and happily put small
IO resources (for SMBus controller devices etc) at places like 0x480 etc.

Looking at the code and history, I see that the code with PCIBIOS_MIN_IO
is there to deal with systems where not all resources are declared
and the kernel might accidentally allocate something that clashes with
strange hardware.  However in my case I'm pretty confident there isn't
anything in the range we used to use (since my system didn't blow up,
and I know there isn't any weird proprietary stuff anyway).

Would it make sense to change the kernel to reduce PCIBIOS_MIN_IO in
my case?  I could make it generic and send it upstream, or just hack
it locally.  Or (given my ignorance of ACPI in the real world) is this
a broken BIOS change that I should ask my BIOS vendor to revert?
Or... ?

Thanks!
  Roland
