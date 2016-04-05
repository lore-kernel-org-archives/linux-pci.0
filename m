Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 5 Apr 2016 18:21:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, linux-pci@vger.kernel.org,
	ravikanth.nalla@hpe.com, lenb@kernel.org, harish.k@hpe.com,
	ashwin.reghunandanan@hpe.com, bhelgaas@google.com,
	rjw@rjwysocki.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] acpi,pci,irq: reduce resource requirements
Message-ID: <20160405232124.GH15353@localhost>
References: <1457484079-18202-1-git-send-email-okaya@codeaurora.org>
 <20160314185251.GA19703@localhost>
 <56E7211F.3070203@codeaurora.org>
 <20160314210147.GA11459@localhost>
 <56E73232.9030704@codeaurora.org>
 <20160315014843.GA16967@localhost>
 <56E7733B.4050308@codeaurora.org>
 <20160315023632.GA23940@localhost>
 <56E80F19.7010503@codeaurora.org>
 <56EEE925.7070202@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56EEE925.7070202@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Mar 20, 2016 at 02:17:09PM -0400, Sinan Kaya wrote:
> Hi Bjorn,
> 
> >>>
> >>> Device(LN0A){
> >>> 	Name(_HID, EISAID("PNP0C0F")) // PCI interrupt link
> >>> 	Name(_UID, 1)
> >>> 	Name(_PRS, ResourceTemplate(){
> >>> 	Interrupt(ResourceProducer, Level, ActiveHigh, Exclusive, , ,) {0x123}
> >>> 	})
> >>
> >> I forgot that the link already include the trigger mode in it.  Maybe we
> >> can check for that instead of assuming level/low.
> >>
> > 
> > Let me explore this area.
> > 
> >> Bjorn
> 
> I have been implementing this. 
> 
> I see that placing the check in allocate function is not right. The interrupts get
> registered with ACPI subsystem after locating the interrupt in register_gsi function.
> Trying to find the IRQ type with get_trigger_type() for an unregistered interrupt
> didn't look right to me.
> 
> I think it is best if we move these checks into get_penalty function.
> 
> I also see that the code is currently allowing EDGE type PCI interrupts assuming they are
> exclusive only. Let me if this looks alright. I'm also curious about the PCI checks.
> 
> static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
> 
> I know you want to validate that all PCI interrupts are level, it looks like the code
> is allowing other combinations.

It's not that we need to validate that all PCI interrupts are level.  What
we need is to make sure all users sharing an IRQ agree on the mode.

> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index 85be579e..5056a9c 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -495,6 +495,45 @@ static int acpi_irq_pci_sharing_penalty(int irq)
>  	return penalty;
>  }
>  
> +static int acpi_link_trigger(int irq, u8 *polarity, u8 *triggering)
> +{
> +	struct acpi_pci_link *link;
> +	int link_trigger = 0;
> +
> +	list_for_each_entry(link, &acpi_link_list, list) {
> +		int i;
> +
> +		if (link->irq.active && link->irq.active == irq) {
> +			*polarity = link->polarity;
> +			*triggering = link->triggering;
> +			return 0;
> +		}
> +
> +		for (i = 0; i < link->irq.possible_count; i++)
> +			if (link->irq.possible[i] == irq) {
> +				*polarity = link->polarity;
> +				*triggering = link->triggering;
> +				return 0;
> +			}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static bool acpi_pci_compatible_trigger(int irq)
> +{
> +	u8 polarity;
> +	u8 triggering;
> +	int type = irq_get_trigger_type(irq);
> +	int rc;
> +
> +	rc = acpi_link_trigger(irq, &polarity, &triggering, &sharing)
> +	if (rc)
> +		return false;
> +
> +	return (type == IRQ_TYPE_LEVEL_LOW || type == IRQ_TYPE_NONE);
> +}
> +
>  static int acpi_irq_get_penalty(int irq)
>  {
>  	int penalty = 0;
> @@ -502,8 +541,21 @@ static int acpi_irq_get_penalty(int irq)
>  	if (irq < ACPI_MAX_ISA_IRQ)
>  		penalty += acpi_irq_isa_penalty[irq];
>  
> -	if (irq == acpi_gbl_FADT.sci_interrupt)
> -		penalty += PIRQ_PENALTY_PCI_USING;
> +	if (irq == acpi_gbl_FADT.sci_interrupt) {
> +		u8 sci_polarity;
> +		u8 sci_trigger;
> +
> +		rc = acpi_link_trigger(irq, &polarity, &sci_trigger);
> +		if (!rc) {
> +			if (sci_trigger != ACPI_LEVEL_SENSITIVE ||
> +			    sci_polarity != ACPI_ACTIVE_LOW)
> +				penalty += PIRQ_PENALTY_ISA_ALWAYS;
> +			else
> +				penalty += PIRQ_PENALTY_PCI_USING;
> +		} else {
> +			return ~0;
> +		}
> +	}
>  
>  	penalty += acpi_irq_pci_sharing_penalty(irq);
>  	return penalty; 
> 
> 
> -- 
> Sinan Kaya
> Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
