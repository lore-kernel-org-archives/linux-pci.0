Return-Path: <SRS0=zv1j=7G=linux.intel.com=andriy.shevchenko@kernel.org>
Return-Path: <SRS0=zv1j=7G=linux.intel.com=andriy.shevchenko@kernel.org>
Message-ID: <1501848579.29303.375.camel@linux.intel.com>
Subject: Re: [PATCH v1] x86/platform/intel-mid: Make IRQ allocation a bit
 more flexible
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, Ingo Molnar
	 <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Date: Fri, 04 Aug 2017 15:09:39 +0300
In-Reply-To: <20170803220804.GK20308@bhelgaas-glaptop.roam.corp.google.com>
References: <20170724173402.12939-1-andriy.shevchenko@linux.intel.com>
	 <20170803220804.GK20308@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2017-08-03 at 17:08 -0500, Bjorn Helgaas wrote:
> On Mon, Jul 24, 2017 at 08:34:02PM +0300, Andy Shevchenko wrote:
> > In the future we would use dynamic allocation for IRQ which brings
> > non-1:1 mapping for IOAPIC domain. Thus, we need to respect return
> > value
> > of mp_map_gsi_to_irq() and assign it back to the device structure.
> > 
> > Besides that we need to read GSI from interrupt pin register to
> > avoid
> > cases when some drivers will try to initialize PCI device twice in a
> > row
> > which will call pcibios_enable_irq() twice as well.
> 
> This seems sort of suspect.  It doesn't seem robust to rely on the
> value of PCI_INTERRUPT_LINE being zero before pcibios_enable_irq().

So, you are telling that it's possible to get pcibios_enable_irq()
called with PCI_INTERRUPT_LINE == 0?

> Can't we make pcibios_enable_irq() idempotent?  I guess I don't
> understand the real problem here.

Currently there is no problem here.

Firmware assigns IRQ line and wrote this to the configuration space.
Intel MID uses 1:1 mapping (IRQ domain is STRICT), so, it just allocates
a vector inside kernel with the very same number.

But...

If we switch to dynamic allocation (it's a default for ACPI case), _on
this platform_ we will get wrong allocation in the IOAPIC since mapping
is not 1:1 anymore.

That's what I'm trying to avoid (dev->irq after this patch points
correctly to dynamically allocated number).

For old SFI enabled platforms it will not make any change.

Note, there is no legacy PIC on this platform (as same case as for ACPI
HW reduced platforms), just IOAPIC.

> Is this really two separate patches that could be separated?

I didn't get this, what separation you see might be applied here?

> > 	serial 0000:00:04.1: Mapped GSI28 to IRQ5
> > 	serial 0000:00:04.2: Mapped GSI29 to IRQ5
> > 	serial 0000:00:04.3: Mapped GSI54 to IRQ5
> > 	8250_mid 0000:00:04.1: Mapped GSI28 to IRQ5
> > 	8250_mid 0000:00:04.2: Mapped GSI29 to IRQ6
> > 	8250_mid 0000:00:04.3: Mapped GSI54 to IRQ7
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  arch/x86/pci/intel_mid_pci.c                                 | 12
> > ++++++++++--
> >  arch/x86/platform/intel-mid/device_libs/platform_mrfld_wdt.c |  6
> > +++---
> >  2 files changed, 13 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/x86/pci/intel_mid_pci.c
> > b/arch/x86/pci/intel_mid_pci.c
> > index 5a18aedcb341..b901ece278dd 100644
> > --- a/arch/x86/pci/intel_mid_pci.c
> > +++ b/arch/x86/pci/intel_mid_pci.c
> > @@ -215,16 +215,23 @@ static int intel_mid_pci_irq_enable(struct
> > pci_dev *dev)
> >  	struct irq_alloc_info info;
> >  	int polarity;
> >  	int ret;
> > +	u8 gsi;
> >  
> >  	if (dev->irq_managed && dev->irq > 0)
> >  		return 0;
> >  
> > +	ret = pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &gsi);
> > +	if (ret < 0) {
> > +		dev_warn(&dev->dev, "Failed to read interrupt line:
> > %d\n", ret);
> > +		return ret;
> > +	}
> > +
> >  	switch (intel_mid_identify_cpu()) {
> >  	case INTEL_MID_CPU_CHIP_TANGIER:
> >  		polarity = IOAPIC_POL_HIGH;
> >  
> >  		/* Special treatment for IRQ0 */
> > -		if (dev->irq == 0) {
> > +		if (gsi == 0) {
> >  			/*
> >  			 * Skip HS UART common registers device
> > since it has
> >  			 * IRQ0 assigned and not used by the
> > kernel.
> > @@ -253,10 +260,11 @@ static int intel_mid_pci_irq_enable(struct
> > pci_dev *dev)
> >  	 * MRST only have IOAPIC, the PCI irq lines are 1:1 mapped
> > to
> >  	 * IOAPIC RTE entries, so we just enable RTE for the
> > device.
> >  	 */
> > -	ret = mp_map_gsi_to_irq(dev->irq, IOAPIC_MAP_ALLOC, &info);
> > +	ret = mp_map_gsi_to_irq(gsi, IOAPIC_MAP_ALLOC, &info);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > +	dev->irq = ret;
> >  	dev->irq_managed = 1;
> >  
> >  	return 0;
> > diff --git a/arch/x86/platform/intel-
> > mid/device_libs/platform_mrfld_wdt.c b/arch/x86/platform/intel-
> > mid/device_libs/platform_mrfld_wdt.c
> > index 9e304e2ea4f5..4f5fa65a1011 100644
> > --- a/arch/x86/platform/intel-mid/device_libs/platform_mrfld_wdt.c
> > +++ b/arch/x86/platform/intel-mid/device_libs/platform_mrfld_wdt.c
> > @@ -30,13 +30,13 @@ static int tangier_probe(struct platform_device
> > *pdev)
> >  {
> >  	struct irq_alloc_info info;
> >  	struct intel_mid_wdt_pdata *pdata = pdev-
> > >dev.platform_data;
> > -	int gsi, irq;
> > +	int gsi = TANGIER_EXT_TIMER0_MSI;
> > +	int irq;
> >  
> >  	if (!pdata)
> >  		return -EINVAL;
> >  
> >  	/* IOAPIC builds identity mapping between GSI and IRQ on
> > MID */
> > -	gsi = pdata->irq;
> >  	ioapic_set_alloc_attr(&info, cpu_to_node(0), 1, 0);
> >  	irq = mp_map_gsi_to_irq(gsi, IOAPIC_MAP_ALLOC, &info);
> >  	if (irq < 0) {
> > @@ -44,11 +44,11 @@ static int tangier_probe(struct platform_device
> > *pdev)
> >  		return irq;
> >  	}
> >  
> > +	pdata->irq = irq;
> >  	return 0;
> >  }
> >  
> >  static struct intel_mid_wdt_pdata tangier_pdata = {
> > -	.irq = TANGIER_EXT_TIMER0_MSI,
> >  	.probe = tangier_probe,
> >  };
> >  
> > -- 
> > 2.13.2
> > 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
