Return-Path: <SRS0=zv1j=7G=linux.intel.com=andriy.shevchenko@kernel.org>
Return-Path: <SRS0=zv1j=7G=linux.intel.com=andriy.shevchenko@kernel.org>
Message-ID: <1501854195.29303.377.camel@linux.intel.com>
Subject: Re: [PATCH v1] x86/platform/intel-mid: Make IRQ allocation a bit
 more flexible
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, Ingo Molnar
	 <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Date: Fri, 04 Aug 2017 16:43:15 +0300
In-Reply-To: <20170804132418.GB16580@bhelgaas-glaptop.roam.corp.google.com>
References: <20170724173402.12939-1-andriy.shevchenko@linux.intel.com>
	 <20170803220804.GK20308@bhelgaas-glaptop.roam.corp.google.com>
	 <1501848579.29303.375.camel@linux.intel.com>
	 <20170804132418.GB16580@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2017-08-04 at 08:24 -0500, Bjorn Helgaas wrote:
> On Fri, Aug 04, 2017 at 03:09:39PM +0300, Andy Shevchenko wrote:
> > On Thu, 2017-08-03 at 17:08 -0500, Bjorn Helgaas wrote:
> > > On Mon, Jul 24, 2017 at 08:34:02PM +0300, Andy Shevchenko wrote:
> > > > In the future we would use dynamic allocation for IRQ which
> > > > brings
> > > > non-1:1 mapping for IOAPIC domain. Thus, we need to respect
> > > > return
> > > > value
> > > > of mp_map_gsi_to_irq() and assign it back to the device
> > > > structure.
> > > > 
> > > > Besides that we need to read GSI from interrupt pin register to
> > > > avoid
> > > > cases when some drivers will try to initialize PCI device twice
> > > > in a
> > > > row
> > > > which will call pcibios_enable_irq() twice as well.
> > > 
> > > This seems sort of suspect.  It doesn't seem robust to rely on the
> > > value of PCI_INTERRUPT_LINE being zero before
> > > pcibios_enable_irq().
> > 
> > So, you are telling that it's possible to get pcibios_enable_irq()
> > called with PCI_INTERRUPT_LINE == 0?
> 
> I don't know about that.  I'm just saying that it sounds like you're
> relying on some condition that is hard to verify.  PCI_INTERRUPT_LINE
> is read/write and it's hard to know what, if anything, BIOS did with
> it.

_On this platform_ BIOS provides a static mapping for IRQ lines (there
is no separate PIR, just IOAPIC). So, that register is initialized by
firmware. We are not suppose to touch it _on this platform_.

> > > Can't we make pcibios_enable_irq() idempotent?  I guess I don't
> > > understand the real problem here.
> > 
> > Currently there is no problem here.
> > 
> > Firmware assigns IRQ line and wrote this to the configuration space.
> > Intel MID uses 1:1 mapping (IRQ domain is STRICT), so, it just
> > allocates
> > a vector inside kernel with the very same number.
> > 
> > But...
> > 
> > If we switch to dynamic allocation (it's a default for ACPI case),
> > _on
> > this platform_ we will get wrong allocation in the IOAPIC since
> > mapping
> > is not 1:1 anymore.
> > 
> > That's what I'm trying to avoid (dev->irq after this patch points
> > correctly to dynamically allocated number).
> > 
> > For old SFI enabled platforms it will not make any change.
> > 
> > Note, there is no legacy PIC on this platform (as same case as for
> > ACPI
> > HW reduced platforms), just IOAPIC.
> > 
> > > Is this really two separate patches that could be separated?
> > 
> > I didn't get this, what separation you see might be applied here?
> 
> The "Besides that" in your changelog suggested that "here is another
> change lumped into this patch."  I was wondering if the "read GSI from
> PCI_INTERRUPT_LINE" part could be separated out.  That makes me wonder
> whether this is really safe, since GSIs are 32 bits, but
> PCI_INTERRUPT_LINE is only 8 bits.  I don't know enough to know why
> this is safe in this case.

"Besides that" part means "we have a second circumstance we have to
follow to avoid breaking working platforms".

The old code, if you look into patch, uses dev->irq as a predefined
constant, which is not in case of dynamic allocation, so, if we respect
return value from mp_map_gsi_to_irq() we may not use dev->irq as
_source_ of IRQ mapping anymore.

I didn't check if we can do things in reversed order than I have done,
i.e. apply part 2 as separate change and then respect the return value.
It looks like it may be done in this way.

However, the patch is applied and I don't see any strong reason
to revert it and bring again as a set of two patches. Thanks for your
input anyway!

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
