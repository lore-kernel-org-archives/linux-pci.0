Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 14 Mar 2016 20:48:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, linux-pci@vger.kernel.org,
	ravikanth.nalla@hpe.com, lenb@kernel.org, harish.k@hpe.com,
	ashwin.reghunandanan@hpe.com, bhelgaas@google.com,
	rjw@rjwysocki.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] acpi,pci,irq: reduce resource requirements
Message-ID: <20160315014843.GA16967@localhost>
References: <1457484079-18202-1-git-send-email-okaya@codeaurora.org>
 <20160314185251.GA19703@localhost>
 <56E7211F.3070203@codeaurora.org>
 <20160314210147.GA11459@localhost>
 <56E73232.9030704@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56E73232.9030704@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 14, 2016 at 05:50:42PM -0400, Sinan Kaya wrote:
> On 3/14/2016 5:01 PM, Bjorn Helgaas wrote:
> > On Mon, Mar 14, 2016 at 04:37:51PM -0400, Sinan Kaya wrote:
> >> Hi Bjorn,
> >>
> >> On 3/14/2016 2:52 PM, Bjorn Helgaas wrote:
> >>>> bool acpi_isa_irq_available(int irq)
> >>>>> @@ -840,13 +881,6 @@ bool acpi_isa_irq_available(int irq)
> >>>>>   */
> >>>>>  void acpi_penalize_sci_irq(int irq, int trigger, int polarity)
> >>>>>  {
> >>>>> -	if (irq >= 0 && irq < ARRAY_SIZE(acpi_irq_penalty)) {
> >>>>> -		if (trigger != ACPI_MADT_TRIGGER_LEVEL ||
> >>>>> -		    polarity != ACPI_MADT_POLARITY_ACTIVE_LOW)
> >>>>> -			acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_ALWAYS;
> >>>>> -		else
> >>>>> -			acpi_irq_penalty[irq] += PIRQ_PENALTY_PCI_USING;
> >>>>> -	}
> >>> I think we lost the validation of trigger mode and polarity, didn't
> >>> we?
> >>>
> >>
> >> This function gets called to inform ACPI that this is the SCI interrupt
> >> and, trigger and polarity are their attributes.
> >>
> >> The return value is void and the caller is not interested in what ACPI thinks
> >> about. 
> >>
> >> This function adjusts the SCI penalty based on correct attributes passed
> >> (ISA_ALWAYS vs. PCI_USING).
> >>
> >> I agree that we lost this validation. 
> >>
> >> I can keep sci_trigger/sci_polarity somewhere and keep that into the calculation
> >> in get function.
> >>
> >> Like this for instance,
> >>
> >> 	if (irq == acpi_gbl_FADT.sci_interrupt) {
> >> +		if (sci_trigger != ACPI_MADT_TRIGGER_LEVEL ||
> >> +		    sci_polarity != ACPI_MADT_POLARITY_ACTIVE_LOW)
> >> +			penalty += PIRQ_PENALTY_ISA_ALWAYS;
> >> +		else
> >> 			penalty += PIRQ_PENALTY_PCI_USING; 
> >> 	}
> >>
> >> Then, we can't get rid of the function just we can reduce the contents.
> > 
> > I think it's important to keep that check.
> > 
> > I raised the possibility of using irq_get_trigger_type() for all IRQs
> > (not just the SCI).  Did you have a chance to look into that at all?
> > 
> > Bjorn
> > 
> 
> Let's take care of SCI first. Is this OK? Would you include IRQ_TYPE_NONE below?
> 
> get_penalty
> {
> ...
> 	if (irq == acpi_gbl_FADT.sci_interrupt) {
> 		if (irq_get_trigger_type(irq) == IRQ_TYPE_LEVEL_LOW)
> 			penalty += PIRQ_PENALTY_PCI_USING;
> 		else
> 			penalty += PIRQ_PENALTY_ISA_ALWAYS;
> 	}
> }
> 
> 
> Yes, I read your email and asked how you would deal with ARM64. There was
> silence after that :) 

Sorry, I missed that.  Trying to juggle too many conversations at
once, I guess.

> ARM64 doesn't have SCI

That's not a problem; we just never have to penalize an IRQ because
SCI is also using it.

> and the PCI interrupts are
> active high and level.

This I don't understand.  I already cited PCI Spec r3.0, sec 2.2.6,
which says PCI interrupts are level-sensitive, asserted low.

If you go to Fry's and buy a conventional PCI card, it is going to
pull INTA# low to assert an interrupt.  It doesn't matter whether you
put it in an x86 system or an arm64 system.

> I pasted the code here again. It looks like you want to validate that
> PCI interrupts are always level low. 

I don't really care whether PCI interrupts are always level low.  What
matters is that the PCI interrupt line matches the configuration of
the interrupt controller input.

If the PCI interrupt can be a different type, e.g., level high, and
there's a way to discover that, we can check that against the
interrupt controller configuration.

This is all in the context of conventional PCI, and we're probably
talking about arm64 PCIe systems, not conventional PCI.  I'm not sure
what an Interrupt Link device means in PCIe.  I suppose it would have
to connect an INTx virtual wire to a system interrupt?  The PCIe spec
says this sort of mapping is system implementation specific (r3.0, sec
2.2.8.1).

> There could be also some other existing Intel platform or architecture 
> that quite doesn't encode the interrupt properly.
> 
>  
>    static int pci_compatible_trigger(int irq)
>    {
>      int type = irq_get_trigger_type(irq);
> 
>      return (type == IRQ_TYPE_LEVEL_LOW || type == IRQ_TYPE_NONE);
>    }
> 
> 
>    static unsigned int acpi_irq_get_penalty(int irq)
>    {
>      unsigned int penalty = 0;
> 
>      if (irq == acpi_gbl_FADT.sci_interrupt)
>        	penalty += PIRQ_PENALTY_PCI_USING;
> 
>      penalty += acpi_irq_pci_sharing_penalty(irq);
>      return penalty;
>    }
> 
>    static int acpi_pci_link_allocate(struct acpi_pci_link *link)
>    {
>      unsigned int best = ~0;
>      ...
> 
>      for (i = (link->irq.possible_count - 1); i >= 0; i--) {
>        candidate = link->irq.possible[i];
>        if (!pci_compatible_trigger(candidate))
>          continue;
> 
>        penalty = acpi_irq_get_penalty(candidate);
>        if (penalty < best) {
>        	    irq = candidate;
>             best = penalty;
>        }
>      }
>    }
> 
> 
> Sinan Kaya
> Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
