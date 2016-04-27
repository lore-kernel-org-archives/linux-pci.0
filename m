Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34246 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752468AbcD0Lqk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 27 Apr 2016 07:46:40 -0400
Date: Wed, 27 Apr 2016 12:46:37 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Tomasz Nowicki <tn@semihalf.com>, arnd@arndb.de,
	will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org,
	hanjun.guo@linaro.org, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, jchandra@broadcom.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com
Subject: Re: [PATCH V6 06/13] arm64, pci, acpi: ACPI support for legacy IRQs
 parsing and consolidation with DT code.
Message-ID: <20160427114637.GA6795@red-moon>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <1460740008-19489-7-git-send-email-tn@semihalf.com>
 <20160427024430.GG6789@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160427024430.GG6789@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 26, 2016 at 09:44:30PM -0500, Bjorn Helgaas wrote:
> On Fri, Apr 15, 2016 at 07:06:41PM +0200, Tomasz Nowicki wrote:
> > To enable PCI legacy IRQs on platforms booting with ACPI, arch code
> > should include ACPI specific callbacks that parse and set-up the
> > device IRQ number, equivalent to the DT boot path. Owing to the current
> > ACPI core scan handlers implementation, ACPI PCI legacy IRQs bindings
> > cannot be parsed at device add time, since that would trigger ACPI scan
> > handlers ordering issues depending on how the ACPI tables are defined.
> 
> Can you be a little more specific about the issue here?  I think you
> mean pci_device_add()-time, because that's where we call
> pcibios_add_device.  Which ACPI tables are involved?  _PRT?  Why is
> that a problem?  We don't cache those tables any more after
> 181380b702ee ("PCI/ACPI: Don't cache _PRT, and don't associate them
> with bus numbers").

https://lists.linaro.org/pipermail/linaro-acpi/2015-October/005944.html

I think it is a scan handler ordering issue and probably by caching
_PRT this problem would not exist but I have to read the commit above
in details to understand if that's the case.

> x86 and ia64 both call acpi_pci_irq_enable() from
> pcibios_enable_device().  Could you do the same on ARM64?
> pcibios_enable_device() happens later than either pci_device_add() or
> pci_device_probe().

We could in theory. In practice we have to see if that triggers DT
regressions on PCI host controllers that do not call pci_fixup_irqs(),
but rely on the legacy IRQ routing to be done in arm64
pcibios_add_device().

> > To solve this problem and consolidate FW PCI legacy IRQs parsing in
> > one single pcibios callback (pending final removal), this patch moves
> > DT PCI IRQ parsing to the pcibios_alloc_irq() callback (called by
> > PCI core code at device probe time) and adds ACPI PCI legacy IRQs
> > parsing to the same callback too, so that FW PCI legacy IRQs parsing
> > is confined in one single arch callback that can be easily removed
> > when code parsing PCI legacy IRQs is consolidated and moved to core
> > PCI code.
> > 
> > Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> > Suggested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > ---
> >  arch/arm64/kernel/pci.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> > index c72de66..15109c11 100644
> > --- a/arch/arm64/kernel/pci.c
> > +++ b/arch/arm64/kernel/pci.c
> > @@ -50,11 +50,16 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
> >  }
> >  
> >  /*
> > - * Try to assign the IRQ number from DT when adding a new device
> > + * Try to assign the IRQ number when probing a new device
> >   */
> > -int pcibios_add_device(struct pci_dev *dev)
> > +int pcibios_alloc_irq(struct pci_dev *dev)
> >  {
> > -	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
> > +	if (acpi_disabled)
> > +		dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
> > +#ifdef CONFIG_ACPI
> > +	else
> > +		return acpi_pci_irq_enable(dev);
> > +#endif
> 
> Not your problem, but your patch makes it obvious: it's ugly that we
> set dev->irq to the IRQ returned from of_irq_parse_and_map_pci(), but
> acpi_pci_irq_enable() sets dev->irq internally.
> 
> x86 also has the situation of calling either acpi_pci_irq_enable() or
> of_irq_parse_and_map_pci(), and it looks like they can even decide at
> run-time as you can here.  If we're solving the same problem, can we
> use a similar mechanism?  x86 sets a pcibios_enable_irq function
> pointer.

Yes we could, but that's orthogonal to this patch, it's basically
rewriting this code in a different way and adding flexibility to the
function mapping irqs.

Thanks,
Lorenzo

> 
> >  	return 0;
> >  }
> > -- 
> > 1.9.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
