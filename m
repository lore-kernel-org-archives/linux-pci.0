Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45742 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933522AbcCHA3N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 7 Mar 2016 19:29:13 -0500
Date: Mon, 7 Mar 2016 18:29:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, linux-pci@vger.kernel.org,
	ravikanth.nalla@hpe.com, lenb@kernel.org, harish.k@hpe.com,
	ashwin.reghunandanan@hpe.com, bhelgaas@google.com,
	rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V2] acpi, pci, irq: account for early penalty assignment
Message-ID: <20160308002909.GA13250@localhost>
References: <20160301194340.GA19783@localhost>
 <56D7317F.7090500@codeaurora.org>
 <56D7ABFB.3070302@codeaurora.org>
 <56D84EA9.3080900@codeaurora.org>
 <20160303151048.GA3290@localhost>
 <56D8546B.5040908@codeaurora.org>
 <56D8745D.70509@codeaurora.org>
 <20160304180959.GA4794@localhost>
 <56DDB28F.1040300@codeaurora.org>
 <20160308002558.GC26149@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160308002558.GC26149@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Thomas for real, sorry]

On Mon, Mar 07, 2016 at 06:25:58PM -0600, Bjorn Helgaas wrote:
> [+cc Thomas, irq_get_trigger_type() question below]
> 
> On Mon, Mar 07, 2016 at 11:55:43AM -0500, Sinan Kaya wrote:
> > On 3/4/2016 1:09 PM, Bjorn Helgaas wrote:
> > > On Thu, Mar 03, 2016 at 12:29:01PM -0500, Sinan Kaya wrote:
> > >> On 3/3/2016 10:12 AM, Sinan Kaya wrote:
> > >>> On 3/3/2016 10:10 AM, Bjorn Helgaas wrote:
> 
> > >> From 6cc33747feb469fe4da2088f34e2c875a36f58f4 Mon Sep 17 00:00:00 2001
> > >> From: Sinan Kaya <okaya@codeaurora.org>
> > >> Date: Thu, 3 Mar 2016 10:14:22 -0500
> > >> Subject: [PATCH] acpi,pci,irq: account for early penalty assignment
> > >>
> > >> ---
> > >>  drivers/acpi/pci_link.c | 77 ++++++++++++++++++++++++++++++-------------------
> > >>  1 file changed, 47 insertions(+), 30 deletions(-)
> > >>
> > >> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> > >> index fa28635..09eea42 100644
> > >> --- a/drivers/acpi/pci_link.c
> > >> +++ b/drivers/acpi/pci_link.c
> 
> > >>  static int acpi_irq_get_penalty(int irq)
> > >>  {
> > >> -	struct irq_penalty_info *irq_info;
> > >> -
> > >>  	if (irq < ACPI_MAX_ISA_IRQ)
> > >>  		return acpi_irq_isa_penalty[irq];
> > >>
> > >> -	list_for_each_entry(irq_info, &acpi_irq_penalty_list, node) {
> > >> -		if (irq_info->irq == irq)
> > >> -			return irq_info->penalty;
> > >> -	}
> > >> +	if (irq == sci_irq)
> > >> +		return sci_irq_penalty;
> > >>
> > >> -	return 0;
> > >> +	return acpi_irq_pci_sharing_penalty(irq);
> > > 
> > > I think there are two issues here that should be teased apart a bit
> > > more:
> > > 
> > >   1) Trigger settings: If the IRQ is configured as anything other than
> > >   level-triggered, active-low, we can't use it at all for a PCI
> > >   interrupt, and we should return an "infinite" penalty.  We currently
> > >   increase the penalty for the SCI IRQ if it's not level/low, but
> > >   doesn't it apply to *all* IRQs, not just the SCI IRQ?
> > 
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
> 
> > >   It looks like we do something similar in the pcibios_lookup_irq()
> > >   loop that uses can_request_irq().  If we used can_request_irq() in
> > >   pci_link.c, would that mean we could get rid of the SCI
> > >   trigger/polarity stuff and just keep track of the SCI IRQ?  I don't
> > >   know whether the SCI IRQ is hooked into whatever can_request_irq()
> > >   uses, but it seems like it *should* be.
> > 
> > Sorry, you lost me here. We are only tracking sci_irq and sci_penalty. 
> > Do you want to add an additional check here? something like this?
> > 
> >         if (trigger != ACPI_MADT_TRIGGER_LEVEL ||
> > -           polarity != ACPI_MADT_POLARITY_ACTIVE_LOW)
> > +           polarity != ACPI_MADT_POLARITY_ACTIVE_LOW) &&
> > +           !can_request_irq(irq, IRQF_SHARED | IRQF_TRIGGER_LOW))
> 
> I'm saying:
> 
>   - If the IRQ trigger type is anything other than level/low, reject
>     this IRQ, and
> 
>   - If this IRQ is the SCI IRQ, penalize the IRQ as though we have a
>     PCI device already using it.
> 
> > > If we adopt the idea that we compute the penalties on the fly in
> > > acpi_irq_get_penalty(), I don't think we need acpi_irq_penalty_init()
> > > any more.  It does basically the same thing acpi_irq_get_penalty()
> > > would do, and it's confusing to do it twice.
> > 
> > Agreed, I was going to take it out. I didn't want to get on it yet. Emptied
> > the function now.
> 
> You might be able to do this incrementally, in several patches, and
> I'd prefer that if it's possible.  It's much easier to review patches
> if each one is as small as possible and changes only one thing at a
> time.
> 
> > >> @@ -900,6 +916,7 @@ void acpi_penalize_sci_irq(int irq, int trigger, int polarity)
> > >>  	if (irq < 0)
> > >>  		return;
> > >>
> > >> +	sci_irq = irq;
> > > 
> > > Possibly acpi_penalize_sci_irq() itself could go away, since all we
> > > really need is the SCI IRQ, and we might be able to just use
> > > acpi_gbl_FADT.sci_interrupt (I'm not 100% sure sci_interrupt is
> > > identical to a Linux IRQ number; we'd have to check that).
> > 
> > Is SCI IRQ exclusive in general? We are now keeping track of SCI IRQ and 
> > adding penalty when irq matches sci_irq in get_penalty function. 
> > 
> > How do we make sci_irq_penalty and acpi_penalize_sci_irq disappear?
> 
> I don't think the SCI IRQ needs to be exclusive.  The ACPI spec says
> it should be sharable, as long as the other devices use a compatible
> trigger mode (level/low per spec).
> 
> If we know the SCI IRQ, we don't need sci_irq_penalty or
> acpi_penalize_sci_irq() because we can penalize an IRQ with the
> PIRQ_PENALTY_PCI_USING, something like this:
> 
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
> 
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
