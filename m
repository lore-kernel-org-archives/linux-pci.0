Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ED239E6CD
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771954441; cv=pass; b=QI4SvODfWyJdbv8582KpUOT9TwjWcuHI7RIGMTu/oNRZHw9XdHSQVZik81swelgGUVEFBN6A1od0XfNGy1Gq00JuYkfDeBtnhzHGwginWYjuTBEJ4+CWaCWsqZW6EFsEXEkEP/e8S8XUabwTKZSiIHWGu+n7EGc+e+PrBJOSMeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771954441; c=relaxed/simple;
	bh=cCuihnC83rVuxNh9g4clqD2+2gMDD3M/m5qB3+opnzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KStzIJqyrNTaB4UvfKASQbI1oHSKUqNG6ZW4fDZIb2x7U12xZlQdSCh30CnnaP8qoeywbk17FgA/ZI2I4/hefvL6aCXCannNN5pEavmIeo0wKJ29L9bLk8ShUcZDyCZ7cWXnies7Tf0W43m+fbdaLQK5UTF7mErxDW0/rzo0dEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jolJbCoX; arc=pass smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jolJbCoX"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-94ac3958788so28990241.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 09:33:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771954438; cv=none;
        d=google.com; s=arc-20240605;
        b=Et9y5g5bDzeaIMguMzO2tFc0toJLlAmsfGmHu3bIw5S8eXqCNfU3Nz4VBgvEcXcGWm
         pyqGyOjsXN+TyCb3ZZx+WF2JeW0Bf3znftPqx15aPmBw1KdT7Mmh+o/JrmXVCbZVQ7Xk
         cG/gpaUQaIf1TDhcqBMNEaGnKQEZxImm+la8LXWOY2esqjAl4OLA3Iq/BcydmHMqwC9P
         TVpdzdyKTkbaZPim+DE1RT1p5O9ypNnx4/IppvoiqOY1BrGqWhpMINgqc86cfdQ0MAXZ
         W2q6uXpd7ZPYV5+MNxysSZJW1k4dQaOx+5BHWdNVNHqxCBEVjm4pIaOrzJosi1XDvIQ2
         0ScA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ifttwnYsIrEN6pRSBIiuqj7H8s+5kPdjKC4U9v3r5Ew=;
        fh=HE+GO3QL0zZ8COSE/yccUwwLcO2iBAjYlBwWKUaN25U=;
        b=d6uuc2SwsAHI2RUMY48wNTl6fVbjMHLsH7bZOsN8jzEovElMt5lljU1e0HkvGsaQ/0
         /jC6PF79q5toPdvHzERKw3wbLAJ2iFLsQhE56EJmzBdMKSEvM2vLCZKtmUtuHQA96yEF
         Iez4BAFkPVFjT8ejF3dIpWzRBOxk5U+HWXrDCPBhnhHIZfcsDkNyBZES8WA7YOSEUYHm
         edaHUcmcgKt2GKDHCke6BryBKhgPiaXF4Q6PRL2Lwb65vYS6wKj1slNK9y/SOoxp0ZqC
         /RpxgBE/3t6gpvj1HP3FGsabJISJo31MlM2MnKgvS3oytd6OGwg2Zm4pLRwk21ku6wVX
         lAxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771954438; x=1772559238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifttwnYsIrEN6pRSBIiuqj7H8s+5kPdjKC4U9v3r5Ew=;
        b=jolJbCoXdMN41Sl54UH1EhIF9lYgMnUAkv31VR7d6YHVfXhNEMI/oWJeEqnwMX6hHl
         TXbMLy906AtVogBxlEiPhmHP2/az0SGQhOe2Wk8iSROqBd1ZVWZ9FQu0biRx/10+7W9v
         9vsTLLwtCZvluGsn7DRIhKOr8fJpk8xV1sg2pmfX1MMyoJLgm9bu/Z55W4/uMZ6ejAWA
         oPZ2xKSlt3hnT73Wi2swQS2owsGclHr3lFH+SjxmRPrb7Jq0rrgaNsZRKBKURZCiUdZe
         fV6uj9DlFicm9uEimVZ1LpRi55AsLMi9t/kE7ornmeU7Z08w94OggX7daje69SKh6xP4
         ICfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771954438; x=1772559238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ifttwnYsIrEN6pRSBIiuqj7H8s+5kPdjKC4U9v3r5Ew=;
        b=RVEElB3MsPLeRxWysr8CkGStGFqTunz+iHo2XIGmvQFPOThVIQtiFW1B0T1q5xnEgM
         IXuQlRDWhq1r//SroiY4Eoy83kW1/VigqNLzib8Rh3QbBSPKVbiUtHGRSgYQds6MNJ1D
         sWX+vANDl9KvpMLuhlqNbX1CWO9GvraclYj1IxmATijjckcZ2EdMYbpzlbf/gWJrRyBc
         IIKcnwoZqgbLTuc1GvA0un0+BgMfuwsD7nUUiSOt92AVIs75aPB1Ck65DltKJelizgd9
         JjxbO1WzCawfiNpBfm8LTxrGXxf+Uzmdc4lgW48BWPChPZEehm37HqGxJOJuApIpyFOG
         +lWA==
X-Forwarded-Encrypted: i=1; AJvYcCVHpZY5rEboya51k4vvK886zqubGVfFR+SQ+mXr52ZunElB6V1bn1ommTZnyIWBZQ/1LnSxRwJSOMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwldFt8kHnK1kY94Kt3ZJJM9AWuf2TpOZy5wnOyXlTYzN98YV62
	x7zMmeXvuabArFGyg9ibVUig/WXMtoneGqkMrvy0XtLSoLp43fyaq3afTchgN+b4Nrox9Yc774f
	Z5vo06Y/OtrU2CKiP16bKkgI3//OP7d3QVxErRzbS
X-Gm-Gg: ATEYQzyTd0492Uq2jTlxHxI+pjPPmFqUiZXoJiVWwvHhsxPsMTIq+4BAxX9PrsM7XHp
	UmPggr0BQc3aolHbhFnr/SWs85zUNlAduHgor9KOkpBlbdGLFY4dc578b8kfeKdGuU7ohuTGDCx
	/WHetzI0Vs2u1Qe0r9eFPuyGdYTROoXnqlqXBA9cmajLIROwCBEs7aAQX+EehdmtJ0mn8kQINAG
	Wuqta35U8VKB/uh2Rp+Lso5yz1m9aXxX2OC3LFs5ixHZ/xkzgQri7VA2s44oxv/MX8ezrNRezx0
	JktxlFM=
X-Received: by 2002:a05:6102:e0a:b0:5ef:b32c:dff8 with SMTP id
 ada2fe7eead31-5feffd8e046mr571923137.5.1771954437826; Tue, 24 Feb 2026
 09:33:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-3-dmatlack@google.com>
 <aZ1svGur9IxQ7Td2@google.com>
In-Reply-To: <aZ1svGur9IxQ7Td2@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 24 Feb 2026 09:33:28 -0800
X-Gm-Features: AaiRm50ftzuk34ivxDcB4SNiM7gs91UDwPlTbTMB1CMe8djixeonPg3t_5VqAYg
Message-ID: <CALzav=fSpd6H5pQNtJoFHdNtWVO11vffhWQFsMFkM+osGuE0wQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/22] PCI: Add API to track PCI devices preserved
 across Live Update
To: Pranjal Shrivastava <praan@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 1:18=E2=80=AFAM Pranjal Shrivastava <praan@google.c=
om> wrote:
> On Thu, Jan 29, 2026 at 09:24:49PM +0000, David Matlack wrote:
> > + * Copyright (c) 2025, Google LLC.
>
> Nit: Should these be 2026 now?

Yes! Thanks for catching that.

> > +int pci_liveupdate_outgoing_preserve(struct pci_dev *dev)
> > +{
> > +     struct pci_dev_ser new =3D INIT_PCI_DEV_SER(dev);
> > +     struct pci_ser *ser;
> > +     int i, ret;
> > +
> > +     /* Preserving VFs is not supported yet. */
> > +     if (dev->is_virtfn)
> > +             return -EINVAL;
> > +
> > +     guard(mutex)(&pci_flb_outgoing_lock);
> > +
> > +     if (dev->liveupdate_outgoing)
> > +             return -EBUSY;
> > +
> > +     ret =3D liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **=
)&ser);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (ser->nr_devices =3D=3D ser->max_nr_devices)
> > +             return -E2BIG;
>
> I'm wondering how (or if) this handles hot-plugged devices?
> max_nr_devices is calculated based on for_each_pci_dev at the time of
> the first preservation.. what happens if a device is hotplugged after
> the first device is preserved but before the second one is, does
> max_nr_devices become stale? Since ser->max_nr_devices will not reflect
> the actual possible device count, potentially leading to an unnecessary
> -E2BIG failure?

Yes, it's possible to run out space to preserve devices if devices are
hot-plugged and then preserved. But I think it's better to defer
handling such a use-case exists (unless you see an obvious simple
solution). So far I am not seeing preserving hot-plugged devices
across Live Update as a high priority use-case to support.

> > +u32 pci_liveupdate_incoming_nr_devices(void)
> > +{
> > +     struct pci_ser *ser;
> > +     int ret;
> > +
> > +     ret =3D liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **=
)&ser);
> > +     if (ret)
> > +             return 0;
>
> Masking this error looks troubled, in the following patch, I see that
> the retval 0 is treated as a fresh boot, but the IOMMU mappings for that
> BDF might still be preserved? Which could lead to DMA aliasing issues,
> without a hint of what happened since we don't even log anything.

All fo the non-0 errors indicate there are 0 incoming devices at the
time of the call, so I think returning 0 is appropriate.

 - EOPNOTSUPP: Live Update is not enabled.
 - ENODATA: Live Update is finished (all incoming devices have been restore=
d).
 - ENOTENT: No PCI data was preserved across the Live Update.

None of these cover the case where an IOMMU mapping for BDF X is
preserved, but device X is not preserved. This is a case we should
handle in some way... but here is not that place.

>
> Maybe we could have something like the following:
>
> int pci_liveupdate_incoming_nr_devices(void)
> {
>         struct pci_ser *ser;
>         int ret;
>
>         ret =3D liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **=
)&ser);
>         if (ret) {
>                 if (ret !=3D -ENOENT)
>                         pr_warn("PCI: Failed to retrieve preservation lis=
t: %d\n", ret);

This would cause this warning to get printed if Live Update was
disabled, or if no PCI devices were preserved. But both of those are
not error scenarios.

> > +void pci_liveupdate_setup_device(struct pci_dev *dev)
> > +{
> > +     struct pci_ser *ser;
> > +     int ret;
> > +
> > +     ret =3D liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **=
)&ser);
> > +     if (ret)
> > +             return;
>
> We should log something here either at info / debug level since the
> error isn't bubbled up and the luo_core doesn't scream about it either.

Any error from liveupdate_flb_get_incoming() simply means there are no
incoming devices. So I don't think there's any error to report in
dmesg.

> > +     dev->liveupdate_incoming =3D !!pci_ser_find(ser, dev);
>
> This feels a little hacky, shall we go for something like:
>
> dev->liveupdate_incoming =3D (pci_ser_find(ser, dev) !=3D NULL); ?

In my experience in the kernel (mostly from KVM), explicity comparison
to NULL is less preferred to treating a pointer as a boolean. But I'm
ok with following whatever is the locally preferred style for this
kind of check.

> > @@ -582,6 +583,10 @@ struct pci_dev {
> >       u8              tph_mode;       /* TPH mode */
> >       u8              tph_req_type;   /* TPH requester type */
> >  #endif
> > +#ifdef CONFIG_LIVEUPDATE
> > +     unsigned int    liveupdate_incoming:1;  /* Preserved by previous =
kernel */
> > +     unsigned int    liveupdate_outgoing:1;  /* Preserved for next ker=
nel */
> > +#endif
> >  };
>
> This would start another anon bitfield container, should we move this
> above within the existing bitfield? If we've run pahole and found this
> to be better, then this should be fine.

Yeah I simply appended these new fields to the very end of the struct.
If we care about optimizing the packing of struct pci_dev I can find a
better place to put it.
