Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792639976;
	b=x2UPNEITy2Lok528mdy8dGRWNwxy70Te7zPCeCd716zLwwhSjrbx3zdeK+kHW5HjK1Z9
	 S6Dd/M7dtVaIx/wC4DmNeGsvuVInLIwvRX0OAn+1UYv/sVN8bGF0wZZESRrwJgGHJLaeH
	 m5p9FMN/VX0Iq68RbhKWqhIVuRXxyqgYwkaR1JN4NPH8ZmP/jAfsnwgHit25VHJSHGDOp
	 Oi/Hp4TZxkY12DSqxmuuH80uUZ/OdW17xnalcARNotryG5siVMnrzFhhejr0i51s1ClQX
	 4eXWBuwQgq7VGgo84s6AsDSMSECuIDlANCvCqmwCqYX0V0lkQqJv0Oqk8C9q4bcIODA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792639976;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Un0pCsebAGgOHU5j/UFuxo61lM6ZZUr6aOfHjWXDb9g=;
	b=p+PiryV8+YlXWh28hAoav4PPbVkmcfnbvQ6ACPqxZZC+28TUwAMeoP2QO1igStZYgQQ3
	 sIz0NddTLrm76qGEDcNxkSvu/uAXVWwuqZ3tJ8bPKUhEBdyEfSl01N0vGWEZO2LTJS9OQ
	 MB6l+HAGDnnAm0ZuEsOi5lgLNIYvBrWvSJaw2oDvMfQZQZbPwUWQ+pG47Il5yCTn+qYds
	 ES3kfrTKhOA4fy8jwdSvJxYKo3CnuwL+g7mYwproludUvwbaNYXIzIhPqXwj06Zslq1KN
	 5b7vqF3mIRmfaXYFKxfoJvtZxH6q+r6tyxNSO9vAwOb9JjbZd6N+83AdlauH4thtT8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCF7606A31A
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 03:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECCF7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6acb9c018ffso767740a12.1
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 20:32:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792639974; cv=none;
        d=google.com; s=arc-20260327;
        b=ndhcEzRO+qCZx/N6UGtgoD8fWKqwwh52EkJjVxCidLMZyYd7Wrq0EbZjAYuucu1AzQ
         Qpn/0rZQCJnPsqSS1wF8J3F5A71l2a52WMwRl2ctKfoXtus9V6j3mdw0XDBzar0dhiHZ
         AyK6Gs8MNjNPkTzzxGaojFN4JROFQNUfPlXeFz09yKaoH4lzCj9xt3+KJ2PtjvB4/Kpx
         6PcE4YpLgyfG9b0bQ9sfVGqmZ88UhQBdRDhSLdDKsd9o3pyeaM8ZtkNAxmc+5ZRJW2JT
         vStn2WE6SFYx4ikT/xSbOJOzNPJUh+la3YO5FZuTw8F/ZnDfLSFKEBzQKsBoYR4WOvuz
         vInQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Un0pCsebAGgOHU5j/UFuxo61lM6ZZUr6aOfHjWXDb9g=;
        fh=B2Im5E3F7mAJdZhx+iSpzLadg4bKCRszOJhVs5ObtkA=;
        b=EMM3rIucsSNtnMhffoVrFcfN/UNPf7aPq2kHme192U/MN2W4xmdaZfMj7OjcIJUZyQ
         AL/yqog4q8V3cEBIWPWAZs2b1DeblO1XIQrLg/zecenuOhtZtKfcZlZk79AXeg7bx88Y
         ILB6UBu3S+PzKWot6CLlN5zoDh3Fi/iB6/3bC23Y/vFbLOZRddTixxMPucuscayql39B
         xHswQeU6+TpCmP/CIFqBNgsbmJ6H9/fniElXoKDkRhlr0aPothEX9OV3fFkUDFLuF8tZ
         j0ssjKiSCBhq9plVxQ6mqXLQwVxqU0jalSzNuAc7Ic0SDENYYUWPCq43pI6aJ4OAc1fY
         oPfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792639974; x=1793244774; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Un0pCsebAGgOHU5j/UFuxo61lM6ZZUr6aOfHjWXDb9g=;
        b=ILFNfDSyM6EiDFQ/deqT3sLOP+u8Kf3pirxcTPIufbp2jigDWT1sZcctywPjNdvkXR
         /Dm+VtE+h68vpC8fzKbTsEvzY0yy3f6MBX6XoKZFnwgHJ2O0hmACknanzNY3hOQO6KIk
         m12u80mVcCUkshG1kjotWGwOrpgnBnlDpf/3Zd4avAHjjCpYhMMTyt2eYzc08W4MzR5U
         76LNcn2btDkRwul4O18tWfJJBsI02oF6mtgPS9U4FC03JhvfE722a3yl5a3Qo4GKBgSa
         ea6RF0yEdwB3rPZP1qRKqFW8Dd6JZ/xSsUqBZ1c2piBn8Poiu+0z4ifQ5YeO4K7tALqD
         vKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792639974; x=1793244774;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Un0pCsebAGgOHU5j/UFuxo61lM6ZZUr6aOfHjWXDb9g=;
        b=vRzy+dgt3JASFLholhm2fz3fYpnTlQxe2T3u4x6mns8tL2dZrHBjgtOsc+Pr9ccxZs
         S2SEKCkGaWLsOKHdTRHmnEvFvfwGV1X2QXbxGBTZcbRgMDzNOYrimWg9n3MTbm4y6nJr
         l3rtJfQqe0HnC/LYSe3bx0//mfoxS/MCW+zOs2rUI/3LWBdd5tWMuxPpNi0Y12g4ArqS
         9nn9L7PR10vGj+LRZXiwTkmkxKpvGT2WZ3jKCCvyfNKN2PeP8qT9NjjqMetdMXeo5xMz
         7Ez4aVzkhFi0gZYUHn4v76+eqyERl3CIHwJYoD/Vde667ZXUAa9aFexiGr5OPGuHcdpB
         fhtw==
X-Forwarded-Encrypted: i=1; AKwUvBxOBDCnaMycGpyLOb/CbZagtBZ1X1JjnrIoH9/69sKd10cNgoq2Xr71sN+WhjZlpuqaXG52b1w9B1w=@vger.kernel.org
X-Gm-Message-State: AFq9FYIs8mlPwr7IPf7FOyCjN0+f8zR98xKVmAfA3dHJDdOzL/q5utxu
	23KU09bXsDCu5RK/9D0UhVkZxweAs0ZI8CVmEgpcpTID1DFJHR5hjfMzJgXUjGVW0isXwQTrmNZ
	ah3luFI/LqQhDfnk1yCkGZHiAGaG9dAC1AbD6/qEyCg==
X-Gm-Gg: AYBFou1L8IcUkPTQtLWtAQOr1rP4u4hc98eKuxRC+GtMPCykKhxY8f3yRxQPo4u2wUz
	DT/vLTNB+6WR7rqeadX5KvlsZNwlHB7i+YC6VyVdg8mWthaNWaUCIikiq6hd/mYusb9xAv5YnxA
	8X+p086+DhMvMvFQOxa6X/kZGty8/LyyhfbvdBAQBL803HBIuTE2aLnClN/oAdvncx0riZq9qv+
	ySwM/3P0ZDIX2A8+3tAtV6MpvuW8EQI2qUUe/YeuuLRQ35+qGX9qXj2KSe2Ce+JaJtlrK/rdTxR
	6lwkhkvrT6FCndQJMhs2E1CMP1NikhoRbWMJR1cRYGYSIVanT7MuT7R2HB6IMBNMoKIINIa7FSI
	4PSjf50OsJ39mRPMa6eMeRbSLgTuJPwOHoTjrcmoe7QNdFRYrXO67K6WpOx/yhsq+sAnG
X-Received: by 2002:a05:6402:2355:b0:6af:d794:4a8 with SMTP id
 4fb4d7f45d1cf-6b41d595e9cmr1157408a12.12.1792639974111; Wed, 21 Oct 2026
 20:32:54 -0700 (PDT)
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
 <atl7peoVHdP5hz7z@google.com>
In-Reply-To: <atl7peoVHdP5hz7z@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 23:32:17 -0400
X-Gm-Features: AclHuK8_AnwdTvKegXWFQaKFyzs_ctZH_O_1uRYIa-PRh8yAhLXciiK9Gp-4xIE
Message-ID: <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: David Matlack <dmatlack@google.com>
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

On Wed, Oct 21, 2026 at 10:57=E2=80=AFPM David Matlack <dmatlack@google.com=
> wrote:
>
> On 2026-10-21 09:26 PM, Pasha Tatashin wrote:
> > On Wed, Oct 21, 2026 at 7:28=E2=80=AFPM David Matlack <dmatlack@google.=
com> wrote:
> > >
> > > On 2026-10-21 02:50 PM, Pasha Tatashin wrote:
> > > > On Wed, Oct 21, 2026 at 2:47=E2=80=AFPM David Matlack <dmatlack@goo=
gle.com> wrote:
> > > > >
> > > > > On Wed, Oct 21, 2026 at 11:40=E2=80=AFAM <tarunsahu@google.com> w=
rote:
> > > > > >
> > > > > > Pasha Tatashin <pasha.tatashin@soleen.com> writes:
> > > > > >
> > > > > > > On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsah=
u@google.com> wrote:
> > > > > > >>
> > > > > > >> LUO and its file handlers validate handed-over state with mo=
nolithic
> > > > > > >> compatibility strings ("luo-v5", "memfd-v2"). Any change to =
a serialized
> > > > > > >> structure, even an optional additive one, must bump the stri=
ng, which
> > > > > > >> breaks live update between adjacent kernels. Replace the str=
ing in
> > > > > > >> struct luo_ser with a feature header, so that the target ker=
nel can
> > > > > > >> accept or reject the source kernel state per feature.
> > > > > > >>
> > > > > > >> struct luo_feature_hdr is a fixed 128-byte header: the seria=
lized
> > > > > > >
> > > > > > > This patch is all wrong; 128 bytes is far too large. For ever=
y _ser
> > > > > > > struct, we only need 8 bytes instead.
> > > > > >
> > > > > > NOO, It is not. It is intended to avoid complex mess with unnec=
essary
> > > > > > over-engineering.
> > > >
> > > > 128-byte per serialized struct is not starter.
> > > >
> > > > > >
> > > > > > >
> > > > > > > The first 4 bytes are the size, and the next 4 bytes are flag=
s (i.e.,
> > > > > > > 30 feature flags + 2 reserved bits for flags extension). The =
last two
> > > > > > > bits of the flags indicate whether an extended flags field is=
 present.
> > > > > > > Each extended flags field is 8 bytes, and its last two bits i=
ndicate
> > > > > > > that yet another extended flags field follows.
> > > > > >
> > > > > > If we will have dynamic extension of flags, Think about this.
> > > > >
> > > > > To support dynamic extensions in a backward compatible way you wa=
nt
> > > > > something like this:
> > > > >
> > > > > struct luo_feature_hdr {
> > > > >    size
> > > > >    flags
> > > >
> > > > __u32 size
> > > > __u32 flags
> > > >
> > > > >    extensions  // offset of first luo_feature_extensions (or 0)
> > > >
> > > > __u64 extensions[0]  --> but the size should be specificed in
> > > > declaration macro that I showed in the next patch.
> > >
> > > I think you may have misunderstood what I meant. In my proposal,
> > > extensions is an offset to the first extension, not an array of
> > > extensions that immediately follow the header.
> > >
> > > If the extensions immediately follow the header, then the number of
> > > extensions is baked into the struct layout. Every field after them si=
ts
> > > at an offset that depends on how many extensions there are. If we eve=
r
> > > need one more extension, all the fields shift and old and new kernels
> > > can no longer read each other's struct. That is the problem Tarun
> >
> > We can structure it cleanly by nesting the payload: something like
> > struct { struct header {...}h; struct serialize_data { ... }p; };
> > That way, the header can expand dynamically at the front, while all
> > fields inside `serialize_data` stay at fixed offsets relative to the
> > start
> > of the payload.
> >
> > Since the header size is self-describing via continuation bits (e.g.,
> > the last two bits indicating whether another flag word follows), LUO
> > can
> > easily compute where the payload begins in the incoming blob. This
> > keeps the implementation simple, avoids linked lists of offsets.
>
> Oh interesting. I agree a dynamically sized header at the front can work
> and is simpler than a linked list.
>
> So the header and the payload need to be separate, and the payload is
> located with pointer arithmetic on the header. For example:
>
> struct luo_ser_hdr {
>     u32 size;    /* Size of the payload in bytes */
>     u32 flags;    /* Bits [31:30] indicate an extension word follows */
>     /* u64 extension words follow while the continuation bits are set */
> };
>
> /* Size of the header, including any extension words. */
> size_t luo_ser_hdr_size(const struct luo_ser_hdr *hdr);
>
> static inline void *luo_ser_payload(const struct luo_ser_hdr *hdr)
> {
>     return (void *)hdr + luo_ser_hdr_size(hdr);
> }
>
> On preserve:
>
>     hdr =3D kho_alloc_preserve(luo_ser_hdr_size_for(nr_ext) + sizeof(*ser=
));
>     luo_ser_hdr_init(hdr, sizeof(*ser), ...);
>     ser =3D luo_ser_payload(hdr);
>     ...
>     args->serialized_data =3D virt_to_phys(hdr);
>
> On retrieve:
>
>     hdr =3D phys_to_virt(args->serialized_data);
>     err =3D luo_ser_hdr_validate(hdr, ...);
>     if (err)
>         return err;
>
>     ser =3D luo_ser_payload(hdr);
>
> What would size mean in luo_ser_hdr? The size of the payload or the size
> of the combined luo_ser_hdr + payload. luo_ser_hdr is self describing so
> maybe it's just the size of the payload?

> What would size mean in luo_ser_hdr? The size of the payload or the size
> of the combined luo_ser_hdr + payload. luo_ser_hdr is self describing so
> maybe it's just the size of the payload?

Either works, but having size cover the combined hdr + payload
provides a few extra guarantees:

1. A single static_assert validates the entire serialized struct at
compile time, including the header and the number of ext_flags
elements.
2. Bounds checking while traversing the header continuation bits on
retrieve: we can sanity-check that luo_ser_hdr_size(hdr) <=3D hdr->size
so we never walk past the end of the serialized blob if there is
memory corruption.

If we declare the payload struct separately and pass it into the
macro, handlers also get a clean type for luo_ser_payload(hdr):

#define DECLARE_LUO_SER(name, expected_size, ext_flags_count, payload_type)=
 \
    struct name {                                                          =
 \
        __u32 size;                                                        =
 \
        __u32 flags;                                                       =
 \
        __u64 ext_flags[ext_flags_count];                                  =
 \
        payload_type payload;                                              =
 \
    };                                                                     =
 \
    static_assert(sizeof(struct name) =3D=3D (expected_size),              =
     \
                  "LUO struct " #name " size mismatch!")

For example:

struct luo_memfd_payload {
    __u64 pos;
    __u64 size;
};

DECLARE_LUO_SER(luo_memfd_ser, 24, 0, struct luo_memfd_payload);
