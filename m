Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792589408;
	b=mmrNqHrOHbxQ2fKXqO6KrvrOpahsf+k9CxK+8KS4FaEB7KNNw+nUFrNyHOZI/fupHs+z
	 0fO7rX4Yr77NriB4tOgQ+n5k7+30BXCJVRjTtF+eM/t5w94bT8olFfJsLcHbX+Tt03ZkU
	 p+Q+1BsoaY6JAu2Uax0wXKH4x1nfc032t0suIy0E0S6glwiCACkLli1H466PdxP41bwLg
	 uqML/cNAh90JIYQlrddbrxzK/oQowmvQw7RCIzJzlipAujcfsG+RUbof7j/Vh1IFavj5M
	 jyB4y9W+6QzpoghvKe0JDvE8yqJO4PN9j+I6SOQokQ8RGkCZdf5Xfds3L1aKsexhdVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792589408;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/FU07OkaIZa2v0Ebwq4nCZ0m4VQ80GWqeeCugsSpmSo=;
	b=1KrllspEiK/djVOjaH6x9cBSS30ovcDYStivkHI/ri6F568u4nte4b2mhw8PMJufdUU0
	 j4cyd5v4dbLTuSwrSAoAI7gx2GIZLCcFz22R5NOYRarATnaYkgd+4eG4Umjo42JHMrJSm
	 LeaSuha6rk5gM7CeU9o/VODdSa1ZUcVABtk+R3m6rNzSxruxAO3P8A+f5OQ9wTEF09KVR
	 Far7+KoQYee1F7t4Odof57RndT+cNqO0BGE2Wxr2u3EpBCv1SfpJX1ydS0k3kPJ5Os8dk
	 QyIpXU723iopGMKhbz82Y/1B+yvm3/NQViHfIoDbR/k4TUytDly6PDmrGHz32ak3ITw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WcvBa7tT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25B5606A31D
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WcvBa7tT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687DA1F000C4;
	Wed, 21 Oct 2026 13:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792589407;
	bh=/FU07OkaIZa2v0Ebwq4nCZ0m4VQ80GWqeeCugsSpmSo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=WcvBa7tTWk41h4p8A78ngJBTQSaohS6PcoBakPlruJkOyxHmMSCyFVqGTs1X2ZOvj
	 JwiqrWph3EJDlW5Pk2BKsFLJGo8lQOtnH6oNmqZwUPIV+OQzwfOHqpsrR/4mCPTvz9
	 cysQWjM6xv1wA37erHkgEu4zM2g1uAJMoQ6t2E+DH8xib56JGBq7feSi0dAGnnNEmW
	 GCDwE4pAepYMJVADSUSopaz+9xcFW4GrQOxgxkDEN5Lj+NfJ2lbOqJuVaEOzO0v8gG
	 zGKw5RxPXeg7R6ubPDYYjc7+4vC2VV2e/gLXywLTm2CNEr1wWANGSAd3UhUB3rWW77
	 UVD3nr183kJ6A==
Message-ID: <sashiko-outbox-180305@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/7] PCI: Place resources to either edge of the
 window
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261021124956.4250-7-ilpo.jarvinen@linux.intel.com>
References: <20261021124956.4250-1-ilpo.jarvinen@linux.intel.com>
 <20261021124956.4250-7-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 13:30:06 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] pci: unaligned placement in pci_align_resource() when size is less=
 than align
- [Medium] pci: pci_max_natural_size() underreports max_align after halving=
 powof2
- [Medium] pci: WARN_ON_ONCE() in pci_resreq_check() when user_align is set=
 with remainder
- [Medium] pci: pci_align_resource() bypasses user_align when returning on =
best =3D=3D -1
- [Medium] PCI: unaligned candidate start addresses in pci_align_resource()
--

commit 19d57daaa9c86d1bd38d377d9e720319c17c02d3
Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

PCI: Place resources to either edge of the window

This commit updates pci_align_resource() to evaluate four candidate positio=
ns
at the left and right edges of an available free space range. It selects the
candidate that leaves the largest naturally aligned power-of-two range, the
largest contiguous free space, and the highest start alignment in the
remaining window space.

> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index 2ca3784aa323f..0833ea88bfa1b 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c

[ ... ]

> @@ -262,16 +265,84 @@ resource_size_t pci_resource_alignment(const struct=
 pci_dev *dev,
>  	return resource_alignment(res);
>  }
> =20
> +static resource_size_t pci_max_natural_size(const struct resource *res,
> +					    resource_size_t *max_align)
> +{
> +	resource_size_t size =3D resource_size(res);
> +	resource_size_t powof2, natural_start;
> +
> +	*max_align =3D 1;
> +	if (!size)
> +		return 0;
> +
> +	powof2 =3D rounddown_pow_of_two64(size);
> +	natural_start =3D ALIGN(res->start, powof2);
> +	/* end =3D ~0 first overflows, then -1 brings it back */
> +	if (natural_start >=3D ALIGN_DOWN(res->end + 1, powof2) - 1) {
> +		powof2 =3D max(powof2 / 2, 1U);
> +		natural_start =3D ALIGN(res->start, powof2);
> +	}
> +
> +	if (natural_start) {
> +		*max_align <<=3D __ffs64(natural_start);
> +	} else {
> +		/*
> +		 * Zero address has infinite alignment, return the largest
> +		 * representable number even if it's not a power of two.
> +		 */
> +		*max_align =3D RESOURCE_SIZE_MAX;
> +	}
> +
> +	return powof2;
> +}

[Severity: Medium]
When the initial powof2 does not fit within res and pci_max_natural_size()
halves powof2, could unconditionally overwriting natural_start with
ALIGN(res->start, powof2) underreport max_align?

If the remaining range contains two naturally aligned blocks of the halved
powof2 size (for example, when res starts at an odd multiple of the halved
powof2 and has size equal to two such blocks), ALIGN(res->start, powof2)
selects the first block at the odd multiple (which only has alignment equal
to the halved powof2) rather than the second block at the original
natural_start (which is at an even multiple and has at least twice the
alignment).

For example, if a root bus window is [0x10900000-0x10b00fff] and a 4KB BAR 0
is assigned before a 2MB, 1MB-aligned bridge window:

1. candidate[0] places BAR 0 at the left edge [0x10900000-0x10900fff],
   leaving remaining =3D [0x10901000-0x10b00fff] (size 0x200000). Halving
   powof2 to 0x100000 gives natural_start =3D ALIGN(0x10901000, 0x100000) =
=3D
   0x10a00000, so natural_size =3D 0x100000, size =3D 0x200000, and
   maxalign =3D 0x200000.

2. candidate[2] places BAR 0 at the right edge [0x10b00000-0x10b00fff],
   leaving remaining =3D [0x10900000-0x10afffff] (size 0x200000), which
   preserves both 1MB blocks. However, halving powof2 to 0x100000 overwrites
   natural_start with ALIGN(0x10900000, 0x100000) =3D 0x10900000, reporting
   natural_size =3D 0x100000, size =3D 0x200000, and maxalign =3D 0x100000.

Because natural_size and size tie, maxalign breaks the tie in favor of
candidate[0], placing BAR 0 at the left edge and blocking the 2MB bridge
window from fitting. Should pci_max_natural_size() keep the original
natural_start when a halved powof2 block starting at that address still fits
within res?

> +
>  static resource_size_t pci_resreq_remainder(resource_size_t size,
>  					    resource_size_t align)
>  {
>  	return size - ALIGN_DOWN(size, align);
>  }

[ ... ]

> @@ -280,38 +351,85 @@ resource_size_t pci_align_resource(struct pci_resre=
q_data *rr,
>  				   resource_size_t align)
>  {
>  	struct pci_dev *dev =3D rr->dev;
> -	resource_size_t remainder, start_addr;
> +	unsigned long type =3D res->flags & PCI_RES_TYPE_MASK;
> +	resource_size_t best_natural_size =3D 0, best_size =3D 0, best_maxalign=
 =3D 0;
> +	resource_size_t aligning, remainder;
> +	struct resource candidate[4];
> +	unsigned int i;
> +	int best =3D -1;
> =20
>  	if (!(res->flags & IORESOURCE_MEM))
>  		return res->start;
> =20
> -	if (rr->user_align)
> -		return res->start;
> -
>  	remainder =3D pci_resreq_remainder(size, align);
> -	if (!remainder)
> -		return res->start;
> +	aligning =3D size - remainder;
> +
> +	candidate[0] =3D DEFINE_RES(ALIGN(empty_res->start, align), size, type);
> +	candidate[1] =3D DEFINE_RES(ALIGN(empty_res->start, align) - remainder,
> +				  size, type);
> +	candidate[2] =3D DEFINE_RES(ALIGN_DOWN(empty_res->end + 1 - remainder, =
align) -
> +				  aligning, size, type);
> +	candidate[3] =3D DEFINE_RES(ALIGN_DOWN(empty_res->end + 1, align) - siz=
e,
> +				  size, type);

[Severity: High]
What happens here when a memory resource has size < align and
rr->user_align =3D=3D 0?

In pci_resreq_remainder(size, align), ALIGN_DOWN(size, align) evaluates to 0
whenever size < align, so pci_resreq_remainder() returns size instead of 0:

drivers/pci/setup-res.c:pci_resreq_remainder() {
	return size - ALIGN_DOWN(size, align);
}

Because pci_resreq_remainder(size, align) is non-zero and rr.user_align =3D=
=3D 0,
__pci_assign_resource() lowers the alignment constraint passed to
pci_bus_alloc_resource() to 1U (or pci_min_window_alignment() for bridge
windows):

drivers/pci/setup-res.c:__pci_assign_resource() {
	if (!rr.user_align &&
	    (res->flags & IORESOURCE_MEM) && pci_resreq_remainder(size, align)) {
		align =3D 1U;
		if (pci_resource_is_bridge_win(resno))
			align =3D pci_min_window_alignment(bus, res->flags);
	}
}

Then in pci_align_resource(), remainder =3D size and aligning =3D 0, which =
treats
the entire resource as a non-aligning remainder with a zero-sized aligning
part:

- candidate[1] is placed at ALIGN(empty_res->start, align) - size
- candidate[3] is placed at ALIGN_DOWN(empty_res->end + 1, align) - size

Neither candidate is aligned to align, and candidate[3] leaves align - size
more contiguous free space on the left than the aligned candidate[2] while
preserving empty_res->start (giving a higher maxalign than candidate[0]), so
pci_align_resource() selects candidate[3] (or candidate[1]) and assigns the
resource to an unaligned start address.

This can be reached when size < align with rr->user_align =3D=3D 0 via:

- Platforms implementing pcibios_default_alignment() (such as PowerNV
  pnv_pci_default_alignment() returning 64KB), where
  pci_reassigndev_resource_alignment() -> pci_request_resource_alignment()
  with resize =3D=3D false sets IORESOURCE_STARTALIGN to 64KB while keeping=
 a
  smaller BAR size (e.g., 4KB) and leaving rr->user_align =3D=3D 0.
- CardBus bridges, where pci_resource_alignment() returns
  pci_cardbus_resource_alignment() (64MB) for all memory resources including
  the 4KB BAR 0.
- SR-IOV VF BARs where pcibios_iov_resource_alignment() returns an alignment
  larger than total_VFs * vf_bar_size, or resources in
  reassign_resources_sorted() where add_align > size.

Should pci_resreq_remainder() return 0 when size < align?

> +
> +	for (i =3D 0; i < ARRAY_SIZE(candidate); i++) {
> +		struct resource remaining;
> +		resource_size_t natural_size, size, maxalign;
> +
> +		if ((candidate[i].start > candidate[i].end) ||
> +		    !__resource_contains_unbound(empty_res, &candidate[i])) {
> +			pci_dbg(dev, "%pR: candidate %u not within free space %pR\n",
> +				&candidate[i], i, empty_res);
> +			continue;
> +		}
> =20
> -	/*
> -	 * Size constraints forced an early start move in
> -	 * pci_check_and_align_resource()?
> -	 */
> -	if (!IS_ALIGNED(res->start, align))
> -		return res->start;
> +		if (rr->user_align &&
> +		    !IS_ALIGNED(candidate[i].start, rr->user_align)) {
> +			pci_dbg(dev, "%pR: candidate %u skipped due to resource_alignment=3D%=
llx\n",
> +				&candidate[i], i,
> +				(unsigned long long)rr->user_align);
> +			continue;
> +		}

[Severity: Medium]
Can removing the early return on rr->user_align trigger the WARN_ON_ONCE() =
in
pci_resreq_check() when rr->user_align is set on a device that also has a
composite resource with a non-zero remainder?

In __pci_assign_resource(), min_align (align) is only lowered when
!rr.user_align:

drivers/pci/setup-res.c:__pci_assign_resource() {
	if (!rr.user_align &&
	    (res->flags & IORESOURCE_MEM) && pci_resreq_remainder(size, align)) {
		align =3D 1U;
		if (pci_resource_is_bridge_win(resno))
			align =3D pci_min_window_alignment(bus, res->flags);
	}
}

If pci=3Dresource_alignment=3D... matches a bridge or SR-IOV PF device with
rr->user_align smaller than rr->real_align (for example, rr->user_align =3D=
 4KB
while assigning a bridge window or VF BAR with real_align =3D 2MB, size =3D=
 3MB,
and remainder =3D 1MB), __pci_assign_resource() leaves min_align at 2MB.

In pci_align_resource(), candidate[1] and candidate[3] have 1MB-aligned sta=
rt
addresses, which pass IS_ALIGNED(candidate[i].start, rr->user_align), so
pci_align_resource() can return a 1MB-aligned start address to
pci_resreq_check():

drivers/pci/setup-res.c:pci_resreq_check() {
	start =3D pcibios_align_resource(rr, &tmp, empty_res, size, align);
	WARN_ON_ONCE(!IS_ALIGNED(start, min_align));
}

With start aligned to 1MB and min_align equal to 2MB, won't this trigger
WARN_ON_ONCE(!IS_ALIGNED(start, min_align))?

> =20
> -	/* Don't mess with size that doesn't align with window size granularity=
 */
> -	if (!IS_ALIGNED(remainder, pci_min_window_alignment(dev->bus, res->flag=
s)))
> -		return res->start;

[Severity: Medium]
Is it safe to remove the pci_min_window_alignment() check on remainder with=
out
checking candidate alignment for bridge windows?

In drivers/pci/setup-bus.c:pci_bus_distribute_available_resources(),
remove_dev_resources() advances available[i].start by non-bridge BAR sizes =
on
the bus (such as a 4KB BAR 0 on a PCIe port). When available[i] is split
across downstream bridges via resource_set_size(), available[i].end becomes
unaligned by that sub-1MB offset, and the recursive call for the child bus
aligns available[i].start up before calling adjust_bridge_window():

drivers/pci/setup-bus.c:pci_bus_distribute_available_resources() {
		align =3D pci_resource_alignment(bridge, res);
		if (!resource_assigned(res) && align)
			available[i].start =3D min(ALIGN(available[i].start, align),
						 available[i].end + 1);
		...
		adjust_bridge_window(bridge, res, add_list,
				     resource_size(&available[i]));
}

This can leave a child bridge window with a size whose remainder is not a
multiple of pci_min_window_alignment(dev->bus, res->flags) (1MB).

When __pci_assign_resource() assigns that bridge window, it sets min_align =
to
pci_min_window_alignment(bus, res->flags). In pci_align_resource(),
candidate[1] (ALIGN(empty_res->start, align) - remainder) and candidate[3]
(ALIGN_DOWN(empty_res->end + 1, align) - size) will have start addresses th=
at
are not aligned to pci_min_window_alignment(). If candidate[1] or
candidate[3] is selected, pci_resreq_check() will trigger
WARN_ON_ONCE(!IS_ALIGNED(start, min_align)) and assign a bridge window whose
base address is not 1MB-aligned.

> -	/* Try to place remainder that doesn't fill align before */
> -	if (res->start < remainder)
> -		return res->start;
> -	start_addr =3D res->start - remainder;
> -	if (empty_res->start > start_addr)
> +		remaining.flags =3D type;
> +		if (i <=3D 1) {
> +			remaining.start =3D candidate[i].end + 1;
> +			remaining.end =3D empty_res->end;
> +		} else {
> +			remaining.start =3D empty_res->start;
> +			remaining.end =3D candidate[i].start - 1;
> +		}
> +
> +		natural_size =3D pci_max_natural_size(&remaining, &maxalign);
> +		size =3D resource_size(&remaining);
> +		pci_dbg(dev, "%pR: candidate %u free space naturalsize=3D%llx size=3D%=
llx maxalign=3D%llx\n",
> +			&candidate[i], i,
> +			(unsigned long long)natural_size,
> +			(unsigned long long)size,
> +			(unsigned long long)maxalign);
> +		if ((best < 0) ||
> +		    (natural_size > best_natural_size) ||
> +		    (natural_size =3D=3D best_natural_size && size > best_size) ||
> +		    (natural_size =3D=3D best_natural_size && size =3D=3D best_size &&
> +		     maxalign > best_maxalign)) {
> +			best =3D i;
> +			best_natural_size =3D natural_size;
> +			best_size =3D size;
> +			best_maxalign =3D maxalign;
> +		}
> +	}
> +
> +	/* None fits? Return some address and let the caller deal with it. */
> +	if (best =3D=3D -1)
>  		return res->start;

[Severity: Medium]
If all candidates in empty_res are rejected because none of them satisfies
IS_ALIGNED(candidate[i].start, rr->user_align), won't returning res->start
here cause the caller to accept an unaligned allocation?

When pci_resreq_check() calls pcibios_align_resource() -> pci_align_resourc=
e(),
res is tmp, which has already been aligned to align inside empty_res. If
empty_res is large enough to contain [res->start, res->start + size - 1],
 returning res->start hands back a range that lies completely within
empty_res (full_avail).

In kernel/resource.c:__find_resource_space(), the caller only checks whether
the returned range fits inside full_avail:

kernel/resource.c:__find_resource_space() {
			alloc.start =3D alignf(alignf_data, &avail, size, align);
			alloc.end =3D alloc.start + size - 1;
			if (alloc.start <=3D alloc.end &&
			    __resource_contains_unbound(&full_avail, &alloc)) {
				new->start =3D alloc.start;
				new->end =3D alloc.end;
				return 0;
			}
}

Because [res->start, res->start + size - 1] is contained in full_avail, won=
't
__find_resource_space() succeed and allocate the resource at res->start in
violation of rr->user_align instead of skipping empty_res?

> =20
> -	pci_dbg(dev, "%pR: moving candidate start address below align to %llx\n=
",
> -		res, (unsigned long long)start_addr);
> -	return start_addr;
> +	pci_dbg(dev, "%pR: candidate %u selected (free space %pR), size: %llx +=
 %llx, align: %llx\n",
> +		&candidate[best], best, empty_res,
> +		(unsigned long long)aligning,
> +		(unsigned long long)remainder,
> +		(unsigned long long)align);
> +
> +	return candidate[best].start;
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021124956.4250=
-1-ilpo.jarvinen@linux.intel.com?part=3D6
