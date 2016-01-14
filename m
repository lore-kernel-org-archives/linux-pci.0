Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <1452797092.28109.42.camel@redhat.com>
Subject: Re: [PATCH V3 00/21] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
From: Mark Salter <msalter@redhat.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Sinan Kaya <okaya@codeaurora.org>,
	Tomasz Nowicki <tn@semihalf.com>, bhelgaas@google.com,
	arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rjw@rjwysocki.net, hanjun.guo@linaro.org,
	jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org, jchandra@broadcom.com, jcm@redhat.com
Date: Thu, 14 Jan 2016 13:44:52 -0500
In-Reply-To: <20160114175924.GC20706@red-moon>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
	 <1452785393.28109.16.camel@redhat.com> <5697C0EB.4020404@codeaurora.org>
	 <20160114161238.GA20706@red-moon> <1452789524.28109.24.camel@redhat.com>
	 <20160114170723.GB20706@red-moon> <1452792723.28109.31.camel@redhat.com>
	 <20160114175924.GC20706@red-moon>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2016-01-14 at 17:59 +0000, Lorenzo Pieralisi wrote:
> On Thu, Jan 14, 2016 at 12:32:03PM -0500, Mark Salter wrote:
> > On Thu, 2016-01-14 at 17:07 +0000, Lorenzo Pieralisi wrote:
> > > On Thu, Jan 14, 2016 at 11:38:44AM -0500, Mark Salter wrote:
> > > 
> > > [...]
> > > 
> > > > You would lose that bet. AddressMinimum/Maximum describe the
> > > > PCI bus addresses.
> > > 
> > > In the mainline DT (APM Mustang), the CPU physical address corresponding
> > > to IO space is 0xe010000000, PCI bus address is 0x0.
> > > 
> > > >                 QWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
> > > >                     0x0000000000000000, // Granularity
> > > >                     0x0000000010000000, // Range Minimum
> > > 
> > > 
> > > >                     0x000000001000FFFF, // Range Maximum
> > > >                     0x000000E000000000, // Translation Offset
> > > 
> > > See above, I will get the APM specifications to countercheck.
> > 
> > The spec won't help other than to verify that the PCIe bridge supports
> > a 32-bit IO address space. The firmware sets the PCI bus base @
> > 0x10000000 with a CPU base address for that window @ 0xe010000000. The
> > pci-xgene.c driver sets the PCI bus IO base address to whatever DT
> > tells it too. For ACPI, we have to use whatever the firmware set it to
> > and described it in the ACPI table.
> 
> It makes sense, thank you for clarifying (and sorry for jumping
> to conclusions, I am a bit worried about the ACPI IO space descriptors
> specification and usage on arm64).
> 
> > When I looked at this a while back, neither ACPI nor PCI had anything
> > which disallowed 32-bit IO space on the PCI bus. The 16-bit limit is
> > an x86 limit in the instruction set.
> 
> We should ask Jiang to remove that check or to make it x86 only (does
> current mainline - where the offset is added to the resource start/end -
> work on ia64 ?)

I think current mainline ia64 would work only for IO spaces which don't
exceed 64KiB in size. Otherwise it would trip on the same check disabling
Mustang IO space. ia64-specific code supports multiple IO spaces but they
all are expected to start at PCI bus address zero. At least my reading of
that code leads me to believe it is broken otherwise. In any case, those
IO spaces on the PCI bus could exceed 64K in size and any of those which do
would get caught by the 64K check in generic code and disabled.

> 
> Thanks,
> Lorenzo
> 
> > 
> > > 
> > > I agree with you we have to verify if this IO space limitation is
> > > real or it is just an x86ism, in which case we remove that check.
> > > 
> > > Lorenzo
> > > >                     0x0000000000010000, // Length
> > > >                     ,, , TypeStatic)
> > > 
> > > > 
> > > > 
> > > > > Jiang's patch:
> > > > > 
> > > > > https://lkml.org/lkml/2015/12/16/249
> > > > > 
> > > > > parses the IO descriptors and stores the AddressMinimum, AddressMaximum
> > > > > in the IO resource (with AddressTranslation as offset which must be the
> > > > > *CPU* physical address mapping IO), from the log above it seems to me in
> > > > > AddressMinimum APM specifies the *CPU* physical address generating IO
> > > > > cycles.
> > > > > 
> > > > > All in all, I was right to fear this would happen, and I already
> > > > > raised the point within the ACPI spec working group, ACPI IO
> > > > > descriptors specification is ambiguous and we must agree on how
> > > > > they have to be specified once for all.
> > > > > 
> > > > > Lorenzo
> > > > 
> > 

