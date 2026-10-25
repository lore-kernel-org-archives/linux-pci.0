Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792960747;
	b=sjoaUHwxG3Ha0TdGCcmcmx4lfXqJ/33J4Tf+4CnkFYavLfmXLFKTsdpUe9ztEgjEjPos
	 3dnGJTU9gp2hb0RGBaHfPkZ7O4Qv0lb26nI1jXSQ1XoxWuqZGYjtHvt34C3vJOW2wpiR8
	 jBPCkpe0lqI1hhexW1T3SkcVI0PR+evsNTz9dtLvG6Xh6Dkm9uCRiY1N2e76zFVm4p8ee
	 lArrRhJqvsEGCqYAcBcQhlGX5DFFaKT1m0ofwnLmutRgEsJ5jTnvH2MqosoHY8HBMRi5Z
	 LxdJz8uRtPLb/o7JE8LhzpmsjIMEgzZBwvIywRl6q8UxlPqz6nO7klQsK7yHRHuP/zw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792960747;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rp5Fden8a6neVzulsysbnvEXD4vRCF1NzLSbVrqKH4E=;
	b=3drh2AS0bENwK7vIb64qg9mg8Fn/ejTQd0A87eBHZbs3xm0yeB+rhvDM9iKY8gvNCcyR
	 VlqTOGjWzojmNUlsXn8SfgcXyLv6aHSPctefO3FYsG2NWVBCu2fwdCFWTmGdB82S3Kgci
	 0EVRXI9MiV490cxOmk26Yrgn3pHPvZa0o4DSWmtd4EDAGgBgqTRCVDbeoaI0FwKJYM5hw
	 ZVv4MGue7lkLlyAIws1xvtfSvWixt6dEfUYA5Y5hkzoCn5I1mUyn+xfYwcEAsHHL5TuVc
	 2AjMOAb2OzBxKbWnVmLnxtHgGnBxARASWIoFXLavLxJggcpg4rlOn5A8RRvrKnpNHUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b="DV/IgpGJ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CF8606A31D
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 20:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41CF8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=DV/IgpGJ
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso3775328a12.3
        for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 13:39:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792960740; cv=none;
        d=google.com; s=arc-20260327;
        b=QfmGufOFfltI9hHvIr5qhudhYF0SIg+L3iRMSxB9ba8VXQan4umOsyBfvQWTT4Sj9l
         j/bZ7YP5VccjTZ5yM/FqPB5s7zjZfjqAPIQjm9qiBItTwx7oj8PlEPxpgoeYE0myBCyp
         ygSjKdnP7Y7aBIArbLVVdmCWPV5C2Bj/qIILdy7te2QLP55HHxqe+E+lVeA8RKZJXeJ/
         bcZjMKZNjAzmf6dPfkXbC3dkLo3QxTVlDhls1E+gGgpAkZ1IVBQNSQj6evnjyZ+fcHgy
         Yz5jeBngdcMSo89pSb3yyyHtMFluIJQFhUc7/8pGj4XMGa5/Z5N+/O2M9RqUKiv1MY79
         X5pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rp5Fden8a6neVzulsysbnvEXD4vRCF1NzLSbVrqKH4E=;
        fh=DQl0fhDXlObd9i5yQsTOn65C7dMi7OIDxoNCGGJMz7U=;
        b=Aai1cBdIKI4PPAZEsTXflQuSovPOTIGBlXw0hlJbXeZAc1GjIkd19P4uWjEpmTLWdv
         dn1SIHallKzP0QxdAnVsNqAd5hL4nRgF7tHyYlk2Gl4LCT86okqja+tmHbxp4WKvhAqy
         xqrrhOqQWQ1E+lPMW1ShKJFvDTYphl/c8KPxcxkh3Z+RkmuaezrnZ0pgTEE6IPswXUDe
         l0tht90EZtSN52WnZb1TsNcoJRqUXU0UOj/KBsKaiKQccaQ434QkXFPI0wSDdWg3wm9f
         GJnpMPP0Yf+774oWNnzX/XcxOgvvjpkbuPbZwgwaQKT1bR04KNhE1KXnqJJRrcE2MV3j
         nXNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792960740; x=1793565540; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rp5Fden8a6neVzulsysbnvEXD4vRCF1NzLSbVrqKH4E=;
        b=DV/IgpGJYzHRXuQDz7DQM0HJY1y2UrWNoj0k9X7vIPdFhTzYbG2hBmzcVoIVY2rS9p
         NRs++i25KutZdEuCIAHKRbFKGEPBoSjokCvm08oMI3dF54EWKUpwXkAFFzWufQVPOsA+
         Gtzn4u8LSb4Fyrciu2eYaaDF1hjmKE0IoXlwpgptO1gt/8O+qxvWxkOIloKbw/bwrMTh
         4pDHCTEIr5/B+DddD3Mdiiu6NgkrFH1jIcgPur2TUw4F6knSq50Qdjy08mHwVUwvH8pH
         KfG5oA5zgGEOmHdXHrATFd2caZEt+SauSD57pYnn8BwZhbAxA0eC5Sr8CrRMjnKrM/LF
         txUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792960740; x=1793565540;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rp5Fden8a6neVzulsysbnvEXD4vRCF1NzLSbVrqKH4E=;
        b=RXoWQYbi8vbg4lc1J62EAjmfKMAJ0+MM27gpX2fd91NmXHYcrVf2MJj0PbSLKKH/GY
         cSCTIni/wd+XYt+bFX1O1+iE4to4oaZ/Llf6Wl2jk8kEQpLGGJJo+E8SufAMioESoo6n
         2mBVl/qiOgR6ED7d9JH0X9+BFubr3EN0rBPNMyqA8AKIO30i46cqsXGN+azIG18ijpuY
         Qlj9D9BLY5/m+SkFogyEUK2rIANKC/YJLEvxHgoYxwzLY645HZd0DesPaSIEqdd2O9Kd
         P9yutsGKVs1Uo362v4dt/GxgtWwxhXKq7Bjqpy6yYU0D8DB7V/pZ2wW/OGyBvG5OedUa
         5lzQ==
X-Forwarded-Encrypted: i=1; AKwUvBy31/oLWxGFm9vBPnNBQfWM58uPZD0j71kKETeC3yvt91icELl8jLlavKKALbexP6n6gRIfqApF12c=@vger.kernel.org
X-Gm-Message-State: AFq9FYI0SPgIBY3mjKJgQCzKPx/YVW171c2hEMMU91Z+Aqu7lfQHSAtS
	XIcMp1wX/B3at/Nkzw2kVmtXjaX8RTmQ7gBgx+cqXraxpqhKz0A1ACKt7ylkvLmUu40jiB2ymuL
	Ei8itF80KAt5DV07NOqx7AdfD2hyQ9h1n5t1ggSdBWw==
X-Gm-Gg: AYBFou0mpakW89jTqHf4g1bFqEz8D4J7zTLHRsBq7hoc+ezA6g3k80kM7a8ctki7nEU
	OPufA3strimEfTJXXzbZxvyfxPRTunCp09nPvJ8c4dMdtgEt8VMCk4pst4brX9ngek+NW8M4LKW
	RzcaLruf4DuOhVGjk27ErAwTG7vZ8Q/sanhUw0I32ROFZwtBdQzPtjmvsEI4uxh4g9O0w+38Gvu
	w9KjZdzIgmcJhEe9dmACFI839HDqG1k2U217grtjpIM1jx91s8cnu4v1ZEZYd+iBNj7Wvo0DF/Q
	m49sjcZtL3MFik9DSNd1JiWoYiilRQzfeCXDF9uysrn1JTCOaodO7Pc0fNgoEkIdE14r1rciRAI
	mu+FPS9iFm7mIlmCfiM/G7pkn7/hyXgtJ2RdrFDSgff+wjDM96gd8bWdzhWv/3mnV3jyS
X-Received: by 2002:aa7:dd0f:0:b0:6b2:2339:370d with SMTP id
 4fb4d7f45d1cf-6b443000b00mr4543991a12.39.1792960740017; Sun, 25 Oct 2026
 13:39:00 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
 <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com>
 <atlKsD-aJB3mJr2j@google.com> <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
 <atl7peoVHdP5hz7z@google.com> <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
 <atpNFEFIlqAoYIwH@google.com> <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
 <attmFVIFU_mS0Y7p@google.com>
In-Reply-To: <attmFVIFU_mS0Y7p@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 25 Oct 2026 16:38:23 -0400
X-Gm-Features: AclHuK80OiwlBnY6tUr3jZ6atHcY2MdRSOFYk5-Bhewn5rIfzUZ_oGQw-LNyjus
Message-ID: <CA+CK2bDXDWbww_d3sD6OZqpo37V1a3t76_ubbrXLQS=9DB3dWA@mail.gmail.com>
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

On Fri, Oct 23, 2026 at 9:50=E2=80=AFAM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-10-22 04:53 PM, Pasha Tatashin wrote:
> > On Thu, Oct 22, 2026 at 1:51=E2=80=AFPM David Matlack <dmatlack@google.=
com> wrote:
> > > On 2026-10-22 12:11 AM, Pasha Tatashin wrote:
>
> > > > Lets drop the fourth macro argument and generate the combined struc=
t name:
> > > >
> > > > #define DECLARE_LUO_SER(name, expected_size, ext_flags_count)      =
        \
> > > >     struct name##_hdr {                                            =
        \
> > > >         __u32 size;                                                =
        \
> > > >         __u32 flags;                                               =
        \
> > > >         __u64 ext_flags[ext_flags_count];                          =
        \
> > > >         struct name payload;                                       =
        \
> > > >     };                                                             =
        \
> > > >     static_assert(sizeof(struct name##_hdr) =3D=3D (expected_size),=
            \
> > > >                   "LUO struct " #name " size mismatch!")
> > > >
> > > > For example:
> > > >
> > > > struct luo_memfd_ser {
> > > >     __u64 pos;
> > > >     __u64 size;
> > > > };
> > > >
> > > > DECLARE_LUO_SER_HDR(luo_memfd_ser, 24, 0);
> > >
> > > I think we are getting close, bu I have two remaining concerns:
> > >
> > >  * Reserving bits in each flags word for continuation leaves gaps
> > >    in the flag space that users have to know to skip.
> >
> > Yes, but callers should never manipulate the raw flag words directly,
> > and we can provide simple accessor macros or inlines that take a
> > contiguous feature ID (0, 1, 2, ...)
> >
> > enum luo_memfd_feats {
> >     LUO_MEMFD_FEAT_HUGETLB =3D 0,
> >     LUO_MEMFD_FEAT_SEALS   =3D 1,
> >     /* ... */
> >     LUO_MEMFD_FEAT_FOO     =3D 15, /* Automatically lands in
> > ext_flags[0] bits 0:1 */
> >     LUO_MEMFD_NR_FEATS
> > };
> >
> > if (luo_ser_get_feat(hdr, LUO_MEMFD_FEAT_HUGETLB)) {
> >     /* handle hugetlb */
> > }
>
> Sure but why deal with all the complexity just to save 8 bytes? All of
> these structs are allocated on folios and there are kilobytes of unused
> space to fit this header. And even if we optimize that we are talking
> about 8 bytes per FH/FLB... or 16 bytes for structs with arch-specific
> sub-structs like the KVM ones.

The reason I care about keeping the header compact is that we are
defining a foundational kernel ABI and want to use this header across
almost every serialized data structure so we can evolve them later
without breaking compatibility. While some top-level structs are on
sparse folios today, other serialized structs are tightly packed, and
we are looking to add KHO slab support in the future where tightly
packed allocations will be common.

That said, in your proposal, as long as nr_flags =3D=3D 0 is allowed when
a struct has no feature flags yet, luo_ser_hdr_size(hdr) is already 8
bytes and only grows to 16 bytes on the first feature flag. I am OK
with that.

> > >  * struct name##_hdr only matches structs written by the current kern=
el
> > >    (in terms of length of array and offset of payload).
> >
> > This is not an issue on the incoming path, we never cast incoming data
> > to struct name##_hdr or access ->payload directly. Instead, we parse
> > the incoming buffer, dynamically compute the header size from the
> > continuation bits, and cast the payload offset to "struct name *"
> > based on the negotiated feature flags.
>
> How?
>
> This is the only data structure that describes the header. Are you
> saying the incoming path will parse the header purely with a void *? Or
> use this header but just be careful not to access payload?
>
> We should have one header structure that can be used on the incoming and
> outgoing path. We should not have one header data structure that can be
> used on the outgoing path and one that can be used on the incoming
> path.
>
> Also we need a standard header that can be shared across all structs,
> not a per struct header. Otherwise you will need to do weird casting and
> overlays to implement the shared helper routines that parse it.

Having DECLARE_KHO_SER_WRAP() in include/linux/kho/abi/ makes it
immediately clear just by looking at kho/abi/ which serialized structs
have the versioned header and which do not, while also enforcing the
header when preserving and static-asserting the combined struct size a
compile time.

So with your header (and let's use KHO as we want to version KHO
structs as well):

struct kho_ser_hdr {
        __u32 size;        /* Size of header + payload in bytes */
        __u32 nr_flags;    /* Number of features encoded in flags[] */
        __u64 flags[];
};

The wrapped struct will look like:

#define DECLARE_KHO_SER_WRAP(name, expected_size, nr_feats)                =
\
        struct name##_wrap {                                               =
\
                __u32 size;                                                =
    \
                __u32 nr_flags;                                            =
    \
                __u64 flags[DIV_ROUND_UP(nr_feats, 32)];                   =
    \
                struct name payload;                                       =
    \
        };                                                                 =
\
        static_assert(sizeof(struct name##_wrap) =3D=3D (expected_size),   =
    \
                "struct " #name " size mismatch!")

On the incoming kernel we don't use struct name##_wrap, but we use
struct kho_ser_hdr for the wrapped data, validate the flags, and
unwrap it via kho_ser_payload(hdr) to get back the struct name *
payload type.

Pasha
