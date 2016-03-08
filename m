Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 8 Mar 2016 09:22:13 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	timur@codeaurora.org, cov@codeaurora.org,
	linux-pci@vger.kernel.org, ravikanth.nalla@hpe.com,
	lenb@kernel.org, harish.k@hpe.com, ashwin.reghunandanan@hpe.com,
	bhelgaas@google.com, rjw@rjwysocki.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] acpi, pci, irq: account for early penalty
 assignment
In-Reply-To: <20160308002558.GC26149@localhost>
Message-ID: <alpine.DEB.2.11.1603080915240.3859@nanos>
References: <56D5E43E.7050406@codeaurora.org> <20160301194340.GA19783@localhost> <56D7317F.7090500@codeaurora.org> <56D7ABFB.3070302@codeaurora.org> <56D84EA9.3080900@codeaurora.org> <20160303151048.GA3290@localhost> <56D8546B.5040908@codeaurora.org>
 <56D8745D.70509@codeaurora.org> <20160304180959.GA4794@localhost> <56DDB28F.1040300@codeaurora.org> <20160308002558.GC26149@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 7 Mar 2016, Bjorn Helgaas wrote:
> On Mon, Mar 07, 2016 at 11:55:43AM -0500, Sinan Kaya wrote:
> > It makes sense for SCI as it is Intel specific.
> > 
> > Unfortunately, this cannot be done in an arch independent way. Of course,
> > ARM had to implement its own thing. While level-triggered, active-low is
> > good for intel world, it is not for the ARM world. ARM uses active-high
> > level triggered.
> 
> I'm confused.  I don't think SCI is Intel-specific.  Per PCI Spec
> r3.0, sec 2.2.6, PCI interrupts are level-sensitive, asserted low.
> Per ACPI Spec v3.0, sec 2.1, the SCI is an "active, low, shareable,
> level interrupt".
> 
> Are you saying SCI is active-high on ARM?  If so, I don't think that's
> necessarily a huge problem, although we'd have to audit the ACPI code
> to make sure we handle it correctly.
> 
> The point here is that a PCI Interrupt Link can only use an IRQ that
> is level-triggered, active low.  If an IRQ is already set to any other
> state, whether for an ISA device or for an active-high SCI, we can't
> use it for a PCI Interrupt Link.
> 
> It'd be nice if there were a generic way we could figure out what the
> trigger mode of an IRQ is.  I was hoping can_request_irq() was that
> way, but I don't think it is, because it only looks at IRQF_SHARED,
> not at IRQF_TRIGGER_LOW.
> 
> Maybe irq_get_trigger_type() is what we want?

Yes, that gives you the trigger typ, if the interrupt is already set up.
 
>   static int pci_compatible_trigger(int irq)
>   {
>     int type = irq_get_trigger_type(irq);
> 
>     return (type == IRQ_TYPE_LEVEL_LOW || type == IRQ_TYPE_NONE);
>   }
> 
>   static unsigned int acpi_irq_get_penalty(int irq)
>   {
>     unsigned int penalty = 0;
> 
>     if (irq == acpi_gbl_FADT.sci_interrupt)
>       penalty += PIRQ_PENALTY_PCI_USING;
> 
>     penalty += acpi_irq_pci_sharing_penalty(irq);
>     return penalty;
>   }
> 
>   static int acpi_pci_link_allocate(struct acpi_pci_link *link)
>   {
>     unsigned int best = ~0;
>     ...
> 
>     for (i = (link->irq.possible_count - 1); i >= 0; i--) {
>       candidate = link->irq.possible[i];
>       if (!pci_compatible_trigger(candidate))
>         continue;
> 
>       penalty = acpi_irq_get_penalty(candidate);
>       if (penalty < best) {
>         irq = candidate;
>         best = penalty;
>       }
>     }
>     ...
>   }
> 
> This looks racy, because we test irq_get_trigger_type() without any
> kind of locking, and later acpi_register_gsi() calls
> irq_create_fwspec_mapping(), which looks like it sets the new trigger
> type.  But I don't know how to fix that.

Right, if that pci link allocation code can be executed concurrent, then you
might end up with problem, but isn't that a problem even without
irq_get_trigger_type()?

Thanks,

	tglx
