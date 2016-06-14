Return-Path: <lorenzo.pieralisi@arm.com>
Return-Path: <lorenzo.pieralisi@arm.com>
Date: Tue, 14 Jun 2016 10:30:19 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Duc Dang <dhdang@apm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Tomasz Nowicki <tn@semihalf.com>,
	Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Rafael Wysocki <rafael@kernel.org>,
	Hanjun Guo <hanjun.guo@linaro.org>, okaya@codeaurora.org,
	Jayachandran C <jchandra@broadcom.com>,
	robert.richter@caviumnetworks.com, Marcin Wojtas <mw@semihalf.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	David Daney <ddaney@caviumnetworks.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Mark Salter <msalter@redhat.com>, linux-pci@vger.kernel.org,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	linux-acpi@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linaro-acpi@lists.linaro.org, Jon Masters <jcm@redhat.com>,
	Andrea Gallo <andrea.gallo@linaro.org>, jeremy.linton@arm.com,
	liudongdong3@huawei.com, cov@codeaurora.org
Subject: Re: [PATCH V9 09/11] ARM64/PCI: ACPI support for legacy IRQs parsing
 and consolidation with DT code
Message-ID: <20160614093019.GB30560@red-moon>
References: <1465588519-11334-1-git-send-email-tn@semihalf.com>
 <1465588519-11334-10-git-send-email-tn@semihalf.com>
 <20160610233612.GB7671@localhost>
 <20160613104005.GA26738@red-moon>
 <CADaLNDk+pHar2t5Xhv9cvYqcXs3uPyWvTUB2MGKbiRrQWyQ-FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CADaLNDk+pHar2t5Xhv9cvYqcXs3uPyWvTUB2MGKbiRrQWyQ-FA@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 13, 2016 at 01:01:35PM -0700, Duc Dang wrote:
> On Mon, Jun 13, 2016 at 3:40 AM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > On Fri, Jun 10, 2016 at 06:36:12PM -0500, Bjorn Helgaas wrote:
> > > On Fri, Jun 10, 2016 at 09:55:17PM +0200, Tomasz Nowicki wrote:
> > > > To enable PCI legacy IRQs on platforms booting with ACPI, arch code
> > > > should include ACPI specific callbacks that parse and set-up the
> > > > device IRQ number, equivalent to the DT boot path. Owing to the current
> > > > ACPI core scan handlers implementation, ACPI PCI legacy IRQs bindings
> > > > cannot be parsed at device add time, since that would trigger ACPI scan
> > > > handlers ordering issues depending on how the ACPI tables are defined.
> > >
> > > Uh, OK :)  I can't figure out exactly what the problem is here -- I
> > > don't know where to look if I wanted to fix the scan handler ordering
> > > issues, and I don't know how I could tell if it would ever be safe to
> > > move this from driver probe-time back to device add-time.
> >
> > Right, the commit log could have been more informative.
> >
> > pcibios_add_device() was added in:
> >
> > commit d1e6dc91b532 ("arm64: Add architectural support for PCI")
> >
> > whose commit log does not specify why legacy IRQ parsing should
> > be done at pcibios_add_device() either, so honestly we had to
> > do with the information we have at hand.
> >
> > > I also notice that x86 and ia64 call acpi_pci_irq_enable() even later,
> > > when the driver *enables* the device.  Is there a reason you didn't do
> > > it at the same time as x86 and ia64?  This is another of those pcibios
> > > hooks that really don't do anything arch-specific, so I can imagine
> > > refactoring this somehow, someday.
> >
> > Yes, with [1], that was the goal, that stopped because [1] does not
> > work on x86.
> >
> > Only DT platform(s) affected by this change are all platforms relying on
> > drivers/pci/host/pci-xgene.c (others rely on pci_fixup_irqs() that
> > should be removed too), if on those platforms probing IRQs at device
> > enable time works ok I can update this patch (it can be done through [1]
> > once we figure out what to do with it on x86) and move the IRQ set-up at
> > pcibios_enable_device() time.
> >
> > @Duc: any feedback on this ?
> 
> Hi Lorenzo,
> 
> The changes to add pcibios_alloc_irq works fine on X-Gene PCIe
> 
> I also tried to remove pcibios_alloc_irq and move its code into
> pcibios_enable_device
> after pci_enable_resource call and legacy IRQ also works.

Thank you, that was important to check.

> Can you also point me to the discussion thread or some info. about the
> issue on x86 with [1]?
> I want to check if there is any more test case I need to verify.

http://marc.info/?l=linux-pci&m=145091187918297&w=2

I do not think there is much we can do, unless we convert pci_fixup_irqs
as per [1] but keep x86 code as-is (for now), there is a way to do it
it is just a matter of taking Matt's series and refactor it, there are
potential problems (not on xgene, but on other ARM platforms
where the IRQ legacy routing is done through pci_fixup_irqs()).

Lorenzo

> Regards,
> Duc Dang.
> 
> >
> > Thanks,
> > Lorenzo
> >
> > [1] http://www.spinics.net/lists/linux-pci/msg45950.html
> >
> > > Did we have this conversation before?  It seems vaguely familiar, so I
> > > apologize if you already explained this once.
> > >
> > > > To solve this problem and consolidate FW PCI legacy IRQs parsing in
> > > > one single pcibios callback (pending final removal), this patch moves
> > > > DT PCI IRQ parsing to the pcibios_alloc_irq() callback (called by
> > > > PCI core code at device probe time) and adds ACPI PCI legacy IRQs
> > > > parsing to the same callback too, so that FW PCI legacy IRQs parsing
> > > > is confined in one single arch callback that can be easily removed
> > > > when code parsing PCI legacy IRQs is consolidated and moved to core
> > > > PCI code.
> > > >
> > > > Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> > > > Suggested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > ---
> > > >  arch/arm64/kernel/pci.c | 11 ++++++++---
> > > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> > > > index d5d3d26..b3b8a2c 100644
> > > > --- a/arch/arm64/kernel/pci.c
> > > > +++ b/arch/arm64/kernel/pci.c
> > > > @@ -51,11 +51,16 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
> > > >  }
> > > >
> > > >  /*
> > > > - * Try to assign the IRQ number from DT when adding a new device
> > > > + * Try to assign the IRQ number when probing a new device
> > > >   */
> > > > -int pcibios_add_device(struct pci_dev *dev)
> > > > +int pcibios_alloc_irq(struct pci_dev *dev)
> > > >  {
> > > > -   dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
> > > > +   if (acpi_disabled)
> > > > +           dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
> > > > +#ifdef CONFIG_ACPI
> > > > +   else
> > > > +           return acpi_pci_irq_enable(dev);
> > > > +#endif
> > > >
> > > >     return 0;
> > > >  }
> > > > --
> > > > 1.9.1
> > > >
> > >
> 
