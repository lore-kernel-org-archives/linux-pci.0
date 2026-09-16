Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AF34AF9F5;
	Wed, 16 Sep 2026 23:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789600232; cv=none; b=brwmHg0n/HFrngHpKQOSDxvFjO1sZkXqbTlBg2kgU6jq+jUfMguOkfKqoQ1iU4438GIr57OoAxelsNjONi1YOuHEFlgWABIIqKoJVs5XrNieeVksRQp1wMfRUbltc6Aq6gPVYQ0sWbm/8wZDMGcjOiNxPC6tQYlUFcxjHPZ6O6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789600232; c=relaxed/simple;
	bh=xCguHQMCYrAhxUbvncvb/JwqRF+LXT699cO5jsTk2qE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=boJb7yRfZJXKeqQpxOJmr5ir959+siT8DQizABSyv2VOaPY1ivzH4vgjPdIgNqndz5V3/aHYdY9+rJOf8QgFmTcWPT7FKElMygHjhcLOz9t/IvOwnRAdJvwHBW+1pxso2tPmkD6gUWc9xxxdHlmqiF9wcWGTM7Ozs34CyO7KUH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwdgEypZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwdgEypZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D482E1F000FF;
	Wed, 16 Sep 2026 23:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789600231;
	bh=y00T1vmj1UNGlqOvYl58ewkG2IXit9qkBHxOO+JErbk=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=kwdgEypZlQDkuCoFOh0C/E21c0yGWzeULgahWnxF1Iu1g+8uMV4XcSCFfZsj9Sy8N
	 MbtJcyqXbrQaeCQmE05ttgEz2xMI4OMelHLRnlW7kVCX6quKsZJ4wu18xUwMZzd03s
	 rJwLQDd4CRfL6kdxM/9uqkO2MC+5hjL6noZQ7dPNnfcko+72dvFQEY9Q88lcBacnPu
	 30D2JY73JbWiXUCZ9mYTAVR0oJP/52ozLf6+/g8XYXFSQcRMjV8aFm3zSiNM5h+cZC
	 dO7j3GNju0sVIT/SmgOZX90zZEajsBFBLAAPDlYPg+xhlBtbCnEfMIJPlntWdMauRQ
	 rbOl0fOIZ9u6Q==
Date: Wed, 16 Sep 2026 18:10:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sangwoo Han <sangwoo.han@nearthlab.com>
Cc: Thomas Gleixner <tglx@kernel.org>, jim2101024@gmail.com,
	florian.fainelli@broadcom.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, bhelgaas@google.com,
	bcm-kernel-feedback-list@broadcom.com, robh@kernel.org,
	linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Inochi Amaoto <inochiama@gmail.com>
Subject: Re: [PATCH] PCI: brcmstb: Reserve only the MSI vectors that are
 handed out
Message-ID: <20260916231029.GA988000@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cxuo3fl9.ffs@fw13>

On Mon, Sep 07, 2026 at 11:40:34PM +0200, Thomas Gleixner wrote:
> On Mon, Sep 07 2026 at 11:34, Bjorn Helgaas wrote:
> > [+cc Thomas, Inochi for MSI expertise]
> >
> > I want to revive this thread because I think there's a real problem
> > here, and we should solve it for all the PCI controller drivers.
> >
> > There's nothing brcm-specific about the bitmap alloc/free except the
> > size of the msi->used bitmap, so I don't want to copy/paste this sort
> > of fix in all the affected drivers.
> >
> > I'd also like to avoid the extra align_mask and
> > bitmap_find_next_zero_area() followed by manual bitmap_set().
> > bitmap_find_free_region() already takes care of the alignment and
> > setting the allocated bits.
> >
> > The MSI Multiple Message Enable situation of enabling more vectors in
> > the device than the driver wants is generic to all devices that
> > advertise Multiple Message Capable, and I don't think we should have
> > to deal with this in every host controller driver.
> 
> Correct.
> 
> > If a driver requests 3 vectors, we have to enable 4 because MSI only
> > supports power-of-two number of vectors.  This tells the device it is
> > allowed to use all 4 vectors, and I think the PCI MSI core should
> > assume they all *will* be used instead of relying on the driver's
> > claim that it will only use 3.
> 
> That's not really a good idea because e.g. the irq affinity stuff relies
> on the accurate number of interrupts the driver requested with the
> minvec/maxvec range. We can't magically spread more interrupts than the
> driver is able/willing to handle.
> 
> But we can fix that without changing the consumer side (device drivers)
> visible behaviour and handle it solely in the core code.
> 
>  1) MSI interrupts are special because they have msi_desc::nvec_used >
>     1, so the allocation and the free path can take care of the power of
>     two requirement. That just allocates more resources than the driver
>     wants but they are just memory.
> 
>  2) All MSI parent domain implementations should be able to handle
>     domain_ops::free() with nr_irqs > 1. That's something which can be
>     trivialy audited.
> 
>     I really have no memories why the bulk remove function iterates the
>     interrupts one by one instead of doing in one go, but this is also
>     used by non MSI domains, which might have issues with a bulk remove.
> 
>     If we establish that all MSI parent domain implementations can
>     handle the free() callback with nr_irqs > 1, then
>     irq_domain_free_irqs_hierarchy can check whether
>     IRQ_DOMAIN_FLAG_MSI_PARENT is set in the domain_flags and avoid the
>     loop for that case.
>     
> Something like the completely untested below.

Sangwoo, is there any chance you can test this and see whether it
fixes the issue?

If it does, I guess we'll have to ask Thomas to post it with the
appropriate Signed-off-by, etc.

> ---
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 4fdcb6df5306..b3f6cc6ae2ce 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -1611,6 +1611,13 @@ static void irq_domain_free_irqs_hierarchy(struct irq_domain *domain,
>  	if (!domain->ops->free)
>  		return;
>  
> +	/* CHECKME: Are all MSI parent domains capable ? */
> +	if (domain->flags & IRQ_DOMAIN_FLAG_MSI_PARENT) {
> +		if (irq_domain_get_irq_data(domain, irq_base))
> +			domain->ops->free(domain, irq_base, nr_irqs);
> +		return;
> +	}
> +
>  	for (i = 0; i < nr_irqs; i++) {
>  		if (irq_domain_get_irq_data(domain, irq_base + i))
>  			domain->ops->free(domain, irq_base + i, 1);
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index fb5f372215bf..2835b09899ea 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -1333,20 +1333,28 @@ static int __msi_domain_alloc_irqs(struct device *dev, struct irq_domain *domain
>  
>  		ops->set_desc(&arg, desc);
>  
> -		virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
> +		/* Make sure a MULTI-MSI allocation is power of two */
> +		unsigned int nvec_aligned = roundup_pow_of_two(desc->nvec_used);
> +
> +		virq = __irq_domain_alloc_irqs(domain, -1, nvec_aligned,
>  					       dev_to_node(dev), &arg, false,
>  					       desc->affinity);
>  		if (virq < 0)
>  			return msi_handle_pci_fail(domain, desc, allocated);
>  
> -		for (i = 0; i < desc->nvec_used; i++) {
> +		for (i = 0; i < nvec_aligned; i++) {
>  			irq_set_msi_desc_off(virq, i, desc);
>  			irq_debugfs_copy_devname(virq + i, dev);
>  			ret = msi_init_virq(domain, virq + i, vflags);
>  			if (ret)
>  				return ret;
>  		}
> +
>  		if (info->flags & MSI_FLAG_DEV_SYSFS) {
> +			/*
> +			 * This only exposes desc->nvec_used and ignores the
> +			 * overallocated MULTI-MSI ones.
> +			 */
>  			ret = msi_sysfs_populate_desc(dev, desc);
>  			if (ret)
>  				return ret;
> @@ -1610,13 +1618,15 @@ static void __msi_domain_free_irqs(struct device *dev, struct irq_domain *domain
>  			continue;
>  
>  		/* Make sure all interrupts are deactivated */
> -		for (i = 0; i < desc->nvec_used; i++) {
> +		unsigned int nvec_aligned = roundup_pow_of_two(desc->nvec_used);
> +
> +		for (i = 0; i < nvec_aligned; i++) {
>  			irqd = irq_domain_get_irq_data(domain, desc->irq + i);
>  			if (irqd && irqd_is_activated(irqd))
>  				irq_domain_deactivate_irq(irqd);
>  		}
>  
> -		irq_domain_free_irqs(desc->irq, desc->nvec_used);
> +		irq_domain_free_irqs(desc->irq, nvec_aligned);
>  		if (info->flags & MSI_FLAG_DEV_SYSFS)
>  			msi_sysfs_remove_desc(dev, desc);
>  		desc->irq = 0;
