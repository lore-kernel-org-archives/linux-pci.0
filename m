Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.130]:58551 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573AbaBSUzG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Feb 2014 15:55:06 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>,
	Liviu Dudau <liviu@dudau.co.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King <rmk@arm.linux.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host controller
Date: Wed, 19 Feb 2014 21:48:48 +0100
Message-ID: <3905203.TvF8RmfLsz@wuerfel>
In-Reply-To: <CAErSpo5PCTyZ5jzumJxD=CCN+-t-Z31Cw+9ejT_oTQ4fFQePag@mail.gmail.com>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com> <3312083.odPX4th7oi@wuerfel> <CAErSpo5PCTyZ5jzumJxD=CCN+-t-Z31Cw+9ejT_oTQ4fFQePag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 19 February 2014 13:18:24 Bjorn Helgaas wrote:
> >
> > Right, this is an interesting case indeed, and I think we haven't
> > considered it in the binding so far. We already encode a "bus-range"
> > in DT, so we can easily partition the ECAM config space, but it
> > still violates one of the two assumptions:
> > a) that the register ranges for the two host bridge devices are
> >    non-overlapping in DT
> > b) that the ECAM register range as specified in DT starts at bus
> >    0 and is a power-of-two size.
> > Since the binding is not fixed that, we could change the definition to
> > say that the ECAM register range in the "reg" property must match
> > the buses listed in the "bus-range" property.
> 
> Addresses in the ACPI MCFG table correspond to bus number 0, but the
> MCFG also provides start & end bus numbers, so the valid range does
> not necessarily start with bus 0 and need not be power-of-two in size.
>  Something similar sounds like a good idea for DT.

Hmm, we'll have to think about that. From a DT perspective, we try
to keep things local to the node using it, so listing only the
registers we are allowed to access is more natural.

Another option would be to have a separate device node for the ECAM
registers and point to that from the host controller node, which
would describe this cleanly but also add a bit of complexity that
will rarely be used.

> > I still want to make sure I understand exactly what this case is about
> > though, i.e. what is shared and what is separate if you have two host
> > bridges with a common ECAM region:
> >
> > * I assume I/O space is always shared on x86, but probably separate
> >   elsewhere.
> 
> I think x86 *could* support multiple I/O spaces, but user-mode
> inb/outb could only reach the 0-64K space.  I think ia64 has the same
> limitation on user code, but it supports many spaces in the kernel.

Ok.

> > * Each host would always have a fixed memory space aperture, right?
> 
> The ACPI _CRS/_PRS/_SRS mechanism theoretically allows changes to the
> bus number, I/O space, and memory space apertures of host bridges.
> But we don't do any of those changes today, and I don't know if any
> BIOSes actually allow it.

I mean non-overlapping apertures in particular. We also have
cases where the aperture that we list in DT is just programmed
into hardware registers by the host driver and could be arbitrary,
but you can't normally have the same MMIO address go to two
devices on internal buses (or not in a sensible way).

> > * From what I understand from your description, the hardware does
> >   not enforce specific bus numbers for each host. How does the
> >   host bridge know its root bus number then?
> 
> I don't know details of any specific hardware.  I'm just saying that
> ACPI provides a mechanism for the OS to manipulate the bus number
> range below a host bridge.  Of course, a BIOS is free to omit _PRS and
> _SRS, and in that case, the bus/IO/memory apertures reported by _CRS
> are fixed and can't be changed.  We learn the root bus number from the
> host bridge _CRS (but I'm sure you knew that, so maybe I missed the
> point of your question).

I guess the answer then is that the host bridge can have a register
for programming the root bus number, but it's not standardized and
therefore the access is hidden in the _PRS/_SRS methods. If we have
the same on DT and want to reprogram the bus numbers, we'd need to
have a kernel driver for the nonstandard registers of the host bridge.

> > * Should I expect one IOMMU per host bridge or one ECAM region,
> >   or can either be possible?
> 
> It's possible to have multiple IOMMUs per host bridge, and I think
> they can even be buried down in the PCIe hierarchy.

Oh, I didn't know that. So how do you actually find the IOMMU for
a given domain/bus/device/function combination?

> > * The IntA-IntB IRQ numbers are always per host bridge I assume.
> 
> For conventional PCI, INTx are just wires that could go anywhere, so
> there's no connection between them and a host bridge.  You have to
> have a _PRT or similar to make sense out of them.  For PCIe, a Root
> Complex maps INTx emulation messages to system interrupts in an
> implementation-specific way, so we need a _PRT there, too.  I don't
> think there's a requirement that these IRQ numbers be per-host bridge.

Right, makes sense.

Thanks for the detailed explanations!

	Arnd
