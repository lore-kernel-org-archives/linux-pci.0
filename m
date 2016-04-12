Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37052 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181AbcDLFTq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Apr 2016 01:19:46 -0400
Date: Tue, 12 Apr 2016 00:19:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, linux-pci@vger.kernel.org,
	ravikanth.nalla@hpe.com, lenb@kernel.org, harish.k@hpe.com,
	ashwin.reghunandanan@hpe.com, bhelgaas@google.com,
	rjw@rjwysocki.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/3] acpi,pci,irq: reduce resource requirements
Message-ID: <20160412051942.GE11361@localhost>
References: <1460165192-4526-1-git-send-email-okaya@codeaurora.org>
 <1460165192-4526-2-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460165192-4526-2-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sinan,

I was hoping we could *simplify* this, but I think it's just getting
even more complicated (it's a net addition of 100 lines), which is due
to feature creep that I'm afraid is my fault.

IIRC, the main thing you need is to get rid of some early memory
allocation.

I don't think all the trigger mode/level checking is worth it.  The
current code doesn't do it, and it's not fixing a problem for you.
It's conceivable that it could even make us trip over a new problem,
e.g., some broken BIOS that we currently tolerate.

I think you could make this a little easier to review if you split
things like the acpi_irq_penalty[] -> acpi_isa_irq_penalty[] rename
into their own patches.  Little patches like that are trivial to
review because a simple rename is pretty safe, and then the patches
that actually *do* interesting things are smaller and easier to
review, too.

On Fri, Apr 08, 2016 at 09:26:30PM -0400, Sinan Kaya wrote:
> Code has been redesigned to calculate penalty requirements on the fly. This
> significantly simplifies the implementation and removes some of the init
> calls from x86 architecture. Command line penalty assignment has been
> limited to ISA interrupts only.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/acpi/pci_link.c | 176 ++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 140 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index ededa90..25695ea 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -437,17 +437,15 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
>   * enabled system.
>   */
>  
> -#define ACPI_MAX_IRQS		256
>  #define ACPI_MAX_ISA_IRQ	16

ACPI_MAX_ISA_IRQ is a bit of a misnomer.  The maximum ISA IRQ is 15,
not 16, so I think this should be named ACPI_MAX_ISA_IRQS.

> -#define PIRQ_PENALTY_PCI_AVAILABLE	(0)
>  #define PIRQ_PENALTY_PCI_POSSIBLE	(16*16)
>  #define PIRQ_PENALTY_PCI_USING		(16*16*16)
>  #define PIRQ_PENALTY_ISA_TYPICAL	(16*16*16*16)
>  #define PIRQ_PENALTY_ISA_USED		(16*16*16*16*16)
>  #define PIRQ_PENALTY_ISA_ALWAYS		(16*16*16*16*16*16)
>  
> -static int acpi_irq_penalty[ACPI_MAX_IRQS] = {
> +static int acpi_isa_irq_penalty[ACPI_MAX_ISA_IRQ] = {
>  	PIRQ_PENALTY_ISA_ALWAYS,	/* IRQ0 timer */
>  	PIRQ_PENALTY_ISA_ALWAYS,	/* IRQ1 keyboard */
>  	PIRQ_PENALTY_ISA_ALWAYS,	/* IRQ2 cascade */
> @@ -457,9 +455,9 @@ static int acpi_irq_penalty[ACPI_MAX_IRQS] = {
>  	PIRQ_PENALTY_ISA_TYPICAL,	/* IRQ6 */
>  	PIRQ_PENALTY_ISA_TYPICAL,	/* IRQ7 parallel, spurious */
>  	PIRQ_PENALTY_ISA_TYPICAL,	/* IRQ8 rtc, sometimes */
> -	PIRQ_PENALTY_PCI_AVAILABLE,	/* IRQ9  PCI, often acpi */
> -	PIRQ_PENALTY_PCI_AVAILABLE,	/* IRQ10 PCI */
> -	PIRQ_PENALTY_PCI_AVAILABLE,	/* IRQ11 PCI */
> +	0,				/* IRQ9  PCI, often acpi */
> +	0,				/* IRQ10 PCI */
> +	0,				/* IRQ11 PCI */
>  	PIRQ_PENALTY_ISA_USED,		/* IRQ12 mouse */
>  	PIRQ_PENALTY_ISA_USED,		/* IRQ13 fpe, sometimes */
>  	PIRQ_PENALTY_ISA_USED,		/* IRQ14 ide0 */
> @@ -467,6 +465,121 @@ static int acpi_irq_penalty[ACPI_MAX_IRQS] = {
>  	/* >IRQ15 */
>  };
>  
> +static int acpi_link_trigger(int irq, u8 *polarity, u8 *triggering)
> +{
> +	struct acpi_pci_link *link;
> +	bool found = false;
> +
> +	*polarity = ~0;
> +	*triggering = ~0;
> +
> +	list_for_each_entry(link, &acpi_link_list, list) {
> +		int i;
> +
> +		if (link->irq.active && link->irq.active == irq) {
> +			if (*polarity == ~0)
> +				*polarity = link->irq.polarity;
> +
> +			if (*triggering == ~0)
> +				*triggering = link->irq.triggering;
> +
> +			if (*polarity != link->irq.polarity)
> +				return -EINVAL;
> +
> +			if (*triggering != link->irq.triggering)
> +				return -EINVAL;
> +
> +			found = true;
> +		}
> +
> +		for (i = 0; i < link->irq.possible_count; i++)
> +			if (link->irq.possible[i] == irq) {
> +				if (*polarity == ~0)
> +					*polarity = link->irq.polarity;
> +
> +				if (*triggering == ~0)
> +					*triggering = link->irq.triggering;
> +
> +				if (*polarity != link->irq.polarity)
> +					return -EINVAL;
> +
> +				if (*triggering != link->irq.triggering)
> +					return -EINVAL;
> +
> +				found = true;
> +			}
> +	}
> +
> +	return found ? 0 : -EINVAL;
> +}
> +
> +static int acpi_pci_compatible_trigger(int irq)
> +{
> +	u8 polarity;
> +	u8 triggering;
> +
> +	return acpi_link_trigger(irq, &polarity, &triggering);
> +}
> +
> +static int acpi_irq_pci_sharing_penalty(int irq)
> +{
> +	struct acpi_pci_link *link;
> +	int penalty = 0;
> +
> +	if (acpi_pci_compatible_trigger(irq))
> +		return ~0;

This is the part (and all the acpi_link_trigger() code) that I think
is new functionality we didn't have before, and maybe not worth doing.
If we *do* want it, I think it should be added in a separate patch.

> +
> +	list_for_each_entry(link, &acpi_link_list, list) {
> +		/*
> +		 * If a link is active, penalize its IRQ heavily
> +		 * so we try to choose a different IRQ.
> +		 */
> +		if (link->irq.active && link->irq.active == irq)
> +			penalty += PIRQ_PENALTY_PCI_USING;
> +		else {
> +			int i;
> +
> +			/*
> +			 * If a link is inactive, penalize the IRQs it
> +			 * might use, but not as severely.
> +			 */
> +			for (i = 0; i < link->irq.possible_count; i++)
> +				if (link->irq.possible[i] == irq)
> +					penalty += PIRQ_PENALTY_PCI_POSSIBLE /
> +						link->irq.possible_count;
> +		}
> +	}
> +
> +	return penalty;
> +}
> +
> +static int acpi_irq_get_penalty(int irq)
> +{
> +	int penalty = 0, rc;
> +
> +	if (irq < ACPI_MAX_ISA_IRQ)
> +		penalty += acpi_isa_irq_penalty[irq];
> +
> +	if (irq == acpi_gbl_FADT.sci_interrupt) {
> +		u8 sci_polarity;
> +		u8 sci_trigger;
> +
> +		rc = acpi_link_trigger(irq, &sci_polarity, &sci_trigger);
> +		if (!rc) {
> +			if (sci_trigger != ACPI_LEVEL_SENSITIVE ||
> +			    sci_polarity != ACPI_ACTIVE_LOW)
> +				penalty += PIRQ_PENALTY_ISA_ALWAYS;
> +			else
> +				penalty += PIRQ_PENALTY_PCI_USING;
> +		} else {
> +			return ~0;

This function (acpi_irq_get_penalty()) returns a signed int,
and I don't think ~0 is the largest possible signed int.

> +		}
> +	}
> +
> +	penalty += acpi_irq_pci_sharing_penalty(irq);
> +	return penalty;
> +}
> +
>  int __init acpi_irq_penalty_init(void)
>  {
>  	struct acpi_pci_link *link;
> @@ -488,13 +601,14 @@ int __init acpi_irq_penalty_init(void)
>  
>  			for (i = 0; i < link->irq.possible_count; i++) {
>  				if (link->irq.possible[i] < ACPI_MAX_ISA_IRQ)
> -					acpi_irq_penalty[link->irq.
> -							 possible[i]] +=
> +					acpi_isa_irq_penalty[link->irq.
> +							     possible[i]] +=
>  					    penalty;
>  			}
>  
> -		} else if (link->irq.active) {
> -			acpi_irq_penalty[link->irq.active] +=
> +		} else if (link->irq.active &&
> +			   (link->irq.active < ACPI_MAX_ISA_IRQ)) {
> +			acpi_isa_irq_penalty[link->irq.active] +=
>  			    PIRQ_PENALTY_PCI_POSSIBLE;
>  		}
>  	}
> @@ -547,12 +661,12 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
>  		 * the use of IRQs 9, 10, 11, and >15.
>  		 */
>  		for (i = (link->irq.possible_count - 1); i >= 0; i--) {
> -			if (acpi_irq_penalty[irq] >
> -			    acpi_irq_penalty[link->irq.possible[i]])
> +			if (acpi_irq_get_penalty(irq) >
> +			    acpi_irq_get_penalty(link->irq.possible[i]))
>  				irq = link->irq.possible[i];
>  		}
>  	}
> -	if (acpi_irq_penalty[irq] >= PIRQ_PENALTY_ISA_ALWAYS) {
> +	if (acpi_irq_get_penalty(irq) >= PIRQ_PENALTY_ISA_ALWAYS) {
>  		printk(KERN_ERR PREFIX "No IRQ available for %s [%s]. "
>  			    "Try pci=noacpi or acpi=off\n",
>  			    acpi_device_name(link->device),
> @@ -568,7 +682,6 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
>  			    acpi_device_bid(link->device));
>  		return -ENODEV;
>  	} else {
> -		acpi_irq_penalty[link->irq.active] += PIRQ_PENALTY_PCI_USING;
>  		printk(KERN_WARNING PREFIX "%s [%s] enabled at IRQ %d\n",
>  		       acpi_device_name(link->device),
>  		       acpi_device_bid(link->device), link->irq.active);
> @@ -778,7 +891,7 @@ static void acpi_pci_link_remove(struct acpi_device *device)
>  }
>  
>  /*
> - * modify acpi_irq_penalty[] from cmdline
> + * modify acpi_isa_irq_penalty[] from cmdline
>   */
>  static int __init acpi_irq_penalty_update(char *str, int used)
>  {
> @@ -787,23 +900,24 @@ static int __init acpi_irq_penalty_update(char *str, int used)
>  	for (i = 0; i < 16; i++) {
>  		int retval;
>  		int irq;
> +		int new_penalty;
>  
>  		retval = get_option(&str, &irq);
>  
>  		if (!retval)
>  			break;	/* no number found */
>  
> -		if (irq < 0)
> -			continue;
> -
> -		if (irq >= ARRAY_SIZE(acpi_irq_penalty))
> +		/* see if this is a ISA IRQ */
> +		if ((irq < 0) || (irq >= ACPI_MAX_ISA_IRQ))
>  			continue;
>  
>  		if (used)
> -			acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_USED;
> +			new_penalty = acpi_irq_get_penalty(irq) +
> +					PIRQ_PENALTY_ISA_USED;
>  		else
> -			acpi_irq_penalty[irq] = PIRQ_PENALTY_PCI_AVAILABLE;
> +			new_penalty = 0;
>  
> +		acpi_isa_irq_penalty[irq] = new_penalty;
>  		if (retval != 2)	/* no next number */
>  			break;
>  	}
> @@ -819,18 +933,15 @@ static int __init acpi_irq_penalty_update(char *str, int used)
>   */
>  void acpi_penalize_isa_irq(int irq, int active)
>  {
> -	if (irq >= 0 && irq < ARRAY_SIZE(acpi_irq_penalty)) {
> -		if (active)
> -			acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_USED;
> -		else
> -			acpi_irq_penalty[irq] += PIRQ_PENALTY_PCI_USING;
> -	}
> +	if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_isa_irq_penalty)))
> +		acpi_isa_irq_penalty[irq] = active ?
> +			PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING;
>  }
>  
>  bool acpi_isa_irq_available(int irq)
>  {
> -	return irq >= 0 && (irq >= ARRAY_SIZE(acpi_irq_penalty) ||
> -			    acpi_irq_penalty[irq] < PIRQ_PENALTY_ISA_ALWAYS);
> +	return irq >= 0 && (irq >= ARRAY_SIZE(acpi_isa_irq_penalty) ||
> +			 acpi_isa_irq_penalty[irq] < PIRQ_PENALTY_ISA_ALWAYS);
>  }
>  
>  /*
> @@ -840,13 +951,6 @@ bool acpi_isa_irq_available(int irq)
>   */
>  void acpi_penalize_sci_irq(int irq, int trigger, int polarity)
>  {

There's a comment just above here that doesn't make any sense after
you remove the entire function body, so maybe you can just remove the
comment at the same time (or move it to the place this code moved to).

> -	if (irq >= 0 && irq < ARRAY_SIZE(acpi_irq_penalty)) {
> -		if (trigger != ACPI_MADT_TRIGGER_LEVEL ||
> -		    polarity != ACPI_MADT_POLARITY_ACTIVE_LOW)
> -			acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_ALWAYS;
> -		else
> -			acpi_irq_penalty[irq] += PIRQ_PENALTY_PCI_USING;
> -	}
>  }
>  
>  /*
> -- 
> 1.8.2.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
