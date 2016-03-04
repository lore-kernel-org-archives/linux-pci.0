Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 4 Mar 2016 12:09:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, linux-pci@vger.kernel.org,
	ravikanth.nalla@hpe.com, lenb@kernel.org, harish.k@hpe.com,
	ashwin.reghunandanan@hpe.com, bhelgaas@google.com,
	rjw@rjwysocki.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] acpi, pci, irq: account for early penalty assignment
Message-ID: <20160304180959.GA4794@localhost>
References: <56D4A53A.1070708@codeaurora.org>
 <20160229223453.GA12162@localhost>
 <56D5E43E.7050406@codeaurora.org>
 <20160301194340.GA19783@localhost>
 <56D7317F.7090500@codeaurora.org>
 <56D7ABFB.3070302@codeaurora.org>
 <56D84EA9.3080900@codeaurora.org>
 <20160303151048.GA3290@localhost>
 <56D8546B.5040908@codeaurora.org>
 <56D8745D.70509@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56D8745D.70509@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 03, 2016 at 12:29:01PM -0500, Sinan Kaya wrote:
> On 3/3/2016 10:12 AM, Sinan Kaya wrote:
> > On 3/3/2016 10:10 AM, Bjorn Helgaas wrote:
> >> That was my idea, but your minimal patch from last night looks awfully
> >> attractive, and maybe it's not worth moving it to arch/x86.  I do think we
> >> could simplify the code significantly by getting rid of the kzalloc and
> >> acpi_irq_penalty_list from acpi_irq_set_penalty().  How about pushing on
> >> that a little bit first, and see what it looks like then?
> > 
> > OK. Let me go that direction.
> > 
> 
> How about this?
> 
> -- 
> Sinan Kaya
> Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

> From 6cc33747feb469fe4da2088f34e2c875a36f58f4 Mon Sep 17 00:00:00 2001
> From: Sinan Kaya <okaya@codeaurora.org>
> Date: Thu, 3 Mar 2016 10:14:22 -0500
> Subject: [PATCH] acpi,pci,irq: account for early penalty assignment
> 
> ---
>  drivers/acpi/pci_link.c | 77 ++++++++++++++++++++++++++++++-------------------
>  1 file changed, 47 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index fa28635..09eea42 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -87,6 +87,7 @@ struct acpi_pci_link {
> 
>  static LIST_HEAD(acpi_link_list);
>  static DEFINE_MUTEX(acpi_link_lock);
> +static int sci_irq, sci_irq_penalty;
> 
>  /* --------------------------------------------------------------------------
>                              PCI Link Device Management
> @@ -466,56 +467,71 @@ static int acpi_irq_isa_penalty[ACPI_MAX_ISA_IRQ] = {
>  	PIRQ_PENALTY_ISA_USED,		/* IRQ15 ide1 */
>  };
> 
> -struct irq_penalty_info {
> -	int irq;
> -	int penalty;
> -	struct list_head node;
> -};
> +static int acpi_irq_pci_sharing_penalty(int irq)
> +{
> +	struct acpi_pci_link *link;
> +	int penalty = 0;
> +	bool found = false;
> +
> +	list_for_each_entry(link, &acpi_link_list, list) {
> +		/*
> +		 * If a link is active, penalize its IRQ heavily
> +		 * so we try to choose a different IRQ.
> +		 */
> +		if (link->irq.active && link->irq.active == irq) {
> +			penalty += PIRQ_PENALTY_PCI_USING;
> +			found = true;
> +		} else {
> +			int i;
> +
> +			/*
> +			 * If a link is inactive, penalize the IRQs it
> +			 * might, but not as severely.

s/might/might use/

> +			 */
> +			for (i = 0; i < link->irq.possible_count; i++) {
> +				if (link->irq.possible[i] == irq) {
> +					penalty += PIRQ_PENALTY_PCI_POSSIBLE /
> +						link->irq.possible_count;
> +					found = true;
> +				}
> +			}
> +		}
> +	}
> 
> -static LIST_HEAD(acpi_irq_penalty_list);
> +	if (found)
> +		return penalty;
> +
> +	return PIRQ_PENALTY_PCI_AVAILABLE;

It's a nit, but I don't think "#define PIRQ_PENALTY_PCI_AVAILABLE 0"
adds any readability.  If we dropped that, you could get rid of
"found" as well, and simply "return penalty" here.

> +}
> 
>  static int acpi_irq_get_penalty(int irq)
>  {
> -	struct irq_penalty_info *irq_info;
> -
>  	if (irq < ACPI_MAX_ISA_IRQ)
>  		return acpi_irq_isa_penalty[irq];
> 
> -	list_for_each_entry(irq_info, &acpi_irq_penalty_list, node) {
> -		if (irq_info->irq == irq)
> -			return irq_info->penalty;
> -	}
> +	if (irq == sci_irq)
> +		return sci_irq_penalty;
> 
> -	return 0;
> +	return acpi_irq_pci_sharing_penalty(irq);

I think there are two issues here that should be teased apart a bit
more:

  1) Trigger settings: If the IRQ is configured as anything other than
  level-triggered, active-low, we can't use it at all for a PCI
  interrupt, and we should return an "infinite" penalty.  We currently
  increase the penalty for the SCI IRQ if it's not level/low, but
  doesn't it apply to *all* IRQs, not just the SCI IRQ?
  
  It looks like we do something similar in the pcibios_lookup_irq()
  loop that uses can_request_irq().  If we used can_request_irq() in
  pci_link.c, would that mean we could get rid of the SCI
  trigger/polarity stuff and just keep track of the SCI IRQ?  I don't
  know whether the SCI IRQ is hooked into whatever can_request_irq()
  uses, but it seems like it *should* be.

  2) Sharing with other devices: It seems useful to me to accumulate
  the penalties because even an IRQ in the 0-15 range might be used by
  PCI devices.  Wouldn't we want to count those users in addition to
  whatever ISA users there might be?  E.g., something like this:

    penalty = 0;

    if (irq < ACPI_MAX_ISA_IRQ)
      penalty += acpi_irq_isa_penalty[irq];

    if (irq == sci_irq)
      penalty += PIRQ_PENALTY_PCI_USING;

    penalty += acpi_irq_pci_sharing_penalty(irq);
    return penalty;

>  }
> 
>  static int acpi_irq_set_penalty(int irq, int new_penalty)
>  {
> -	struct irq_penalty_info *irq_info;
> -
>  	/* see if this is a ISA IRQ */
>  	if (irq < ACPI_MAX_ISA_IRQ) {
>  		acpi_irq_isa_penalty[irq] = new_penalty;
>  		return 0;
>  	}
> 
> -	/* next, try to locate from the dynamic list */
> -	list_for_each_entry(irq_info, &acpi_irq_penalty_list, node) {
> -		if (irq_info->irq == irq) {
> -			irq_info->penalty  = new_penalty;
> -			return 0;
> -		}
> +	if (irq == sci_irq) {
> +		sci_irq_penalty = new_penalty;
> +		return 0;
>  	}
> 
> -	/* nope, let's allocate a slot for this IRQ */
> -	irq_info = kzalloc(sizeof(*irq_info), GFP_KERNEL);
> -	if (!irq_info)
> -		return -ENOMEM;
> -
> -	irq_info->irq = irq;
> -	irq_info->penalty = new_penalty;
> -	list_add_tail(&irq_info->node, &acpi_irq_penalty_list);
> -
> +	/*
> +	 * This is the remaining PCI IRQs. They are calculated on the
> +	 * flight in acpi_irq_get_penalty function.
> +	 */
>  	return 0;
>  }

If we adopt the idea that we compute the penalties on the fly in
acpi_irq_get_penalty(), I don't think we need acpi_irq_penalty_init()
any more.  It does basically the same thing acpi_irq_get_penalty()
would do, and it's confusing to do it twice.

The acpi_irq_add_penalty() call in acpi_pci_link_allocate() should go
away for the same reason.

The acpi_irq_add_penalty() call in acpi_penalize_sci_irq() should go
away (assuming we can use can_request_irq() or something similar to
validate trigger settings).

I think acpi_irq_add_penalty() itself could go away, since the only
remaining user would be the command-line processing, which could just
set the penalty directly.

> 
> @@ -900,6 +916,7 @@ void acpi_penalize_sci_irq(int irq, int trigger, int polarity)
>  	if (irq < 0)
>  		return;
> 
> +	sci_irq = irq;

Possibly acpi_penalize_sci_irq() itself could go away, since all we
really need is the SCI IRQ, and we might be able to just use
acpi_gbl_FADT.sci_interrupt (I'm not 100% sure sci_interrupt is
identical to a Linux IRQ number; we'd have to check that).

>  	if (trigger != ACPI_MADT_TRIGGER_LEVEL ||
>  	    polarity != ACPI_MADT_POLARITY_ACTIVE_LOW)
>  		penalty = PIRQ_PENALTY_ISA_ALWAYS;
> --
> 1.8.2.1
> 

