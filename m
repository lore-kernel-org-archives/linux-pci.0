Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:34017 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130Ab3GPIbg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jul 2013 04:31:36 -0400
Date: Tue, 16 Jul 2013 10:31:15 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCHv5 01/11] irqdomain: add irq_alloc_mapping() function
Message-ID: <20130716103115.552dcbd6@skate>
In-Reply-To: <1373889167-27878-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1373889167-27878-2-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Grant,

Would it be possible to get your opinion on the below patch? We have
already discussed it in the past, and it was implemented according to
your suggestions, so I guess it should be fine, but I'd like to have
your formal Acked-by if possible, or additional comments. It is needed
for the MSI support on Marvell PCIe, but now the Tegra people are also
interested by it, and we hope to get this merged in 3.12.

Thanks!

Thomas

On Mon, 15 Jul 2013 13:52:37 +0200, Thomas Petazzoni wrote:
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
> +
> +	if (hwirq == domain->hwirq_max) {
> +		pr_debug("-> no available hwirq found\n");
> +		return 0;
> +	}
> +
> +	*out_hwirq = hwirq;
> +	return irq_create_mapping(domain, hwirq);
> +}
> +EXPORT_SYMBOL_GPL(irq_alloc_mapping);
> +
> +/**
>   * irq_create_mapping() - Map a hardware interrupt into linux irq space
>   * @domain: domain owning this hardware interrupt or NULL for default domain
>   * @hwirq: hardware irq number in that domain space



-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
