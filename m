Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246AC360ED6
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789981521; cv=pass; b=t3QlAYnX44df+aoC3Y5nGKxULOqMaMFdjNnRTwPfYy/Yx+tyFAxXIM3Dw76/iQ6K7HVA0dynxm1HSY4TPgoR3FWBVayIGgLNrpKZ9wFUK6aYMsPNanYk7CtyfY58ofXWWDwWNAvKbgNwmHeMEOUJGOb7vqJaRFDAdvJY6JKu+/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789981521; c=relaxed/simple;
	bh=7oibe3yf4Od9OHwVEriZj8jSngUfqx45BDj+zMuFzCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jECQ/hFGHClBWrbiJZhO35jrxDcKpPjBgkajUq7rsu44TvgmGIiySI+AheJlr5fPKzisXEtWBTH9NkoBe7td2Mw2uws8dS+bEn4u6soHCU27VocWYo9I24HZ2vTacOQxCbpzDnhqCN3u7oDYg54E3nWSxE8N0+7JVQKLiLDCHWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nearthlab.com; spf=pass smtp.mailfrom=nearthlab.com; dkim=pass (1024-bit key) header.d=nearthlab.com header.i=@nearthlab.com header.b=Zb8DTAaw; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nearthlab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nearthlab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nearthlab.com header.i=@nearthlab.com header.b="Zb8DTAaw"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469d249c6so2314656b3a.1
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 02:05:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789981519; cv=none;
        d=google.com; s=arc-20260327;
        b=IscQgV8b/sBF0JfyMkUFhho1hRnKookeT8UcPqpWaHf2ndSBOWzcmIjjQGF8aKYg80
         C6oe6F8+ZeZyd/1UW3VmnPfE3ndf9jIg0qywJfExg/XM8TWs0HFVHKAMl6hKEWIdHv/2
         Oh4XNmqUA9v3kBZ1rs+rOzactwbmVsC5JHweIGey1uTSnEx5eb7d4b5L4gk/1gjDxTyg
         PkHVuSuDW2SUjBaCyqoIID+K1LBZB54ucBCkXVS0p+zGvJplFWDPxKpUAmGc1ZgUfrhS
         FRBRG0tsucxdKPxwjvs5RehHNA2SrxoKczELGWLE5i6fWqvJkiN8zMOj27pA8QT6mPw4
         En2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8X/5deMM6cMfCPfio5kUdEFewo5cSW2r2DWxfpdO5fk=;
        fh=KqIDNcBeNaxXw3DZJuSfqpVNbzyIEaGT3vzMkYkbF+s=;
        b=RCQ0qG4+QdCcYT3/Pdd4mP0Jw5FtNi5pTQgfCogB8LSw/rA09Bq/Q8xlNAbqtIa/+I
         n95U3xiBWgC+MaTtWa2luhWHMAfnWGv6MxBkCFn8+FnboyASSgAMdCpuMIyyUXt5nINX
         1UwwPvIQ4BBDqu3gbamRKpqNwsUfG6QbgBYX7Nbbu7vDiX+vmusg1bV5IXsvceXK1Sw6
         CUWO0ydeRwMNk8gKXtdKTWh4oTg6LEVX1cOZfwFM4/Px5JRHNeSleVOkHevYygxCS1XV
         Xmzm9Uk0XFIFURUGcvp4SzvWdJouQ+nm5qq1rzU0wyYmq/IqEOC9looWs9Ql/2mdMoLy
         BifA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nearthlab.com; s=google; t=1789981519; x=1790586319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8X/5deMM6cMfCPfio5kUdEFewo5cSW2r2DWxfpdO5fk=;
        b=Zb8DTAawHfxAOgy76F7O3pu2/UdI1Fp+kpz1oTzphE3zw+/R2a4q3i2ZbExmHNZdk1
         HOd5vk9QEef6x2WR5U/AvxHV+UV/cC4W5JzKZJIRnlCQbLU2e7FCp2sCJpnZ6O1vUnTy
         VOAOQEZ/FkDg6p3s8dDz33bJHQxvx03O91Ny8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789981519; x=1790586319;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8X/5deMM6cMfCPfio5kUdEFewo5cSW2r2DWxfpdO5fk=;
        b=eTjZTa9AunD3N4vKWNe44fX9jtVriB3mIwl9A6ULamWRHnjlYvWu9b9Dne+UnTqL+3
         c3rDVpRSsf+RMcwgG71tcj9HLARsCZ663kkQ/KlW5uWgtN0LaGqaTWCTBI0VylmhL4YT
         pm5Rt610bLVlgitugx6gMiPiQno8cPCuxBfC46SPVFx/WDsPALMVh1/LzX/T/2oAfadl
         6g+KcXIBmoSJlGuDCgsiFesIyAva4iiTI5mqTgm3iR3TmAV1h6RJbGVuitLvp+7pb+A6
         Tp8+G98dXWCKStZEerTuYxk9iKahmITb/+lKUUOEoduDfuxfM1p859zq89DU+grpsL6K
         9cag==
X-Forwarded-Encrypted: i=1; AKwUvBwmBIEsVZpFSRnGt/CGgLuSxSqHfIv3ysGSqH5KRzj1Jxn7sj1Bn/sqtcJ+iAv+28VXf/Tdidrumhg=@vger.kernel.org
X-Gm-Message-State: AFuF++lPS+7q7aQNXsRPdAW98419LYxM+mVUeQl+eb5Jj+o6Jvc3Ps9r
	15Rg4yC2x7JuFOdhrWATMZZgLSIvR+G3glTYFYntrphjh3LJzNmJP0KvJcFJ08j6bfdjsDGdZN/
	/WwbHOQEtngnSrfRKNexbstSyKUEXqwFjudiYMRaYtA==
X-Gm-Gg: AYBFou3EzANdGRafPKnENLMT53sQE7d8TihUaRJU8KNpWIstG0BRVHHwx32seilTRsJ
	PY1675QziDfXBtPlWOpuk0moFYIPLCW1tZGgUHa2kCgeJPztaFeBU64nWS1cp2GuvhqHatY0ZnG
	ocBXiobgF7oa2LYmTIcKOqUuSAeZTqWM29RJl+m1VZQmSiWVH6EfK3bzmCP3b/QCOtMKdk8HVEK
	QZbTnw5Wm32FLf+N9t2Qg0kiVSETcM4l+plhtcQaST6KKvAK6CZ2u4CQ7nbdFwAMQ1pCENRjm37
	JH+xTBvpRyY03+ue2FUrSVJbcyHqRdEBTcd54nWj/g78XqQBoGm7uIK5
X-Received: by 2002:aa7:8883:0:b0:84e:d5e6:a085 with SMTP id
 d2e1a72fcca58-874d84a92bemr14325682b3a.0.1789981519125; Mon, 21 Sep 2026
 02:05:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87cxuo3fl9.ffs@fw13> <20260916231029.GA988000@bhelgaas>
In-Reply-To: <20260916231029.GA988000@bhelgaas>
From: =?UTF-8?B?SGFuIC8g7ZWc7IOB7JqwU2FuZ3dvbw==?= <sangwoo.han@nearthlab.com>
Date: Mon, 21 Sep 2026 18:05:07 +0900
X-Gm-Features: AcwNN1UY_p08SHSW4zqTzU8BM9IzyWZV-P37VhRnSz8vgq1qfIqIDCSUy-MEUFs
Message-ID: <CAFg7d9bJJjR7JEMXanttGVcGisa4x3uLYPR43Te4+JKMzHBkfQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: brcmstb: Reserve only the MSI vectors that are
 handed out
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, jim2101024@gmail.com, florian.fainelli@broadcom.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	bhelgaas@google.com, bcm-kernel-feedback-list@broadcom.com, robh@kernel.org, 
	linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Inochi Amaoto <inochiama@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

Sorry for the delay in testing this.

I tested Thomas's patch on the same hardware setup with the 5-vector
MSI endpoint. The patch was applied as posted on top of 6.12.93
(rpi-6.12.y).

With the patch applied:

- The MSI base hwirq remained at 0x8 across 200 driver reload cycles.
- The driver got all 5 requested vectors on every cycle, with no
single-MSI fallback. Multiple Message Enable remained at 8.
- The brcmstb inner-domain mapping returned to baseline after each
unload/reload, with 12 mapped while the driver was loaded and 4 after
unload.
- A kprobe showed one allocation of 8 vectors followed by eight
single-vector frees, with nothing left over.

The MSI vector exhaustion issue I originally observed no longer
reproduces with the patch.

I also observed a KASAN report with managed affinity. Using a small
out-of-tree test module bound to the same endpoint and requesting 1..3
vectors with PCI_IRQ_MSI | PCI_IRQ_AFFINITY, a request for 3 vectors
resulted in:

BUG: KASAN: slab-out-of-bounds in __irq_alloc_descs+0x158/0x460

Requests for 5 and 7 vectors were capped to 4 on this 4-CPU system and
did not trigger the report. I have not checked this against the
unpatched kernel yet, so I cannot tell whether it is related to the
patch.

Best regards,
Sangwoo


2026=EB=85=84 9=EC=9B=94 17=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 8:10, B=
jorn Helgaas <helgaas@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon, Sep 07, 2026 at 11:40:34PM +0200, Thomas Gleixner wrote:
> > On Mon, Sep 07 2026 at 11:34, Bjorn Helgaas wrote:
> > > [+cc Thomas, Inochi for MSI expertise]
> > >
> > > I want to revive this thread because I think there's a real problem
> > > here, and we should solve it for all the PCI controller drivers.
> > >
> > > There's nothing brcm-specific about the bitmap alloc/free except the
> > > size of the msi->used bitmap, so I don't want to copy/paste this sort
> > > of fix in all the affected drivers.
> > >
> > > I'd also like to avoid the extra align_mask and
> > > bitmap_find_next_zero_area() followed by manual bitmap_set().
> > > bitmap_find_free_region() already takes care of the alignment and
> > > setting the allocated bits.
> > >
> > > The MSI Multiple Message Enable situation of enabling more vectors in
> > > the device than the driver wants is generic to all devices that
> > > advertise Multiple Message Capable, and I don't think we should have
> > > to deal with this in every host controller driver.
> >
> > Correct.
> >
> > > If a driver requests 3 vectors, we have to enable 4 because MSI only
> > > supports power-of-two number of vectors.  This tells the device it is
> > > allowed to use all 4 vectors, and I think the PCI MSI core should
> > > assume they all *will* be used instead of relying on the driver's
> > > claim that it will only use 3.
> >
> > That's not really a good idea because e.g. the irq affinity stuff relie=
s
> > on the accurate number of interrupts the driver requested with the
> > minvec/maxvec range. We can't magically spread more interrupts than the
> > driver is able/willing to handle.
> >
> > But we can fix that without changing the consumer side (device drivers)
> > visible behaviour and handle it solely in the core code.
> >
> >  1) MSI interrupts are special because they have msi_desc::nvec_used >
> >     1, so the allocation and the free path can take care of the power o=
f
> >     two requirement. That just allocates more resources than the driver
> >     wants but they are just memory.
> >
> >  2) All MSI parent domain implementations should be able to handle
> >     domain_ops::free() with nr_irqs > 1. That's something which can be
> >     trivialy audited.
> >
> >     I really have no memories why the bulk remove function iterates the
> >     interrupts one by one instead of doing in one go, but this is also
> >     used by non MSI domains, which might have issues with a bulk remove=
.
> >
> >     If we establish that all MSI parent domain implementations can
> >     handle the free() callback with nr_irqs > 1, then
> >     irq_domain_free_irqs_hierarchy can check whether
> >     IRQ_DOMAIN_FLAG_MSI_PARENT is set in the domain_flags and avoid the
> >     loop for that case.
> >
> > Something like the completely untested below.
>
> Sangwoo, is there any chance you can test this and see whether it
> fixes the issue?
>
> If it does, I guess we'll have to ask Thomas to post it with the
> appropriate Signed-off-by, etc.
>
> > ---
> > diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> > index 4fdcb6df5306..b3f6cc6ae2ce 100644
> > --- a/kernel/irq/irqdomain.c
> > +++ b/kernel/irq/irqdomain.c
> > @@ -1611,6 +1611,13 @@ static void irq_domain_free_irqs_hierarchy(struc=
t irq_domain *domain,
> >       if (!domain->ops->free)
> >               return;
> >
> > +     /* CHECKME: Are all MSI parent domains capable ? */
> > +     if (domain->flags & IRQ_DOMAIN_FLAG_MSI_PARENT) {
> > +             if (irq_domain_get_irq_data(domain, irq_base))
> > +                     domain->ops->free(domain, irq_base, nr_irqs);
> > +             return;
> > +     }
> > +
> >       for (i =3D 0; i < nr_irqs; i++) {
> >               if (irq_domain_get_irq_data(domain, irq_base + i))
> >                       domain->ops->free(domain, irq_base + i, 1);
> > diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> > index fb5f372215bf..2835b09899ea 100644
> > --- a/kernel/irq/msi.c
> > +++ b/kernel/irq/msi.c
> > @@ -1333,20 +1333,28 @@ static int __msi_domain_alloc_irqs(struct devic=
e *dev, struct irq_domain *domain
> >
> >               ops->set_desc(&arg, desc);
> >
> > -             virq =3D __irq_domain_alloc_irqs(domain, -1, desc->nvec_u=
sed,
> > +             /* Make sure a MULTI-MSI allocation is power of two */
> > +             unsigned int nvec_aligned =3D roundup_pow_of_two(desc->nv=
ec_used);
> > +
> > +             virq =3D __irq_domain_alloc_irqs(domain, -1, nvec_aligned=
,
> >                                              dev_to_node(dev), &arg, fa=
lse,
> >                                              desc->affinity);
> >               if (virq < 0)
> >                       return msi_handle_pci_fail(domain, desc, allocate=
d);
> >
> > -             for (i =3D 0; i < desc->nvec_used; i++) {
> > +             for (i =3D 0; i < nvec_aligned; i++) {
> >                       irq_set_msi_desc_off(virq, i, desc);
> >                       irq_debugfs_copy_devname(virq + i, dev);
> >                       ret =3D msi_init_virq(domain, virq + i, vflags);
> >                       if (ret)
> >                               return ret;
> >               }
> > +
> >               if (info->flags & MSI_FLAG_DEV_SYSFS) {
> > +                     /*
> > +                      * This only exposes desc->nvec_used and ignores =
the
> > +                      * overallocated MULTI-MSI ones.
> > +                      */
> >                       ret =3D msi_sysfs_populate_desc(dev, desc);
> >                       if (ret)
> >                               return ret;
> > @@ -1610,13 +1618,15 @@ static void __msi_domain_free_irqs(struct devic=
e *dev, struct irq_domain *domain
> >                       continue;
> >
> >               /* Make sure all interrupts are deactivated */
> > -             for (i =3D 0; i < desc->nvec_used; i++) {
> > +             unsigned int nvec_aligned =3D roundup_pow_of_two(desc->nv=
ec_used);
> > +
> > +             for (i =3D 0; i < nvec_aligned; i++) {
> >                       irqd =3D irq_domain_get_irq_data(domain, desc->ir=
q + i);
> >                       if (irqd && irqd_is_activated(irqd))
> >                               irq_domain_deactivate_irq(irqd);
> >               }
> >
> > -             irq_domain_free_irqs(desc->irq, desc->nvec_used);
> > +             irq_domain_free_irqs(desc->irq, nvec_aligned);
> >               if (info->flags & MSI_FLAG_DEV_SYSFS)
> >                       msi_sysfs_remove_desc(dev, desc);
> >               desc->irq =3D 0;
