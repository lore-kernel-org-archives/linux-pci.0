Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbeHODCg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Aug 2018 23:02:36 -0400
Date: Tue, 14 Aug 2018 19:12:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: set flag IRQCHIP_ONESHOT_SAFE for PCI-MSI
 irqchip's
Message-ID: <20180815001257.GD28888@bhelgaas-glaptop.roam.corp.google.com>
References: <9f18bc20-cf27-bc3c-71e5-4e24a6c983c7@gmail.com>
 <70984d26-1d35-d925-f67b-698ed85bbab5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <70984d26-1d35-d925-f67b-698ed85bbab5@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Aug 05, 2018 at 10:31:03PM +0200, Heiner Kallweit wrote:
> If flag IRQCHIP_ONESHOT_SAFE isn't set for an irqchip and we have a
> threaded interrupt with no primary handler, then flag IRQF_ONESHOT
> needs to be set for the interrupt, causing some overhead in the
> threaded interrupt handler. For more detailed explanation also check
> following comment in __setup_irq():
> 
> The interrupt was requested with handler = NULL, so we use the default
> primary handler for it. But it does not have the oneshot flag set.
> In combination with level interrupts this is deadly, because the
> default primary handler just wakes the thread, then the irq lines is
> reenabled, but the device still has the level irq asserted.
> Rinse and repeat....
> While this works for edge type interrupts, we play it safe and reject
> unconditionally because we can't say for sure which type this interrupt
> really has. The type flags are unreliable as the underlying chip
> implementation can override them.
> 
> Another comment in __setup_irq() gives a hint already that this
> overhead can be avoided for PCI-MSI:
> 
> Some irq chips like MSI based interrupts are per se one shot safe.
> Check the chip flags, so we can avoid the unmask dance at the end
> of the threaded handler for those.
> 
> Following this let's mark all PCI-MSI irqchip's as oneshot-safe.
> 
> See also discussion here:
> https://marc.info/?l=linux-pci&m=153332526101128&w=2
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied to pci/msi for v4.19, thanks!

> ---
> v2:
> - extended commit message
> ---
>  drivers/pci/msi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 4d88afdf..f2ef8964 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1446,6 +1446,9 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
>  	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
>  		info->flags |= MSI_FLAG_MUST_REACTIVATE;
>  
> +	/* PCI-MSI is oneshot-safe */
> +	info->chip->flags |= IRQCHIP_ONESHOT_SAFE;
> +
>  	domain = msi_create_irq_domain(fwnode, info, parent);
>  	if (!domain)
>  		return NULL;
> -- 
> 2.18.0
> 
> 
