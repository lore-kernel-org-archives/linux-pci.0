Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792641189;
	b=qZm0v8r8e+xiRVjs9DLihJ0N9UZY2Pnaodhz1g4A/21U5onJ46ezQ7bCYDFxb+5sN/7K
	 2SqPXZVZMYJCw9BHj3i8sAG+3gdSI06x7F/cHsqgiMGEpaWR6HtlzDSLxb+hxDYlNLss9
	 ptJou8ogoTycH2N08kLX++mfMh47lT4ljUTqY/BVYKrg1JkPqETiFB55VA7R6CSgKG3ya
	 gDgo5rovDxnEVECNO24ejc3R4rlsj4F3VgjHOp2hc7bEgsSrxZtfcCSqxSuHqF1fLlHNS
	 XjzyV0bZ6gie1ikonpykTvJ17wByXZdBRGIoJ8CqjsZYu6S33jJ9kr3JI3ChJf+Bt6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792641189;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5AuqEvetTId+KGd9+1A3sRuao4CeyCeXTKq86oAL9AY=;
	b=Vq7i+RpeTtn2QiuymEF8bRfgSKoUW5mjODkigIKh80XuOnR0lT781grXRV5RQjKwsGyq
	 Cg39JQkSMb2ceyR75dSqpXyra1KlT4R1+Gx0KwYRr9jW1n9SFDdUwXxbtUfZJvKb6+2BK
	 1wsVnny5ybFN5lgnzdzFUV7BdufyUwrpZG2v7caypCtl7WT1RNZkcO1ynwBM6CUZygBA7
	 bHELsPlv5vl3QCt9CAuBZzr9pj255CkYHK01Xp186p6BMcEGo4g2AhDTF+ReKxH9RWDB+
	 U3SbFTey5J7F8Bja1GQyR6x3/0sSj5DXkM7D+1X05GAioIwdKcnTRU3UPGGxcsU5mQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LOhbp3WF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F016B606A31D
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 03:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F016B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LOhbp3WF
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c3fd91337baso198846266b.3
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 20:53:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792641187; cv=none;
        d=google.com; s=arc-20260327;
        b=TCIS7U62Y4io7wfb+RO1cnyf8FacwMKTvuDPr5ngP7D2Bfhhjr1c1d1zTf5LrdxGIx
         +iZDDLWDF5A9NkLT7mI7BCV2Umlir1y5ReWEUY5PJjws3bhUp5WbdumraDSMGaX1y/YD
         KjSmShyImAuc4AIBFr8tMtwCl4xe3WzBXX7C4fqxk4egg+G6u0KXkp5mPWESFjC1ppkq
         q1edgNWzX4Beiynd7l61LDtu794YKQVDA0x/Bgo2YxlEA9tdA6IT15cznpB4Dwa8JBzm
         tSKeHzPwZleEqfgaM7WXZd37nuz8bOGzcizgRaFDnXxmJTkM7AlciszI33mzQvW6hOSF
         2F+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5AuqEvetTId+KGd9+1A3sRuao4CeyCeXTKq86oAL9AY=;
        fh=E6MJTy3X1f1hCly9zWOGY3Qf5Qgy/Bo+WwhQax7fkpw=;
        b=opS7WY/UUsc18hQzh4gGSCQestGTR1puLpo8sIHdy1qHE+nMVt3cHLu+RYaMvNa7h6
         hhZaZFNM8IDwA3bT2e4Oyem0rAIvwxk2jI435wxjbqHFS0BOOCQGAxr59f6eEQWOuDqd
         ug24ld7A0xvn4YqrIPmjMEE60nmarMzYTgCdRcgtPFK0y3FT5QvkCjH/BkreQEzoMian
         PgaYS+TjBrIoYiZh3nYcXHTYNtgde5rSgWYq/1JS+lOVvrnX1cQEEep2l6E0v00ZPkzs
         R3QaspKnDngBtuF9IoyZzF7GdXg5pWkrTm9osIJtpi3m+p/buEhjLxAuQ/njgYbvKLRj
         WT0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792641187; x=1793245987; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5AuqEvetTId+KGd9+1A3sRuao4CeyCeXTKq86oAL9AY=;
        b=LOhbp3WFEcFQe0IjMecKk6I8Kz19GoZar+AHkRdzrCDmEfKyIagdj3cguFRCodjIts
         2K+ZlprU9+K4p456yAE/IebJt/JB/rOfVvmZQmmoWzFFV7Uhk9UJSYbg2Fi1Pe2vOULY
         KWEc5d2pfc2rk/Wh8DzOHlqJ+zuJg1V4nJFaELFzei42i1+yKzrhAiPXdJNMVP1K7p2m
         JS+2xJhikQBG5/GE4vNgGWxkijWuhVZaAZ1XGHPbtlK5UQYpIIH4ZScYaaGOx5D3LAiG
         M7hw8fmN7YUpuY/4QKg9bEL+8FY6TOxB9TunTmZ9BJhIgSXGhPcPvi12WcAM+CvE533E
         FA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792641187; x=1793245987;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5AuqEvetTId+KGd9+1A3sRuao4CeyCeXTKq86oAL9AY=;
        b=j2Zustqka49hcM8fS4JwGy5OG9fa9HrbzfplZsOAFbnQJNZCuch080JAjU6pO39K2A
         9b7KJ5DatyvIcsT0G79F8U0/66jKI+l59Ed6jWaMNklfYlWMYfDqaqs1JaG8wQ4SgTav
         spFq2+NnrBs3fuNN8dFbK4fOheJNExyPG8qS1JCKSbzn1D4gaegmJ6+vgyou98G5NzWr
         uTUBcnqX01pzs7swMHdlXmPkLQ1ENWTPRUpu4sPB9CndI5x1wAcanZOF5C43osI+dQDO
         RiUzUPIKMqZ3tjApPqovp6DrHyEJA5djV50Acx/w2h3MMgCxz3KPvhETispIyVV3DzVF
         /0Zw==
X-Forwarded-Encrypted: i=1; AKwUvBxlSzJRQSzzRHAUfrtt+vIHRZp+XYBfXirLWP8bqEOvfnWYXZYyBxUe9tIOlivCtM/jfOKcQZ18Wtw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwICTci7t5zi+8PJNtuf/6JdIFQlgSJ+IgE+d0P4uEirqdHaaH
	IKNVXrZh3XQqUaH9WHQCrKWzXgdIx9wDsQwGFwHz+3mmdTb4hMPtRqZdSp/w4dNIq+UMJMZGBK/
	+w80Nhd3sBMMrThzDIv/Lm84B1d9UsoWZ04wU9eir
X-Gm-Gg: AYBFou0D4/qfmS2EJO3IAsJsY88EJzE2YYVD3ti8yGBA9v23py/32aXvbp/0R3F1aX1
	o47RvpzUjpf2SExLpJ2oW9UOD4eWB0QgMkWNeXKeuJwOF3ekSTh8NKblUSi1xwoDNI9G7v+ZSQK
	riOjYlwtNCQZY6duRzj+S+MBh66qtNMW9SnMcgWh7NlDbKWQdU+fvwnijLr/u++Z9wMri9o6EVT
	ifW77/ERaEM4PAdAYhLB/gq+Tfq8WSiObhwJY1t2LvfkdTvgjBvFWd4/hUg4PvShYG90aCBxpUb
	P4UfEuRAuqJS7aDm999OavQ2ZC7HOXTktvURJMW5uou5ruCO62LUeZUUCkgKoGl1HtyTzJ4ulTQ
	AokgdtpoURZeUV73fz4jzocpowX1GzZseV6gfoQ==
X-Received: by 2002:a17:906:dc89:b0:c40:f9ea:7387 with SMTP id
 a640c23a62f3a-c46791a979emr355026566b.6.1792641186777; Wed, 21 Oct 2026
 20:53:06 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-4-tarunsahu@google.com>
 <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com>
 <9huzecdi6go0.fsf@tarunix.c.googlers.com> <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
 <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com>
 <atlKsD-aJB3mJr2j@google.com> <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
 <atl7peoVHdP5hz7z@google.com> <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
In-Reply-To: <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 21 Oct 2026 20:52:39 -0700
X-Gm-Features: AclHuK_94mheSr-cOV0RjUmA5boG8AcWT7XfL_o8Cm1BzPA_mpTiDbYCVzKwGVg
Message-ID: <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: tarunsahu@google.com, Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 8:32=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Wed, Oct 21, 2026 at 10:57=E2=80=AFPM David Matlack <dmatlack@google.c=
om> wrote:
> >
> > On 2026-10-21 09:26 PM, Pasha Tatashin wrote:
> > > On Wed, Oct 21, 2026 at 7:28=E2=80=AFPM David Matlack <dmatlack@googl=
e.com> wrote:
> > > >
> > > > On 2026-10-21 02:50 PM, Pasha Tatashin wrote:
> > > > > On Wed, Oct 21, 2026 at 2:47=E2=80=AFPM David Matlack <dmatlack@g=
oogle.com> wrote:
> > > > > >
> > > > > > On Wed, Oct 21, 2026 at 11:40=E2=80=AFAM <tarunsahu@google.com>=
 wrote:
> > > > > > >
> > > > > > > Pasha Tatashin <pasha.tatashin@soleen.com> writes:
> > > > > > >
> > > > > > > > On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <taruns=
ahu@google.com> wrote:
> > > > > > > >>
> > > > > > > >> LUO and its file handlers validate handed-over state with =
monolithic
> > > > > > > >> compatibility strings ("luo-v5", "memfd-v2"). Any change t=
o a serialized
> > > > > > > >> structure, even an optional additive one, must bump the st=
ring, which
> > > > > > > >> breaks live update between adjacent kernels. Replace the s=
tring in
> > > > > > > >> struct luo_ser with a feature header, so that the target k=
ernel can
> > > > > > > >> accept or reject the source kernel state per feature.
> > > > > > > >>
> > > > > > > >> struct luo_feature_hdr is a fixed 128-byte header: the ser=
ialized
> > > > > > > >
> > > > > > > > This patch is all wrong; 128 bytes is far too large. For ev=
ery _ser
> > > > > > > > struct, we only need 8 bytes instead.
> > > > > > >
> > > > > > > NOO, It is not. It is intended to avoid complex mess with unn=
ecessary
> > > > > > > over-engineering.
> > > > >
> > > > > 128-byte per serialized struct is not starter.
> > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > The first 4 bytes are the size, and the next 4 bytes are fl=
ags (i.e.,
> > > > > > > > 30 feature flags + 2 reserved bits for flags extension). Th=
e last two
> > > > > > > > bits of the flags indicate whether an extended flags field =
is present.
> > > > > > > > Each extended flags field is 8 bytes, and its last two bits=
 indicate
> > > > > > > > that yet another extended flags field follows.
> > > > > > >
> > > > > > > If we will have dynamic extension of flags, Think about this.
> > > > > >
> > > > > > To support dynamic extensions in a backward compatible way you =
want
> > > > > > something like this:
> > > > > >
> > > > > > struct luo_feature_hdr {
> > > > > >    size
> > > > > >    flags
> > > > >
> > > > > __u32 size
> > > > > __u32 flags
> > > > >
> > > > > >    extensions  // offset of first luo_feature_extensions (or 0)
> > > > >
> > > > > __u64 extensions[0]  --> but the size should be specificed in
> > > > > declaration macro that I showed in the next patch.
> > > >
> > > > I think you may have misunderstood what I meant. In my proposal,
> > > > extensions is an offset to the first extension, not an array of
> > > > extensions that immediately follow the header.
> > > >
> > > > If the extensions immediately follow the header, then the number of
> > > > extensions is baked into the struct layout. Every field after them =
sits
> > > > at an offset that depends on how many extensions there are. If we e=
ver
> > > > need one more extension, all the fields shift and old and new kerne=
ls
> > > > can no longer read each other's struct. That is the problem Tarun
> > >
> > > We can structure it cleanly by nesting the payload: something like
> > > struct { struct header {...}h; struct serialize_data { ... }p; };
> > > That way, the header can expand dynamically at the front, while all
> > > fields inside `serialize_data` stay at fixed offsets relative to the
> > > start
> > > of the payload.
> > >
> > > Since the header size is self-describing via continuation bits (e.g.,
> > > the last two bits indicating whether another flag word follows), LUO
> > > can
> > > easily compute where the payload begins in the incoming blob. This
> > > keeps the implementation simple, avoids linked lists of offsets.
> >
> > Oh interesting. I agree a dynamically sized header at the front can wor=
k
> > and is simpler than a linked list.
> >
> > So the header and the payload need to be separate, and the payload is
> > located with pointer arithmetic on the header. For example:
> >
> > struct luo_ser_hdr {
> >     u32 size;    /* Size of the payload in bytes */
> >     u32 flags;    /* Bits [31:30] indicate an extension word follows */
> >     /* u64 extension words follow while the continuation bits are set *=
/
> > };
> >
> > /* Size of the header, including any extension words. */
> > size_t luo_ser_hdr_size(const struct luo_ser_hdr *hdr);
> >
> > static inline void *luo_ser_payload(const struct luo_ser_hdr *hdr)
> > {
> >     return (void *)hdr + luo_ser_hdr_size(hdr);
> > }
> >
> > On preserve:
> >
> >     hdr =3D kho_alloc_preserve(luo_ser_hdr_size_for(nr_ext) + sizeof(*s=
er));
> >     luo_ser_hdr_init(hdr, sizeof(*ser), ...);
> >     ser =3D luo_ser_payload(hdr);
> >     ...
> >     args->serialized_data =3D virt_to_phys(hdr);
> >
> > On retrieve:
> >
> >     hdr =3D phys_to_virt(args->serialized_data);
> >     err =3D luo_ser_hdr_validate(hdr, ...);
> >     if (err)
> >         return err;
> >
> >     ser =3D luo_ser_payload(hdr);
> >
> > What would size mean in luo_ser_hdr? The size of the payload or the siz=
e
> > of the combined luo_ser_hdr + payload. luo_ser_hdr is self describing s=
o
> > maybe it's just the size of the payload?
>
> > What would size mean in luo_ser_hdr? The size of the payload or the siz=
e
> > of the combined luo_ser_hdr + payload. luo_ser_hdr is self describing s=
o
> > maybe it's just the size of the payload?
>
> Either works, but having size cover the combined hdr + payload
> provides a few extra guarantees:
>
> 1. A single static_assert validates the entire serialized struct at
> compile time, including the header and the number of ext_flags
> elements.
> 2. Bounds checking while traversing the header continuation bits on
> retrieve: we can sanity-check that luo_ser_hdr_size(hdr) <=3D hdr->size
> so we never walk past the end of the serialized blob if there is
> memory corruption.
>
> If we declare the payload struct separately and pass it into the
> macro, handlers also get a clean type for luo_ser_payload(hdr):
>
> #define DECLARE_LUO_SER(name, expected_size, ext_flags_count, payload_typ=
e) \
>     struct name {                                                        =
   \
>         __u32 size;                                                      =
   \
>         __u32 flags;                                                     =
   \
>         __u64 ext_flags[ext_flags_count];                                =
   \
>         payload_type payload;                                            =
   \
>     };                                                                   =
   \
>     static_assert(sizeof(struct name) =3D=3D (expected_size),            =
       \
>                   "LUO struct " #name " size mismatch!")
>
> For example:
>
> struct luo_memfd_payload {
>     __u64 pos;
>     __u64 size;
> };
>
> DECLARE_LUO_SER(luo_memfd_ser, 24, 0, struct luo_memfd_payload);

This looks pretty reasonable but I would name the payload
luo_memfd_ser. The combined struct that DECLARE_LUO_SER() creates
should never be used directly since the offset of the payload in that
struct is only valid in the current kernel. So I would give that
struct a special name that makes it obvious you shouldn't be using it.
