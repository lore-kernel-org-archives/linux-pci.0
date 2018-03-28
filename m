Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.llwyncelyn.cymru ([82.70.14.225]:51138 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751058AbeC1X2I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Mar 2018 19:28:08 -0400
Date: Thu, 29 Mar 2018 00:28:05 +0100
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Timothy Normand Miller <theosib@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: HELP PLEASE: Without ugly hacks, no interrupt delivery at all
 to our driver; 3.10.0 kernel (RHEL7.4) on Intel 82X38/X48 chipset, Shuttle
 (SX38/FX38, Core 2 Duo)
Message-ID: <20180329002805.2824f7af@alans-desktop>
In-Reply-To: <CAK7bmU-P0siz3pD9cHeuKMzK0PHZd4R8XqFDKswVkr4hwZ=-2g@mail.gmail.com>
References: <CAK7bmU-P0siz3pD9cHeuKMzK0PHZd4R8XqFDKswVkr4hwZ=-2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> I suspect a large part of the problem is that our device isn't really
> a PCIe device.  It's a PCI device retrofitted with a TI
> XIO2000(A)/XIO2200A PCI Express-to-PCI Bridge.  Large numbers of this

That really shouldn't be an issue. Just about every PC up to a few years
ago has something that at least looks like a PCIe to PCI bridge on it
somewhere (or buried in the chipset) to handle the PCI slots. There are
also a vast number of older PCIe cards that are in fact PCI devices glued
to PCIe x1 this way (or by worse things) in the market.

..

> The next thing I notice is that all of a sudden, the interrupt line
> for our chip has changed:
> 
> 02:00.0 Display controller: Tech-Source Device 0043
>         Subsystem: Tech-Source Device 0043
>         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B+ DisINTx-
>         Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-  
>         Interrupt: pin A routed to IRQ 16
> 
> Some more debug messages later, and I find out that it was
> pci_enable_device that changed the IRQ line:

Yes it can do that.

> So, the pci_dev struct has had irq updated to 16, and lspci reports
> that the IRQ line has been updated to 16 in the hardware.  So why is
> it that when I read PCI config space directly, I get the old value?
> In fact, lspci is apparently LYING about this!  Here's what I get from
> a raw dump of PCI config space:

The hardware generates INTA-INTD, your bridge should turn those into the
in band PCIe messages for INTA-INTD. The IRQ 'number' is just a
configuration construct, and in fact it's very much a *PC* BIOS one.

However pci_assign_irq does always update the INTERRUPT_LINE register
because it has to do so for certain 'fake PCI' environments (like some
old VIA chipsets) where the INTERRUPT_LINE is used for IRQ routing magic
internally.

Anyway it shouldn't matter!

> long after booting.  There seems to be a global function pointer
> pcibios_enable_irq that is called from pcibios_enable_device.  And
> this brings me to the question as to what is the difference between
> pci_ calls and pcibios_ calls.  One thing I can see is that

Armwavingly 'generic' vs 'platform specific'. If you look at a modern
kernel you'll find pci_assign_irq deals with all of this and does update
the LINE register. 3.10 is five years old (I actually had hair when it
came out) so this is really the wrong place to worry about ancient
computing history.

> In the Documention on PCI, it mentions using pci_enable_msi and
> pci_enable_msix calls.  That and other text makes it pretty clear that
> INTx interrupts are the *default*, and MSI has to be enabled

Yes.

> explicitly.  Looking at do_pci_enable_device, if msi and msix are
> disabled, then it will clear PCI_COMMAND_INTX_DISABLE on the device,
> but it doesn't ascend the bridge hierarchy fixing those too.

Do you see the same problem with a current 4.x kernel ? If you then it's
definitely worth further discussion (and I've added linux-pci to the cc),
if it works fine in 4.14, then I'd stick your hack in the Red Hat driver,
and remember its not something anyone is too likely to fix there.

Alan
