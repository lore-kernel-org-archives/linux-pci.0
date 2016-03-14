Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 14 Mar 2016 13:52:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, linux-pci@vger.kernel.org,
	ravikanth.nalla@hpe.com, lenb@kernel.org, harish.k@hpe.com,
	ashwin.reghunandanan@hpe.com, bhelgaas@google.com,
	rjw@rjwysocki.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] acpi,pci,irq: reduce resource requirements
Message-ID: <20160314185251.GA19703@localhost>
References: <1457484079-18202-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457484079-18202-1-git-send-email-okaya@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 08, 2016 at 07:41:16PM -0500, Sinan Kaya wrote:
> Code has been redesigned to calculate penalty requirements on the fly. This
> significantly simplifies the implementation and removes some of the init
> calls from x86 architecture.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/acpi/pci_link.c | 82 ++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 58 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index ededa90..a5a66ca 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -36,6 +36,8 @@
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
>  
>  #include "internal.h"
>  
> @@ -440,7 +442,6 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
>  #define ACPI_MAX_IRQS		256
>  #define ACPI_MAX_ISA_IRQ	16
>  
> -#define PIRQ_PENALTY_PCI_AVAILABLE	(0)
>  #define PIRQ_PENALTY_PCI_POSSIBLE	(16*16)
>  #define PIRQ_PENALTY_PCI_USING		(16*16*16)
>  #define PIRQ_PENALTY_ISA_TYPICAL	(16*16*16*16)
> @@ -457,9 +458,9 @@ static int acpi_irq_penalty[ACPI_MAX_IRQS] = {
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
> @@ -467,6 +468,49 @@ static int acpi_irq_penalty[ACPI_MAX_IRQS] = {
>  	/* >IRQ15 */
>  };
>  
> +static int acpi_irq_pci_sharing_penalty(int irq)
> +{
> +	struct acpi_pci_link *link;
> +	int penalty = 0;
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
> +	int penalty = 0;
> +
> +	if (irq < ACPI_MAX_ISA_IRQ)
> +		penalty += acpi_irq_penalty[irq];
> +
> +	if (irq == acpi_gbl_FADT.sci_interrupt)
> +		penalty += PIRQ_PENALTY_PCI_USING;
> +
> +	penalty += acpi_irq_pci_sharing_penalty(irq);
> +	return penalty;
> +}
> +
>  int __init acpi_irq_penalty_init(void)
>  {
>  	struct acpi_pci_link *link;
> @@ -568,7 +612,6 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
>  			    acpi_device_bid(link->device));
>  		return -ENODEV;
>  	} else {
> -		acpi_irq_penalty[link->irq.active] += PIRQ_PENALTY_PCI_USING;
>  		printk(KERN_WARNING PREFIX "%s [%s] enabled at IRQ %d\n",
>  		       acpi_device_name(link->device),
>  		       acpi_device_bid(link->device), link->irq.active);
> @@ -787,23 +830,24 @@ static int __init acpi_irq_penalty_update(char *str, int used)
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
> +		acpi_irq_penalty[irq] = new_penalty;
>  		if (retval != 2)	/* no next number */
>  			break;
>  	}
> @@ -819,12 +863,9 @@ static int __init acpi_irq_penalty_update(char *str, int used)
>   */
>  void acpi_penalize_isa_irq(int irq, int active)
>  {
> -	if (irq >= 0 && irq < ARRAY_SIZE(acpi_irq_penalty)) {
> -		if (active)
> -			acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_USED;
> -		else
> -			acpi_irq_penalty[irq] += PIRQ_PENALTY_PCI_USING;
> -	}
> +	if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_irq_penalty)))
> +		acpi_irq_penalty[irq] = active ?
> +			PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING;
>  }
>  
>  bool acpi_isa_irq_available(int irq)
> @@ -840,13 +881,6 @@ bool acpi_isa_irq_available(int irq)
>   */
>  void acpi_penalize_sci_irq(int irq, int trigger, int polarity)
>  {
> -	if (irq >= 0 && irq < ARRAY_SIZE(acpi_irq_penalty)) {
> -		if (trigger != ACPI_MADT_TRIGGER_LEVEL ||
> -		    polarity != ACPI_MADT_POLARITY_ACTIVE_LOW)
> -			acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_ALWAYS;
> -		else
> -			acpi_irq_penalty[irq] += PIRQ_PENALTY_PCI_USING;
> -	}

I think we lost the validation of trigger mode and polarity, didn't
we?

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
