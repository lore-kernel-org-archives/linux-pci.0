Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-out6.electric.net ([192.162.217.185]:56588 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbdJKKEP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2017 06:04:15 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: 'Bjorn Helgaas' <helgaas@kernel.org>
CC: "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>
Subject: RE: PCIe error reporting
Date: Wed, 11 Oct 2017 10:04:15 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD0090E73@AcuExch.aculab.com>
References: <063D6719AE5E284EB5DD2968C1650D6DD008D9F2@AcuExch.aculab.com>
 <20171010211035.GY25517@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20171010211035.GY25517@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas
> Sent: 10 October 2017 22:11
> On Mon, Oct 09, 2017 at 03:12:45PM +0000, David Laight wrote:
> > I'm trying to determine how a PCIe card we are building handles (and
> > hopefully recovers from) PCIe link errors.
> > However I'm not at all sure what I should expect the x86 Linux host to do.
> >
> > The card has an Altera FPGA and I can monitor things like changes to
> > it's LTSSM state engine, but not quite the full operation of the PCIe logic.
> >
> > I've enabled AER and lspci seems to decode most of the bits but
> > it looks as though something needs to detect error bits being set
> > log the error and then clear them.
> >
> > I did a rather brutal test - shorted the TX lines after the caps.
> > The card's PCIe logic issued a reset to the internal logic before
> > bringing the PCIe link back up.
> > I could then read config space - but the BARs were all zero
> > (I think lspci reported the old values, but the -x data showed zeros).
> > Nothing seemed to indicate the Linux thought anything was wrong.
> > Not surprisingly reads returned ~0u.

I've confirmed that lspci is giving the cached values for the BARs.

The card is setting its AER registers to something that looks sensible.
The 'error pointer' referred to a read TLP that didn't match a BAR (all zero).
I can also clear down the error bits (with setpci).
Presumably the read TLP was forwarded because the bridge is still
forwarding the requests.

> > On that system (XEON E5-2600) dmesg contains (retyped):
> >   acpi: PNP0A08:00: _OSC: platform does not support [AER]
> 
> Per the PCI Firmware spec r3.0, sec 4.5.1, on ACPI platforms, the OS
> is supposed to use _OSC to ask the firmware for permission before
> using AER.  In this case, the firmware declined to grant us
> permission, so we're not supposed to do anything at all with AER.

I read that as 'BIOS knows nothing about AER' rather than 'BIOS
refused to hand over control' - but I could be wrong.

I'm not sure where to look to see if the actual hardware does.
I'm guessing that Intel Haswell-E should.

An original pdf document I found about AER (from 2.16.x days) mentioned
a kernel parameter to enable the AER interrupts even if the BIOS didn't
support them.
But I failed to spot that in the current kernel source.
Could it be done as a sysctl rather than a boot parameter?

> > Another system is even more 'useless', it reports "AER handled
> > by the firmware".
> 
> This means the ACPI HEST table has the "firmware first" bit set, which
> means the BIOS is supposed to field the AER interrupt, read the AER
> logging CSRs, package them up, and deliver them to the OS.  The OS is
> supposed to feed the error info into the OS AER recovery path.

Hmmm...
These are Dell servers with a 'server management board'.
I suspect that 'handled' means 'logged' and since a 'PCIe link
down' is probably a 'fatal' error (for that link) they assume
it is a system wide fatal error that is unrecoverable.
So deem an NMI the correct action.

Maybe I can manage to send a read TLP for an address that is in
the range the bridge forwards, but outside the actual BARs.
(There are plenty of such addresses, just need to get one mapped
into kernel space.)

> Linux AER recovery *should* work on this system.  But I don't think
> AER is well-tested in general, and any time we have firmware-OS
> interfaces, there's always potential for misunderstandings.

The old 'it works with windows'....

	David
