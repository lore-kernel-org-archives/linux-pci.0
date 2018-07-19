Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48166 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbeGSMUD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Jul 2018 08:20:03 -0400
Date: Thu, 19 Jul 2018 12:37:14 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 01/10] PCI: Add pci_host_alloc_intx_irqd() for
 allocating IRQ domain
Message-ID: <20180719113714.GC9213@e107981-ln.cambridge.arm.com>
References: <1528939995-183203-1-git-send-email-shawn.lin@rock-chips.com>
 <1528940057-183252-1-git-send-email-shawn.lin@rock-chips.com>
 <20180614090902.7b30a0d2@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180614090902.7b30a0d2@windsurf>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 14, 2018 at 09:09:02AM +0200, Thomas Petazzoni wrote:

[...]

> > +				sizeof(struct irq_domain_ops), GFP_KERNEL);
> > +		if (!irqd_ops) {
> > +			err = -ENOMEM;
> > +			goto err_out;
> > +		}
> > +
> > +		irqd_ops->map = &pcie_intx_map;
> > +		if (general_xlate)
> > +			irqd_ops->xlate = &pci_irqd_intx_xlate;
> > +		intx_domain_ops = irqd_ops;
> > +	}
> > +#ifdef CONFIG_IRQ_DOMAIN
> > +	domain = irq_domain_add_linear(intc, PCI_NUM_INTX,
> > +				       intx_domain_ops, host);
> > +#endif
> 
> Isn't it a bit weird to have this in the middle of this function ?
> Should you instead declare a stub pci_host_alloc_intx_irqd() function
> in the header file if CONFIG_IRQ_DOMAIN is not enabled ?
> 
> I.e in pci.h:
> 
> #ifdef CONFIG_IRQ_DOMAIN
> struct irq_domain *pci_host_alloc_intx_irqd(struct device *dev,
> 				void *host, bool general_xlate,
> 				const struct irq_domain_ops *intx_domain_ops,
> 				struct device_node *local_intc);
> #else
> static inline struct irq_domain *pci_host_alloc_intx_irqd(struct device *dev,
> 	void *host, bool general_xlate, const struct irq_domain_ops *intx_domain_ops,
> 	struct device_node *local_intc)
> {
> 	return PTR_ERR(-EINVAL);
> }
> #endif
> 
> or something like that.

Yes, he should.

> Finally a purely subjective and personal opinion: I'm not a big fan of
> this boolean that tells whether the ->xlate hook should be populated or
> not. I'm not sure if it makes sense for this function to create the
> irqdomain_ops altogether, perhaps it should be mandatory for the
> irq_domain_ops to be provided by the caller. The problem with the
> boolean general_xlate is that it is an endless story of additional
> booleans to tweak more stuff in the irq_domain_ops structure. But of
> course that's just a personal view, and my view doesn't really count
> here :-)

Your view does count here and I 100% agree with you. I do not like the
->xlate hack (that is just there to make things work on systems with
broken DTS files and bindings for legacy IRQ mappings) and this patch
would just institutionalize it at PCI API level. So, if we *do* want to
consolidate code, the domain ops should be passed in, as you mentioned.

Thanks,
Lorenzo
