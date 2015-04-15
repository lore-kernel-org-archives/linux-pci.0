Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36457 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933503AbbDOQhB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 Apr 2015 12:37:01 -0400
Date: Wed, 15 Apr 2015 17:36:54 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
Cc: <linux-pci@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Scott Wood <scottwood@freescale.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] irqchip/gicv3-its: Support share device ID
Message-ID: <20150415173654.431f5d89@arm.com>
In-Reply-To: <1429091364-31939-2-git-send-email-Minghuan.Lian@freescale.com>
References: <1429091364-31939-1-git-send-email-Minghuan.Lian@freescale.com>
	<1429091364-31939-2-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 15 Apr 2015 17:49:23 +0800
Minghuan Lian <Minghuan.Lian@freescale.com> wrote:

> SMMU of some platforms can only isolate limited device ID.
> This may require that all PCI devices share the same ITS
> device with the fixed device ID. The patch adds function
> arch_msi_share_devid_update used for these platforms to update
> the fixed device ID and maximum MSI interrupts number.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index d0374a6..be78d0a 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1169,6 +1169,15 @@ static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
>  	return 0;
>  }
>  
> +void __weak
> +arch_msi_share_devid_update(struct pci_dev *pdev, u32 *dev_id, u32 *nvesc)
> +{
> +	/*
> +	 * use PCI_DEVID NOT share device ID as default
> +	 * so nothing need to do
> +	 */
> +}
> +

NAK. On top of being ugly as sin, this breaks any form of multiplatform
support. No way anything like this is going in. Guys, you really should
know better.

>  static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
>  			   int nvec, msi_alloc_info_t *info)
>  {
> @@ -1185,6 +1194,8 @@ static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
>  	dev_alias.count = nvec;
>  
>  	pci_for_each_dma_alias(pdev, its_get_pci_alias, &dev_alias);
> +	arch_msi_share_devid_update(pdev, &dev_alias.dev_id, &dev_alias.count);
> +

See the function above? That's where the aliasing should be taken care
of.

>  	its = domain->parent->host_data;
>  
>  	its_dev = its_find_device(its, dev_alias.dev_id);

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
