Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linaro-kernel <linaro-kernel@lists.linaro.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v7 1/6] pci: Introduce pci_register_io_range() helper function.
Date: Mon, 07 Apr 2014 13:36:15 +0200
Message-ID: <5183143.FxBNM0xTAV@wuerfel>
In-Reply-To: <20140407083120.GE17163@e106497-lin.cambridge.arm.com>
References: <1394811272-1547-1-git-send-email-Liviu.Dudau@arm.com> <20140405001953.GE15806@google.com> <20140407083120.GE17163@e106497-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 07 April 2014 09:31:20 Liviu Dudau wrote:
> On Sat, Apr 05, 2014 at 01:19:53AM +0100, Bjorn Helgaas wrote:
>
> > Host bridges on x86 could have MMIO apertures that turn CPU memory accesses
> > into PCI port accesses.  We could implement any number of I/O port spaces
> > this way, by making the kernel inb()/outb()/etc. interfaces smart enough to
> > use the memory-mapped space instead of (or in addition to) the
> > INB/OUTB/etc. instructions.

PowerPC actually has this already, as CONFIG_PPC_INDIRECT_PIO meaning that
access to PIO registers is bus specific, and there is also CONFIG_PPC_INDIRECT_MMIO
for the case where MMIO access is not native.
 
> Right, sorry for my ignorance then: how does *currently* the device driver do
> the I/O transfer transparent of the implementation mechanism? Or they have
> intimate knowledge of wether the device is behind a host bridge and can do MMIO
> or is on an ISA or CF bus and then it needs INB/OUTB ? And if we make inb/outb
> smarter, does that mean that we need to change the drivers?

The idea of that would be to not change drivers.

My preference here would be to only have a generic function for those
architectures that have the simple MMIO access all the time.

> > ia64 does this (see arch/ia64/include/asm/io.h for a little description)
> > and I think maybe one or two other arches have something similar.
> > 
> > > Introduce a pci_register_io_range() helper function that can be used
> > > by the architecture code to keep track of the I/O ranges described by the
> > > PCI bindings. If the PCI_IOBASE macro is not defined that signals
> > > lack of support for PCI and we return an error.
> > 
> > I don't quite see how you intend to use this, because this series doesn't
> > include any non-stub implementation of pci_register_io_range().
> > 
> > Is this anything like the ia64 strategy I mentioned above?  If so, it would
> > be really nice to unify some of this stuff.
> 
> After discussions with Arnd and Catalin I know have a new series that moves
> some of the code from arm64 series into this one. I am putting it through
> testing right know as I am going to have to depend on another series that
> makes PCI_IOBASE defined only for architectures that do MMIO in order to
> choose the correct default implementation for these functions. My hope is
> that I will be able to send the series this week.

I think migrating other architectures to use the same code should be
a separate effort from adding a generic implementation that can be
used by arm64. It's probably a good idea to have patches to convert
arm32 and/or microblaze.

	Arnd
