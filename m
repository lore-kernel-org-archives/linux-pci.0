Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:49491 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab3G1ELa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 28 Jul 2013 00:11:30 -0400
Received: by mail-pd0-f173.google.com with SMTP id p11so130214pdj.18
        for <linux-pci@vger.kernel.org>; Sat, 27 Jul 2013 21:11:29 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCHv5 01/11] irqdomain: add irq_alloc_mapping() function
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@gmail.com>
In-Reply-To: <1373889167-27878-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com> <1373889167-27878-2-git-send-email-thomas.petazzoni@free-electrons.com>
Date: Sat, 27 Jul 2013 22:11:26 -0600
Message-Id: <20130728041127.068613E08F8@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 15 Jul 2013 13:52:37 +0200, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:
> This commit extends the irqdomain subsystem with an
> irq_alloc_mapping() function which allows to let the irqdomain code
> find an available hwirq number in the range [ 0 ; domain size ] for
> the given domain, and create a virq mapping for it.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  include/linux/irqdomain.h |  2 ++
>  kernel/irq/irqdomain.c    | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> index c983ed1..1ffa336 100644
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -195,6 +195,8 @@ static inline unsigned int irq_linear_revmap(struct irq_domain *domain,
>  extern unsigned int irq_find_mapping(struct irq_domain *host,
>  				     irq_hw_number_t hwirq);
>  extern unsigned int irq_create_direct_mapping(struct irq_domain *host);
> +extern unsigned int irq_alloc_mapping(struct irq_domain *host,
> +				      irq_hw_number_t *hwirq);
>  extern int irq_create_strict_mappings(struct irq_domain *domain,
>  				      unsigned int irq_base,
>  				      irq_hw_number_t hwirq_base, int count);
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 706724e..b9ddb94 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -375,6 +375,38 @@ unsigned int irq_create_direct_mapping(struct irq_domain *domain)
>  EXPORT_SYMBOL_GPL(irq_create_direct_mapping);
>  
>  /**
> + * irq_alloc_mapping() - Allocate an irq for mapping
> + * @domain: domain to allocate the irq for or NULL for default domain
> + * @hwirq:  reference to the returned hwirq
> + *
> + * This routine are used for irq controllers which can choose the
> + * hardware interrupt number from a range [ 0 ; domain size ], such as
> + * is often the case with PCI MSI controllers. The function will
> + * returned the allocated hwirq number in the hwirq pointer, and the
> + * corresponding virq number as the return value.
> + */
> +unsigned int irq_alloc_mapping(struct irq_domain *domain,
> +			       irq_hw_number_t *out_hwirq)
> +{
> +	irq_hw_number_t hwirq;
> +
> +	pr_debug("irq_alloc_mapping(0x%p)\n", domain);
> +
> +	for (hwirq = 0; hwirq < domain->hwirq_max; hwirq++)
> +		if (!irq_find_mapping(domain, hwirq))
> +			break;

Okay, you can add my acked-by, but only if you change the above hunk to:

	for (hwirq = 0; hwirq < domain->revmap_size; hwirq++)
		if (domain->linear_revmap[hwirq] == 0)
			break;

In some cases hwirq_max will be set to ~0, which means calling
irq_find_mapping about 4 billion times. Not safe. The above change
prevents that problem, but it also means the function won't work for the
tree map. A followup patch can be crafted to add support for the tree
mapping.

> +
> +	if (hwirq == domain->hwirq_max) {
> +		pr_debug("-> no available hwirq found\n");
> +		return 0;
> +	}
> +
> +	*out_hwirq = hwirq;
> +	return irq_create_mapping(domain, hwirq);

out_hwirq should *not* be modified if irq_create_mapping fails. You'll
need to rework the above to:

	rc = irq_create_mapping(domain, hwirq);
	if (rc)
		*out_hwirq = hwirq;
	return rc;

When the above two issues are fixed:

Acked-by: Grant Likely <grant.likely@linaro.org>

> +}
> +EXPORT_SYMBOL_GPL(irq_alloc_mapping);
> +
> +/**
>   * irq_create_mapping() - Map a hardware interrupt into linux irq space
>   * @domain: domain owning this hardware interrupt or NULL for default domain
>   * @hwirq: hardware irq number in that domain space
> -- 
> 1.8.1.2
> 

