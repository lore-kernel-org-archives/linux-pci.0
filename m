Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793062547;
	b=pKTjB0qU9JjKCVoecJFSsgWvESjnQFsQ2np70eVJBEpbaR/ZJdgJ6DgxTnlCVGz/koOp
	 Ws8mqoHRVCRR9xiqxQyKFTTQMWSnCDU2VDnR0DnCdAuR2hULmdRyEPoVZv4wuO0kDoX95
	 3kUI4BJ/Vbyfr16Yr3MTvE4aPS88GllKeGr/eGzV0bxTyVZPzqnk4oi7f4PqhFbprOse6
	 DhSTCfVenHDiwuiIeAguvJ9JqlaU6JKrdYa6rZhxz+5oMkjeKHZQEDPpAEcCFgQAgWlH/
	 at8lWakaZF07M7Ec0Y58mE1HUw96e6jbCazzwVyQFpufnv2ejqgDq+TmZXxPQnp/WsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793062547;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0rDUgYp8MSkkxbz0QJpm44/zZryJwi/MN1DJH+bVzxg=;
	b=WmOfsuoHbNB0ZgI3Bo4cJdJw2++0qByez7thlTW4NkWJ+O4QUyB7u7W37pwZXMXefD0R
	 hw5LZr5TLhTrvAxU+NI9hfxf4m1oh8HENNP78KQE/MUFkHHZkSVgDH7Zgq3kIF42suR+x
	 Fdo9ukZ7lV9BPBaJp1mlX0JR+fmx9N8433c1cwyvxuDw7EnrtXtvQBVPBa+17sUe0beVa
	 t0PTqYP1HoQlwRS36i6tO4oSFT14CLrbKAB4Moz2VrLmAjcaCoLg0IL4BlB6HJxvBZfZE
	 7fDQ50t6uZrUPsGtuFV/rOnjP+xQC/+A9FL7n3FMOYSkP+dhF0mHbNdQ5NRRWe9moYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=B1Bnrmjz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A8E606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 00:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1A8E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=B1Bnrmjz
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-676858d42f8so3194165d50.2
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 17:55:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793062546; cv=none;
        d=google.com; s=arc-20260327;
        b=Qz8Sl+6dUN/CSU6eC0okkBYtWr5AgLTeaRQdZjUD77IMhpyC+9oVYHqO1FyOi4d7iE
         gZGU26BTUAw5tg9AeTZn/gJY+g3E9TGkmoEnwmeoBK4vyOldZrjbDEt4/3WxxNs2Qo+B
         vuig0XnbvTkl90wtiSArlndxMFtUUMPDaPRa+vqoupyfsba1Sbu4yOgcU4WDyzUqxbYm
         ykFNC1sKxCqEqnIXu6Ysry3sA23O0p4fKY1c1WYovBSuViqy7aJS7eKKQUeOJwD7pogY
         PjWqRzgupj1MpIexbXxTkMQpFYEutC+Se+hJ5Fw1MrBsK8+MeOLinrwlpQKczvyb3Yn+
         2VHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0rDUgYp8MSkkxbz0QJpm44/zZryJwi/MN1DJH+bVzxg=;
        fh=wZX6C6c0LrSDRv51AC1X2LLUL2xSm6bUXusFKDbM7IA=;
        b=PGvLloAjMT4OsQfqa+XpMJHtsDd+JeF4ezs0Ds3Us2bAHIfPvfGnf7FYBXQvgJJHfc
         CZJ5O9W3IIapYt+k/hxTs2KLsuR5McECu8lJldnP+SvsFafCBxpq8tTTCWTI5bFuEctc
         iNIsXuBokiZbg2ZzLQz4aHgTbSWY/buHc8KJ0szxWVDI+VbSloZ1zYUfDy6GD0iBN58C
         UjMoG+tO6YxsPXstZ/gT+lgoER6m5c0EWCtKs3ufOLZdyXR4iz2z4hjtdE5cE5y1tpg+
         mu8Q3++vgt3kWzIbzr3GWsK8xKF1emavCO65HKsHLF53I7+Xw6xokGC3p7npLabPQ2jb
         pAaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793062546; x=1793667346; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0rDUgYp8MSkkxbz0QJpm44/zZryJwi/MN1DJH+bVzxg=;
        b=B1BnrmjzOQllWKlg5tVh7jHtuToyh4b9r2vQ41qauboTRVa58oOPeN8G5oUXOb6cKI
         KOa3tNY3pp4+zh4ygoBN2k3b7t1N6irCUYzsghDt3gh4jIZY83CPyzvX+YwDDTWsFDrb
         Wgicpxlr71pf+zr86rXSF4xWP9rL+KOsCiTa0LVyDbR7hasv/hm64of2cVxj3pV5zla4
         T7tXoXeEfGXRDv1TziB3LNcG8y/OQqULQkKAPmZO+6OJ/npajDarvKKtoxRNsBp04Blz
         5RfXY9e1mmS5k1wHMy7yJ8WTVUrN+zPz1xHYHMA+gjY9DeGV/mLlOXofy7vTgSpHLxsT
         Bbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793062546; x=1793667346;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0rDUgYp8MSkkxbz0QJpm44/zZryJwi/MN1DJH+bVzxg=;
        b=lBQL+6tfMFw2XyfJ2Vw97yWv5GKh6axRR/cSYbOiWUUp+4/hY/8KABWPyNyAlP/Shf
         gSxeDowFSXEGSA1UTQG+UiTmn8vmexX0j+EcXLrqRAPJnffW9VNSWx3uKFS559eQ6cXo
         /M5C23XIWzvS1Ea8eHC3uPmMwRo1TVV8flrjCZMRSfmNGw9NKYYlh3G9a9KDuwRV/gnU
         ErJgS17DyLy+OxLodHNMxApc2C9R0widsx5QY8eBwybTHa4TNFunOkZTSIqvWc/Iw59s
         jm/rEssZiaYyTAoraA9iZMLPNFVFYwo2ZiL1v+naouftm2zEuCjl6CPOTN1ttSPdd7QD
         VYnA==
X-Forwarded-Encrypted: i=1; AKwUvBypL8U5DgOWXMvR76N4G4xRIzDlk0suOufia4Yl+fjWcWjMnbymd7KcRBoRavsklLSJTLF0nSlNiHs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSp1haQxPqWZI0TPD3QmUvA62GTMo5l1xPadPts2CJKJvcz1Fi
	rJDmuxYp4sMXVz/ye34BuicMLPfJ4hIpKbcQdRARKd3gVgvHE9xOp9lHwB9h+3hwS+nwekpAPaf
	tsX5YkSISYlguQP+LsfPQvZOAfc+IguV4tcBQyp3H
X-Gm-Gg: AYBFou0SnReNqudDuHS0QY/KAqqDqky9zw33RTzdp9v8vJt0+FVVV10jf6pYF++ptMG
	Z7RwWJxsnBYdmdnydpYquJbicgSKBAQYWVHCASiiXG5z1n43x2Xu4HH55i2HEnSjc9f5nDb2AUV
	LNrqi/Ul7zJN/Mx8uocdzC4gQANtz6YKJCKWs5tdf0YBFkmtytgdSlU70kR5b7dHNsgZq9LX621
	we88qOh1hVWO8iRplun+VmaBiyv3yQSlBbBhG6PPRrgUmF5T97iMGsFI9kjLMLKW9eyILuDjiE3
	yDnipX53g90wqvYnlV2ZEuEmRdjUOacBTZ/ObUz1Ce/eqhLRVvZoMom6lBXckIUh+DNq7sIEpaP
	aYnCqoUZfDh/96w3QECLqAEOgCWwvdmcj4DxRQU2mGfsg4SpRlhlo+ponDlXH6GuzyI9Ke3Wk3j
	o8+espbxi+OohaX/TL4hZ+le1/nXkFVBROxMVksDU34HjZDwwb+GKJR+g6wg==
X-Received: by 2002:a05:690e:4193:b0:679:ab13:5517 with SMTP id
 956f58d0204a3-67a454185a9mr4463627d50.104.1793062545192; Mon, 26 Oct 2026
 17:55:45 -0700 (PDT)
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
 <atlQ_Er0Ig7CCSxv@google.com> <CALzav=f00C4yOAseNunW8GgQTDUGWT927Qy=TLm-3-J0TEDH8Q@mail.gmail.com>
 <9huzzew0el59.fsf@tarunix.c.googlers.com> <at_CncIPYCxOVkLo@google.com>
 <9huzecdcghxu.fsf@tarunix.c.googlers.com> <at_pxoULR1Tp5anN@google.com>
In-Reply-To: <at_pxoULR1Tp5anN@google.com>
From: Tarun Sahu <tarunsahu@google.com>
Date: Tue, 27 Oct 2026 01:55:34 +0100
X-Gm-Features: AclHuK8fanKHLtbPQb3b8Hh9aMr64vlKSACVWw1UZzkklpf-Ls0Hu1JyLQFmaw8
Message-ID: <CALe+6DxTR0BpvW7mXMjq_+dczT2jO=R_qLbHhSduhnuSPcXhzQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
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
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 1:01=E2=80=AFAM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-10-26 11:28 PM, tarunsahu@google.com wrote:
> > David Matlack <dmatlack@google.com> writes:
>
> > > But looking at this again, I think the required bit is redundant. Whe=
ther
> > > a feature can be safely ignored is a property of the feature itself, =
not
> > > of any particular file. Every file that has a feature present will ha=
ve
> > > the same required bit for it. The only thing that actually varies per
> > > file is whether the feature is present.
> >
> > The required bit is subsystem property not the per-file. e.g. memfd_luo=
,
> > it is set at compile time for a kernel. So every file will get that req=
uired
> > bit set. It is not per file property.
> >
> > struct u8 memfd_luo_feature_state {
> >        [MEMFD_LUO_CORE_FEATURE] =3D LUO_FEATURE_REQUIRED
> > }
>
> Right, whether a feature is required is a static property of the
> feature.  That's exactly why it's redundant to send it in every header.

I meant the different thing.I was saying if a Feature in a kernel will have
constant value either required or optional which is fixed at compile time.
But the same feature can have different values in two different kernels.

I am not finding a good example, But I am skeptical about making the
assumption for all future kernels that the features will always be
required if they were required before.

Maybe a seal added in kernel version M. Later in kernel  version N this sea=
l is
deprecated and replaced by a new seal.

So transition from M->N
source kernel will preserve the seal values and flag the feature as require=
d.
target kernel will mark it supported and use its value to translate
into a new seal.

From N -> Z (latest)

Old seal is no longer required, But the new seal is required, so kernel N w=
ill
mark the new seal as required. and Z will support it.

This is hypothetical example. I'm not sure this is enough to convince the p=
oint.
So, I will rely on others to chime in with their thoughts.

>
> > > The required bit still has to be conveyed to the target somehow, sinc=
e
> > > the kernel that needs it is the one that doesn't know about the featu=
re.
> > > But it can be conveyed by the feature's number rather than an extra b=
it:
> > > split the flag space into required features and optional features, an=
d
> > > assign each feature to one of them when it is defined. This is simila=
r
> > > to the required_flags and optional_flags approach in struct pci_ser [=
1].
> > >
> > > Keeping the same header shape as discussed with Pasha:
> > >
> > > struct kho_ser_hdr {
> > >     __u32 size;           /* Size of header + payload in bytes */
> > >     __u16 nr_required;    /* Number of required feature bits */
> > >     __u16 nr_optional;    /* Number of optional feature bits */
> > >     __u64 flags[];        /* Required bits, followed by optional bits=
 */
> > > };
> > >
> > > Required feature N is bit N of flags[], and optional feature N is bit
> > > nr_required + N (using nr_required from the incoming header). The len=
gth
> > > of flags[] is DIV_ROUND_UP(nr_required + nr_optional, 64). Both space=
s
> > > are numbered contiguously, so there are no gaps, and up to 64 feature=
s
> > > still fit in a 16-byte header.
> > >
> > > Each bit just means the feature is present, so the truth table become=
s:
> > >
> > > Source bit       Target supports  Action
> > > ---------------  ---------------  ------------------------------
> > > Not set          -                Accept: feature absent
> > > Optional set     No               Accept: ignore the feature data
> > > Optional set     Yes              Accept: use the feature data
> > > Required set     No               Reject: -EOPNOTSUPP
> > > Required set     Yes              Accept: use the feature data
> > >
> > > There is no invalid encoding left to check.
> >
> >
> > IIUC, I believe this will not work.
> >
> > To Communicate between source and target, We are defining a protocol, A
> > protocol which will be standard for all the kernel. And each bit locati=
on in
> > flags must have the same meaning in both the source and target kernel.
> >
> > Now in you approach, If Source kernel send feature N to target kernel,
> > target kernel must understand Nth bit as the same feature. Even though
> > the bit position in your approach is not fixed but they are fixed
> > relative to their starting point.
>
> I think you misunderstood the proposal. I'm not proposing to pack only
> the set bits, and I'm not proposing that each feature have a bit in both
> ranges.
>
> In my proposal, there is no such thing as "feature N", there is
> "required feature N" and "optional feature N".  Required feature N can
> be found at bit position flags[N]. Optional feature N can be found at
> flags[nr_required + N].
>
> In more detail:
>
>  - Each feature is defined as either required or optional, once, when
>    the feature is added. That choice is permanent.
>
>  - Each feature gets exactly one bit, in its range, and that bit is
>    always at the same position whether or not it is set. Required
>    feature N is bit N. Optional feature N is bit nr_required + N.
>
>  - nr_required and nr_optional are the number of features of each kind
>    the source kernel knows about, not the number of bits set. They tell
>    the target where the optional range starts and how long flags[] is.
>
>  - A set bit means the feature is present in this file's payload. A clear
>    bit means it is absent.

So For #NR number of features, We will end up using 2*NR bits which
is exactly same number of bits, V3 [2] uses. So this is just a different
way of encoding in implementation perspective.

>
>  - There is no invalid or reserved encoding to define. Each bit just
>    means "present".

What if a buggy source sets both required and optional for a feature?
That is an invalid case here. Same as 0b10 is an invalid value set by
buggy kernel.

>
>  - The target doesn't need a supported table. Required features are only
>    ever appended, so it rejects any required bit at or beyond its own
>    MEMFD_LUO_NR_REQUIRED. Optional bits need no validation; the target
>    just checks the ones it knows about.
>

As I explained above, incase a feature is replaced by another feature,
new kernel
can support it deserialization but it will not be required from there on. S=
o
The supported table will still be needed.

> > For the current appraoch and V3 [2]. Think the below one as msb is
> > required bit and lsb is feature present in payload bit.
> >
> > 00  FEATURE_ABSENT / DEPRECATED
> > 01  FEATURE_OPTIONAL
> > 11  FEATURE_REQUIRED
> > 10  IS INVALID (analogy: required set but feature is not present) which=
 can
> > have different meaning in future if in future, a need arises to reuse t=
his
> > field.
>
> In v3, 0b10 is reserved and not checked by the target. That means an
> older kernel will silently accept it, so the only meaning it could ever
> safely take on is "safe to ignore", which is what 0b01 already means.
> A reserved encoding is only useful if older kernels reject it, and at
> that point it's no different from adding a new required feature.

Yes, because I thought 0b10 could be used in the future. And Currently
If it is set by a source kernel, it is buggy source kernel. But I can chang=
e
back to INVALID, As you said, it overlaps with valid field 0b00.

~Tarun

>
> > Deserialization can happen per feature from right to left. without
> > jumping back and forth.
> >
> > Because of all these reasons, I believe current approach presented in
> > V3 [2] is the better. It is close to your PCI series with two flags
> > field for required and optional except I combined both field into one
> > flags. In your above approach you do have two counts but not having gap=
s
> > (which is wrong) and the way you proposed to parse with an offset is di=
fferent.
