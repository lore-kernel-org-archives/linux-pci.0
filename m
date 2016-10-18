Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753461AbcJRKq7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Oct 2016 06:46:59 -0400
Date: Tue, 18 Oct 2016 05:46:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org,
        cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com,
        eric.auger@redhat.com, linux-pci@vger.kernel.org,
        agross@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wim@djo.tudelft.nl,
        perex@perex.cz, tiwai@suse.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/4] ACPI,PCI,IRQ: separate ISA penalty calculation
Message-ID: <20161018104649.GA13940@localhost>
References: <1467188859-28188-1-git-send-email-okaya@codeaurora.org>
 <1467188859-28188-4-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467188859-28188-4-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sinan,

On Wed, Jun 29, 2016 at 04:27:37AM -0400, Sinan Kaya wrote:
> Since commit 103544d86976 ("ACPI,PCI,IRQ: reduce resource requirements")
> the penalty values are calculated on the fly rather than boot time.
> 
> This works fine for PCI interrupts but not so well for the ISA interrupts.
> Whether an ISA interrupt is in use or not information is not available
> inside the pci_link.c file. This information gets sent externally via
> acpi_penalize_isa_irq function. If active is true, then the IRQ is in use
> by ISA. Otherwise, IRQ is in use by PCI.
> 
> Since the current code relies on PCI Link object for determination of
> penalties, we are factoring in the PCI penalty twice after
> acpi_penalize_isa_irq function is called.

I know this patch has already been merged, but I'm confused.

Can you be a little more specific about how we factor in the PCI
penalty twice?  I think that when we enumerate an enabled link device,
we call acpi_penalize_isa_irq(x) in this path:

  pnpacpi_allocated_resource
    pnpacpi_add_irqresource
      pcibios_penalize_isa_irq
        acpi_penalize_isa_irq
          acpi_isa_irq_penalty[x] = PIRQ_PENALTY_ISA_USED

And I see that acpi_irq_penalty_init() also adds in some penalty
(either "PIRQ_PENALTY_PCI_POSSIBLE / possible_count" or
PIRQ_PENALTY_PCI_POSSIBLE).  And when we call acpi_irq_get_penalty(x),
we add in PIRQ_PENALTY_PCI_USING.

It doesn't seem right to me that we're adding both
PIRQ_PENALTY_ISA_USED and PIRQ_PENALTY_PCI_USING.  Is that the problem
you're referring to?

> This change is limiting the newly added functionality to just PCI
> interrupts so that old behavior is still maintained.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/acpi/pci_link.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index 714ba4d..8c08971 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -496,9 +496,6 @@ static int acpi_irq_get_penalty(int irq)
>  {
>  	int penalty = 0;
>  
> -	if (irq < ACPI_MAX_ISA_IRQS)
> -		penalty += acpi_isa_irq_penalty[irq];
> -
>  	/*
>  	* Penalize IRQ used by ACPI SCI. If ACPI SCI pin attributes conflict
>  	* with PCI IRQ attributes, mark ACPI SCI as ISA_ALWAYS so it won't be
> @@ -513,6 +510,9 @@ static int acpi_irq_get_penalty(int irq)
>  			penalty += PIRQ_PENALTY_PCI_USING;
>  	}
>  
> +	if (irq < ACPI_MAX_ISA_IRQS)
> +		return penalty + acpi_isa_irq_penalty[irq];
> +
>  	penalty += acpi_irq_pci_sharing_penalty(irq);
>  	return penalty;

I don't understand what's going on here.

acpi_irq_pci_sharing_penalty(X) basically tells us how many link
devices are already using IRQ X.  This change makes it so we don't
consider that information if X < ACPI_MAX_ISA_IRQS.

Let's say we have several link devices that are initially disabled,
e.g.,

  LNKA (IRQs 9 10 11)
  LNKB (IRQs 9 10 11)
  LNKC (IRQs 9 10 11)

When we enable these, I think we'll choose the same IRQ for all of
them because we no longer look at the other links to see how they're
configured.

>  }
> -- 
> 1.8.2.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
