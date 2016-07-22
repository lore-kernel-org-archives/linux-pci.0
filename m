Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57426 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751916AbcGVWEp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 22 Jul 2016 18:04:45 -0400
Date: Fri, 22 Jul 2016 17:04:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq/msi: Make sure PCI MSIs are activated early
Message-ID: <20160722220440.GC32142@localhost>
References: <1468426713-31431-1-git-send-email-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1468426713-31431-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 13, 2016 at 05:18:33PM +0100, Marc Zyngier wrote:
> Bharat Kumar Gogada reported issues with the generic MSI code,
> where the end-point ended up with garbage in its MSI configuration
> (both for the vector and the message).
> 
> It turns out that the two MSI paths in the kernel are doing slightly
> different things:
> 
> generic MSI: disable MSI -> allocate MSI -> enable MSI -> setup EP
> PCI MSI: disable MSI -> allocate MSI -> setup EP -> enable MSI
> 
> and it turns out that end-points are allowed to latch the content
> of the MSI configuration registers as soon as MSIs are enabled.
> In Bharat's case, the end-point ends up using whatever was there
> already, which is not what you want.
> 
> In order to make things converge, we introduce a new MSI domain
> flag (MSI_FLAG_ACTIVATE_EARLY) that is unconditionally set for
> PCI/MSI. When set, this flag forces the programming of the end-point
> as soon as the MSIs are allocated.
> 
> A consequence of this is that we have an extra activate in
> irq_startup, but that should be without much consequence.
> 
> Reported-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Tested-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thomas, let me know if you'd like me to take this.  It looks like the
real smarts here are in kernel/irq, so I assume you'll take it unless
I hear otherwise.

> ---
>  drivers/pci/msi.c   | 2 ++
>  include/linux/msi.h | 2 ++
>  kernel/irq/msi.c    | 7 +++++++
>  3 files changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index a080f44..565e2a4 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1277,6 +1277,8 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
>  	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
>  		pci_msi_domain_update_chip_ops(info);
>  
> +	info->flags |= MSI_FLAG_ACTIVATE_EARLY;
> +
>  	domain = msi_create_irq_domain(fwnode, info, parent);
>  	if (!domain)
>  		return NULL;
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 8b425c6..513b7c7 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -270,6 +270,8 @@ enum {
>  	MSI_FLAG_MULTI_PCI_MSI		= (1 << 3),
>  	/* Support PCI MSIX interrupts */
>  	MSI_FLAG_PCI_MSIX		= (1 << 4),
> +	/* Needs early activate, required for PCI */
> +	MSI_FLAG_ACTIVATE_EARLY		= (1 << 5),
>  };
>  
>  int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index 38e89ce..4ed2cca 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -361,6 +361,13 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
>  		else
>  			dev_dbg(dev, "irq [%d-%d] for MSI\n",
>  				virq, virq + desc->nvec_used - 1);
> +
> +		if (info->flags & MSI_FLAG_ACTIVATE_EARLY) {
> +			struct irq_data *irq_data;
> +
> +			irq_data = irq_domain_get_irq_data(domain, desc->irq);
> +			irq_domain_activate_irq(irq_data);
> +		}
>  	}
>  
>  	return 0;
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
