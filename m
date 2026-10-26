Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015412;
	b=pynbTFSho6AyCAbMtEeyXUfax2rC5FljbVDdAn7AkEbnEDm1TQAp/OpVIj4lZrt2Zg4a
	 tA5NuLwgkgcIkCdfcqAv3i5ZAuCd3SNVwOYb0c1RuxfutDw6PJJBM+7OYxbUWlEfOd3dG
	 b9ksZkPkJSXXP/6341gq/4mmbEheQgRVEIbmKrTIyrgP/hdrAfpqGmTy487g8F20PXZS+
	 qhDWWnsst7WP4USBPbPrBjqjMeVJgfIqnZzvZe4ExUHK/sff1NyPAs8ADootr2vxO3aO2
	 KUHNmk1tboKshpWamU6sA3KCzZixYtgFKZkMXDqG3iQjmHshSewcEv+LgC0QI5dbpxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=E6ehAr+5O7aPeLIKo6+S6CS8cvliVvtVKcymE8BrUws=;
	b=EmKG9h/KOFGmoTBv2kKBv6mXLWGno5nt5a64og6r3IaduhBLcDdBZhaGQSTLNMYyA6Vt
	 Ep+MK2+t9QKjMsCMxQMPv4WbCIAJIErmY2oX3ouS076rvhwX3ZpSKX0Y4/qskqdPsyMRl
	 8gcefxmEk7lHgPHgMfMuL8Oyi8TBFb+yE92/x9bx4mWuo8M3MVRifuxMGjMmdwlTP1MZZ
	 amnbq98ufR6Qm6oy5lk43S+/Epr737L910t6BEtKuQ7dPdXrIEJ2tCuMX97V5P6/JyaEm
	 VdUVU5iD9UxW7JRENa1Lj2gqcZi1759kGG7iXj8I/aCcqNOqXgavukEUyVanZ+uau2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	arc=none smtp.remote-ip=209.85.208.70
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92128606A321
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 11:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92128606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6b1c285faebso3084476a12.2
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 04:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793015411; x=1793620211; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E6ehAr+5O7aPeLIKo6+S6CS8cvliVvtVKcymE8BrUws=;
        b=XAsGlQ44QhxLbX3s/vWrWR1fEjhFGkT5IlmfbZ+lkLP9Oe85SXpiAn1GeRLEL1H2XO
         yQc+jA06Xl9daZwtD/YhVCQBe4QhPG4Wx6MdjOZ4iJEgGnKFU/FYUV7xzaqZQKLsA0aN
         R/0o43MCYXNrmiuXKNSZMqL9QRoabLxkTEN4RZcoISWY2W4N5MHoElGvLxv39SyWGeoh
         S2qHKVenxm/vznKTPaQvnAwIq1AJacG92itDoKu8OCiHjWi2HDS+a0fN0ni6jgV3kLpO
         SlxEHMWkwZPDCPxARUPnqJ5+CJrAkhzChQ6p6s68BDHOT5BDv1rKIoQIexS1xnBLr1l6
         sTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793015411; x=1793620211;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E6ehAr+5O7aPeLIKo6+S6CS8cvliVvtVKcymE8BrUws=;
        b=EVDeMEVx4X+49KjgISZO9ntM8KKg4jx2NmWuwhgGHan4k4bKRU7nC9VBZhoUNWihA7
         Sbzd7sTXKQDBTS9tCi/Ak835B6ELPPK2pyk+A6moeA1PA2rqVPBSXwBZ6RSdu29ERxpl
         ukrdG1H4/QvmnO4/9CJUm9OOTd+mu3QwWFH8CFQpnDZSqFc+dw8dz+FbQIxGQ2457giV
         WLdIx6zZ4bcQQSInCN8ym6Kn/CHDg5Y8E4mn2ShXdvgSWsWJLdXyPlTmSEW0vM8mUEXD
         GgnRXC1sunKRRhArfZwxOyc15FMP+XRKGJkYzdch8ehyi5DLW19EuMsBzlC/V1j64xLr
         Hoow==
X-Forwarded-Encrypted: i=1; AKwUvBwQDrJ0dzGOTF6eypOMMvimF7Rl714KcrRdzWj10/HluwYAy+IX8LC/sKjb78x3RQTbrj7Q7UP2WjQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKe9Upv4iD2TpaFb6i5tS+yMt1jyWuxW+aFQpHTiHCZZxlnQUn3
	B9tRppzzwl95gWdI03eis9147uvHes0kWm4dIIfzH5OPfV7p5NR/DShRewlhZZGAmcyC+6jXGR5
	Qqi0q3Uj5Zz6mSIozTg==
X-Received: from edrd16.prod.google.com ([2002:aa7:d690:0:b0:6b3:8448:41c6])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:249e:b0:6b1:c7d9:b622 with SMTP id 4fb4d7f45d1cf-6b442fffef3mr7891637a12.26.1793015410774;
 Mon, 26 Oct 2026 04:50:10 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:50:10 +0000
In-Reply-To: <CALzav=f00C4yOAseNunW8GgQTDUGWT927Qy=TLm-3-J0TEDH8Q@mail.gmail.com>
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
Message-ID: <9huzzew0el59.fsf@tarunix.c.googlers.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

David Matlack <dmatlack@google.com> writes:

> On Wed, Oct 21, 2026 at 4:55=E2=80=AFPM David Matlack <dmatlack@google.co=
m> wrote:
>>
>> On 2026-10-21 03:25 PM, Tarun Sahu wrote:
>> > LUO and its file handlers validate handed-over state with monolithic
>> > compatibility strings ("luo-v5", "memfd-v2"). Any change to a serializ=
ed
>> > structure, even an optional additive one, must bump the string, which
>> > breaks live update between adjacent kernels. Replace the string in
>> > struct luo_ser with a feature header, so that the target kernel can
>> > accept or reject the source kernel state per feature.
>> >
>> > struct luo_feature_hdr is a fixed 128-byte header: the serialized
>> > structure size from the source kernel followed by 15 chained u64 featu=
re
>> > flags entries. The fixed size keeps payload field offsets identical in
>> > every kernel, regardless of how many flags entries a source kernel use=
s.
>> >
>> > Each feature has a 2-bit pair (req, active) state (enum luo_feat_state=
:
>> > LUO_FEAT_DISABLED, LUO_FEAT_OPTIONAL, LUO_FEAT_REQUIRED). A flags entr=
y
>> > holds 31 features, and bits [63:62] =3D 0b11 chain to the next entry (=
465
>> > features in total). Each subsystem defines its feature states as a
>> > static const u8 array indexed by its feature enum, which
>> > luo_feature_hdr_init() packs into 64-bit flags entries with
>> > LUO_FEAT_EXT_MASK chain bits. The target kernel validates the header f=
rom
>> > the source kernel against its own feature array via
>> > luo_feature_hdr_validate() according to the per-feature (req, active)
>> > truth table:
>> >
>> >   Source Target Action
>> >   (1,0)  (x,x)  Reject -EINVAL: invalid source kernel (req without act=
ive)
>> >   (x,x)  (1,0)  Reject -EINVAL + WARN_ON_ONCE: invalid target kernel
>> >   (0,0)  (0,0)  Accept: feature absent
>> >   (0,0)  (0,1)  Accept: feature absent
>> >   (0,0)  (1,1)  Reject -EOPNOTSUPP: target kernel requires the feature
>> >   (0,1)  (0,0)  Accept: ignore payload data
>> >   (1,1)  (0,0)  Reject -EOPNOTSUPP: source kernel requires the feature
>> >   (x,1)  (x,1)  Accept: use payload data
>>
>> I think we have different definitions of "required".
>>
>> In the PCI series [1], required and optional flags describe the _data_
>> the previous kernel handed over, not the kernel itself. A required bit
>> means "this preserved state depends on feature X; a kernel that does
>> not understand X must not take it over". An optional bit means "the
>> data for X is here, but you can safely ignore it". The source kernel
>> only sets a bit when the preserved state actually uses the feature.
>>
>> It's up to the FLB/FH retrieve how to handle the scenario where a
>> required bit is set that the target kernel does not understand. For the
>> PCI FLB we panic since failing to adopt the PCI state could lead to
>> memory corruption as preserved devices can be doing DMA.
>>
>> The target kernel never requires anything from the source. If a
>> feature is absent, the target kernel must handle that, e.g. by
>> falling back to default behavior. If it can't, that is a compatibility
>> break and should be handled by the compatible string.
>>
>> In this patch each kernel has a single static feature array that is used
>> both to generate the header and to validate the incoming header.  So if
>> kernel N marks a new feature X as required (so that older kernels reject
>> data they cannot understand), then kernel N will also reject every
>> kernel that does not have X, because of the (0,0) -> (1,1) row in the
>> truth table. That breaks forward updates from N-1 to N, and rollbacks
>> from N to N-1 even when **nothing being preserved uses X**. Therefore,
>> every new required feature becomes a compatible string bump.
>>

Right, Required bit should be source kernel payload property to tell
target kernel that the payload must be handled to correctly deserialize
the data. It should be source kernel (userspace) responsiblity to make
sure it understand the target kernel before doing liveupdate.

Saying this, During deserialization, target kernel's required bit is not
necessary. So I propose the following truth table.

Source hdr  Target supported[i]  Action
----------  -------------------  ----------------------------------
00          0 or 1               Accept: feature absent in payload
01          0                    Accept: ignore the feature data
01          1                    Accept: use the feature data
11          0                    Reject: -EOPNOTSUPP
11          1                    Accept: use the feature data
10          0 or 1               Reject: -EINVAL (invalid encoding)

Where Supported bit is extra bit information used by target kernel to
deserialize the data. Which is static information of target kernel and
will never be used in serialization payload.

Like,

static bool memfd_feat_supported[MEMFD_NR_FEATUERS]{
       [MEMFD_CORE_FEATURE] =3D true
}

This makes every kernel 3 bit information.

required+active: used by source kernel and embedded in serialized hdr
supported: used by target kernel to deserialize the data if it supports.

~Tarun



>> I would drop the target-side required state entirely and let the source
>> kernel decide which flags to set for each Live Update based on what is
>> _actually_ preserved. Accessing a field added after the original struct
>> then always requires checking its flag.
>>
>> At the end of the day it is up to userspace to never start using a
>> required feature while they can still rollback to a kernel that does not
>> support it. Cloud Providers know how to do this since Live Migration has
>> the same problem. This also means we must be very careful when adding
>> new required features, as they need some way for userspace to explicitly
>> opt-into them. I do _not_ think we should try to have some generic LUO
>> opt-in for required features. That is up to the File Handlers and FLBs,
>> as they have their own uAPI.
>>
>> [1] https://lore.kernel.org/linux-pci/20261013162529.1928093-1-dmatlack@=
google.com/
>
> Oh and please see the follow-up PCI series to preserve BARs and bridge
> windows for some examples of using optional_flags to extend struct
> pci_ser with additional data without breaking backwards compatibility.
> e.g. https://lore.kernel.org/linux-pci/20261019213054.3157159-5-dmatlack@=
google.com/
>
> I don't yet have a use-case for a required_flag.




