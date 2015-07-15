Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40197 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752000AbbGORaj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 Jul 2015 13:30:39 -0400
Message-ID: <55A698BC.2060308@arm.com>
Date: Wed, 15 Jul 2015 18:30:36 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: David Daney <ddaney.cavm@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>
CC: Robert Richter <rrichter@cavium.com>, linux-kernel@vger.kernel.org,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 2/5] gic-its: Allow pci_requester_id to be overridden.
References: <1436979285-8177-1-git-send-email-ddaney.cavm@gmail.com> <1436979285-8177-3-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1436979285-8177-3-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 15/07/15 17:54, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c   | 14 +++++++++++++-
>  include/linux/irqchip/arm-gic-v3.h |  2 ++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 1b7e155..4580970 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1189,11 +1189,23 @@ static int its_pci_msi_vec_count(struct pci_dev *pdev)
>  	return max(msi, msix);
>  }
>  
> +static u32 its_dflt_pci_requester_id(struct pci_dev *pdev, u16 alias)
> +{
> +	return alias;
> +}
> +
> +static its_pci_requester_id_t its_pci_requester_id = its_dflt_pci_requester_id;
> +void set_its_pci_requester_id(its_pci_requester_id_t fn)
> +{
> +	its_pci_requester_id = fn;
> +}
> +EXPORT_SYMBOL(set_its_pci_requester_id);
> +
>  static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
>  {
>  	struct its_pci_alias *dev_alias = data;
>  
> -	dev_alias->dev_id = alias;
> +	dev_alias->dev_id = its_pci_requester_id(pdev, alias);
>  	if (pdev != dev_alias->pdev)
>  		dev_alias->count += its_pci_msi_vec_count(dev_alias->pdev);
>  
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> index ffbc034..18e3757 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -389,6 +389,8 @@ int its_cpu_init(void);
>  int its_init(struct device_node *node, struct rdists *rdists,
>  	     struct irq_domain *domain);
>  
> +typedef u32 (*its_pci_requester_id_t)(struct pci_dev *, u16);
> +void set_its_pci_requester_id(its_pci_requester_id_t fn);
>  #endif
>  
>  #endif
> 

This has already been proposed, and I already spoke my mind about that
sort of approach (just in case you had any doubt, this is a NAK).

If you have a new fancy kind of aliasing, please extend the capabilities
of pci_for_each_dma_alias or describe it in terms of topological
information that can be parsed.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
