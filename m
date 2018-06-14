Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:40408 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752833AbeFNHJE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Jun 2018 03:09:04 -0400
Date: Thu, 14 Jun 2018 09:09:02 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 01/10] PCI: Add pci_host_alloc_intx_irqd() for
 allocating IRQ domain
Message-ID: <20180614090902.7b30a0d2@windsurf>
In-Reply-To: <1528940057-183252-1-git-send-email-shawn.lin@rock-chips.com>
References: <1528939995-183203-1-git-send-email-shawn.lin@rock-chips.com>
        <1528940057-183252-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

One nit below.

On Thu, 14 Jun 2018 09:34:17 +0800, Shawn Lin wrote:

> +	if (!intc) {
> +		intc = of_get_next_child(dev->of_node, NULL);
> +		if (!intc) {
> +			dev_err(dev, "missing child interrupt-controller node\n");
> +			goto err_out;
> +		}
> +		need_put = true;
> +	}
> +
> +	if (!intx_domain_ops) {
> +		irqd_ops = (struct irq_domain_ops *)devm_kmalloc(dev,

The cast doesn't seem to be useful.

> +				sizeof(struct irq_domain_ops), GFP_KERNEL);
> +		if (!irqd_ops) {
> +			err = -ENOMEM;
> +			goto err_out;
> +		}
> +
> +		irqd_ops->map = &pcie_intx_map;
> +		if (general_xlate)
> +			irqd_ops->xlate = &pci_irqd_intx_xlate;
> +		intx_domain_ops = irqd_ops;
> +	}
> +#ifdef CONFIG_IRQ_DOMAIN
> +	domain = irq_domain_add_linear(intc, PCI_NUM_INTX,
> +				       intx_domain_ops, host);
> +#endif

Isn't it a bit weird to have this in the middle of this function ?
Should you instead declare a stub pci_host_alloc_intx_irqd() function
in the header file if CONFIG_IRQ_DOMAIN is not enabled ?

I.e in pci.h:

#ifdef CONFIG_IRQ_DOMAIN
struct irq_domain *pci_host_alloc_intx_irqd(struct device *dev,
				void *host, bool general_xlate,
				const struct irq_domain_ops *intx_domain_ops,
				struct device_node *local_intc);
#else
static inline struct irq_domain *pci_host_alloc_intx_irqd(struct device *dev,
	void *host, bool general_xlate, const struct irq_domain_ops *intx_domain_ops,
	struct device_node *local_intc)
{
	return PTR_ERR(-EINVAL);
}
#endif

or something like that.

Finally a purely subjective and personal opinion: I'm not a big fan of
this boolean that tells whether the ->xlate hook should be populated or
not. I'm not sure if it makes sense for this function to create the
irqdomain_ops altogether, perhaps it should be mandatory for the
irq_domain_ops to be provided by the caller. The problem with the
boolean general_xlate is that it is an endless story of additional
booleans to tweak more stuff in the irq_domain_ops structure. But of
course that's just a personal view, and my view doesn't really count
here :-)

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
