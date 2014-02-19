Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:61547 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868AbaBSWNR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Feb 2014 17:13:17 -0500
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
Date: Wed, 19 Feb 2014 23:12:52 +0100
Message-ID: <3351875.BO8J5k2cFs@wuerfel>
In-Reply-To: <CAErSpo7g5G0vn_8tyRE52MK6YuTB8XhBbk9thhzLx4tg0hmDMg@mail.gmail.com>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com> <3905203.TvF8RmfLsz@wuerfel> <CAErSpo7g5G0vn_8tyRE52MK6YuTB8XhBbk9thhzLx4tg0hmDMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 19 February 2014 14:33:54 Bjorn Helgaas wrote:
> On Wed, Feb 19, 2014 at 1:48 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 19 February 2014 13:18:24 Bjorn Helgaas wrote:
> >> >
> >> > Right, this is an interesting case indeed, and I think we haven't
> >> > considered it in the binding so far. We already encode a "bus-range"
> >> > in DT, so we can easily partition the ECAM config space, but it
> >> > still violates one of the two assumptions:
> >> > a) that the register ranges for the two host bridge devices are
> >> >    non-overlapping in DT
> >> > b) that the ECAM register range as specified in DT starts at bus
> >> >    0 and is a power-of-two size.
> >> > Since the binding is not fixed that, we could change the definition to
> >> > say that the ECAM register range in the "reg" property must match
> >> > the buses listed in the "bus-range" property.
> >>
> >> Addresses in the ACPI MCFG table correspond to bus number 0, but the
> >> MCFG also provides start & end bus numbers, so the valid range does
> >> not necessarily start with bus 0 and need not be power-of-two in size.
> >>  Something similar sounds like a good idea for DT.
> >
> > Hmm, we'll have to think about that. From a DT perspective, we try
> > to keep things local to the node using it, so listing only the
> > registers we are allowed to access is more natural.
> 
> The combination of MCFG base address for bus 00 and the bus number
> range from _CRS, plus the obvious offset computation does effectively
> describe the registers you're allowed to access; it's just up to the
> OS to compute the offsets.

That's not what I meant. The 'reg' property is supposed to list the
registers that are exclusively owned by the device. We normally
expect that we want to request_mem_region() and ioremap() the entire
range for each device, which doesn't make sense if we only want a
small part of it, or if another device owns the same registers.

Having a separate device that just owns the ECAM region would work
fine, because then it can ioremap that once and get referenced
by the host bridge drivers.

> >> > * Should I expect one IOMMU per host bridge or one ECAM region,
> >> >   or can either be possible?
> >>
> >> It's possible to have multiple IOMMUs per host bridge, and I think
> >> they can even be buried down in the PCIe hierarchy.
> >
> > Oh, I didn't know that. So how do you actually find the IOMMU for
> > a given domain/bus/device/function combination?
> 
> For VT-d on x86, there's a DMAR table that describes the remapping
> units (IOMMUs), and each has a list of associated devices.  This is
> one place where the FW/OS interface uses segment and bus numbers.
> There's something different for AMD IOMMUs, but I think it also
> involves looking up the device in a table from the firmware.

Ok, that seems complicated. I hope we don't have to get this deep
on ARM and can keep it on a per host-bridge basis rather than having
to get down all the way to the device. We wouldn't be able to encode
IOMMUs for hotplugged devices in DT, because the firmware is no
longer running by the time they show up.

	Arnd
