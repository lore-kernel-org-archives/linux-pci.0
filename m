Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751595AbeCVT2B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Mar 2018 15:28:01 -0400
Date: Thu, 22 Mar 2018 14:27:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wolfgang Denk <wd@denx.de>
Cc: linux-pci@vger.kernel.org
Subject: Re: PCIe x4 cards not detected on Z370 mainboards
Message-ID: <20180322192759.GA252023@bhelgaas-glaptop.roam.corp.google.com>
References: <20180322184840.E31D4247251@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180322184840.E31D4247251@gemini.denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 22, 2018 at 07:48:40PM +0100, Wolfgang Denk wrote:
> Hello,
> 
> sorry if this is not an appropriate list for my question - any
> pointers are welcome.

This is a perfect place to ask!

> Short version:
> 
> Both on a GIGABYTE Z370-HD3 and on a MSI Z370 TOMAHAWK mainboard
> neither of my LSI SAS controllers (SAS3444 E PCIe x4 and
> SAS3442E-R PCIe x4) gets detected.  Not by the system BIOS, there is
> not messages from the SAS Controller BIOS, Linux does not see it in
> the PCI bus scan - nothing.  Both controllers work find in older
> mainboards.
> 
> Is this a known problem?  Can it be fixed?
> 
> 
> More details:
> 
> I tried all combinations of PCIe slots with one or with both cards -
> none is working.
> 
> I asked MSI support, who told me:
> 
> 	These are old controllers which don't support UEFI/GOP. this
> 	is the reason they don't work.  Cards which have only legacy
> 	support cannot be operated in modern mainboards.

That doesn't make sense to me.  Maybe these controllers have option
ROMs that aren't compatible with UEFI (though even that sounds
unlikely to me).  But even in that case, I would expect the card to at
least be visible in PCI config space, because that's needed even to
read the option ROM from the card.

We have had issues with LSI devices in the past, e.g.,

  822155100e58 ("PCI: Mark Cavium CN8xxx to avoid bus reset")
  12d8706963f0 ("Revert "PCI: Make sure bus number resources stay within their parents bounds"")

822155100e58 is a band-aid to avoid bus resets when LSI devices are
involved.  We don't really have a root cause for that, so it's
possible you're seeing a similar issue.

12d8706963f0 has to do with a defect in an LSI device where it
apparently fails to latch its bus number correctly when the OS changes
it.  You never see the device at all, so the only bus number change
should be when the BIOS enumerates and programs bus numbers initially.
But it seems like the BIOS doesn't see the device either.

> Hm...  but I also have a PCIe x 1 Adaptect SCSI controller
> (29320LPE, firmware version v4.31.4 of 2007) which certainly never
> heard of UEFI/GOP before, and this is working fine: I see the BIOS
> messages when it does the SCSI bus scan, I see the initialization
> under Linux, and I can access the SCSI devices under Linux.

So we know the slot is functional at least for a x1 controller.  The
spec requires that a xN port can also form a x1 link (PCIe r4.0, sec
4.2.4.10.1), so I think your x4 controllers *should* be functional at
least at x1.

I wonder the port leading to that slot is disabled or not negotiating
the link for some reason.  Can you collect "lspci -vvv" output with
the working card and with one of the non-working cards?

You could try locating the port leading to the slot and using setpci
to reset its secondary bus, then using /sys/bus/pci/rescan to rescan
the bus.

Bjorn
