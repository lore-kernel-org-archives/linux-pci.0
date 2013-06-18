Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:45941 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756032Ab3FRKPn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2013 06:15:43 -0400
Received: by mail-we0-f173.google.com with SMTP id x54so3270658wes.32
        for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2013 03:15:42 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 4/8] irqchip: armada-370-xp: implement MSI support
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Maen Suleiman <maen@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org
In-Reply-To: <20130618104218.7917f927@skate>
References: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com> <1370536888-8871-5-git-send-email-thomas.petazzoni@free-electrons.com> <20130611133745.514CA3E0A90@localhost> <20130618104218.7917f927@skate>
Date: Tue, 18 Jun 2013 11:15:38 +0100
Message-Id: <20130618101538.8D54E3E0D60@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 18 Jun 2013 10:42:18 +0200, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:
> Dear Grant Likely,
> 
> On Tue, 11 Jun 2013 14:37:45 +0100, Grant Likely wrote:
> 
> > > +static int armada_370_xp_setup_msi_irq(struct msi_chip *chip,
> > > +				       struct pci_dev *pdev,
> > > +				       struct msi_desc *desc)
> > > +{
> > > +	struct msi_msg msg;
> > > +	int hwirq, irq;
> > > +
> > > +	hwirq = armada_370_xp_alloc_msi();
> > > +	if (hwirq < 0)
> > > +		return hwirq;
> > > +
> > > +	irq = irq_create_mapping(armada_370_xp_msi_domain, hwirq);
> > > +	if (!irq) {
> > > +		armada_370_xp_free_msi(hwirq);
> > > +		return -EINVAL;
> > > +	}
> > 
> > This looks like something that the irq_domain should handle for you.
> > It would be good to have a variant of irq_create_mapping() that keeps
> > track of available hwirqs, allocates a free one, and maps it all with
> > one function call. I can see that being useful by other MSI interrupt
> > controllers and would eliminate needing to open-code it above.
> > 
> > take a look at the irqdomain/test branch on git://git.secretlab.ca/git/linux
> > 
> > I'm hoping to push that series into v3.11 and it simplifies the
> > irq_domain code quite a bit. It would be easy to build an
> > irq_create_mapping() variant on top of that. Take a look at
> > irq_create_direct_mapping() for inspiration (although that function does
> > it the other way around. It allocates a virq and uses that number for
> > the hwirq number)
> 
> Ok, I've implemented something according to your idea. Will be part of
> the v3 of this series. For reference, the piece of code I've added in
> irqdomain.c looks like:
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
> +                              irq_hw_number_t *out_hwirq)
> +{
> +       unsigned int virq;
> +       irq_hw_number_t hwirq;
> +
> +       pr_debug("irq_alloc_mapping(0x%p)\n", domain);
> +
> +       if (domain == NULL)
> +               domain = irq_default_domain;

Drop the above 2 lines. You absolutely must know what irq_domain you
want to operate on when calling this function. There is no situation
where the default domain is what should be used.

> +
> +       for (hwirq = 0; hwirq < domain->hwirq_max; hwirq++)
> +               if (!irq_find_mapping(domain, hwirq))
> +                       break;

Ugh. This will be slow on domains with a high hwirq_max and low
revmap_size since all the lookups will go out to the radix tree. Blech.
Not much to do about it though at this point without implementing some
kind of fast lookup path. To do it right would require iterating over
the radix tree looking for a hole.

> +
> +       if (hwirq == domain->hwirq_max) {
> +               pr_debug("-> no available hwirq found\n");
> +               return 0;
> +       }
> +
> +       virq = irq_alloc_desc_from(1, of_node_to_nid(domain->of_node));
> +       if (virq <= 0) {
> +               pr_debug("-> virq allocation failed\n");
> +               return 0;
> +       }
> +
> +       if (irq_domain_associate(domain, virq, hwirq)) {
> +               irq_free_desc(virq);
> +               return 0;
> +       }

Once a free hwirq has been found, it would be better to call
irq_create_mapping() directly rather than open coding it.

> +
> +       pr_debug("irq %lu on domain %s mapped to virtual irq %u\n",
> +                hwirq, of_node_full_name(domain->of_node), virq);
> +
> +       *out_hwirq = hwirq;
> +
> +       return virq;
> +}
> +EXPORT_SYMBOL_GPL(irq_alloc_mapping);
> +
> +/**
