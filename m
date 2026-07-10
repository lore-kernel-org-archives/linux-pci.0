Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612A642EEA3
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 22:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783722077; cv=pass; b=AbZ7V3z2kD4rTEP3wsDy2MB2erOdA+VZKxYRJBNd4YB5qjL+hWTS9GFIS50Dd94E4B2wcE6INfpOINI6WmIzCMyBi4UfJ50aJONARcDMzSvxXYiKl3MtrLGA1PxBFlCtih6grwtbV9Hd5sHpDEJ4KwpuDzuB/dwIGJcGEKIb0G0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783722077; c=relaxed/simple;
	bh=AexQyWdtnOBNxCR14romYussjnXujihHW3o7Jk8KjV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKIWlL6AFG8S8IyaF6oX0J3SZKtCm4aaM/odGus30BnwXkemguUf6zVB1APQRbTtbt26bpSO13RRuiz/WAWZ0b+fAdFtUP1hutwIPneU1J707WcXHowoZzgvdrDcol34I3aUhq/TG8Fm+H/24cKDZfBWGBS3sJ6dsv+YFOM6JrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OeeVUgf/; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OeeVUgf/"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc6ae3e7f1so8606775ad.0
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 15:21:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783722075; cv=none;
        d=google.com; s=arc-20260327;
        b=OHW+OnlsqNihaH6zDxRYnnulyDCqHt1U+ROKMUxjyYoANhFW3MJnZYDcwiVEmcKFkC
         E92Qk9voTLPKBu9QWEcYz9yEl8aEOZ57+97b33weaRIl2V7U3HjZqfM6c+f8fAqqNT3X
         z037gSdNCIEimDJ/2yP37zLPU7jaQI04ajgAmFhyVdgJeuZzJJn8xLVChMlJh3v8wLCx
         2UttIceRpZ29IApg4zpGNa6JipNa/sBGcYkI9ba3+KB0wt0mm48WBYizyRdwTIMat4gq
         SFsDWFeT2QRLoIi0wOsEWWhX2YrSpksS9HZhA+ec8ByUn90HR2p4uzFpUpRJdNQgP7qq
         DIIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eJQ12QuZIJ5EMRjO8Od9KXNRvzbL6BoA/mx93EpDKlk=;
        fh=2E8G5L5HRIhYv0SLHRh0bmuG4bK/RxhrEd6+zC1U6gY=;
        b=SmQV+7ZAbzPaDweriew3KzvJpo3ovxkHvn+ocvz7O+BFxYWfbPeO+aqhY+SOdKK2ZJ
         FuleEHGj5kBre2/xveEwu8mgwGswlVXUnQSFBO/s1HrUiH4a8lq2mmoABNSP2UXt+rKK
         apJaE/Uv/0iqcBnj/psWCZDuTqwvdZLWzhIF3X7/5M0zBLDrlWvMmFYaREfqxgaJZF/X
         1MfX/NzHdkdeTo8AXoQAD67pFWsto0ZIYuXxchkJ8c2M4W+4pxC0Y0Nev6gSKmoKlXsm
         Y6UUVa4Ael8si9OiloIIagEIcjwCfMOl6eZj0HMWMHcoGTwnDtjr24DL2A5vGF4mm+Qb
         jkFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783722075; x=1784326875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eJQ12QuZIJ5EMRjO8Od9KXNRvzbL6BoA/mx93EpDKlk=;
        b=OeeVUgf/F070XnylWI7Iut9D/nJIvhMe7tPm3E12/01EDhGW6wAYDAF1Yi7o9Lbx5j
         1W1TdttUMnCXutWXiSdtI9yu+QnbGT1Wvx1T1uP/eltAdDdpebjiYcE0kBdYTIxUAs+I
         ISoDYo8F5/yFPIeWy1+xMg0kxOzVs+nNABWfI5QOByTHCWurWOqYiia3uU3ilMJ2qCdl
         IlrVuuBO1JkCY0A2PnUIp1NiF0MaT7z2M16mxlniyO54aFUxp3+8Q43m0aotBIHw1xqi
         YeicMukHZa07qDuIL82ZHA0dRAmGFGglppLc+T+cIzeLtcns6EdeMGRyQ9WDeWSKELqr
         jK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783722075; x=1784326875;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eJQ12QuZIJ5EMRjO8Od9KXNRvzbL6BoA/mx93EpDKlk=;
        b=WVaeIZQci6CwpPrgnbepRhE/W1Vm8djMZClszO8fJbc3Id29IIjlEukIK3DrVQpcdn
         yE8SoemnBFY5ox8ByQe8vUMlrenBU/+LWNVtKlsCBDztxDS5tIKFtrdbzcyj0ivnmPUM
         LnzMdxp3FgkDfR+2ccNBCleK2WcWOPHZ1TfTDZ003p8zstmly1QnJuA32PXQNXXawQXP
         +78fs+Z2CXY6L8hcqOsblru48Bvr+CkHqrj0/SrEfFMPzAfml/EhZML8fW69SFL9qz16
         x9Ge80Nn21tY00B54K7b8JKEttXaBlJjlHFs9i+DsfDdj9Jd9BAe6UIehk/HQd0JP8Hv
         DyPQ==
X-Gm-Message-State: AOJu0Yw8fOBr0767sFtILZh2z/8cl3TcCzMrnaGWzSGqZWI4wbayzX1c
	Vq5VgTVHoHT8PonD1HE6PZJtnp06lr+Q1YH2dtdu8sv8E5Cb0kn+SD2oKLytTjeMaPAvkANQc4G
	EJyS1Kf1CFyuNQZFvKkI6176r7DPfjOjNOuQN2I7EN0aZyk7qB0kSzpHn
X-Gm-Gg: AfdE7clN9yh+iF7H83BVJ2MXC+yT5x9j63aOEcKdftKZnuwencj8BdCFTi4EaquqZgn
	WW7ZxkMVcL06tJMkazJOP5OW/G5x9QdOYg0A0Otvi+LooEu8cA9yqrN1oU2NoZYzw3Mjuo4inW4
	g6lmGIYfr30sL5NPnzmVo+/ivhGGb7kWV6Yv8+R0Ez0Fy5WSd0zQf4XH/iSCYuP8i+qCRc8VNZt
	LvbmSIV6idKaHwH7tsjqncyIpO3/n22fxqGKPLxjAlk9+r6YHkufJye1IYjdLvVm7550aAN
X-Received: by 2002:a05:6a20:431a:b0:3c0:b766:7500 with SMTP id
 adf61e73a8af0-3c110bd8c49mr741431637.68.1783722074179; Fri, 10 Jul 2026
 15:21:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com> <20260710212616.1351130-3-dmatlack@google.com>
 <20260710213902.56C6C1F000E9@smtp.kernel.org>
In-Reply-To: <20260710213902.56C6C1F000E9@smtp.kernel.org>
From: David Matlack <dmatlack@google.com>
Date: Fri, 10 Jul 2026 15:20:47 -0700
X-Gm-Features: AVVi8CdWY4CLdCe1vaQDkifwOsvrPs1KJiTBtDjvCkcdYtirLyoV_GSd_ZjCv0E
Message-ID: <CALzav=eTgbKt2dfYBd3FrLm_epGncLpOC7t=52u2xn-gSd1qLA@mail.gmail.com>
Subject: Re: [PATCH v7 02/12] PCI: liveupdate: Track outgoing preserved PCI devices
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 2:39=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Missing lock acquisition in FLB destruction callbacks allows con=
current operations to trigger a Use-After-Free.
> - [High] A dangling dev->liveupdate.outgoing pointer after an aborted Liv=
e Update leads to a Use-After-Free if a subsequent Live Update is attempted=
.
> --
>
> --- Patch [2]: [PATCH v7 02/12] PCI: liveupdate: Track outgoing preserved=
 PCI devices ---
> commit 9a74c06de23d913aa84d2cbcc2aa3409bb1d2eb3
> Author: David Matlack <dmatlack@google.com>
>
> PCI: liveupdate: Track outgoing preserved PCI devices
>
> This patch adds tracking for outgoing preserved PCI devices across Kexec
> Handover (Live Update). It introduces APIs for drivers to notify the core
> when devices are preserved or unpreserved, updating the PCI core's FLB da=
ta.
>
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > index 899758883dd5d..03075ce06ac98 100644
> > --- a/drivers/pci/liveupdate.c
> > +++ b/drivers/pci/liveupdate.c
>
> [ ... ]
>
> > +static void pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *=
outgoing, struct pci_dev *dev)
> > +{
> > +     struct pci_dev_ser *dev_ser =3D dev->liveupdate.outgoing;
>
> [Severity: High]
> If a previous Live Update was aborted without explicitly unpreserving all
> devices, will dev->liveupdate.outgoing point to freed memory here?
>
> During an abort, pci_flb_unpreserve() executes:
>
>     WARN_ON(outgoing->ser->nr_devices);
>     kho_block_set_destroy(&outgoing->block_set);
>
> This destroys the block set backing the dev_ser allocations, but the
> dev->liveupdate.outgoing pointers on the actual pci_dev structs are never
> cleared.
>
> If a subsequent Live Update is started and pci_liveupdate_unpreserve() is
> called on one of those devices, could we dereference that dangling dev_se=
r
> pointer and corrupt memory when clearing it below?

This would only be possible if a driver violated its contract with the
PCI core to call pci_liveupdate_unpreserve() when the device is
unpreserved.

>
> > +
> > +     if (!dev_ser) {
> > +             pci_warn(dev, "Cannot unpreserve device that is not prese=
rved\n");
> > +             return;
> > +     }
> > +
> > +     pci_info(dev, "Device will no longer be preserved across next Liv=
e Update\n");
> > +     outgoing->ser->nr_devices--;
> > +     memset(dev_ser, 0, sizeof(*dev_ser));
> > +     dev->liveupdate.outgoing =3D NULL;
> > +}
>
> [ ... ]
>
> > +void pci_liveupdate_unpreserve(struct pci_dev *dev)
> > +{
> > +     struct pci_flb_outgoing *outgoing =3D NULL;
> > +
> > +     guard(rwsem_write)(&pci_liveupdate.rwsem);
> > +
> > +     outgoing =3D pci_liveupdate_flb_get_outgoing();
>
> [Severity: High]
> Does the destruction path in pci_flb_unpreserve() also need to acquire
> pci_liveupdate.rwsem?
>
> If a PCI device is hot-removed concurrently with a Live Update abort:
>
> Thread 1 (driver remove):
> pci_liveupdate_unpreserve()
>     guard(rwsem_write)(&pci_liveupdate.rwsem);
>     outgoing =3D pci_liveupdate_flb_get_outgoing();
>     ... begins modifying outgoing and dev_ser
>
> Thread 2 (Live Update core abort):
> pci_flb_unpreserve()
>     kho_block_set_destroy(&outgoing->block_set);
>     kho_unpreserve_free(outgoing->ser);
>     kfree(outgoing);
>
> If pci_flb_unpreserve() destroys the outgoing FLB without acquiring the
> semaphore, could Thread 1 end up writing to freed memory?

No. Drivers must call pci_liveupdate_{,un}preserve() only from their
file handler callbacks, which cannot race with FLB handler callbacks
(enforced by LUO).

>
> > +     if (IS_ERR(outgoing)) {
> > +             pci_warn(dev, "Cannot unpreserve device without outgoing =
Live Update state\n");
> > +             return;
> > +     }
> > +
> > +     pci_liveupdate_unpreserve_device(outgoing, dev);
> > +}
> > +EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710212616.13=
51130-1-dmatlack@google.com?part=3D2
