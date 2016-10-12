Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932956AbcJLWOF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 18:14:05 -0400
Date: Wed, 12 Oct 2016 17:13:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
        ravikanth.nalla@hpe.com, linux@rainbow-software.org,
        timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com,
        alex.williamson@redhat.com, linux-pci@vger.kernel.org,
        agross@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wim@djo.tudelft.nl,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/3] Revert "ACPI,PCI,IRQ: reduce static IRQ array
 size to 16"
Message-ID: <20161012221357.GB15116@localhost>
References: <1475615720-31047-1-git-send-email-okaya@codeaurora.org>
 <1475615720-31047-2-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1475615720-31047-2-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sinan,

I have to apologize because I haven't followed all the discussion and
now I'm trying to figure it out from the patches and changelogs.  But
I guess that's not all bad, because future interested folks *should*
be able to figure things out from that :)

On Tue, Oct 04, 2016 at 05:15:17PM -0400, Sinan Kaya wrote:
> This reverts commit 5c5087a55390 ("ACPI,PCI,IRQ: reduce static IRQ array
> size to 16").
> 
> The code maintains a fixed size array for IRQ penalties. The array
> gets updated by external calls such as acpi_penalize_sci_irq,
> acpi_penalize_isa_irq to reflect the actual interrupt usage of the
> system. Since the IRQ distribution is platform specific, this is
> not known ahead of time. The IRQs get updated based on the SCI
> interrupt number BIOS has chosen or the ISA IRQs that were assigned
> to existing peripherals.
> 
> By the time ACPI gets initialized, this code tries to determine an
> IRQ number based on penalty values in this array. It will try to locate
> the IRQ with the least penalty assignment so that interrupt sharing is
> avoided if possible.
> 
> A couple of notes about the external APIs:
> 1. These API can be called before the ACPI is started. Therefore, one
> cannot assume that the PCI link objects are initialized for calculating
> penalties.

Which API are you thinking about here?  pcibios_penalize_isa_irq() is
called by ACPI and PNP, which should both be after ACPI is started.

My guess is you're thinking about acpi_penalize_sci_irq() (added back
later in this series), which is called here, which is definitely
before ACPI objects are available:

  setup_arch
    acpi_boot_init
      acpi_process_madt
	acpi_parse_madt_ioapic_entries
	  acpi_table_parse_madt
	    acpi_parse_int_src_ovr
	      acpi_sci_ioapic_setup
	        acpi_penalize_sci_irq       # <---

> 2. The polarity and trigger information passed via the
> acpi_penalize_sci_irq from the BIOS may not match what the IRQ subsystem
> is reporting as the call might have been placed before the IRQ is
> registered by the interrupt subsystem.
> 
> The previous change was in the direction to remove these external API and
> try to calculate the penalties at runtime for the ISA path as well. This
> didn't work out well with the existing platforms.
> 
> Restoring the old behavior for IRQ < 256 and the new behavior will remain
> effective for IRQ >= 256.

IIRC, this all started because we needed more than 256 IRQs, but we
didn't know how to size a static table to be large enough without
being wasteful.

Prior to 5c5087a55390, we tracked penalties for IRQs 0-255.  After it,
we only tracked penalties for IRQs 0-15.  I think this patch basically
makes it so we track 0-255 again.

*This* patch only increases the range for pcibios_penalize_isa_irq()
(and command-line hints, but hopefully nobody cares about those).  A
subsequent patch increases it for SCI as well.

The name "ACPI_MAX_IRQS" is now slightly misleading (because we do
support more than 256 IRQs) and the 256 value is sort of an
unjustified magic number.  16 is explainable as the number of ISA
IRQs, but I don't know what 256 is based on (other than historical
practice, of course).  ACPI device IRQs can be much larger, and I
think the SCI IRQ can be, too (the FADT SCI_INT field is 16 bits).

Can you tie this back to the specific problem on the broken machine
somehow?  Do we need a penalty for an IRQ in the 16-255 range?

In a subsequent patch, I see something about the IRQ type not being
updated at the right time, but I can't quite connect the dots.

To be clear, I'm not asking for any changes in the patch; I'm just
trying to understand what's going on.

> Tested-by: Jonathan Liu <net147@gmail.com>
> Tested-by: Ondrej Zary <linux@rainbow-software.org>
> Link: http://www.gossamer-threads.com/lists/linux/kernel/2537016#2537016
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/acpi/pci_link.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index c983bf7..f3792f4 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -438,6 +438,7 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
>   * enabled system.
>   */
>  
> +#define ACPI_MAX_IRQS		256
>  #define ACPI_MAX_ISA_IRQS	16
>  
>  #define PIRQ_PENALTY_PCI_POSSIBLE	(16*16)
> @@ -446,7 +447,7 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
>  #define PIRQ_PENALTY_ISA_USED		(16*16*16*16*16)
>  #define PIRQ_PENALTY_ISA_ALWAYS		(16*16*16*16*16*16)
>  
> -static int acpi_isa_irq_penalty[ACPI_MAX_ISA_IRQS] = {
> +static int acpi_irq_penalty[ACPI_MAX_IRQS] = {
>  	PIRQ_PENALTY_ISA_ALWAYS,	/* IRQ0 timer */
>  	PIRQ_PENALTY_ISA_ALWAYS,	/* IRQ1 keyboard */
>  	PIRQ_PENALTY_ISA_ALWAYS,	/* IRQ2 cascade */
> @@ -511,7 +512,7 @@ static int acpi_irq_get_penalty(int irq)
>  	}
>  
>  	if (irq < ACPI_MAX_ISA_IRQS)
> -		return penalty + acpi_isa_irq_penalty[irq];
> +		return penalty + acpi_irq_penalty[irq];
>  
>  	penalty += acpi_irq_pci_sharing_penalty(irq);
>  	return penalty;
> @@ -538,14 +539,14 @@ int __init acpi_irq_penalty_init(void)
>  
>  			for (i = 0; i < link->irq.possible_count; i++) {
>  				if (link->irq.possible[i] < ACPI_MAX_ISA_IRQS)
> -					acpi_isa_irq_penalty[link->irq.
> +					acpi_irq_penalty[link->irq.
>  							 possible[i]] +=
>  					    penalty;
>  			}
>  
>  		} else if (link->irq.active &&
> -				(link->irq.active < ACPI_MAX_ISA_IRQS)) {
> -			acpi_isa_irq_penalty[link->irq.active] +=
> +				(link->irq.active < ACPI_MAX_IRQS)) {
> +			acpi_irq_penalty[link->irq.active] +=
>  			    PIRQ_PENALTY_PCI_POSSIBLE;
>  		}
>  	}
> @@ -828,7 +829,7 @@ static void acpi_pci_link_remove(struct acpi_device *device)
>  }
>  
>  /*
> - * modify acpi_isa_irq_penalty[] from cmdline
> + * modify acpi_irq_penalty[] from cmdline
>   */
>  static int __init acpi_irq_penalty_update(char *str, int used)
>  {
> @@ -837,24 +838,24 @@ static int __init acpi_irq_penalty_update(char *str, int used)
>  	for (i = 0; i < 16; i++) {
>  		int retval;
>  		int irq;
> -		int new_penalty;
>  
>  		retval = get_option(&str, &irq);
>  
>  		if (!retval)
>  			break;	/* no number found */
>  
> -		/* see if this is a ISA IRQ */
> -		if ((irq < 0) || (irq >= ACPI_MAX_ISA_IRQS))
> +		if (irq < 0)
> +			continue;
> +
> +		if (irq >= ARRAY_SIZE(acpi_irq_penalty))
>  			continue;
>  
>  		if (used)
> -			new_penalty = acpi_irq_get_penalty(irq) +
> -					PIRQ_PENALTY_ISA_USED;
> +			acpi_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
> +				PIRQ_PENALTY_ISA_USED;
>  		else
> -			new_penalty = 0;
> +			acpi_irq_penalty[irq] = 0;
>  
> -		acpi_isa_irq_penalty[irq] = new_penalty;
>  		if (retval != 2)	/* no next number */
>  			break;
>  	}
> @@ -870,14 +871,14 @@ static int __init acpi_irq_penalty_update(char *str, int used)
>   */
>  void acpi_penalize_isa_irq(int irq, int active)
>  {
> -	if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_isa_irq_penalty)))
> -		acpi_isa_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
> -		  (active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING);
> +	if (irq >= 0 && irq < ARRAY_SIZE(acpi_irq_penalty))
> +		acpi_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
> +		    (active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING);
>  }
>  
>  bool acpi_isa_irq_available(int irq)
>  {
> -	return irq >= 0 && (irq >= ARRAY_SIZE(acpi_isa_irq_penalty) ||
> +	return irq >= 0 && (irq >= ARRAY_SIZE(acpi_irq_penalty) ||
>  		    acpi_irq_get_penalty(irq) < PIRQ_PENALTY_ISA_ALWAYS);
>  }
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
