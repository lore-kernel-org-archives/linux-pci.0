Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <55B342A4.30501@linaro.org>
Date: Sat, 25 Jul 2015 16:02:44 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: Marc Zyngier <marc.zyngier@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	linux-pci@vger.kernel.org, Duc Dang <dhdang@apm.com>,
	linux-kernel@vger.kernel.org, Yijing Wang <wangyijing@huawei.com>,
	linux-arm-kernel@lists.infradead.org, Ma Jun <majun258@huawei.com>
Subject: Re: [PATCH v5 02/19] PCI: MSI: Register irq domain with specific
 token
References: <1437643598-19795-1-git-send-email-marc.zyngier@arm.com> <1437643598-19795-3-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1437643598-19795-3-git-send-email-marc.zyngier@arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/23/2015 05:26 PM, Marc Zyngier wrote:
> When creating a PCI/MSI domain, tag it with DOMAIN_BUS_PCI_MSI so
> that it can be looked-up using irq_find_matching_host().
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   drivers/pci/msi.c         | 8 +++++++-
>   include/linux/irqdomain.h | 1 +
>   2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 373d96e..ef4ec6e 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1273,12 +1273,18 @@ struct irq_domain *pci_msi_create_irq_domain(struct device_node *node,
>   					     struct msi_domain_info *info,
>   					     struct irq_domain *parent)
>   {
> +	struct irq_domain *domain;
> +
>   	if (info->flags & MSI_FLAG_USE_DEF_DOM_OPS)
>   		pci_msi_domain_update_dom_ops(info);
>   	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
>   		pci_msi_domain_update_chip_ops(info);
>
> -	return msi_create_irq_domain(node, info, parent);
> +	domain = msi_create_irq_domain(node, info, parent);
> +	if (domain)
> +		domain->bus_token = DOMAIN_BUS_PCI_MSI;
> +
> +	return domain;
>   }
>
>   /**
> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> index 91a83ad..25e9e66 100644
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -54,6 +54,7 @@ struct irq_data;
>    */
>   enum irq_domain_bus_token {
>   	DOMAIN_BUS_ANY		= 0,
> +	DOMAIN_BUS_PCI_MSI,
>   };

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
