Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:32889 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817AbbJHUFN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Oct 2015 16:05:13 -0400
Subject: Re: [PATCH v8 4/6] pci: altera: Add Altera PCIe MSI driver
To: lftan@altera.com
References: <E1ZkHFw-0007bx-3v@feisty.vs19.net>
Cc: linux-kernel@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, linux-pci@vger.kernel.org
From: Corentin LABBE <clabbe.montjoie@gmail.com>
Message-ID: <5616CC75.5030700@gmail.com>
Date: Thu, 8 Oct 2015 22:05:09 +0200
MIME-Version: 1.0
In-Reply-To: <E1ZkHFw-0007bx-3v@feisty.vs19.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> This patch adds Altera PCIe MSI driver. This soft IP supports configurable
> number of vectors, which is a dts parameter.
> 
> Signed-off-by: Ley Foon Tan <lftan@altera.com>
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> +
> +static inline void msi_writel(struct altera_msi *msi, u32 value, u32 reg)
> +{
> +	writel_relaxed(value, msi->csr_base + reg);
> +}
> +
> +static inline u32 msi_readl(struct altera_msi *msi, u32 reg)
> +{
> +	return readl_relaxed(msi->csr_base + reg);
> +}
> +

You could set value and reg parameter as const

> +
> +static int altera_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +				   unsigned int nr_irqs, void *args)
> +{
> +	struct altera_msi *msi = domain->host_data;
> +	unsigned long bit;
> +	u32 mask;
> +
> +	WARN_ON(nr_irqs != 1);
> +	mutex_lock(&msi->lock);
> +
> +	bit = find_first_zero_bit(msi->used, msi->num_of_vectors);
> +	if (bit >= msi->num_of_vectors)
> +		return -ENOSPC;
> +
> +	set_bit(bit, msi->used);
> +
> +	mutex_unlock(&msi->lock);
> +
> +	irq_domain_set_info(domain, virq, bit, &altera_msi_bottom_irq_chip,
> +			    domain->host_data, handle_simple_irq,
> +			    NULL, NULL);
> +
> +	mask = msi_readl(msi, MSI_INTMASK);
> +	mask |= 1 << bit;
> +	msi_writel(msi, mask, MSI_INTMASK);
> +
> +	return 0;
> +}

You do not unlock the mutex when returning -ENOSPC
And again some parameter could be set as const

