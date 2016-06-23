Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 23 Jun 2016 11:21:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: wim@djo.tudelft.nl, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	perex@perex.cz, linux-pci@vger.kernel.org,
	Takashi Iwai <tiwai@suse.com>, linux-pci-owner@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: kernel-4.7 bug in Intel sound and/or ACPI
Message-ID: <20160623162158.GA17987@localhost>
References: <2999417.fp4mqtxYS2@vostro.rjw.lan>
 <20160620212507.GA24086@localhost>
 <57686D67.8010201@codeaurora.org>
 <20160621124715.GB3528@djo.tudelft.nl>
 <576943BA.1000001@codeaurora.org>
 <20160621221347.GA28603@djo.tudelft.nl>
 <72eb7b76d449f906d9b2b1bb15d995bf@codeaurora.org>
 <20160623141234.GA14662@djo.tudelft.nl>
 <576BF86E.8060302@codeaurora.org>
 <576C042B.20507@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <576C042B.20507@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Alex, FYI]

This thread is about a regression that we'll want to fix before v4.7
releases.  It looks like it's related to these changes which were
merged via the ACPI tree:

  9e5ed6d1fb87 ACPI,PCI,IRQ: remove SCI penalize function
  1fcb6a813c4f ACPI,PCI,IRQ: remove redundant code in acpi_irq_penalty_init()
  5c5087a55390 ACPI,PCI,IRQ: reduce static IRQ array size to 16
  103544d86976 ACPI,PCI,IRQ: reduce resource requirements

If that turns out to be the case, it probably makes sense to merge the fix
via the ACPI tree as well.  But in the unlikely event the fix turns out to
be in PCI, Alex will probably have to merge it because I'll be on vacation.
So I'm adding Alex to the CC: list in case that happens.

On Thu, Jun 23, 2016 at 11:45:47AM -0400, Sinan Kaya wrote:
> On 6/23/2016 10:55 AM, Sinan Kaya wrote:
> > On 6/23/2016 10:12 AM, Wim Osterholt wrote:
> >> On Wed, Jun 22, 2016 at 11:54:39PM -0400, okaya@codeaurora.org wrote:
> >>> On 2016-06-21 18:13, Wim Osterholt wrote:
> >>>>>
> >>>>> 	pr_info("%s:%d irq = %d penalty = %d\n", __func__, __LINE__, irq,
> >>>>> 		penalty);
> >>>>>
> >>>>
> >>>> This produced some 60 lines extra....
> >>>
> >>> Thanks, let's go back to 4.6 and add a very similar printf to every 
> >>> single place where the array is modified and also right before the 
> >>> enabled message.
> >>>
> >>
> >> I don't get this right.
> >> Assuming that you're still talking about the same file, I find a few
> >> instances of 'enabled', most of them in if-statements and one where it might
> >> be set, so it looks. However, that's already in a printk statement.
> >> I don't know about arrays and even less where these are set. Even worse, I
> >> don't know what to put in a 'similar' line if you don't mean 'exactly the
> >> same'.
> >> So please state file and line numbers and the line to be inserted.
> >>
> > 
> > Sure, let me get a patch for you. I was hoping to do it yesterday. 
> > I ran out of time. I typed the message from my phone. 
> > 
> 
> Here it is
> 
> 
> 
> -- 
> Sinan Kaya
> Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index ededa90..228b61f 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -487,15 +487,18 @@ int __init acpi_irq_penalty_init(void)
>  			    link->irq.possible_count;
>  
>  			for (i = 0; i < link->irq.possible_count; i++) {
> -				if (link->irq.possible[i] < ACPI_MAX_ISA_IRQ)
> +				if (link->irq.possible[i] < ACPI_MAX_ISA_IRQ) {
>  					acpi_irq_penalty[link->irq.
>  							 possible[i]] +=
>  					    penalty;
> +					pr_info("%s:%d acpi_irq_penalty[%d] = 0x%x\n", __func__, __LINE__, link->irq.possible[i], acpi_irq_penalty[link->irq.possible[i]]);
> +				}
>  			}
>  
>  		} else if (link->irq.active) {
>  			acpi_irq_penalty[link->irq.active] +=
>  			    PIRQ_PENALTY_PCI_POSSIBLE;
> +			pr_info("%s:%d acpi_irq_penalty[%d] = 0x%x\n", __func__, __LINE__, link->irq.active, acpi_irq_penalty[link->irq.active]);
>  		}
>  	}
>  
> @@ -548,8 +551,11 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
>  		 */
>  		for (i = (link->irq.possible_count - 1); i >= 0; i--) {
>  			if (acpi_irq_penalty[irq] >
> -			    acpi_irq_penalty[link->irq.possible[i]])
> +			    acpi_irq_penalty[link->irq.possible[i]]) {
> +				    pr_info("%s:%d acpi_irq_penalty[irq=%d](0x%x) vs. acpi_irq_penalty[%d](0x%x)\n",
> +					    __func__, __LINE__, irq, acpi_irq_penalty[irq], link->irq.possible[i], acpi_irq_penalty[link->irq.possible[i]]);
>  				irq = link->irq.possible[i];
> +			    }
>  		}
>  	}
>  	if (acpi_irq_penalty[irq] >= PIRQ_PENALTY_ISA_ALWAYS) {
> @@ -569,6 +575,7 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
>  		return -ENODEV;
>  	} else {
>  		acpi_irq_penalty[link->irq.active] += PIRQ_PENALTY_PCI_USING;
> +		pr_info("%s:%d acpi_irq_penalty[%d] = 0x%x\n", __func__, __LINE__, link->irq.active, acpi_irq_penalty[link->irq.active]);
>  		printk(KERN_WARNING PREFIX "%s [%s] enabled at IRQ %d\n",
>  		       acpi_device_name(link->device),
>  		       acpi_device_bid(link->device), link->irq.active);
> @@ -804,6 +811,8 @@ static int __init acpi_irq_penalty_update(char *str, int used)
>  		else
>  			acpi_irq_penalty[irq] = PIRQ_PENALTY_PCI_AVAILABLE;
>  
> +		pr_info("%s:%d acpi_irq_penalty[%d] = 0x%x\n", __func__, __LINE__, irq, acpi_irq_penalty[irq]);
> +
>  		if (retval != 2)	/* no next number */
>  			break;
>  	}
> @@ -824,11 +833,16 @@ void acpi_penalize_isa_irq(int irq, int active)
>  			acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_USED;
>  		else
>  			acpi_irq_penalty[irq] += PIRQ_PENALTY_PCI_USING;
> +
> +		pr_info("%s:%d acpi_irq_penalty[%d] = 0x%x\n", __func__, __LINE__, irq, acpi_irq_penalty[irq]);
>  	}
>  }
>  
>  bool acpi_isa_irq_available(int irq)
>  {
> +	if (irq >= 0 && (irq < ARRAY_SIZE(acpi_irq_penalty)))
> +		pr_info("%s:%d acpi_irq_penalty[%d] = 0x%x\n", __func__, __LINE__, irq, acpi_irq_penalty[irq]);
> +
>  	return irq >= 0 && (irq >= ARRAY_SIZE(acpi_irq_penalty) ||
>  			    acpi_irq_penalty[irq] < PIRQ_PENALTY_ISA_ALWAYS);
>  }
> @@ -846,6 +860,8 @@ void acpi_penalize_sci_irq(int irq, int trigger, int polarity)
>  			acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_ALWAYS;
>  		else
>  			acpi_irq_penalty[irq] += PIRQ_PENALTY_PCI_USING;
> +
> +		pr_info("%s:%d acpi_irq_penalty[%d] = 0x%x\n", __func__, __LINE__, irq, acpi_irq_penalty[irq]);
>  	}
>  }
>  

