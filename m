Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:47724 "EHLO
	mail.free-electrons.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753156Ab3G2NEm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jul 2013 09:04:42 -0400
Date: Mon, 29 Jul 2013 15:04:38 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <robherring2@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Re: [PATCHv5 05/11] of: pci: add registry of MSI chips
Message-ID: <20130729150438.4872da76@skate>
In-Reply-To: <20130729125826.GH23152@manwe>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1373889167-27878-6-git-send-email-thomas.petazzoni@free-electrons.com>
	<51E41F7A.4010502@gmail.com>
	<20130728043310.6CF1D3E08FE@localhost>
	<20130728162711.32a9a21e@skate>
	<20130729065431.GA1115@manwe>
	<20130729142600.63eeab50@skate>
	<20130729125826.GH23152@manwe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Thierry Reding,

On Mon, 29 Jul 2013 14:58:27 +0200, Thierry Reding wrote:

> >  /**
> > + * irq_find_msi() - Locates a MSI domain for a given device node
> > + * @node: device-tree node of the interrupt controller
> > + */
> > +struct irq_domain *irq_find_msi(struct device_node *node)
> > +{
> > +	struct irq_domain *h, *found = NULL;
> > +
> > +	mutex_lock(&irq_domain_mutex);
> > +	list_for_each_entry(h, &irq_domain_list, link) {
> > +		if (!h->msi_chip)
> > +			continue;
> > +		if (h->of_node && h->of_node == node) {
> > +			found = h;
> > +			break;
> > +		}
> > +	}
> > +	mutex_unlock(&irq_domain_mutex);
> > +	return found;
> > +}
> > +EXPORT_SYMBOL_GPL(irq_find_msi);
> 
> This doesn't quite copy what irq_find_host() does, since it ignores the
> associated ops->match().

Correct.

> But given that ops->match() already provides a way to hook into the
> lookup, perhaps we could add a function such as this:
> 
> 	int irq_domain_supports_msi(struct irq_domain *d, struct device_node *node)
> 	{
> 		if ((d->of_node == NULL) || (d->of_node != node))
> 			return 0;
> 
> 		return d->msi_chip != NULL;
> 	}
> 
> Then use that in drivers that expose MSI functionality via an IRQ domain
> like this:
> 
> 	static const struct irq_domain_ops foo_irq_domain_ops = {
> 		...
> 		.match = irq_domain_supports_msi,
> 		...
> 	};
>
> One problem with this is that it doesn't solve your problem where two
> different IRQ domains are exposed by the same device, because the
> irq_find_host() will still match the MSI IRQ domain for the non-MSI
> device node as well.

Indeed.

> This could be solved by adding another match function...

But this would involve changing all the users of irq_find_host(), no?

> This goes in hand with the helper-style API that I mentioned above. But
> it's really up to Grant to decide which way he wants this to go.

Yes, Grant, your suggestions are welcome on this. Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
