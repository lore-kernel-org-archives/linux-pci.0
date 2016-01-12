Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33514 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933111AbcALLYJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Jan 2016 06:24:09 -0500
Date: Tue, 12 Jan 2016 11:25:48 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Matthew Minter <matt@masarand.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, Liviu.Dudau@arm.com,
	ddaney@caviumnetworks.com, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V4 08/29] x86/pci: Defer IRQ assignment to device enable
 time
Message-ID: <20160112112548.GB3601@red-moon>
References: <1445576642-29624-1-git-send-email-matt@masarand.com>
 <1445576642-29624-9-git-send-email-matt@masarand.com>
 <20151223230433.GA27708@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151223230433.GA27708@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Wed, Dec 23, 2015 at 05:04:33PM -0600, Bjorn Helgaas wrote:
> [+cc Thomas]
> 
> Hi Matthew,
> 
> On Fri, Oct 23, 2015 at 06:03:41AM +0100, Matthew Minter wrote:
> > The x86 architecture boot code currently traverses the PCI buses with
> > an extra pass in order to initialise the PCI device IRQs at boot, this
> > patch avoids this pass and defers the IRQ assignment untill device
> > enable time which also has the benefit that hot-plugged devices are
> > assigned IRQs without additional code.
> 
> I think the outline of this patch (doing the IRQ init at device
> enable-time instead of at boot-time) is good, but I am concerned about
> two things:
> 
> 1) pcibios_lookup_irq() contains a for_each_pci_dev() loop that
> updates dev->irq for all devices with the same pirq value.  Previously
> we ran that loop at boot-time via this path:
> 
>   pci_subsys_init                   # subsys_initcall
>     x86_init.pci.init_irq           # .init_irq = x86_default_pci_init_irq
>     x86_default_pci_init_irq        # x86_default_pci_init_irq = pcibios_irq_init
>     pcibios_irq_init
>       x86_init.pci.fixup_irqs       # .fixup_irqs = x86_default_pci_fixup_irqs
>       x86_default_pci_fixup_irqs    # x86_default_pci_fixup_irqs = pcibios_fixup_irqs
>       pcibios_fixup_irqs
>         for_each_pci_dev
>           pcibios_lookup_irq
> 
> Now we'll run it later, in this path:
> 
>   pci_enable_device
>     pci_enable_device_flags
>       do_pci_enable_device
>         pci_assign_irq
>           pci_map_irq                   # bridge->map_irq
>             pcibios_fixup_irq
>               pcibios_lookup_irq
>                 for_each_pci_dev(dev2)
>                   dev2->irq = irq       # <-- potential problem
> 
> The problem is that dev2 is an unrelated device and may already have a
> driver bound to it, and we shouldn't change dev->irq after a driver
> binds to a device.

Yes, this looks wrong. On the other hand, removing pci_fixup_irqs from
generic PCI code does not mean that we cannot implement it in x86 using
pci_assign_irq() (in arch code) and leave the current behaviour unchanged.

True, do_pci_enable_device() (or better pci_device_probe() as you say
below) would carry out the fixup unconditionally, but if arch code
carries out the fixup before do_pci_enable_device() I *guess* that the
one carried out in do_pci_enable_device() would become a nop (the fixup
already assigned an IRQ so basically doing it again in do_pci_enable_device()
should not change anything. Still, I am not a fan of this solution either).

I would avoid holding this patch series back, it is a nice clean-up.

> I don't know enough about interrupts and PIRQ to know whether this is
> really a problem in practice or not.  I added Thomas in case he knows.
> 
> 2) I'm also worried about the fact that we don't do the IRQ init until
> a driver calls pci_enable_device().  We've been doing some IRQ init in
> pcibios_alloc_irq() in this path for a long time:
> 
>   pci_subsys_init
>     ...
>       pcibios_fixup_irqs                # <-- moved from here ...
>         for_each_pci_dev
>   ...
>   pci_device_probe
>     pcibios_alloc_irq
>       pcibios_enable_irq                # pcibios_enable_irq = acpi_pci_irq_enable
>                                         # (or pirq_enable_irq, x86_of_pci_irq_enable, lguest_enable_irq, etc)
>       acpi_pci_irq_enable
>     __pci_device_probe
>       ...
> 	pci_drv->probe                  # driver .probe routine
> 	  ...
> 	    pci_enable_device
>               ...
>                 pci_fixup_irq           # <-- ... to here
> 
> I think there are two problems here:
> 
> 2.1) We changed the order of pcibios_enable_irq() and pci_fixup_irq().
> Both update dev->irq, and I doubt it's safe to reverse the order.
> 
> 2.2) It's conceivable that a driver may use interrupts without ever
> calling pci_enable_device().  That driver would be broken by this
> change.
> 
> I think we could probably fix both of these worries by calling
> pci_assign_irq() from pci_device_probe() instead of from
> do_pci_enable_device().

Yes, I think your proposal makes sense (we can even add it to
pci_device_add() (?), the pointers in the bridge used to carry out the
mapping, set-up in pci_create_root_bus()->pcibios_root_bridge_prepare()
are already set-up by the time that function is called).

Actually, executing pci_assign_irq() in pci_device_add(), would not
it solve the issue above too ? Certainly we would still have an issue
with hot-added devices (I have no idea how this works at present
on x86).

We have to decide if the assignment can be done in generic code or
in pcibios_* arches callbacks (to do it on a per-arch basis).

> I'm not so sure about the pcibios_lookup_irq() problem.  That's a
> little farther outside my area, so I'll have to look at that some
> more.
> 
> I really want to merge this stuff because it's a major cleanup, so I'm
> going to push on this more myself.  I'm just writing this as a
> heads-up in case anybody else has ideas.

+1, I am reviewing the ARM/ARM64 code to check for correctness.

Thanks,
Lorenzo

> 
> Bjorn
> 
> > Signed-off-by: Matthew Minter <matt@masarand.com>
> > ---
> >  arch/x86/include/asm/pci_x86.h |  7 +++--
> >  arch/x86/kernel/x86_init.c     |  1 -
> >  arch/x86/pci/irq.c             | 70 +++++++++++++++++++++---------------------
> >  3 files changed, 39 insertions(+), 39 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
> > index fa1195d..16fd8e9 100644
> > --- a/arch/x86/include/asm/pci_x86.h
> > +++ b/arch/x86/include/asm/pci_x86.h
> > @@ -90,6 +90,7 @@ extern unsigned int pcibios_irq_mask;
> >  
> >  extern raw_spinlock_t pci_config_lock;
> >  
> > +extern int pci_map_irq(struct pci_dev *dev, u8 slot, u8 pin);
> >  extern int (*pcibios_enable_irq)(struct pci_dev *dev);
> >  extern void (*pcibios_disable_irq)(struct pci_dev *dev);
> >  
> > @@ -119,7 +120,7 @@ extern int __init pci_acpi_init(void);
> >  extern void __init pcibios_irq_init(void);
> >  extern int __init pcibios_init(void);
> >  extern int pci_legacy_init(void);
> > -extern void pcibios_fixup_irqs(void);
> > +extern int pcibios_fixup_irq(struct pci_dev *dev, u8 pin);
> >  
> >  /* pci-mmconfig.c */
> >  
> > @@ -200,9 +201,9 @@ static inline void mmio_config_writel(void __iomem *pos, u32 val)
> >  #  define x86_default_pci_init		pci_legacy_init
> >  # endif
> >  # define x86_default_pci_init_irq	pcibios_irq_init
> > -# define x86_default_pci_fixup_irqs	pcibios_fixup_irqs
> > +# define x86_default_pci_fixup_irq	pcibios_fixup_irq
> >  #else
> >  # define x86_default_pci_init		NULL
> >  # define x86_default_pci_init_irq	NULL
> > -# define x86_default_pci_fixup_irqs	NULL
> > +# define x86_default_pci_fixup_irq	NULL
> >  #endif
> > diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
> > index 3839628..810f1dd 100644
> > --- a/arch/x86/kernel/x86_init.c
> > +++ b/arch/x86/kernel/x86_init.c
> > @@ -80,7 +80,6 @@ struct x86_init_ops x86_init __initdata = {
> >  	.pci = {
> >  		.init			= x86_default_pci_init,
> >  		.init_irq		= x86_default_pci_init_irq,
> > -		.fixup_irqs		= x86_default_pci_fixup_irqs,
> >  	},
> >  };
> >  
> > diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
> > index 350e785..15c507b 100644
> > --- a/arch/x86/pci/irq.c
> > +++ b/arch/x86/pci/irq.c
> > @@ -1021,47 +1021,38 @@ static int pcibios_lookup_irq(struct pci_dev *dev, int assign)
> >  	return 1;
> >  }
> >  
> > -void __init pcibios_fixup_irqs(void)
> > +int pcibios_fixup_irq(struct pci_dev *dev, u8 pin)
> >  {
> > -	struct pci_dev *dev = NULL;
> > -	u8 pin;
> > -
> > +	int irq = dev->irq;
> >  	DBG(KERN_DEBUG "PCI: IRQ fixup\n");
> > -	for_each_pci_dev(dev) {
> > -		/*
> > -		 * If the BIOS has set an out of range IRQ number, just
> > -		 * ignore it.  Also keep track of which IRQ's are
> > -		 * already in use.
> > -		 */
> > -		if (dev->irq >= 16) {
> > -			dev_dbg(&dev->dev, "ignoring bogus IRQ %d\n", dev->irq);
> > -			dev->irq = 0;
> > -		}
> > -		/*
> > -		 * If the IRQ is already assigned to a PCI device,
> > -		 * ignore its ISA use penalty
> > -		 */
> > -		if (pirq_penalty[dev->irq] >= 100 &&
> > -				pirq_penalty[dev->irq] < 100000)
> > -			pirq_penalty[dev->irq] = 0;
> > -		pirq_penalty[dev->irq]++;
> > +	/*
> > +	 * If the BIOS has set an out of range IRQ number, just
> > +	 * ignore it.  Also keep track of which IRQ's are
> > +	 * already in use.
> > +	 */
> > +	if (irq >= 16) {
> > +		dev_dbg(&dev->dev, "ignoring bogus IRQ %d\n", irq);
> > +		irq = 0;
> >  	}
> > +	/*
> > +	 * If the IRQ is already assigned to a PCI device,
> > +	 * ignore its ISA use penalty
> > +	 */
> > +	if (pirq_penalty[irq] >= 100 &&
> > +			pirq_penalty[irq] < 100000)
> > +		pirq_penalty[irq] = 0;
> > +	pirq_penalty[irq]++;
> >  
> > -	if (io_apic_assign_pci_irqs)
> > -		return;
> > +	if (io_apic_assign_pci_irqs || !pin)
> > +		return irq;
> >  
> > -	dev = NULL;
> > -	for_each_pci_dev(dev) {
> > -		pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
> > -		if (!pin)
> > -			continue;
> > +	/*
> > +	 * Still no IRQ? Try to lookup one...
> > +	 */
> > +	if (!irq && pcibios_lookup_irq(dev, 0))
> > +		irq = dev->irq;
> >  
> > -		/*
> > -		 * Still no IRQ? Try to lookup one...
> > -		 */
> > -		if (!dev->irq)
> > -			pcibios_lookup_irq(dev, 0);
> > -	}
> > +	return irq;
> >  }
> >  
> >  /*
> > @@ -1174,6 +1165,7 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
> >  		struct pci_sysdata *sd = bridge->bus->sysdata;
> >  		ACPI_COMPANION_SET(&bridge->dev, sd->companion);
> >  	}
> > +	bridge->map_irq = pci_map_irq;
> >  	return 0;
> >  }
> >  
> > @@ -1201,6 +1193,14 @@ void pcibios_penalize_isa_irq(int irq, int active)
> >  		pirq_penalize_isa_irq(irq, active);
> >  }
> >  
> > +int pci_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
> > +{
> > +	dev->irq = pcibios_fixup_irq(dev, pin);
> > +	if (pcibios_enable_irq(dev))
> > +		return -1;
> > +	return dev->irq;
> > +}
> > +
> >  static int pirq_enable_irq(struct pci_dev *dev)
> >  {
> >  	u8 pin = 0;
> > -- 
> > 2.6.2
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
