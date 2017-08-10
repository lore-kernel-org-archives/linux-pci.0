Return-Path: <SRS0=Obka=7M=linux.intel.com=andriy.shevchenko@kernel.org>
Return-Path: <SRS0=Obka=7M=linux.intel.com=andriy.shevchenko@kernel.org>
Message-ID: <1502356760.29303.381.camel@linux.intel.com>
Subject: Re: [PATCH v1] xen/pci: Use acpi_noirq_set() helper
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter
 Anvin" <hpa@zytor.com>,  x86@kernel.org, Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Date: Thu, 10 Aug 2017 12:19:20 +0300
In-Reply-To: <20170802214537.GM20308@bhelgaas-glaptop.roam.corp.google.com>
References: <20170717103907.77308-1-andriy.shevchenko@linux.intel.com>
	 <20170802214537.GM20308@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2017-08-02 at 16:45 -0500, Bjorn Helgaas wrote:
> On Mon, Jul 17, 2017 at 01:39:07PM +0300, Andy Shevchenko wrote:
> > No need to keep an #ifdef since we have a helper (in x86 world).
> > Use it instead.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Looks reasonable to me, and I assume some non-PCI tree will take it.

It seems either TODO list is long, or everyone from x86 is on vacation
:-)

Can't you push this through your tree?

> 
> > ---
> >  arch/x86/pci/xen.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
> > index c4b3646bd04c..9542a746dc50 100644
> > --- a/arch/x86/pci/xen.c
> > +++ b/arch/x86/pci/xen.c
> > @@ -409,10 +409,8 @@ int __init pci_xen_init(void)
> >  	pcibios_enable_irq = xen_pcifront_enable_irq;
> >  	pcibios_disable_irq = NULL;
> >  
> > -#ifdef CONFIG_ACPI
> >  	/* Keep ACPI out of the picture */
> > -	acpi_noirq = 1;
> > -#endif
> > +	acpi_noirq_set();
> >  
> >  #ifdef CONFIG_PCI_MSI
> >  	x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
> > -- 
> > 2.11.0
> > 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
