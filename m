Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 23 Jul 2015 08:05:24 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yijing Wang <wangyijing@huawei.com>,
	Ma Jun <majun258@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Duc Dang <dhdang@apm.com>
Subject: Re: [PATCH v5 02/19] PCI: MSI: Register irq domain with specific
 token
Message-ID: <20150723130524.GQ21967@google.com>
References: <1437643598-19795-1-git-send-email-marc.zyngier@arm.com>
 <1437643598-19795-3-git-send-email-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437643598-19795-3-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Nit: "PCI/MSI" in subject so it matches the rest.

On Thu, Jul 23, 2015 at 10:26:21AM +0100, Marc Zyngier wrote:
> When creating a PCI/MSI domain, tag it with DOMAIN_BUS_PCI_MSI so
> that it can be looked-up using irq_find_matching_host().
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi.c         | 8 +++++++-
>  include/linux/irqdomain.h | 1 +
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 373d96e..ef4ec6e 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1273,12 +1273,18 @@ struct irq_domain *pci_msi_create_irq_domain(struct device_node *node,
>  					     struct msi_domain_info *info,
>  					     struct irq_domain *parent)
>  {
> +	struct irq_domain *domain;
> +
>  	if (info->flags & MSI_FLAG_USE_DEF_DOM_OPS)
>  		pci_msi_domain_update_dom_ops(info);
>  	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
>  		pci_msi_domain_update_chip_ops(info);
>  
> -	return msi_create_irq_domain(node, info, parent);
> +	domain = msi_create_irq_domain(node, info, parent);
> +	if (domain)
> +		domain->bus_token = DOMAIN_BUS_PCI_MSI;
> +
> +	return domain;

Nit2: I have a slight preference, hardly worth mentioning in such a simple
case, for this:

    domain = msi_create_irq_domain(node, info, parent);
    if (!domain)
	return NULL;

    domain->bus_token = DOMAIN_BUS_PCI_MSI;
    return domain;

>  }
>  
>  /**
> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> index 91a83ad..25e9e66 100644
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -54,6 +54,7 @@ struct irq_data;
>   */
>  enum irq_domain_bus_token {
>  	DOMAIN_BUS_ANY		= 0,
> +	DOMAIN_BUS_PCI_MSI,
>  };
>  
>  /**
> -- 
> 2.1.4
> 
