Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057327;
	b=tnOU9efrHqUU89ZXGsSWNX4/tAbiOGTCugHeIFNPV6WnkiSe25HEhL5aIpW3UVJ2ws1z
	 er4Xnit5c5K2U1YqNyUX335GbBvXphhmrn+uf8YucvNIydxY3B89gyhqLz7iAf2dDpQC2
	 KAgTDcOjOfvGobnMynoZr6ElRcj9vQ9mUIURzdaZLxUHykuVH5UGuFZpW9FC46TDlxMK6
	 Ss2DyGXNl26kWqkCJeSacNDvRAoU9uJJ4AoMg6apHFrzn3KjqQLNR6qJWqio7wtFaQitB
	 9AEOpMqQO9czBfOkJLvkLIGLnb6VvENiTHZfmc+v1+mfhXWy+W7ZnxxpQYMiVnwlnJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057327;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=RxRwD13OM0fFBvRZdfnXU3z0HVhv0MS7kXCqcjKQ5Ko=;
	b=wq0WLCa3YiS1wFjDf2yNxmFrM5RBkYVCsvMdmupscIAezNfNNXmeLxJejPvYQg0kbgc8
	 h9bSHofQZG+wm5yr/y2aXrAdWQNLLF/BYTl5dKU3XN9M5hnfgvK10Z16Hi59Z4cMUhmqC
	 Ig0r/5e4GkoaffLklNRW8VRlecTa+0r6FTeYmjktSzPwXKnOToj69ZvnuVwnL2oyzIu41
	 utfPVgEQDz4GGZEqvTFLoULiZqAiP6j3u2ozjPirNAJuoc2f2V9FFtvEQJawLT14/H4m3
	 N8yvM2QSnmra1bB2beldsfBp9r4aNSbi4du/dINXr0D2rGuxwa5dn6aXj+lpnDX4k7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=hK9TvNQw;
	arc=none smtp.remote-ip=209.85.208.69
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80679606A323
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 23:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80679606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=hK9TvNQw
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6b1d818b501so4309264a12.0
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 16:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793057326; x=1793662126; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RxRwD13OM0fFBvRZdfnXU3z0HVhv0MS7kXCqcjKQ5Ko=;
        b=hK9TvNQwKUHIZZZjxzV0a2Cbv7bIzmVQ6+G1+2ZS+4rTVIMHR7NWA80kKuwDAAcZoF
         pLSOv89ov3CxcEG25n/cIU3vcbj43p8ZXy7YHgOAoZooXblEghty3Cp5OoXY961rTOFW
         vluruvAUIamnZHp/w6s/IA7uOvsu/nAHiF4juHAsJeVSwD1sGDyCemEYrF5pQaIy2+dJ
         QncJE2F0CD5HeT7HOcfVMBY502l/Fc/PZf3COQxRAYovwWZKrkVRC9iWD24UfTl8Wv1i
         2Cb4/bNodGzK/8TOu/0nGkcK9Dm/cZFmh/qAGvSI9XFlwuGZNgDKyDxopMHwUIKLkmPa
         2o7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793057326; x=1793662126;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RxRwD13OM0fFBvRZdfnXU3z0HVhv0MS7kXCqcjKQ5Ko=;
        b=CUhK94m6WpAuoLG3aLZA8sGJixOWexMLb42lmfjJaTn7358R6VGePWS0oohZXNUEyv
         8TdrU0p0xj71dUeZ2gd22XkTJ8dLe0F34iVuQXfYcgfeyeRroUwBIMwChCnhm6th4EAq
         1dlZBAIS9R2ginhU+1/ObL0LpfCYk9p7XHzmxuqVSkjeMNlKaBNIYF73HAqWVcyrwLtE
         MMzJ2OJpZZ/utkHmNEP4VmfWboTXvLR/c25M2XIcbHw05Q2/ew3OQBekFPu3ij+wGdvh
         bERrpQqM2tWeEESl3Fy1nNFPrG41kOKAE15aOb3A4gugWXwgza58LDLXa4h5MvOSng6X
         i1eQ==
X-Forwarded-Encrypted: i=1; AKwUvByxZkzWyIKFBk/AfyiFB3knwwak52xEOgd9XZjSdAWoKJzNlhnmOrQfAtmYuQJ7/5xUW33aMPIYLWs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKo2+FR6FdztEBQ2JTcmv4CqMFTewniAPF6nxGOQBth9d1XKJFn
	C2N6tqSZTTGNfbtPFqHqBOVwLfRY6Zbnqmglm408DA3NAr0xhOGcQdHr+0XVcQ58Au2dNQMrovE
	Lz3O2FyaLSDwECsr8TA==
X-Received: from edxw25.prod.google.com ([2002:a05:6402:719:b0:6a7:4541:3de3])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:4026:b0:6b4:1037:2b87 with SMTP id 4fb4d7f45d1cf-6b44300b84fmr9392138a12.31.1793057325809;
 Mon, 26 Oct 2026 16:28:45 -0700 (PDT)
Date: Mon, 26 Oct 2026 23:28:45 +0000
In-Reply-To: <at_CncIPYCxOVkLo@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-4-tarunsahu@google.com>
 <atlQ_Er0Ig7CCSxv@google.com> <CALzav=f00C4yOAseNunW8GgQTDUGWT927Qy=TLm-3-J0TEDH8Q@mail.gmail.com>
 <9huzzew0el59.fsf@tarunix.c.googlers.com> <at_CncIPYCxOVkLo@google.com>
Message-ID: <9huzecdcghxu.fsf@tarunix.c.googlers.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
From: tarunsahu@google.com
To: David Matlack <dmatlack@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

David Matlack <dmatlack@google.com> writes:

> On 2026-10-26 11:50 AM, tarunsahu@google.com wrote:
>> Right, Required bit should be source kernel payload property to tell
>> target kernel that the payload must be handled to correctly deserialize
>> the data. It should be source kernel (userspace) responsiblity to make
>> sure it understand the target kernel before doing liveupdate.
>> 
>> Saying this, During deserialization, target kernel's required bit is not
>> necessary. So I propose the following truth table.
>> 
>> Source hdr  Target supported[i]  Action
>> ----------  -------------------  ----------------------------------
>> 00          0 or 1               Accept: feature absent in payload
>> 01          0                    Accept: ignore the feature data
>> 01          1                    Accept: use the feature data
>> 11          0                    Reject: -EOPNOTSUPP
>> 11          1                    Accept: use the feature data
>> 10          0 or 1               Reject: -EINVAL (invalid encoding)
>
> Yes, this matches what I had in mind for the semantics.
>
> To be explicit: the source kernel should set the bits for each Live
> Update based on what is actually preserved, rather than generating the
> header from a static per-kernel array. E.g. memfd would only mark a
> feature present for memfds that actually use it. That's what allows
> rollback to an older kernel as long as nothing being preserved depends
> on the new feature.
>
> But looking at this again, I think the required bit is redundant. Whether
> a feature can be safely ignored is a property of the feature itself, not
> of any particular file. Every file that has a feature present will have
> the same required bit for it. The only thing that actually varies per
> file is whether the feature is present.

The required bit is subsystem property not the per-file. e.g. memfd_luo,
it is set at compile time for a kernel. So every file will get that required
bit set. It is not per file property.

struct u8 memfd_luo_feature_state {
       [MEMFD_LUO_CORE_FEATURE] = LUO_FEATURE_REQUIRED
}


>
> The required bit still has to be conveyed to the target somehow, since
> the kernel that needs it is the one that doesn't know about the feature.
> But it can be conveyed by the feature's number rather than an extra bit:
> split the flag space into required features and optional features, and
> assign each feature to one of them when it is defined. This is similar
> to the required_flags and optional_flags approach in struct pci_ser [1].
>
> Keeping the same header shape as discussed with Pasha:
>
> struct kho_ser_hdr {
>     __u32 size;           /* Size of header + payload in bytes */
>     __u16 nr_required;    /* Number of required feature bits */
>     __u16 nr_optional;    /* Number of optional feature bits */
>     __u64 flags[];        /* Required bits, followed by optional bits */
> };
>
> Required feature N is bit N of flags[], and optional feature N is bit
> nr_required + N (using nr_required from the incoming header). The length
> of flags[] is DIV_ROUND_UP(nr_required + nr_optional, 64). Both spaces
> are numbered contiguously, so there are no gaps, and up to 64 features
> still fit in a 16-byte header.
>
> Each bit just means the feature is present, so the truth table becomes:
>
> Source bit       Target supports  Action
> ---------------  ---------------  ------------------------------
> Not set          -                Accept: feature absent
> Optional set     No               Accept: ignore the feature data
> Optional set     Yes              Accept: use the feature data
> Required set     No               Reject: -EOPNOTSUPP
> Required set     Yes              Accept: use the feature data
>
> There is no invalid encoding left to check.


IIUC, I believe this will not work.

To Communicate between source and target, We are defining a protocol, A
protocol which will be standard for all the kernel. And each bit location in
flags must have the same meaning in both the source and target kernel.

Now in you approach, If Source kernel send feature N to target kernel,
target kernel must understand Nth bit as the same feature. Even though
the bit position in your approach is not fixed but they are fixed
relative to their starting point.

required: reference is 0th bit: So target kernel will undersatnd the
          bit as the same feature as source kernel.
optional: reference is nr_required: So target kernel will understand the
          bit as the same feature as the source kernel.

To make sure there is harmony between these two kernel. Even though a
bit is not set in required for a feature that must be 0 in required
range. and similarly for optional bits.

So flags will look like 0b 0 0 1 1 0 0 0 1 0 0 1 1 1 0
                               o o o o o o r r r r r r

                        0b 0 0 0 0 0 0 0 0 1 1 1 1 1 1
                                           o o o r r r <= This is wrong
                                           because target can never know
                                           which bit mean what feature.
                                           So as you said there will be
                                           no gaps which will not work here.

So, Based on the first, We still using same number of bits and increased
complexity and no gain.


For the current appraoch and V3 [2]. Think the below one as msb is
required bit and lsb is feature present in payload bit.

00  FEATURE_ABSENT / DEPRECATED
01  FEATURE_OPTIONAL
11  FEATURE_REQUIRED
10  IS INVALID (analogy: required set but feature is not present) which can
have different meaning in future if in future, a need arises to reuse this
field.

Deserialization can happen per feature from right to left. without
jumping back and forth.

Because of all these reasons, I believe current approach presented in
V3 [2] is the better. It is close to your PCI series with two flags
field for required and optional except I combined both field into one
flags. In your above approach you do have two counts but not having gaps
(which is wrong) and the way you proposed to parse with an offset is different.

Let me know what you think.

[2] https://lore.kernel.org/all/20261026174217.603114-1-tarunsahu@google.com/
>
> [1] https://lore.kernel.org/linux-pci/20261013162529.1928093-1-dmatlack@google.com/
