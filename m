Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792691482;
	b=wYlK7tE9e51T9Nj84MuxOrBrAWPZL+jdErt/3zjiGcEuvJL2Ig9X1UtY0ZE7lHp2+ByQ
	 m1o3DLkdq3OGz03oQ+2KPoW5cEmv36fR2GudHtvYM9+vEniPfsa6SveeedMUa4nqnwn9M
	 Ba7Esv1HOR4uyPjTtfejWxO7BLP71/6OVkNyv/q2zIl2K6LnQ2Q0YimEn4YP3imG5blgT
	 CbwJdVfKgJhOUcoAkjiJpfJ81L83M3oaAir8On+6tQoF2I9YycEAexqXqX+ofL/EB8P5Y
	 UzozgLIel11gTf2KOWSn11lxWvTHGopL5mNPw7EfkGDTvh6tP1oEwTjwCHBCabcXOFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=VXuE27163XQs95Y17MHXQoRtZevE9c0I3KUjJaU7M5M=;
	b=cDxuUbnqK38RMwSneeMyIRpTjt2/B2N68bO0EF0TQpohsVOgug4Lg4i3aRuSM+vM5Q25
	 2QxO+uJgtmumb5X//7KX3YTg9dhBo2JOjx+gTutS5hv25uJXpMW83qJbjWiregb+ApVmi
	 NDr+gry7KXJROT3Kjw4rfSA5+WB9kaEyBpvgkKdHuIgEGJBrtuJvjs2xUAmRA1YR3wVeZ
	 /oA2i1haejSlaiRovXTFWLvtgcJFv/ijxN4vat3SkU+o+4fWa1D0MH3zFOisneVHlhkdB
	 3V2zqCs6HneCax3BOfhmWH/ov3fReT+44TK4mTJGIIxOMLNyC4fyxfZhEbRVq3n1g+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=p1qG8FoI;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2346606A320
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 17:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2346606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=p1qG8FoI
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e60f9af6e6so4925ad.3
        for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 10:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792691481; x=1793296281; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VXuE27163XQs95Y17MHXQoRtZevE9c0I3KUjJaU7M5M=;
        b=p1qG8FoI+FjuKYeesNRnsPhbCfDhwml/usg+eoDHGMWDq5c9L7RoQnXbQ5ygdFeImB
         Y96eZVBRy7Flrobq9DvnlMx/EAyJVDf7WJctSTtuGbVgjeFDs2m6RTwwiSPC0LmBVkCm
         q//xVinr9gtMZoWgq1NQIFL0uzwGwE/V24ZLVIW8G1yhe/wB+Gcnn5u1YQQUqbWmIrjh
         Uo02TstCIh822E+953yQvTfk319ia9ovb46tiV339HlH+uBjMURBgFgL/5fgKJcJtArW
         4bmKBPvuelgC1wdGuPmxiJnVYPGFeU5HOJmaXzqnY4h30wYbHVrjjVQ7NqnCfBG7oXxH
         1g2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792691481; x=1793296281;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VXuE27163XQs95Y17MHXQoRtZevE9c0I3KUjJaU7M5M=;
        b=UY56tGXHtJvKr9R0X2/whY3gB4p1Cow6NDCAl+nAXP2gBEoBeZJvWYWTRXQsUrIgk2
         9tkg2VpObsgvvboF/0UPfG4fwVb6k38lqBQRhfA4k4i4Umip8nOoY1tgaA66gK6TYp/L
         SvJQ+EALBXxD2GaZklYysJ5uD5HieSGP72lfBIQebkkSCyafL+QdLJN4MGacXtBAc5jD
         MKKao9Sv1IL3+omXQ4VOxp76caGwB7NvMmhWVZe3zkEUfuVumOP6/WsElaW8rjvb54oU
         RDhRIR2sbC5RXER1UJlaI5jakJ7YXjsVDB4DjJr9pGCntNs+JcN1SQfpLSkxdEVOiDfo
         B1Uw==
X-Forwarded-Encrypted: i=1; AKwUvBwFjXpKbjazBqOh7Bq7YXY+YxZEuTLrY7ailAqbItpCQ3bjo6X21S++PMqPY7anzRD1Vmg/lDn2iAo=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1on5WjHQtTNc4zSb1Uosx+6Ql3Eou0PeOEVfraRd0YwrR/2YW
	Su65A1hPMWTpTiJ/k9gk9cghW3p6hZ3qtAlSStEvmxWyY2WHeNOU94DNBGZFJzkqlA==
X-Gm-Gg: AYBFou38qDM8OkWKZ4HvYLQ3J9DT/OC1ElmmB3yl/QOHjnKRi/77K+5jVPWUpHRK414
	RrLit18d3KS+lyF0YyvLPfgKQDlohTAXNHMVGZ8NO0t08ESwVaiN8ClNCraXmyiJupKxB/a97XM
	EDwaPBL4CHyLpP5lz/RlXTf/F5Fn7YD6RRRB38OgdHAD1GkmOwv2cp9pUOELlTm3CPfh2Ew33Hu
	Y6ULItlpYyOz3WnJj2Q0IiD5+7lDW40wj1k8VP/+XyYS3+lqFWiBWIoSyCusHnMaatAbw0Ga3Uf
	bs4G1sGVhqMRLbgtIdP4sUZKT3tJFU7T4MhfgDDM5ZF7A2Tmw7jIvLS5S7nau24Y8bBBPmEwooG
	vTNQ+1OouyilMUte8bWMGnVPfARXvWFz+vudXvQfrQpZq9PgXAPfxH0iL3dCC1ymxgqU7JkOCGH
	fgf3ARHEjYCwepDoQDmexDukNSYU6Hhq90kexQHSle6y4pXEmUrc0J1r5VdGK7KT0nU9KvUyXYy
	fStHP5v4ZH3qSzDiZlrEc520bZWzbYtwVLtEh31aZtZ6MrTcy/2Fw9Rzu7S1T7N5lyNp8eZLcrI
	6qsYwQtOqwE/FKTI
X-Received: by 2002:a17:902:e547:b0:2e9:502a:ddbb with SMTP id d9443c01a7336-2ea43c9f6bcmr53298445ad.45.1792691480085;
        Thu, 22 Oct 2026 10:51:20 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea7b346c43sm1644745ad.13.2026.10.22.10.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 10:51:19 -0700 (PDT)
Date: Thu, 22 Oct 2026 17:51:16 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: tarunsahu@google.com, Andrew Morton <akpm@linux-foundation.org>,
	joro@8bytes.org, Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de,
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com,
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org,
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com,
	will@kernel.org, Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
Message-ID: <atpNFEFIlqAoYIwH@google.com>
References: <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com>
 <9huzecdi6go0.fsf@tarunix.c.googlers.com>
 <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
 <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com>
 <atlKsD-aJB3mJr2j@google.com>
 <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
 <atl7peoVHdP5hz7z@google.com>
 <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>

On 2026-10-22 12:11 AM, Pasha Tatashin wrote:
> On Wed, Oct 21, 2026 at 11:53 PM David Matlack <dmatlack@google.com> wrote:

> > > #define DECLARE_LUO_SER(name, expected_size, ext_flags_count, payload_type) \
> > >     struct name {                                                           \
> > >         __u32 size;                                                         \
> > >         __u32 flags;                                                        \
> > >         __u64 ext_flags[ext_flags_count];                                   \
> > >         payload_type payload;                                               \
> > >     };                                                                      \
> > >     static_assert(sizeof(struct name) == (expected_size),                   \
> > >                   "LUO struct " #name " size mismatch!")
> > >
> > > For example:
> > >
> > > struct luo_memfd_payload {
> > >     __u64 pos;
> > >     __u64 size;
> > > };
> > >
> > > DECLARE_LUO_SER(luo_memfd_ser, 24, 0, struct luo_memfd_payload);
> >
> > This looks pretty reasonable but I would name the payload
> > luo_memfd_ser. The combined struct that DECLARE_LUO_SER() creates
> > should never be used directly since the offset of the payload in that
> > struct is only valid in the current kernel. So I would give that
> > struct a special name that makes it obvious you shouldn't be using it.
> 
> Lets drop the fourth macro argument and generate the combined struct name:
> 
> #define DECLARE_LUO_SER(name, expected_size, ext_flags_count)              \
>     struct name##_hdr {                                                    \
>         __u32 size;                                                        \
>         __u32 flags;                                                       \
>         __u64 ext_flags[ext_flags_count];                                  \
>         struct name payload;                                               \
>     };                                                                     \
>     static_assert(sizeof(struct name##_hdr) == (expected_size),            \
>                   "LUO struct " #name " size mismatch!")
> 
> For example:
> 
> struct luo_memfd_ser {
>     __u64 pos;
>     __u64 size;
> };
> 
> DECLARE_LUO_SER_HDR(luo_memfd_ser, 24, 0);

I think we are getting close, bu I have two remaining concerns:

 * Reserving bits in each flags word for continuation leaves gaps
   in the flag space that users have to know to skip.

 * struct name##_hdr only matches structs written by the current kernel
   (in terms of length of array and offset of payload).

How about this instead:

struct luo_ser_hdr {
    __u32 size;        /* Size of header + payload in bytes */
    __u32 nr_flags;    /* Number of features encoded in flags[] */
    __u64 flags[];
};

Each feature occupies 2 bits of flags[], so feature N is always bits
[2N+1:2N] of flags[N / 32], with no gaps:

  00: Feature not present
  01: Feature present, safe to ignore if not supported
  11: Feature present, must be supported by the next kernel
  10: Invalid

The length of flags[] and the header size are computed directly rather
than by walking continuation bits:

static inline u32 luo_ser_nr_flag_words(const struct luo_ser_hdr *hdr)
{
    return DIV_ROUND_UP(hdr->nr_flags, 32);
}

static inline size_t luo_ser_hdr_size(const struct luo_ser_hdr *hdr)
{
    return struct_size(hdr, flags, luo_ser_nr_flag_words(hdr));
}

static inline void *luo_ser_payload(const struct luo_ser_hdr *hdr)
{
    return (void *)hdr + luo_ser_hdr_size(hdr);
}

and bounds checking is just luo_ser_hdr_size(hdr) <= hdr->size. The
payload is always 8-byte aligned.

Payload structs are then declared on their own, with no header:

struct luo_memfd_ser {
    __u64 pos;
    __u64 size;
};
LUO_SER_ASSERT_SIZE(luo_memfd_ser, 16);

The static_assert covers the payload to catch embedded structs changing
size.  Asserting the header doesn't add anything since its size varies
by kernel. And because flags[] is a flexible array, the header can't be
embedded in front of a payload in a combined struct; it can only be
reached through luo_ser_payload().

I think the only downside is that the header increases to 16-bytes when
there is at least 1 flag. But I don't think we need to be so concerned
about an 8 byte difference...
