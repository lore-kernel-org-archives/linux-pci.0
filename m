Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:41259 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbeHDJA7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Aug 2018 05:00:59 -0400
Date: Sat, 4 Aug 2018 09:01:18 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Heiner Kallweit <hkallweit1@gmail.com>
cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] PCI: set flag IRQCHIP_ONESHOT_SAFE for PCI-MSI
 irqchip's
In-Reply-To: <9f18bc20-cf27-bc3c-71e5-4e24a6c983c7@gmail.com>
Message-ID: <alpine.DEB.2.21.1808040900150.1658@nanos.tec.linutronix.de>
References: <9f18bc20-cf27-bc3c-71e5-4e24a6c983c7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 3 Aug 2018, Heiner Kallweit wrote:

> PCI-MSI is oneshot-safe, therefore set flag IRQCHIP_ONESHOT_SAFE to
> avoid unneeded masking/unmasking. See also discussion here:
> https://marc.info/?l=linux-pci&m=153332526101128&w=2

This changelog really wants a bit more detailed information.

> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
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
