Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from up.free-electrons.com ([94.23.35.102]:52395 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751166Ab3HAJRH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Aug 2013 05:17:07 -0400
Date: Thu, 1 Aug 2013 11:17:02 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv5 05/11] of: pci: add registry of MSI chips
Message-ID: <20130801111702.5f85dc91@skate>
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

> > +static inline struct irq_domain *irq_domain_add_msi(struct device_node *of_node,
> > +						    unsigned int size,
> > +						    const struct irq_domain_ops *ops,
> > +						    struct msi_chip *msi_chip,
> > +						    void *host_data)
> > +{
> > +	return __irq_domain_add(of_node, size, size, 0, ops,
> > +				msi_chip, host_data);
> >  }
> 
> Given that the majority of interrupt controllers probably don't have any
> MSI functionality, I wonder if perhaps this should be done in a more
> helper-oriented way, see below...

I'm not sure I get the relation between this comment on this specific
part of the code and the match helpers suggestion that you did below.
Could you explain?


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
> 
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
> device node as well. This could be solved by adding another match
> function...

I've given this some thought, and I don't see how ->match() functions
can solve the problem. The irq_find_host() is simply given as input a
DT node, and is asked to find the irqdomain attached to this DT node.
To do so, for each irqdomain in the system, it calls the ->match()
operation, or does some default DT node equality checking. However,
nor the irq_find_host() function, nor a custom ->match() function has a
way of knowing whether what you're looking for is the "normal" IRQ
controller, or the MSI controller.

> This goes in hand with the helper-style API that I mentioned above. But
> it's really up to Grant to decide which way he wants this to go.

Again, I am not sure what you meant with "helper-style API". I do
understand the idea of providing a helper irq_domain_supports_msi()
that can be used as the ->match() operation in irq_domain_ops, but I
fail to see how this solves the problem.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
