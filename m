Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6273905F0
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 08:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881283; cv=pass; b=mMmA/yfvSydcQgSuGK2AkhqA1ebWdt6s1rjjm7M9cHo/PHwNyLzfHFwFQmWmD5+baU2Zd4w+ApB08H1OAwXCZ6NRl7UYUDlWp0jsLf+pKcVIs1IwwKyDWntXnqUMfDu1xC3yGPoXoPRrBU5ZspbVOEnuFznnEUmGhBHoaexOdA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881283; c=relaxed/simple;
	bh=CLDYnK6SJJppn6ruFYkJBkFq1xs1TunxHWw8XvTRdp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sgF2sC+gATM23GPvkHFJPZx2F3tX1I7+wvquKRekBFP3a41CpTmOFXwW+reUiXve3BlivZ1gCySimhEXkhM4SkRmxryf4w65DCUQx8rIMqxNeNfIXnJIWBSeK7Y8VNyk8vemUknL+uGpLTBiSQe/7upl3Oi4NtlI1ZELJ5DqISk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nearthlab.com; spf=pass smtp.mailfrom=nearthlab.com; dkim=pass (1024-bit key) header.d=nearthlab.com header.i=@nearthlab.com header.b=kXrNiLzh; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nearthlab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nearthlab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nearthlab.com header.i=@nearthlab.com header.b="kXrNiLzh"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3a80d1c98f5so1531165a91.0
        for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 01:48:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791881281; cv=none;
        d=google.com; s=arc-20260327;
        b=YIkuRv609VxyWBxyOaFo2KNznhDi67hV+jDCRHU+rtc+k8e7PkHiJ/giOvaIi2rzhu
         IwN/i3ZrrJA+mWj795gqvPEW0g7Du2O+hCDOBh/eN0hvbjSO+lOiSwskkDU4jgPOzJ48
         Rjmbf6RxeCZiftL+l6RgfcOW0CQkuf9RVOjsBQj6phX+MmFaHlYLYII7UCWXsQD5mo1Y
         NVNr4hRkoPl1TS0fmDXzqmsisQnMk9XX05qpWZe9dbg17WIb7COhYpuOUQ7UJZ1gCRqI
         AG9HNvbmVemQqnE6+NbKJ/BqVMpT4YvUa/V2FTfCIqLNH9emfDgAAYhs7xem+kHrPpXd
         2tXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rzNVaT90GYZEug/T1ZLZlSqiBeontwDSLfIxns+H/So=;
        fh=Z9HRlaOLTd36n+4c9Hno0RzqoMx+/4k4xR+xB0IhbeY=;
        b=NcAv2HuNADn3Uz6dLWs+ab1pNQwVVetJ8hDzV6dIfOlNrrdaU5a8lDry77cJhC5Rs3
         dZGNOd49Y683G0MKDMuuo2YvM402ZULPF9w3JvRVh7OSVaVy4eLPL9eJPuWiwBEH23/2
         qMLl8UQJd50By2XoWwZGhULxQqjpYPUpJU5T/CnYj+JlR8b52ddmh9xVtgZn1pGocqrY
         K/kgLbdRS5Z5UCOxMAeo2V8aJ/WDYk6MFrjk8j9oObcCho1Aqqekqo0N3wIcN8rtTpEl
         8f74FQlbt7BrTFVPs5y7cfhssl5GMfW15PZK+A+i5ZbUyScTzpiR7wn1CJmN195iAqLC
         hUcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nearthlab.com; s=google; t=1791881281; x=1792486081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rzNVaT90GYZEug/T1ZLZlSqiBeontwDSLfIxns+H/So=;
        b=kXrNiLzh0PnIgjxOsK3cc8dYdJIdDsyOHw6NTjXS68McRrAuBat6n3Ooj5aprup66u
         LbZvXRddhOKoF9diZwwmaYmvREe4l2YE/1zEMBFx3NvmIyAj1IyzWgjwPZ/DKGsAsCTT
         gssSCHrRFrByDrdpJE33mpfa9mdK2T/k75Ia0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791881281; x=1792486081;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rzNVaT90GYZEug/T1ZLZlSqiBeontwDSLfIxns+H/So=;
        b=OcxRgKWzT/d1IriqCb5ySxc4pu3L60EK81CVUzSqVKl9XbTfE9LT8sSR/dgZDq0I5q
         QW9F0pGx4LtbSrLKO0fzxMOvANfdPSGmtXp8Zd/g/PqzN/aDUEzkQ14Mfm7sPTNjmec/
         YGzUZi+ts7u0AmmmH1CrDiXSGY35z+D6Yj9dI4TgT/yVswU5Qk48a7m/wc6lO95qvykp
         7/DJFO5OrEDeRpk2uidflTTrIsGiuRB9rkp7pO9fI6JXrrCAPbAGumLOBRR8jmo46tGt
         NzwaXEufjmsBA9hBSllzKIOlyhwBm15+QoL/+mkYM1zPkZfiaNDYWF9hfwUVFcuCVx5q
         xt3w==
X-Forwarded-Encrypted: i=1; AKwUvBxq97kWMzJYHEEeo/WcYPD6X7csguYnhg/6/bW9fYP4dE3PbInVksxbn8ZBxIVitmIrQz5WWUVqffg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKc9rgpROiAJz7Mc2tas4yzy91lyBzVW1aABnr2G0TKlfPs6yBW
	yy/rMf2JH7VyC8119554U2fDxnbBWvGM5H+DAWRu9z/R6FvwGW6u2bCDLprto+UO2irq2MaBOvk
	8/jDte7woDbu8eaYKfiXXsd93QQOxS+TatwKdl/4HzA==
X-Gm-Gg: AYBFou34+v4TJHeBzZONOPPY5n2HhYcQDrpFNVmeXswac3CjE6UZwB14RIY6JJT2iEn
	UawhL/2g6NIGj6al9K2mSm7DNs6Q1+1+pYt2rMhUfmYRiBERU18jf2XORPn82TQrRlknnW9C+l/
	Z4Ab7qZrB2SsESYcSFaw7N1Uq6tAerP1yf0+l/hshV749Oy1kRufZmh37sZYISA6bBxULIqYLQ5
	mdiZsw88kB1+l6NvjJlqYulwjt627nQA8lxUjK3z1iWVOc8bZL5A8m682N7r3mqf/QCwi7h5X64
	+SXql/JFncagYtBelkM9xJuO5MiaeY/wEUD4qF0muE9O6FsPrWPPMEPx
X-Received: by 2002:a17:90a:d006:b0:3a7:bf13:6007 with SMTP id
 98e67ed59e1d1-3ab3a9128c8mr9969201a91.14.1791881281048; Tue, 13 Oct 2026
 01:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <871pa9gqy0.ffs@fw13> <20261012214737.GA1400495@bhelgaas>
In-Reply-To: <20261012214737.GA1400495@bhelgaas>
From: =?UTF-8?B?SGFuIC8g7ZWc7IOB7JqwU2FuZ3dvbw==?= <sangwoo.han@nearthlab.com>
Date: Tue, 13 Oct 2026 17:47:49 +0900
X-Gm-Features: AclHuK_m5ccTa8frqqq3Xr7dirm-kMGsCwAMeH37wK9ea3ERtMGi0K_ixLEeTqU
Message-ID: <CAFg7d9becn9_=ZzNwQ7bSBBNid28t_RnofL-Vb1cZVHVHxS9fw@mail.gmail.com>
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

Hi Bjorn, Thomas,

> > Good. Can you please retest with the updated patch?
>
> Sangwoo, any update on this?

Sorry for the silence.

I have not been able to retest yet. I have several work items on a
tight schedule right now, and I am currently working on a different
board for another project, so I cannot get to this at the moment.

For the KASAN slab-out-of-bounds report, I will follow up within
October.

For the retest with the updated patch, I cannot give a date right now.
I am sorry about that.

Thanks,
Sangwoo

2026=EB=85=84 10=EC=9B=94 13=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 6:47, =
Bjorn Helgaas <helgaas@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Thu, Oct 01, 2026 at 09:29:27PM +0200, Thomas Gleixner wrote:
> > On Mon, Sep 21 2026 at 18:05, Han / =ED=95=9C=EC=83=81=EC=9A=B0Sangwoo =
wrote:
> > > I tested Thomas's patch on the same hardware setup with the 5-vector
> > > MSI endpoint. The patch was applied as posted on top of 6.12.93
> > > (rpi-6.12.y).
> > >
> > > With the patch applied:
> > >
> > > - The MSI base hwirq remained at 0x8 across 200 driver reload cycles.
> > > - The driver got all 5 requested vectors on every cycle, with no
> > > single-MSI fallback. Multiple Message Enable remained at 8.
> > > - The brcmstb inner-domain mapping returned to baseline after each
> > > unload/reload, with 12 mapped while the driver was loaded and 4 after
> > > unload.
> > > - A kprobe showed one allocation of 8 vectors followed by eight
> > > single-vector frees, with nothing left over.
> >
> > 8 single vector frees?
> >
> > Seems I got something wrong there verus the bulk free. Updated patch
> > below.
> >
> > > The MSI vector exhaustion issue I originally observed no longer
> > > reproduces with the patch.
> >
> > Good. Can you please retest with the updated patch?
>
> Sangwoo, any update on this?
>
> I don't see this patch in linux-next (next-20261012), so I don't think
> this will be fixed for v7.4 unless something moves it ahead.
>
> > > I also observed a KASAN report with managed affinity. Using a small
> > > out-of-tree test module bound to the same endpoint and requesting 1..=
3
> > > vectors with PCI_IRQ_MSI | PCI_IRQ_AFFINITY, a request for 3 vectors
> > > resulted in:
> > >
> > > BUG: KASAN: slab-out-of-bounds in __irq_alloc_descs+0x158/0x460
> > >
> > > Requests for 5 and 7 vectors were capped to 4 on this 4-CPU system an=
d
> > > did not trigger the report. I have not checked this against the
> > > unpatched kernel yet, so I cannot tell whether it is related to the
> > > patch.
> >
> > Any updates on that? Also please provide the source for that test.
> >
> > Thanks,
> >
> >         tglx
> > ---
> > --- a/kernel/irq/irqdomain.c
> > +++ b/kernel/irq/irqdomain.c
> > @@ -1610,6 +1610,17 @@ static void irq_domain_free_irqs_hierarc
> >       if (!domain->ops->free)
> >               return;
> >
> > +     /*
> > +      * MSI device domains are capable of bulk free.
> > +      *
> > +      * CHECKME: Are all MSI parent domains capable?
> > +      */
> > +     if (domain->flags & (IRQ_DOMAIN_FLAG_MSI_DEVICE | IRQ_DOMAIN_FLAG=
_MSI_PARENT)) {
> > +             if (irq_domain_get_irq_data(domain, irq_base))
> > +                     domain->ops->free(domain, irq_base, nr_irqs);
> > +             return;
> > +     }
> > +
> >       for (i =3D 0; i < nr_irqs; i++) {
> >               if (irq_domain_get_irq_data(domain, irq_base + i))
> >                       domain->ops->free(domain, irq_base + i, 1);
> > --- a/kernel/irq/msi.c
> > +++ b/kernel/irq/msi.c
> > @@ -1333,20 +1333,28 @@ static int __msi_domain_alloc_irqs(struc
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
> > @@ -1610,13 +1618,15 @@ static void __msi_domain_free_irqs(struc
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
