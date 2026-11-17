Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794883202;
	b=DYCbCooLvt/bDWYoTYHbATmlBgNP+efET/GN6nbNLtwTedsip54aNGpU7SbXiHimHSiS
	 xXYLQeuGO51CVHFcIhtd4n3aGClcqHJbZa7nIJNScIQpmw8wC8eB09Tkq1Ol73zWaiWWd
	 R9K96LBB+uy/6vU4cwzuWpCvaA0FnAokGIQb6T0KjO/a9Dmj3pqRBs8x+ZFIzRMUNLeyL
	 +Ehdt3Fn87369QHVBM4dpdjiIqM9rXu62OlY0TfpPbXV/V+5VkKi3Z5w55CbBCF+RCjrP
	 HnIj7rUJhTnVHZKFZZMfGj+Z+ll3KLOEyxCkySYBfLgVWT5jLwflJQ6n8p8/Gaervxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794883202;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LMBbatKuFXiOiiKhIDdtLoJOCz6eVaYMtmr54QH3Bd4=;
	b=So6n7iVXOdh/2mD4ZLTnwOy61zS5drRIvkSRGHnr1SZeueAutnonjPXcs2lEuHITY98r
	 LZQlQ0AnVLYDclg0eDQ+3e5ys8vBRE17Z/aSOHrm7nwFy45iyJlSUQz4JVVPb2EviSD+T
	 miOXv7yKQzXT1kimod0Sk27KXW/qq2kEIRCH+DWvIw+Q0Zpn5NecJjC02gJZHn/W3Qcbg
	 GBC1m+b6dgiiqbBLFOxYPHnqrckjwd7q3OHUKCX0b1ZLx3szBAPr0jxWLpTbNFshpg5wo
	 3DE7DbaEWvfoEI3l7J+p1WShg6vFYyq95WAyV5qVvx9CzL3R7rrEfo6IkFVKaIVTcWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nearthlab.com;
	spf=pass smtp.mailfrom=nearthlab.com;
	dkim=pass header.d=nearthlab.com header.i=@nearthlab.com header.a=rsa-sha256 header.s=google header.b=HhBujmfA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2266606A31C
	for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2026 02:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2266606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nearthlab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nearthlab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nearthlab.com header.i=@nearthlab.com header.a=rsa-sha256 header.s=google header.b=HhBujmfA
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ea7987517aso28436935ad.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 18:40:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794883201; cv=none;
        d=google.com; s=arc-20260327;
        b=HlKHBL/0XGPVugrJ/YQbYpreea0UQvg2+Y2oSz2qOLVDTwT8AAb/eO/PrJwlgzQA6n
         E0G9YtHeKqYNaVxO7leaU6M+mKPKfj6AYSuZixT5Xp0z2MuLrzRGL/J9WGh2sQ3BohYA
         ezoyIx0I+HrmHd+dktpm7spLC8StxblcJKem+hyNvDn9gsQ70OmFpFFylcOR8nh2XTdg
         Y2S4GDKgypIo3hWiX0SOPICeigV86C/Pk08ah5zXBlcCc0S6opreEdLb69OY13YHhY80
         6CJhdCsslCiLJnpGv+idY1A7ng57CDY9cHkE3TlOGcqOZARKUTEv8AqgLq0z1PrmuVLr
         jVHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LMBbatKuFXiOiiKhIDdtLoJOCz6eVaYMtmr54QH3Bd4=;
        fh=G8Mj4/iv5DJsKuE9IElcsgD0igwJ+pW7lwUQE6xE7rA=;
        b=hBN1lBTwSgqwOcbVSQNvWcB+Mu8DFQmWyCOnckCgmXbVD2oAoiFuGsfzxxF9wked/C
         y3Ht40Q8XxLfLV1cjscfyOtuyjnX6G2HT4Z3jPFqdCU5d/x1SlnddbQ+9L5qWWKpAxoA
         1SvKPNSzVrMchtRWuJ0qCzKlS9gXgBix9xrLO0CgMJ5Gd8jrWsS74UqZG2Lmu0N4m1fe
         2w5bB5UIdqwuhv0ZedHUaOayopvJFOOilFO2OMw5BIsRpNMiKIxag0riAPvRaaumRySx
         cqm02zImd5RFZ8z0qDjU0UN6SYAx0/T4jWs7kl07TVU2TWwdDnLMTfMRzKdkHPJJ37oa
         G2lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nearthlab.com; s=google; t=1794883201; x=1795488001; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LMBbatKuFXiOiiKhIDdtLoJOCz6eVaYMtmr54QH3Bd4=;
        b=HhBujmfAkwMRQPr6nu+rDwFTlb3C2lDsC/PbkZ5x6Q3r4SpH9XihfhnQ5o8GQ892RZ
         v7SFk6yn3bgqLWfPyrNLQ79zSSszAiVMB21uZchlwagfq4i695kp0G+OfR8WD9p7Yy97
         t6h4iwTQ3XHOser8e5nWrEyOEPQcxsktVq/ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794883201; x=1795488001;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LMBbatKuFXiOiiKhIDdtLoJOCz6eVaYMtmr54QH3Bd4=;
        b=cTOAjBi7grP2OiJ4XUKOGpWzAA6t+lynzWJclqnb8fP1J5TPgcANrArJp+QIMTaLG1
         65Parnjlk0xEy1tmkP93g6pXZORt5k+YxNBMWDF5n7vi/zM6pD/P3E3kwNRIwZD0QN8l
         sGNfYpk1ULKQMm+WEuPSlRRH+Rzg1XD/5G5F3WmI4RbR3Rb4W2ClRfAKFZiBpoMVTepq
         yvGRHHUpcvraUb51Oytz6kMQi9VAr3Fa5BGBhJ4ZiMdUlxpeASWMu/DXMX+xSKvP7Jxk
         NY3xhoETmZF+IYsfC1LmuK+gDyF0mHiHGDhqd4Cnni3wsqjHOAPT1JsHVa45ot4HojeL
         SDsQ==
X-Forwarded-Encrypted: i=1; AL+hErEARJ8T2TzFXU4Pe00Am6c/V0kU+VKTKzYnyD6N5dRRU5cVIsSduIlr3hQEVld+u/uWx60UXa5mwNk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8kYC8Ed7fxh7oor+FnTz17TmTI5/XiCGkOscI38Vefaa4PsOH5
	KyS13cC5dNMQwmbhmkuyd9jCGb2wZV9ObgsLbnlYAzXlEpZednaJZNRTaaJ/ED5xZGpU2iOr1Q6
	QdLp+lcwRktwjLZp658jH5jo2p+w4T9QLIwXhiPP4jg==
X-Gm-Gg: AZFdTZf6owyDskE3TZmKNCHMjQE2a8QN3qMrkcdjg+7ggrBrWUXYpq5S/gH1Q/rK8gc
	/OjQlpDB4mqLOhFwazvcfkZFvQtCXXODmDMWqY4YsFJpHa1zd5zlqYB+mazGuhQ0CPIWCfvlAOR
	zNF8rSpApd/i8NA/t86HDmaKxm/rn+MClRALJlHuqRuGipqWisYG5kUvcUPaDCcFW7KnANgZvDt
	Jtkcve2iw/BD5kCrw8/nmnS/g9j0I2dXywkDGd/xpGPjUMedINTAna5/Mv0VG2BVnmgQuW6wJMK
	jS3yIKzmsTcZm8lJ08Eshzlk5iqXgeZf93gtT4J+/Vy7fN6280fPBoS2x4R78aBB5f533ZJB1KW
	wloCOyD3Rjy8NHPTX3lZwYfwsIFJu64EF1svRbg==
X-Received: by 2002:a17:902:c942:b0:2dd:b795:9cb6 with SMTP id
 d9443c01a7336-2ee0daa43eamr121018955ad.21.1794883201054; Mon, 16 Nov 2026
 18:40:01 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAFg7d9becn9_=ZzNwQ7bSBBNid28t_RnofL-Vb1cZVHVHxS9fw@mail.gmail.com>
 <20261013160612.GA1522005@bhelgaas> <CAFg7d9a2p2jtGyThS1M=2ZFDX0y5rpSK3H34ZuTz09R5r_ff0A@mail.gmail.com>
 <87h5i3xael.ffs@fw13> <87fqxbwla2.ffs@fw13>
In-Reply-To: <87fqxbwla2.ffs@fw13>
From: =?UTF-8?B?SGFuIC8g7ZWc7IOB7JqwU2FuZ3dvbw==?= <sangwoo.han@nearthlab.com>
Date: Tue, 17 Nov 2026 11:39:49 +0900
X-Gm-Features: AclHuK_Q986uTw7GVWmW0pPbL64Jb6Aqx4x9deC_Y4lkDrtjuDN2ErRNHLdvq1g
Message-ID: <CAFg7d9bXZEy78HqxyJ9J103FvRZLQ_jyDWUimDrHfEAQtNWDfw@mail.gmail.com>
Subject: Re: [PATCH] PCI: brcmstb: Reserve only the MSI vectors that are
 handed out
To: Thomas Gleixner <tglx@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, jim2101024@gmail.com, florian.fainelli@broadcom.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	bhelgaas@google.com, bcm-kernel-feedback-list@broadcom.com, robh@kernel.org, 
	linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Inochi Amaoto <inochiama@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

Thank you for the updated patch.

I will test it on the BCM2712 with the same setup as before and report
back within November.

Thanks,
Sangwoo

2026=EB=85=84 11=EC=9B=94 8=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 9:38, T=
homas Gleixner <tglx@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Fri, Oct 30 2026 at 20:20, Thomas Gleixner wrote:
> > On Fri, Oct 30 2026 at 21:59, Han wrote:
> >> On Thu, Oct 01 2026 at 21:29, Thomas Gleixner wrote:
> >>   The buggy address is located 0 bytes to the right of
> >>    allocated 48-byte region [ffff8000053a6880, ffff8000053a68b0)
> >>
> >> The report is caused by the patch. __msi_domain_alloc_irqs() passes
> >> nvec_aligned (4) to __irq_domain_alloc_irqs() together with
> >> desc->affinity, which has only nvec_used (3) entries. alloc_descs()
> >> then reads all 4 entries. The fourth entry is read past the end of
> >> the array. If the data there has no CPU set, the allocation fails
> >> with -ENOSPC. Without PCI_IRQ_AFFINITY, desc->affinity is NULL, so
> >> this read does not happen.
> >
> > Ah. I missed that detail. I'll look at it on Monday.
>
> The updated patch below should handle that situation too.
>
> Thanks,
>
>         tglx
> ---
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -421,7 +421,7 @@ int devm_platform_get_irqs_affinity(stru
>                 ptr->irq[i] =3D irq;
>         }
>
> -       desc =3D irq_create_affinity_masks(nvec, affd);
> +       desc =3D irq_create_affinity_masks(nvec, nvec, affd);
>         if (!desc) {
>                 ret =3D -ENOMEM;
>                 goto err_free_devres;
> --- a/drivers/pci/msi/api.c
> +++ b/drivers/pci/msi/api.c
> @@ -286,7 +286,7 @@ int pci_alloc_irq_vectors_affinity(struc
>                          * for the single interrupt case.
>                          */
>                         if (affd)
> -                               irq_create_affinity_masks(1, affd);
> +                               irq_create_affinity_masks(1, 1, affd);
>                         pci_intx(dev, 1);
>                         return 1;
>                 }
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -414,8 +414,14 @@ static int msi_capability_init(struct pc
>          */
>         pci_msi_set_enable(dev, 0);
>
> +       /*
> +        * Make sure a MULTI-MSI allocation is power of two even if the
> +        * requested number of vectors (@nvec) is not.
> +        */
> +       unsigned int nvec_aligned =3D roundup_pow_of_two(nvec);
> +
>         struct irq_affinity_desc *masks __free(kfree) =3D
> -               affd ? irq_create_affinity_masks(nvec, affd) : NULL;
> +               affd ? irq_create_affinity_masks(nvec, nvec_aligned, affd=
) : NULL;
>
>         guard(msi_descs_lock)(&dev->dev);
>         return __msi_capability_init(dev, nvec, masks);
> @@ -704,7 +710,7 @@ static int msix_setup_interrupts(struct
>                                  int nvec, struct irq_affinity *affd)
>  {
>         struct irq_affinity_desc *masks __free(kfree) =3D
> -               affd ? irq_create_affinity_masks(nvec, affd) : NULL;
> +               affd ? irq_create_affinity_masks(nvec, nvec, affd) : NULL=
;
>
>         guard(msi_descs_lock)(&dev->dev);
>         return __msix_setup_interrupts(dev, entries, nvec, masks);
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -370,7 +370,7 @@ extern int
>  irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *=
notify);
>
>  struct irq_affinity_desc *
> -irq_create_affinity_masks(unsigned int nvec, struct irq_affinity *affd);
> +irq_create_affinity_masks(unsigned int nvec, unsigned int totvec, struct=
 irq_affinity *affd);
>
>  unsigned int irq_calc_affinity_vectors(unsigned int minvec, unsigned int=
 maxvec,
>                                        const struct irq_affinity *affd);
> @@ -425,7 +425,7 @@ irq_set_affinity_notifier(unsigned int i
>  }
>
>  static inline struct irq_affinity_desc *
> -irq_create_affinity_masks(unsigned int nvec, struct irq_affinity *affd)
> +irq_create_affinity_masks(unsigned int nvec, unsigned int totvec, struct=
 irq_affinity *affd)
>  {
>         return NULL;
>  }
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -17,13 +17,17 @@ static void default_calc_sets(struct irq
>
>  /**
>   * irq_create_affinity_masks - Create affinity masks for multiqueue spre=
ading
> - * @nvecs:     The total number of vectors
> + * @nvecs:     The number of active vectors for which affinity spreading=
 is required
> + * @totvecs:   The total number of required descriptors to handle the ov=
er
> + *             allocation for PCI/MSI which requires power of two even i=
f @nvec is
> + *             not power of two. The extra descriptors are filled with d=
efault
> + *             affinity and not relevant for the spreading calcuations.
>   * @affd:      Description of the affinity requirements
>   *
>   * Returns the irq_affinity_desc pointer or NULL if allocation failed.
>   */
>  struct irq_affinity_desc *
> -irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
> +irq_create_affinity_masks(unsigned int nvecs, unsigned int totvecs, stru=
ct irq_affinity *affd)
>  {
>         unsigned int affvecs, curvec, usedvecs, i;
>         struct irq_affinity_desc *masks =3D NULL;
> @@ -56,7 +60,7 @@ irq_create_affinity_masks(unsigned int n
>         if (!affvecs)
>                 return NULL;
>
> -       masks =3D kzalloc_objs(*masks, nvecs);
> +       masks =3D kzalloc_objs(*masks, totvecs);
>         if (!masks)
>                 return NULL;
>
> @@ -90,7 +94,7 @@ irq_create_affinity_masks(unsigned int n
>                 curvec =3D affd->pre_vectors + affvecs;
>         else
>                 curvec =3D affd->pre_vectors + usedvecs;
> -       for (; curvec < nvecs; curvec++)
> +       for (; curvec < totvecs; curvec++)
>                 cpumask_copy(&masks[curvec].mask, irq_default_affinity);
>
>         /* Mark the managed interrupts */
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -1611,6 +1611,17 @@ static void irq_domain_free_irqs_hierarc
>         if (!domain->ops->free)
>                 return;
>
> +       /*
> +        * MSI device domains are capable of bulk free.
> +        *
> +        * CHECKME: Are all MSI parent domains capable?
> +        */
> +       if (domain->flags & (IRQ_DOMAIN_FLAG_MSI_DEVICE | IRQ_DOMAIN_FLAG=
_MSI_PARENT)) {
> +               if (irq_domain_get_irq_data(domain, irq_base))
> +                       domain->ops->free(domain, irq_base, nr_irqs);
> +               return;
> +       }
> +
>         for (i =3D 0; i < nr_irqs; i++) {
>                 if (irq_domain_get_irq_data(domain, irq_base + i))
>                         domain->ops->free(domain, irq_base + i, 1);
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -1333,20 +1333,28 @@ static int __msi_domain_alloc_irqs(struc
>
>                 ops->set_desc(&arg, desc);
>
> -               virq =3D __irq_domain_alloc_irqs(domain, -1, desc->nvec_u=
sed,
> +               /* Make sure a MULTI-MSI allocation is power of two */
> +               unsigned int nvec_aligned =3D roundup_pow_of_two(desc->nv=
ec_used);
> +
> +               virq =3D __irq_domain_alloc_irqs(domain, -1, nvec_aligned=
,
>                                                dev_to_node(dev), &arg, fa=
lse,
>                                                desc->affinity);
>                 if (virq < 0)
>                         return msi_handle_pci_fail(domain, desc, allocate=
d);
>
> -               for (i =3D 0; i < desc->nvec_used; i++) {
> +               for (i =3D 0; i < nvec_aligned; i++) {
>                         irq_set_msi_desc_off(virq, i, desc);
>                         irq_debugfs_copy_devname(virq + i, dev);
>                         ret =3D msi_init_virq(domain, virq + i, vflags);
>                         if (ret)
>                                 return ret;
>                 }
> +
>                 if (info->flags & MSI_FLAG_DEV_SYSFS) {
> +                       /*
> +                        * This only exposes desc->nvec_used and ignores =
the
> +                        * overallocated MULTI-MSI ones.
> +                        */
>                         ret =3D msi_sysfs_populate_desc(dev, desc);
>                         if (ret)
>                                 return ret;
> @@ -1610,13 +1618,15 @@ static void __msi_domain_free_irqs(struc
>                         continue;
>
>                 /* Make sure all interrupts are deactivated */
> -               for (i =3D 0; i < desc->nvec_used; i++) {
> +               unsigned int nvec_aligned =3D roundup_pow_of_two(desc->nv=
ec_used);
> +
> +               for (i =3D 0; i < nvec_aligned; i++) {
>                         irqd =3D irq_domain_get_irq_data(domain, desc->ir=
q + i);
>                         if (irqd && irqd_is_activated(irqd))
>                                 irq_domain_deactivate_irq(irqd);
>                 }
>
> -               irq_domain_free_irqs(desc->irq, desc->nvec_used);
> +               irq_domain_free_irqs(desc->irq, nvec_aligned);
>                 if (info->flags & MSI_FLAG_DEV_SYSFS)
>                         msi_sysfs_remove_desc(dev, desc);
>                 desc->irq =3D 0;
