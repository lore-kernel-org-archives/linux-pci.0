Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792763419;
	b=ZD90letnJ39kGUkoGmQh1O1CBlyFK2tAy0zG0wBTwPjezp8vNE3Sxdyx48VfLtmpknpi
	 085WSCd23Jxir4zDinJ3moEnMgBOyllNkpfMc/deYbHvR3GZmywxjDV22jOhQf3NfVXpl
	 9aKO6hC28+G8rJ2zQYpKlEQAkXt0ha9Y9f9h3O/QrOxg1S+SK19a6vzm60VAVb4SeJpeO
	 6xO7kL9Vs62N8HMKOwgGyISdLeGUNHzDtiJKfz9js5/Ia38OGkEkA3wUseG0Mbf16IJvC
	 8o/HSgfQCPDT1HKvMFQxehPSKzW3I9e/tiP8puIDRvw2ldQqc9R4ydG9s7qAp8fmf1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792763419;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=8FyuJnnll3uJwbR+wT99CVBO9fzREsmjzeqnUECMRTY=;
	b=c9uLiNVab7tKppFjA2Rco9qP13Q3VKVZc1t7tpsNS3e0rCdDfPg/13wUxHqZDyUCzA0c
	 E4UEzR6s2oxnKbshlrvXwbS29+W6WwoRgIJOnIXK1PuOAjIiHUbQJN9vvSID4eBPjLHv4
	 CRhSpBAgI5Vvrepbod2kETkACioqojThphgaW8j1v2Uhi27DmiX3A4yTxPGyDmAhuxAg9
	 QHHGcu1M8cFeGg2wtsdUjAio0gZGwPyZlK2WNNRfyHmeCSkNqMikf/uJeqyNF/ntmC8H7
	 WMuXjDbr1LLvcrKdqFZH5uLDIuFY/Ay8dpN4Wm3QHoHToasGt62aapwbmYC984TVAmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=tePYhySp;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069A1606A31E
	for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2026 13:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 069A1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=tePYhySp
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc1d57602e8so368698a12.3
        for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2026 06:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792763418; x=1793368218; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8FyuJnnll3uJwbR+wT99CVBO9fzREsmjzeqnUECMRTY=;
        b=tePYhySpUVOPmNC7qMFCyUKUchitL2PPRJngdPKMZb+6YMlbzUwgcreLJ2yA42AZnA
         v8cLSMIlGA3u4RIUYVaES5a8/BGQAUiCR1RaqgsSgZkWKdBE/ZcATVE5Tll8cS9l1X0y
         jUG+yVquGbWgcvm/8MxxycOg/mddw+0l+MplyEJOYfUmLmzlCXrzhSBgacFZkAq8wkob
         Pj6RrEf69ya9zTjuBsqnaaINqezSaQsmRkyRLV8jGDNSGGxqoJhr6jeq4my7fpYC7dyj
         qOmm9rddJ6UF9PtTp9Nx897N1k7lGSJXyujgP0EVLYI9Voi13+8/ttJ+pRcICMcmmMTc
         3lJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792763418; x=1793368218;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8FyuJnnll3uJwbR+wT99CVBO9fzREsmjzeqnUECMRTY=;
        b=DmsWhPBw+2/xZrF3U+QYwt87Fqii9NjGXkgNonqkzV45SLV4Ob5MKa9jM1G+3Dhffa
         bL3QQmeNd6NyQQyIwYFQJfvTcZIgA4bg86JeSACXvFzHWCcyooe/usWwMSAM01COwiIP
         Lv+Ek4EA+wxCp6jNz21ruw3TPeQoGR02nU8jcTWyCe6E2JgH/TdFexoot6XRehifG1rp
         neujccMHnY0guNvSanC9cZe7JM5BEKyQGL4P/D25PC/vcgR+zJlj8Muj6a2BamYutbql
         d4vHR/G9yTYfirLt90mkI+pnd8ZdmH43ID+goUvlmsvVn0RKY8cK335bMC0HUsOdaBg+
         QJ5A==
X-Forwarded-Encrypted: i=1; AKwUvBz48Pn+dcZgnfy7S99E81HXw3DYQ7B0AcIy6DssrmbdIKjyS5pNpecGkBpo6KAepqxqNOUXQYMNR1M=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAIahd8xirX39aDDs31VI5FhImdAUQNxd7QcGeN8hLONr/LTTd
	rsw5wJt8IkD8XnLZLzERwbr9dG1qSAh75VkqMQ0PTfFRomIZt1aQOBh+wVcvf0XyAg==
X-Gm-Gg: AYBFou0qynv8mdfwfU3bjRWnRSe20jI0T6IuUvEJKKf8e4lAeNlmdNrH8lfGxAn2uS/
	12qomFtwO3WFJi2yKbH2eUJC1VxZnTdMr9WFSYlTTMeB+vivnOeURZAjuD+vgj9Zd3igYroz5Ab
	JgcpeF0+vVk2UGnJcTJLkz5mU/+mFuz5Ni3PXKRLoI6nILpXAvham/x3Eai8nbzGKJKhnoi1SB9
	iBAG2MKCNLYiW+Sv7wl6W19Y+ys6b20hFC6YRQq42FysAYYkgpGlPZgOiFWg5WhlvaDbctfhm8h
	IaAB/Zip6NFiQEisvIkKOjxJOrw3ZXjJkOQFXGKcb41tz7XPIA17Zd9v4ubdFcGsUoIgFk1nk8p
	DErIczZ9WIBEwhKKVLqQgKOTSEiVtYp5HO5Ib0/sPi+5DQUSkGQbZSb5yz9PDYK0sKzeVr4EI2x
	ujeLRA4Wkv28W2W2+j9tARLtc8EeA0ij19+rR8vE6EuW1KmLYe0KwSUVwoluYHXxNtgojlTQYPj
	z83jT4U0Y5JjOOEiXJJCTZnVf2lLYC5UrK8W+8v/2Td2zWP02riCGMOsbr2rcEakTPAqQqtlAz8
	dcE/HZtMbhZ+6U09BV65S/vnOMNsyJfpbpNo6w==
X-Received: by 2002:a17:90b:5906:b0:3ab:3437:554f with SMTP id 98e67ed59e1d1-3adce0073a2mr1983207a91.29.1792763417701;
        Fri, 23 Oct 2026 06:50:17 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea94677c91sm545015ad.4.2026.10.23.06.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:50:16 -0700 (PDT)
Date: Fri, 23 Oct 2026 13:50:13 +0000
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
Message-ID: <attmFVIFU_mS0Y7p@google.com>
References: <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
 <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com>
 <atlKsD-aJB3mJr2j@google.com>
 <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
 <atl7peoVHdP5hz7z@google.com>
 <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
 <atpNFEFIlqAoYIwH@google.com>
 <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
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
In-Reply-To: <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>

On 2026-10-22 04:53 PM, Pasha Tatashin wrote:
> On Thu, Oct 22, 2026 at 1:51 PM David Matlack <dmatlack@google.com> wrote:
> > On 2026-10-22 12:11 AM, Pasha Tatashin wrote:

> > > Lets drop the fourth macro argument and generate the combined struct name:
> > >
> > > #define DECLARE_LUO_SER(name, expected_size, ext_flags_count)              \
> > >     struct name##_hdr {                                                    \
> > >         __u32 size;                                                        \
> > >         __u32 flags;                                                       \
> > >         __u64 ext_flags[ext_flags_count];                                  \
> > >         struct name payload;                                               \
> > >     };                                                                     \
> > >     static_assert(sizeof(struct name##_hdr) == (expected_size),            \
> > >                   "LUO struct " #name " size mismatch!")
> > >
> > > For example:
> > >
> > > struct luo_memfd_ser {
> > >     __u64 pos;
> > >     __u64 size;
> > > };
> > >
> > > DECLARE_LUO_SER_HDR(luo_memfd_ser, 24, 0);
> >
> > I think we are getting close, bu I have two remaining concerns:
> >
> >  * Reserving bits in each flags word for continuation leaves gaps
> >    in the flag space that users have to know to skip.
> 
> Yes, but callers should never manipulate the raw flag words directly,
> and we can provide simple accessor macros or inlines that take a
> contiguous feature ID (0, 1, 2, ...)
> 
> enum luo_memfd_feats {
>     LUO_MEMFD_FEAT_HUGETLB = 0,
>     LUO_MEMFD_FEAT_SEALS   = 1,
>     /* ... */
>     LUO_MEMFD_FEAT_FOO     = 15, /* Automatically lands in
> ext_flags[0] bits 0:1 */
>     LUO_MEMFD_NR_FEATS
> };
> 
> if (luo_ser_get_feat(hdr, LUO_MEMFD_FEAT_HUGETLB)) {
>     /* handle hugetlb */
> }

Sure but why deal with all the complexity just to save 8 bytes? All of
these structs are allocated on folios and there are kilobytes of unused
space to fit this header. And even if we optimize that we are talking
about 8 bytes per FH/FLB... or 16 bytes for structs with arch-specific
sub-structs like the KVM ones.

> >  * struct name##_hdr only matches structs written by the current kernel
> >    (in terms of length of array and offset of payload).
> 
> This is not an issue on the incoming path, we never cast incoming data
> to struct name##_hdr or access ->payload directly. Instead, we parse
> the incoming buffer, dynamically compute the header size from the
> continuation bits, and cast the payload offset to "struct name *"
> based on the negotiated feature flags.

How?

This is the only data structure that describes the header. Are you
saying the incoming path will parse the header purely with a void *? Or
use this header but just be careful not to access payload?

We should have one header structure that can be used on the incoming and
outgoing path. We should not have one header data structure that can be
used on the outgoing path and one that can be used on the incoming
path.

Also we need a standard header that can be shared across all structs,
not a per struct header. Otherwise you will need to do weird casting and
overlays to implement the shared helper routines that parse it.

> > How about this instead:
> >
> > struct luo_ser_hdr {
> >     __u32 size;        /* Size of header + payload in bytes */
> >     __u32 nr_flags;    /* Number of features encoded in flags[] */
> >     __u64 flags[];
> > };
> >
> > Each feature occupies 2 bits of flags[], so feature N is always bits
> > [2N+1:2N] of flags[N / 32], with no gaps:
> >
> >   00: Feature not present
> >   01: Feature present, safe to ignore if not supported
> >   11: Feature present, must be supported by the next kernel
> >   10: Invalid
> >
> > The length of flags[] and the header size are computed directly rather
> > than by walking continuation bits:
> >
> > static inline u32 luo_ser_nr_flag_words(const struct luo_ser_hdr *hdr)
> > {
> >     return DIV_ROUND_UP(hdr->nr_flags, 32);
> > }
> >
> > static inline size_t luo_ser_hdr_size(const struct luo_ser_hdr *hdr)
> > {
> >     return struct_size(hdr, flags, luo_ser_nr_flag_words(hdr));
> > }
> >
> > static inline void *luo_ser_payload(const struct luo_ser_hdr *hdr)
> > {
> >     return (void *)hdr + luo_ser_hdr_size(hdr);
> > }
> >
> > and bounds checking is just luo_ser_hdr_size(hdr) <= hdr->size. The
> > payload is always 8-byte aligned.
> >
> > Payload structs are then declared on their own, with no header:
> >
> > struct luo_memfd_ser {
> >     __u64 pos;
> >     __u64 size;
> > };
> > LUO_SER_ASSERT_SIZE(luo_memfd_ser, 16);
> >
> > The static_assert covers the payload to catch embedded structs changing
> > size.  Asserting the header doesn't add anything since its size varies
> > by kernel. And because flags[] is a flexible array, the header can't be
> > embedded in front of a payload in a combined struct; it can only be
> > reached through luo_ser_payload().
> >
> > I think the only downside is that the header increases to 16-bytes when
> > there is at least 1 flag. But I don't think we need to be so concerned
> > about an 8 byte difference...
> 
> I would prefer to keep the default header at 8 bytes. With 15 features
> fitting directly inside the base __u32 flags word, adding the first 15
> features to a struct keeps the header at 8 bytes and does not shift
> the payload.
> 
> Computation-wise it is also very similar: for the 99% of structs that
> have <= 15 features, LUO_FLAGS_CONT is 0, so computing the header size
> is just a single bit test with no loop. Even if a struct ever needs
> ext_flags, the loop will walk at most one or two extra words.

Please explain why it is so important to keep the header 8 bytes that we
have to jump through all these hoops to map a contiguous flag space
onto a u32 + u64[] array structure where certain bits are reserved and
have to be skipped.
