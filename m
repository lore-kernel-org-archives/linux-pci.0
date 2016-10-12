Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754926AbcJLTHw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 15:07:52 -0400
Date: Wed, 12 Oct 2016 14:07:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
        ravikanth.nalla@hpe.com, linux@rainbow-software.org,
        timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com,
        alex.williamson@redhat.com, linux-pci@vger.kernel.org,
        agross@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wim@djo.tudelft.nl,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/3] ACPI, PCI IRQ: add PCI_USING penalty for ISA
 interrupts
Message-ID: <20161012190729.GA15116@localhost>
References: <1475615720-31047-1-git-send-email-okaya@codeaurora.org>
 <1475615720-31047-3-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1475615720-31047-3-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 04, 2016 at 05:15:18PM -0400, Sinan Kaya wrote:
> The change introduced in commit 103544d86976 ("ACPI,PCI,IRQ: reduce
> resource requirements") removed PCI_USING penalty from
> acpi_pci_link_allocate function as there is no longer a fixed size penalty
> array for both PCI and IRQ interrupts.
> 
> We need to add the PCI_USING penalty for ISA interrupts too if the link is
> in use and matches our ISA IRQ number.
> 
> Tested-by: Jonathan Liu <net147@gmail.com>
> Tested-by: Ondrej Zary <linux@rainbow-software.org>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/acpi/pci_link.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index f3792f4..06c2a11 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -620,6 +620,10 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
>  			    acpi_device_bid(link->device));
>  		return -ENODEV;
>  	} else {
> +		if (link->irq.active < ACPI_MAX_IRQS)
> +			acpi_irq_penalty[link->irq.active] +=
> +				PIRQ_PENALTY_PCI_USING;

Nit: elsewhere you use ARRAY_SIZE(acpi_irq_penalty), so it'd be nice
to be consistent, e.g.,

  if (link->irq.active < ARRAY_SIZE(acpi_irq_penalty))
    acpi_irq_penalty[link->irq.active] += PIRQ_PENALTY_PCI_USING;

There are a couple other similar uses in acpi_irq_get_penalty() and
acpi_irq_penalty_init().

>  		printk(KERN_WARNING PREFIX "%s [%s] enabled at IRQ %d\n",
>  		       acpi_device_name(link->device),
>  		       acpi_device_bid(link->device), link->irq.active);
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
