Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F02147C0EA;
	Tue, 13 Oct 2026 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907575; cv=none; b=KIpuh1JVoWKSVYY6jH9BDBhDYikrW2zSM2U3OOVIQCq8c+6GGyeeK/FHVx16D5xnWRxTbkNnlk/3WDS4a0TvmK1xUjaz5EEypXghAfuKRu9fYR5RQhsaNxxd8loXCGd5Eg2ZkROuFxHNiLq7j/hbi5IQ+jsCOYtagkN+6sXhXsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907575; c=relaxed/simple;
	bh=tizlwMDmpdJZE5XMR5di9pSHWoUlQ07Rr8ENFj4JF2s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mxl6DaPSVKnOZTl2i5XMlBtOcYzOe9h4ihtGsHGiitsoEgLBdaZvfeNl262YMjNzadmCuZpkVCT0QxPoIH/ZhgoxXXjAmrGoQbFRsZmTgdqj9F7dpozAB39DaxzKjMAwqTBBbCW+JLvqZwRYVz/pHTh8YJt46cWkC7oYiDw96zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNSDC9rq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNSDC9rq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7A31F00898;
	Tue, 13 Oct 2026 16:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791907574;
	bh=2TkAIaqzm1EUB0X8M5R3xg4WLcgURvGO6UYOB2RX4n4=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=DNSDC9rqnowCNqd0H3S4sDS6f5K/FJG+XlLS3jLIJs3SEAvZ2QAYt8oIjI0kEQMbO
	 TSFeuob/mfzliaidJdgDOXmntrsO7BV94ZXXr2gjo/hFMM3cP56sN0cZvwaGvxi0k6
	 zmi0XCAauU6FlcIHh5yZH1dqtPrqTVZVy7ecO40KRBz9PQ63G/GHbLm/NeYcyc6aHS
	 kQqXW2s3/AkT5F0s2wGYLDRWpJax/EchX0gwqwSbymKA7Ux8ozeS+J78DH0E3fWdDb
	 dALery65vIsfoJGnen6mlo9oZ4+5iX8fca0jg/SCfzIbhSFPpcenbxCCMFTIEwwpCC
	 MdQiZiG5QUCZw==
Date: Tue, 13 Oct 2026 11:06:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Han / =?utf-8?B?7ZWc7IOB7JqwU2FuZ3dvbw==?= <sangwoo.han@nearthlab.com>
Cc: Thomas Gleixner <tglx@kernel.org>, jim2101024@gmail.com,
	florian.fainelli@broadcom.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, bhelgaas@google.com,
	bcm-kernel-feedback-list@broadcom.com, robh@kernel.org,
	linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Inochi Amaoto <inochiama@gmail.com>
Subject: Re: [PATCH] PCI: brcmstb: Reserve only the MSI vectors that are
 handed out
Message-ID: <20261013160612.GA1522005@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFg7d9becn9_=ZzNwQ7bSBBNid28t_RnofL-Vb1cZVHVHxS9fw@mail.gmail.com>

On Tue, Oct 13, 2026 at 05:47:49PM +0900, Han / 한상우Sangwoo wrote:
> Hi Bjorn, Thomas,
> 
> > > Good. Can you please retest with the updated patch?
> >
> > Sangwoo, any update on this?
> 
> Sorry for the silence.
> 
> I have not been able to retest yet. I have several work items on a
> tight schedule right now, and I am currently working on a different
> board for another project, so I cannot get to this at the moment.
> 
> For the KASAN slab-out-of-bounds report, I will follow up within
> October.
> 
> For the retest with the updated patch, I cannot give a date right now.
> I am sorry about that.

No worries, just wanted to make sure we didn't drop this.  I have a
note to follow up again later :)

> 2026년 10월 13일 (화) 오전 6:47, Bjorn Helgaas <helgaas@kernel.org>님이 작성:
> >
> > On Thu, Oct 01, 2026 at 09:29:27PM +0200, Thomas Gleixner wrote:
> > > On Mon, Sep 21 2026 at 18:05, Han / 한상우Sangwoo wrote:
> > > > I tested Thomas's patch on the same hardware setup with the 5-vector
> > > > MSI endpoint. The patch was applied as posted on top of 6.12.93
> > > > (rpi-6.12.y).
> > > >
> > > > With the patch applied:
> > > >
> > > > - The MSI base hwirq remained at 0x8 across 200 driver reload cycles.
> > > > - The driver got all 5 requested vectors on every cycle, with no
> > > > single-MSI fallback. Multiple Message Enable remained at 8.
> > > > - The brcmstb inner-domain mapping returned to baseline after each
> > > > unload/reload, with 12 mapped while the driver was loaded and 4 after
> > > > unload.
> > > > - A kprobe showed one allocation of 8 vectors followed by eight
> > > > single-vector frees, with nothing left over.
> > >
> > > 8 single vector frees?
> > >
> > > Seems I got something wrong there verus the bulk free. Updated patch
> > > below.
> > >
> > > > The MSI vector exhaustion issue I originally observed no longer
> > > > reproduces with the patch.
> > >
> > > Good. Can you please retest with the updated patch?
> >
> > Sangwoo, any update on this?
> >
> > I don't see this patch in linux-next (next-20261012), so I don't think
> > this will be fixed for v7.4 unless something moves it ahead.
> >
> > > > I also observed a KASAN report with managed affinity. Using a small
> > > > out-of-tree test module bound to the same endpoint and requesting 1..3
> > > > vectors with PCI_IRQ_MSI | PCI_IRQ_AFFINITY, a request for 3 vectors
> > > > resulted in:
> > > >
> > > > BUG: KASAN: slab-out-of-bounds in __irq_alloc_descs+0x158/0x460
> > > >
> > > > Requests for 5 and 7 vectors were capped to 4 on this 4-CPU system and
> > > > did not trigger the report. I have not checked this against the
> > > > unpatched kernel yet, so I cannot tell whether it is related to the
> > > > patch.
> > >
> > > Any updates on that? Also please provide the source for that test.
> > >
> > > Thanks,
> > >
> > >         tglx
> > > ---
> > > --- a/kernel/irq/irqdomain.c
> > > +++ b/kernel/irq/irqdomain.c
> > > @@ -1610,6 +1610,17 @@ static void irq_domain_free_irqs_hierarc
> > >       if (!domain->ops->free)
> > >               return;
> > >
> > > +     /*
> > > +      * MSI device domains are capable of bulk free.
> > > +      *
> > > +      * CHECKME: Are all MSI parent domains capable?
> > > +      */
> > > +     if (domain->flags & (IRQ_DOMAIN_FLAG_MSI_DEVICE | IRQ_DOMAIN_FLAG_MSI_PARENT)) {
> > > +             if (irq_domain_get_irq_data(domain, irq_base))
> > > +                     domain->ops->free(domain, irq_base, nr_irqs);
> > > +             return;
> > > +     }
> > > +
> > >       for (i = 0; i < nr_irqs; i++) {
> > >               if (irq_domain_get_irq_data(domain, irq_base + i))
> > >                       domain->ops->free(domain, irq_base + i, 1);
> > > --- a/kernel/irq/msi.c
> > > +++ b/kernel/irq/msi.c
> > > @@ -1333,20 +1333,28 @@ static int __msi_domain_alloc_irqs(struc
> > >
> > >               ops->set_desc(&arg, desc);
> > >
> > > -             virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
> > > +             /* Make sure a MULTI-MSI allocation is power of two */
> > > +             unsigned int nvec_aligned = roundup_pow_of_two(desc->nvec_used);
> > > +
> > > +             virq = __irq_domain_alloc_irqs(domain, -1, nvec_aligned,
> > >                                              dev_to_node(dev), &arg, false,
> > >                                              desc->affinity);
> > >               if (virq < 0)
> > >                       return msi_handle_pci_fail(domain, desc, allocated);
> > >
> > > -             for (i = 0; i < desc->nvec_used; i++) {
> > > +             for (i = 0; i < nvec_aligned; i++) {
> > >                       irq_set_msi_desc_off(virq, i, desc);
> > >                       irq_debugfs_copy_devname(virq + i, dev);
> > >                       ret = msi_init_virq(domain, virq + i, vflags);
> > >                       if (ret)
> > >                               return ret;
> > >               }
> > > +
> > >               if (info->flags & MSI_FLAG_DEV_SYSFS) {
> > > +                     /*
> > > +                      * This only exposes desc->nvec_used and ignores the
> > > +                      * overallocated MULTI-MSI ones.
> > > +                      */
> > >                       ret = msi_sysfs_populate_desc(dev, desc);
> > >                       if (ret)
> > >                               return ret;
> > > @@ -1610,13 +1618,15 @@ static void __msi_domain_free_irqs(struc
> > >                       continue;
> > >
> > >               /* Make sure all interrupts are deactivated */
> > > -             for (i = 0; i < desc->nvec_used; i++) {
> > > +             unsigned int nvec_aligned = roundup_pow_of_two(desc->nvec_used);
> > > +
> > > +             for (i = 0; i < nvec_aligned; i++) {
> > >                       irqd = irq_domain_get_irq_data(domain, desc->irq + i);
> > >                       if (irqd && irqd_is_activated(irqd))
> > >                               irq_domain_deactivate_irq(irqd);
> > >               }
> > >
> > > -             irq_domain_free_irqs(desc->irq, desc->nvec_used);
> > > +             irq_domain_free_irqs(desc->irq, nvec_aligned);
> > >               if (info->flags & MSI_FLAG_DEV_SYSFS)
> > >                       msi_sysfs_remove_desc(dev, desc);
> > >               desc->irq = 0;
