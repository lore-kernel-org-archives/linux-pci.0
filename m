Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF06F37E310
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 20:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787602982; cv=pass; b=Wmbu5xQI6Hyrh84WgxKbWMKGMghiaPMGy1OjCB0rRxemM5f8iMweafYxLM+fjllezxz30IROBBN7NJFUZ4WBkVW8zEun4hgIojXv7UBFGdXGIzlhkpXNu1FI9DquylZiDmbY5xfgbqBmvXHPa8vc27FrW56d6ZM3oY/nkcq+VJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787602982; c=relaxed/simple;
	bh=Wi35RsFVCXTH1AS7f3JJzBhl9U0v9HsB8GYM+6yLxFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O//9UvzNKA0riVJAl98O2E+Q91VEDbK70RS+unSl9d0H84YNlOib1gn4o/o88LBpVc0qN/VtQYiKZIoc1GA69klXCuFrK3RKIhLdDwVQ9jwJJceYk2uwEBk+PQppxir7JQQyk/T1EaBrZeRN6tNm0HEOy5yKeBGQfVCQ5TzWBTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DlSmm6jM; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DlSmm6jM"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-381b831d535so5765477a91.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 13:23:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787602980; cv=none;
        d=google.com; s=arc-20260327;
        b=OfaHN45g4FlX1r7YUASDXhMwS/OS/cWd+6aiXso+Qlzx8bML0IaZmJzLF4lqj12aGy
         8X0ePGAMcR9csitLwBc9A6x2RkS2xgrMsCk2Cf+WCMqIZ8CvG7SbF7qcq0wMowiLUc1K
         n7SILrpFFFBvDhOOg5M5/opALuHSCswLcEuDLxT8y5b/sp7mMPr6Z/0w2B4X+yt6J2+C
         HaKNaUauojDd+Y4b5L1wBbS9N9/QnLknOopGVV5jzsFqmgBFN1lKXwnBsJFE05uClEqZ
         l7M7xFfZQu8avDZm3J/Ohc/n4Pu8XQNThnqv5K3qiFX3tURF04JriKJFh5Oak8Igfzp4
         YyiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=50cIx+7jrks3hpuiEP9gkJNfbYNNsNkIZ20/e0dF6p0=;
        fh=5dSoMebMBhbcN69xtPuPaF3wYROJygQdvt62Kx8OVn8=;
        b=RTVRZDfmPtbte8+Vqv6I2DKoH2ZZr2cXnJ6lqtZGIfKM7xvFr7WQ6Ha1U1KR4DbZQ1
         9iPtqStQ/PgKv35ftI6SZ7iFVkcu3G6sOK4hQ+saxzJjZfD/NgnHQBvmAphNtw8hBUZ/
         7/Plg9iKpLmlM0or/zxGiyFr70flJ72wleHbqq8lULiPCVcjSyE78JMsZ9v86P8k9s71
         h3i7vKqPu9unHE/6v6/jR4HUlRtzzAjWyW0MFgc8CYIYtS6bZ+rZp7ho8Hpri6PgXR8V
         SiBP3mkUVrCuRHLsMKAa/wim+Wyj/13edB1rIXNWqJ2MSFWxvTyjBHI+GGHveq93C5+A
         +lKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787602980; x=1788207780; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=50cIx+7jrks3hpuiEP9gkJNfbYNNsNkIZ20/e0dF6p0=;
        b=DlSmm6jM+H9o0doTGGEhOYDj+mV1bed27EWZYCmbsHx5JLZRg/VpzXpFT0AoA7PAk0
         dHMcphHzsThDSNhYySJHNFUrrS57iY6i/kqJIEMJWNKPNCZIy73FAkYsCEZOmUZY+jJc
         PEXffnjW7K4fJVlzfuecaqxnzSbN5JzcNfl04DoX8170wiHcAZEEqp7gS0AEvL0u+QE7
         ilJauMPJBvuYXbV4vLWk61XIFP56ubV0cjSoReDem3LXURXBDA6EnaLHtd/OYjAs3onl
         nzv6hSsWesrVvtC/xsSPcVWwnHbdj+udCNJCMmpm1T0xD1mUSgqa4TvIOrweUQWNlVyc
         HkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787602980; x=1788207780;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=50cIx+7jrks3hpuiEP9gkJNfbYNNsNkIZ20/e0dF6p0=;
        b=ISkjAooQe5f1Wnox85YdQizSIzzpM5NnXh/gc6FNbSspaDiPLPVsvXixOHS1eppDbw
         U1qDYbBry7+2rQwNtZu738J1RqNh9YU4EYmu7SgFuyXEwMjeps0W8TUPoL+im9a5wCo5
         f++S7igvK0taMgMX0iMI7qyio2X9D73Nr2krk4433vaW4NqanDlJSIG3opR06HvihJxk
         oz1nX9Tn/yPx/9gmK1j4LtLkizfC9wgW3cb8CkMmytkkXvFFMFI0/Q+AhD2275XhPVJS
         7glMXeGUNewaduRe3acpRJR3Rc//Rr0rUrUIISeYCVJ61qe3KO4N+y4kBsVher/3SJUf
         Ixiw==
X-Forwarded-Encrypted: i=1; AHgh+RqU8IhnVcp79w8pqULNk5qgMRfddNUEVKy9bRF/efg2GkbzDPYAFsH07vf7KAtDqSiN8AO8sVfoO/Y=@vger.kernel.org
X-Gm-Message-State: AFuF++kP98nO0h3vw/t9mAJQT+CDT704dZ7lp37R334m9akmkPgyTNsw
	3EYDrKo8DdTHxNGjTrOt6czv+x5i9g7FvmTQnn+LPfIv0c+1QvdDEWO/FkwoKeGsd4FKt0J2Xo+
	p0I6PsPg5gjmMFQHoQG8e71CpLHKK5ulWVz3dszzwVFZHHb03/rZqcNOcPg8=
X-Gm-Gg: AR+sD110jbkYrVxbvONBy9MTH1ZFAkk+i89OLO3HZLB44e9wRaBCMKela9C5dnPf8wB
	S9D34tTaZYdB4V+fbiF8FREv5BM8gnYJqFsdtJ6/Jv0vHl55MyzXLOihfnnbwuKfsAEoNn3+dUI
	9bZbOKEO4i0LJu8LnjeKSdBUZhjtJAw5El/dN6vsac7cvU8/H0ujq0woPh6Ijd9daDzwGjo89RU
	FDJBRskKYl8GXi9xcEKwyKuqYihQNiB58vVdMX5K1sfb7mQZKLA1hPct1x9tFwRNGwzP4HNgen9
	wc0FSIFh+m19YxYqWJ3iHt2sKmLBh35MHl5VYvHusC9Z1A==
X-Received: by 2002:a17:90b:588c:b0:38d:ef48:b04 with SMTP id
 98e67ed59e1d1-396464bf465mr2648446a91.10.1787602979634; Mon, 24 Aug 2026
 13:22:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821221610.3570722-1-dmatlack@google.com> <20260821230620.fcpmn7radmwnfnh2@pali>
 <CALzav=dOumVYvjShjHHd1fydKMO1OX2w-ps4HEH5kBU7_3AVzg@mail.gmail.com> <20260824173635.tqbivfr6l7pvi3qh@pali>
In-Reply-To: <20260824173635.tqbivfr6l7pvi3qh@pali>
From: David Matlack <dmatlack@google.com>
Date: Mon, 24 Aug 2026 13:22:32 -0700
X-Gm-Features: AcwNN1V5wAj7wpHer5fWpvixOpAfFrfTnsfZcCES8Z61ZMdZ90F_sM5Scg2zCFc
Message-ID: <CALzav=c5WY4MQ4PzOTkuYA-eDv_cVWF74L4dd46smiZjPzsPLQ@mail.gmail.com>
Subject: Re: [pciutils PATCH v2] lspci: Determine bridge window address size
 from bridge_flags
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Martin Mares <mj@ucw.cz>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 10:36=E2=80=AFAM Pali Roh=C3=A1r <pali@kernel.org> =
wrote:
>
> On Monday 24 August 2026 09:24:33 David Matlack wrote:
> > On Fri, Aug 21, 2026 at 4:06=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.or=
g> wrote:
> > >
> > > Hello! Thank you for taking this issue. I briefly checked the change =
and
> > > I think that this is the right way how to address that issue.
> > >
> > > Anyway, it would be nice to provide some example of config space of P=
CI
> > > Bridge (lspci -x) which is affected by this issue and have it in
> > > pciutils/tests/ directory.
> >
> > Ack, I will incorporate that into a v3.
>
> Feel free to send it separately. No need to have it in this one change.

Sure, I can send a 2 patch series in v3 if that's what you mean?

By the way, since lspci parsing of the pciutils/tests/ directory would
use the dump backend, which does not use PCI_FILL_BRIDGE_BASES, it
will not exercise the bug fixed by this commit. Is it still worth
adding the test case? I am happy to send it, but I'm curious how it
will be used.

>
> > > On Friday 21 August 2026 22:15:59 David Matlack wrote:
> > > > Use bridge_flags to determine address size bits (16- vs 32-bit for =
I/O,
> > > > 32- vs 64-bit for prefetchable memory) when displaying bridge range=
s
> > > > populated via PCI_FILL_BRIDGE_BASES.
> > > >
> > > > Commit ccf68033a452 ("lspci: Use PCI_FILL_BRIDGE_BASES to detect if
> > > > range behind bridge is disabled or unsupported") introduced code in
> > > > show_htype1() that reads PCI_IO_RANGE_TYPE_MASK and
> > > > PCI_MEMORY_RANGE_TYPE_MASK from bridge_base_addr[]. However,
> > > > bridge_base_addr[] holds base addresses without flags, as documente=
d in
> > > > lib/pci.h and implemented across backends like sysfs.c and
> > > > win32-cfgmgr32.c.
> > > >
> > > > Because bridge_base_addr[] does not contain configuration register =
flag
> > > > bits, masking the lower bits evaluates to zero. As a result, 32-bit=
 I/O
> > > > windows are mislabeled as "[16-bit]" and 64-bit prefetchable memory
> > > > windows are mislabeled as "[32-bit]" when using PCI_FILL_BRIDGE_BAS=
ES.
> > > >
> > > > Fixes: ccf68033a452 ("lspci: Use PCI_FILL_BRIDGE_BASES to detect if=
 range behind bridge is disabled or unsupported")
> > > > Signed-off-by: David Matlack <dmatlack@google.com>
> > > > ---
> > > > v2:
> > > >  - Fix lspci.c to use bridge_flags[], per lib/pci.h, rather than
> > > >    changing the behavior of just the sysfs backend (Pali Roh=C3=A1r=
)
> > > >
> > > > v1: https://lore.kernel.org/linux-pci/20260626213047.189951-1-bhelg=
aas@google.com/
> > > >
> > > >  lspci.c | 12 +++++-------
> > > >  1 file changed, 5 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/lspci.c b/lspci.c
> > > > index 2a14303e74f6..52fd9247aefb 100644
> > > > --- a/lspci.c
> > > > +++ b/lspci.c
> > > > @@ -571,10 +571,9 @@ show_htype1(struct device *d)
> > > >
> > > >    if ((p->known_fields & PCI_FILL_BRIDGE_BASES) && !io_disabled)
> > > >      {
> > > > -      io_base =3D p->bridge_base_addr[0] & PCI_IO_RANGE_MASK;
> > > > +      io_base =3D p->bridge_base_addr[0];
> > > >        io_limit =3D io_base + p->bridge_size[0] - 1;
> > > > -      io_type =3D p->bridge_base_addr[0] & PCI_IO_RANGE_TYPE_MASK;
> > > > -      io_bits =3D (io_type =3D=3D PCI_IO_RANGE_TYPE_32) ? 32 : 16;
> > > > +      io_bits =3D (p->bridge_flags[0] & PCI_IORESOURCE_IO_16BIT_AD=
DR) ? 16 : 32;
> > > >        show_range("\tI/O behind bridge", io_base, io_limit, io_bits=
, io_disabled);
> > > >      }
> > > >    else if (io_type !=3D (io_limit & PCI_IO_RANGE_TYPE_MASK) ||
> > > > @@ -600,7 +599,7 @@ show_htype1(struct device *d)
> > > >
> > > >    if ((p->known_fields & PCI_FILL_BRIDGE_BASES) && !mem_disabled)
> > > >      {
> > > > -      mem_base =3D p->bridge_base_addr[1] & PCI_MEMORY_RANGE_MASK;
> > > > +      mem_base =3D p->bridge_base_addr[1];
> > > >        mem_limit =3D mem_base + p->bridge_size[1] - 1;
> > > >        show_range("\tMemory behind bridge", mem_base, mem_limit, 32=
, mem_disabled);
> > > >      }
> > > > @@ -616,10 +615,9 @@ show_htype1(struct device *d)
> > > >
> > > >    if ((p->known_fields & PCI_FILL_BRIDGE_BASES) && !pref_disabled)
> > > >      {
> > > > -      u64 pref_base_64 =3D p->bridge_base_addr[2] & PCI_MEMORY_RAN=
GE_MASK;
> > > > +      u64 pref_base_64 =3D p->bridge_base_addr[2];
> > > >        u64 pref_limit_64 =3D pref_base_64 + p->bridge_size[2] - 1;
> > > > -      pref_type =3D p->bridge_base_addr[2] & PCI_MEMORY_RANGE_TYPE=
_MASK;
> > > > -      pref_bits =3D (pref_type =3D=3D PCI_PREF_RANGE_TYPE_64) ? 64=
 : 32;
> > > > +      pref_bits =3D (p->bridge_flags[2] & PCI_IORESOURCE_MEM_64) ?=
 64 : 32;
> > > >        show_range("\tPrefetchable memory behind bridge", pref_base_=
64, pref_limit_64, pref_bits, pref_disabled);
> > > >      }
> > > >    else if (pref_type !=3D (pref_limit & PCI_PREF_RANGE_TYPE_MASK) =
||
> > > >
> > > > base-commit: b41ce14da749fb44ca7940ba9797027bfa62c23e
> > > > --
> > > > 2.55.0.766.g2966f0265a-goog
> > > >
> > >
