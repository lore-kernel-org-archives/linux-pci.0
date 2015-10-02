Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <560EA099.2060907@arm.com>
Date: Fri, 02 Oct 2015 16:19:53 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: David Daney <ddaney.cavm@gmail.com>, linux-kernel@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Grant Likely <grant.likely@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Frank Rowand <frowand.list@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
CC: David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v4 4/4] irqchip/gic-v3-its:  Add handling of PCI requester
 id.
References: <1443747025-9918-1-git-send-email-ddaney.cavm@gmail.com> <1443747025-9918-5-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1443747025-9918-5-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/10/15 01:50, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Replace open coded generation PCI/MSI requester id with call to the
> new function pci_msi_domain_get_msi_rid() which applies the "msi-map"
> to the id value.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  drivers/irqchip/irq-gic-v3-its-pci-msi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> index cf351c6..7bbf64a 100644
> --- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> +++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> @@ -42,7 +42,6 @@ static struct irq_chip its_msi_irq_chip = {
>  
>  struct its_pci_alias {
>  	struct pci_dev	*pdev;
> -	u32		dev_id;
>  	u32		count;
>  };
>  
> @@ -60,7 +59,6 @@ static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
>  {
>  	struct its_pci_alias *dev_alias = data;
>  
> -	dev_alias->dev_id = alias;
>  	if (pdev != dev_alias->pdev)
>  		dev_alias->count += its_pci_msi_vec_count(dev_alias->pdev);

Damn it. You've just shown me a bug. Unrelated to what you're doing, but
still. I'll post a patch shortly.

>  
> @@ -86,7 +84,7 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
>  	pci_for_each_dma_alias(pdev, its_get_pci_alias, &dev_alias);
>  
>  	/* ITS specific DeviceID, as the core ITS ignores dev. */
> -	info->scratchpad[0].ul = dev_alias.dev_id;
> +	info->scratchpad[0].ul = pci_msi_domain_get_msi_rid(domain, pdev);
>  
>  	return msi_info->ops->msi_prepare(domain->parent,
>  					  dev, dev_alias.count, info);
> 

Looks good to me.

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
