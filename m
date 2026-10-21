Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792589551;
	b=2hNKpodG36xFabDE0A43yze9e829T2edGH+jLLmQXp6k2/dth8Qrh4ZGZiYR0f9jQnuu
	 A/ciyXmYF1r7ohhSiTBuDXFOFQfdhqUqEuk/fYDFuWgzixxyhDmPJErtiGOUzzD+XxEF/
	 DCpbfFwXOal/c1G/873rbp4HRNv6wHgocWb53C+sU2kUAdFYVbmh8dAG7XBtCw/68Kej1
	 buR4oKMc6ICxFV1bHqfd4Oo69c0pxZIzybiLHmYCxQiHIEmop5wfCGOIXUUkwrkM+Q3CN
	 VUvjG0yflqQl/WOx9kx4inFWXfy9Lueuh+EvwRaaW+r3cCF9p6bMr/ib+tChvhA4MeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792589551;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mFTldsOmE3pwihevS/TLReILU1zdfy8wuG9bog3o8H4=;
	b=wOR1Ncm9+965QZgbDYZrxZeOGs/1Bk12hdDBo3yyhWdEDuLcKAF7faSs/OUn+34bQX+P
	 RRK+Fq6bXk4v+bS+N3HvbQO/RRAo1/9YkdBfz573MvnzmcH5wZbQu4rTxZ1ChUCv1fsdn
	 vOCPVNokSV2o5AQW3JZL+O42ubFP5Z9OGd795v95nhrro3RKW9dV7B9XaoMFKVb0IgF7l
	 UBspBv1Lo9n+WdzlY0z7vd9fu2GDaRhlEVHY6lRx8X6vZ63EsiKV3xch/1v3GFWiVSdqg
	 vSXeA040FC8EvR5HYS7HHY9MDwHynEVf7h66jxhz6Hla47ibRexFnLiSqi+iQofISRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cpSjP4Bh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84DF606A31B
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 13:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cpSjP4Bh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653D51F000C4;
	Wed, 21 Oct 2026 13:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792589550;
	bh=mFTldsOmE3pwihevS/TLReILU1zdfy8wuG9bog3o8H4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=cpSjP4BhzoD8YcAPwxp2sac/1Bc8HeqtoSZYk7O+SURcKygPxKJsy76hrlNfsJEbb
	 KmIOUQ/qra3aBPjkIFuyDf7DQolZVdQluG6oXD53hLJVRZtUdWvJnemIyC3INVTF/0
	 wUKcQMJwoXd5Y9BECXqp9k5gYC/7OAAnBPKd+UUxJly3RyDkKCFY+7ia5zYJu8c+Uv
	 hMdMCMVfnTtYxqTnp0K0zScnhKvkFJB1wvGVhNasxCUVxa+yVa0gtdmtcYavaVheqB
	 03zWIplwbsD/GXdicnVT4j0uR+3hKkOTTuecNRzvS3NRQLJj0sg3BYyAWqj+M/3Iob
	 pW/XBpZQshoaQ==
Message-ID: <sashiko-outbox-180311@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/7] PCI: Fix nesting windows with remainder at the
 left edge
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261021124956.4250-5-ilpo.jarvinen@linux.intel.com>
References: <20261021124956.4250-1-ilpo.jarvinen@linux.intel.com>
 <20261021124956.4250-5-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 13:32:29 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] PCI: pci_resreq_remainder() treats size < align as tail remainder
- [Medium] PCI: wrong bus passed to pci_min_window_alignment() in __pci_ass=
ign_resource()
--

commit d393d2dd34eb6d31504106da364759753902d029
Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

PCI: Fix nesting windows with remainder at the left edge

This commit wraps pcibios_align_resource() with pci_resreq_check() and pass=
es
a smaller alignment constraint to the resource allocator when a memory
resource has a non-zero remainder. This allows nested bridge windows with a
remainder at the left edge to fit into parent windows of the same size while
preserving the real alignment in pci_resreq_data.

> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index 441a62807719d..2ca3784aa323f 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c

[ ... ]

> @@ -260,6 +262,12 @@ resource_size_t pci_resource_alignment(const struct =
pci_dev *dev,
>  	return resource_alignment(res);
>  }
> =20
> +static resource_size_t pci_resreq_remainder(resource_size_t size,
> +					    resource_size_t align)
> +{
> +	return size - ALIGN_DOWN(size, align);
> +}
> +
>  /*
>   * For mem bridge windows, try to relocate tail remainder space to space
>   * before res->start if there's enough free space there. This enables
> @@ -280,10 +288,17 @@ resource_size_t pci_align_resource(struct pci_resre=
q_data *rr,
>  	if (rr->user_align)
>  		return res->start;
> =20
> -	if (IS_ALIGNED(size, align))
> +	remainder =3D pci_resreq_remainder(size, align);
> +	if (!remainder)
> +		return res->start;
> +
> +	/*
> +	 * Size constraints forced an early start move in
> +	 * pci_check_and_align_resource()?
> +	 */
> +	if (!IS_ALIGNED(res->start, align))
>  		return res->start;
> =20
> -	remainder =3D size - ALIGN_DOWN(size, align);
>  	/* Don't mess with size that doesn't align with window size granularity=
 */
>  	if (!IS_ALIGNED(remainder, pci_min_window_alignment(dev->bus, res->flag=
s)))
>  		return res->start;
> @@ -315,6 +330,33 @@ resource_size_t __weak pcibios_align_resource(void *=
data,
>  	return pci_align_resource(rr, res, empty_res, size, align);
>  }
> =20
> +static resource_size_t pci_resreq_check(void *data,
> +					const struct resource *res,
> +					const struct resource *empty_res,
> +					resource_size_t size,
> +					resource_size_t min_align)
> +{
> +	struct pci_resreq_data *rr =3D data;
> +	resource_size_t align =3D rr->real_align;
> +	resource_size_t remainder, start;
> +	struct resource tmp =3D *res;
> +
> +	if (res->flags & IORESOURCE_MEM && !IS_ALIGNED(res->start, align)) {
> +		resource_set_range(&tmp, ALIGN(res->start, align), size);
> +		if (!__resource_contains_unbound(empty_res, &tmp)) {
> +			remainder =3D pci_resreq_remainder(size, align);
> +			resource_set_range(&tmp, tmp.start - remainder, size);
> +			if (!__resource_contains_unbound(empty_res, &tmp))
> +				return tmp.start;	/* caller skips range */
> +		}
> +	}

[Severity: High]
What happens in pci_resreq_remainder() and pci_resreq_check() when a memory
resource has size < align and rr.user_align is 0?

When size < align, ALIGN_DOWN(size, align) evaluates to 0, so
pci_resreq_remainder(size, align) returns size instead of 0. That treats the
entire resource as a movable remainder even though it has no align-sized
portion.

This can occur with rr.user_align =3D=3D 0 in paths such as:

1. On PowerNV, pcibios_default_alignment() -> pnv_pci_default_alignment()
   returns PAGE_SIZE (for example, 64 KiB). When no pci=3Dresource_alignmen=
t=3D
   parameter matches the device, pci_reassigndev_resource_alignment() ->
   pci_specified_resource_alignment(dev, &resize) returns align =3D PAGE_SI=
ZE
   with resize =3D false. For a 4 KiB BAR, pci_request_resource_alignment()
   sets IORESOURCE_STARTALIGN with r->start =3D PAGE_SIZE while keeping
   size =3D 4 KiB, and pci_init_pci_resreq_data() leaves rr.user_align =3D =
0.

2. For a CardBus bridge (PCI_CLASS_BRIDGE_CARDBUS), BAR 0 has size =3D 4 KiB
   while pci_resource_alignment() -> pci_cardbus_resource_alignment()
   returns 64 MiB with rr.user_align =3D=3D 0.

In __pci_assign_resource(), because pci_resreq_remainder(size, align) is
non-zero and !pci_resource_is_bridge_win(resno), the alignment constraint
passed to pci_bus_alloc_resource() is lowered to 1U.

Then in pci_resreq_check(), if an unaligned free range empty_res cannot fit
[ALIGN(res->start, align), ALIGN(res->start, align) + size - 1], subtracting
remainder (which equals size) shifts tmp.start to
ALIGN(res->start, align) - size. If that range fits within empty_res, the
resource is assigned just below the alignment boundary at an unaligned
address (for example, 0x8000f000 in [0x80001000, 0x8000ffff] after an earli=
er
4 KiB BAR at 0x80000000), violating the required alignment.

Later in the series, commit "PCI: Place resources to either edge of the
window" also uses pci_resreq_remainder() in pci_align_resource() to constru=
ct
candidates at ALIGN(empty_res->start, align) - remainder and
ALIGN_DOWN(empty_res->end + 1, align) - size, which similarly selects
unaligned addresses when size < align.

Should pci_resreq_remainder() return 0 when size < align?

> +
> +	start =3D pcibios_align_resource(rr, &tmp, empty_res, size, align);
> +	WARN_ON_ONCE(!IS_ALIGNED(start, min_align));
> +
> +	return start;
> +}
> +
>  static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *de=
v,
>  		int resno, resource_size_t size, resource_size_t align)
>  {
> @@ -324,9 +366,17 @@ static int __pci_assign_resource(struct pci_bus *bus=
, struct pci_dev *dev,
>  	int ret;
> =20
>  	pci_init_pci_resreq_data(&rr, dev);
> +	rr.real_align =3D align;
> =20
>  	min =3D (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
> =20
> +	if (!rr.user_align &&
> +	    (res->flags & IORESOURCE_MEM) && pci_resreq_remainder(size, align))=
 {
> +		align =3D 1U;
> +		if (pci_resource_is_bridge_win(resno))
> +			align =3D pci_min_window_alignment(bus, res->flags);
> +	}

[Severity: Medium]
Should pci_min_window_alignment() here (and in pci_align_resource()) be
passed dev->subordinate instead of bus?

When sizing bridge windows in pbus_size_io() and pbus_size_mem(),
pci_min_window_alignment() is called with the bridge's subordinate bus
(where bus->self is the bridge device dev):

drivers/pci/setup-bus.c:pbus_size_mem() {
	...
	win_align =3D pci_min_window_alignment(bus, b_res->flags);
}

On PowerNV, pnv_pci_window_alignment() walks up from bridge =3D bus->self
counting PCI_EXP_TYPE_PCI_BRIDGE devices:

arch/powerpc/platforms/powernv/pci-ioda.c:pnv_pci_window_alignment() {
	...
	bridge =3D bus->self;
	while (bridge) {
		if (pci_pcie_type(bridge) =3D=3D PCI_EXP_TYPE_PCI_BRIDGE) {
			num_pci_bridges++;
			if (num_pci_bridges >=3D 2)
				return 1;
		}

		bridge =3D bridge->bus->self;
	}
	...
}

In __pci_assign_resource(), dev is the bridge whose window res is being
assigned, while bus is dev->bus (or an ancestor bus). For a second-level
PCI_EXP_TYPE_PCI_BRIDGE bridge on PowerNV, pbus_size_mem(dev->subordinate,
...) sizes the window with a 1 MiB minimum window alignment
(num_pci_bridges >=3D 2), whereas calling pci_min_window_alignment(bus,
res->flags) with dev->bus sees num_pci_bridges =3D=3D 1 and returns m32_seg=
size
or m64_segsize (for example, 16 MiB or 64 MiB) as min_align.

If pci_resreq_check() (or pci_align_resource() in the subsequent commit
"PCI: Place resources to either edge of the window") places the window at an
address shifted by remainder that is aligned to dev->subordinate's 1 MiB
window alignment but not to the parent bus's segment size, can that reject
valid candidates or trigger WARN_ON_ONCE(!IS_ALIGNED(start, min_align)) in
pci_resreq_check()?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021124956.4250=
-1-ilpo.jarvinen@linux.intel.com?part=3D4
