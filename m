Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792589134;
	b=UKW4EJm6216TdtCcIyqurQfUIVtDjrXlKAmgJgFU2gU92pchrLL6tLhsc4IJktU2aEWQ
	 Pxn+KaZNmV8NXBwPrCZ1AgMTNce6HD6ZulgAurWu/9nGrvlb/cp3BncQfNCKJGLxFbBFE
	 jgE/O34KYzlfhsewaLowGM8/HplR2JVfD1c70zURwVSCjq0DlN34wiDrR34SoMjlM9e50
	 UuBCirceTUk32vY7NqxN++VhpEHbEMdRcSVihFoF4UJ53xoV+Xm4WF5aZqJZa+kbD479z
	 aW/Dt7UCu9I9uG1Iy4oWcD/CgWI0vUb9YqaUdKWhMl164ZqSnaF0r40efrXmvWgoDBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792589134;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ux6S53rwdcMya2vltoMuKa0E81LCeMS4WMXmfb0fM40=;
	b=vD6ZzXMkThku0rB1QsDB7tFZtSkIbzc8tAK+YHtn/3Pj+eRo6rAYlu4N0sHNUn5P+azf
	 IQgbbSRvH+qh58QpDLdAO6FcIcXdj5Nnber31KXIQ4Cb66Aa8uaeUZpqEgiCq2xIdUwxf
	 +r1EohPftPUq85Kt/2eHw0xLBbcCtOqihZwyagSsd55XN9LZL7dNUXgoytZi5qJGF9d41
	 m42AgR+YzA+DFj6l5ImSX/FDaAC3er/nLUracE4Ach8HKWZ0JCRKb6OFjZwg6ivte3FaI
	 uo0rRvNSaG/Hj8tqz83hvGBMopC7oYFnYPKkkdFC48tZis+jDygcbNbTIgtg2BsNuAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RiLN7QuG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B20606A319
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RiLN7QuG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C451F000C4;
	Wed, 21 Oct 2026 13:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792589134;
	bh=Ux6S53rwdcMya2vltoMuKa0E81LCeMS4WMXmfb0fM40=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=RiLN7QuGOvFoJq6KJG8S9Abmr7EBNM5kchQ3oAW2qXZeAmWWtXjbEW32yqi8Dre3c
	 TF3mVbk54jsMkKuSX+JXHO4ypCF9gXIXruiB/fSJFUodUcocj4x58/EZhriasGa9dT
	 Gv1LiPqWDTK0SF87rjhGue9hQ3s5QrCUXoSAVqpqvaex9TYGxSrd9lQiHDubVH3m5M
	 E22VMmhnfIsbLWEkxV0n4Dbe+lUlwp+DWGgVZuzY5P87P3Vu+7AGgH1am1UgXcESLD
	 GbfAeMbydMlR4fKYF0tm3AVwInoFo2MzP4DIfhymqEHKvUc+K1Gw/uPiEtztijb0/B
	 rrDUrhr6oRF2w==
Message-ID: <sashiko-outbox-180301@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/7] PCI: Fix composite resource sizing
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261021124956.4250-8-ilpo.jarvinen@linux.intel.com>
References: <20261021124956.4250-1-ilpo.jarvinen@linux.intel.com>
 <20261021124956.4250-8-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 13:25:33 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] PCI: missing bridge window gap in calculate_win_gap_size() when r_=
align !=3D win_align
- [Medium] PCI: missing bridge window gap in calculate_win_gap_size() for s=
ingle remainder
- [Medium] PCI: calculate_win_gap_size() underestimates gap with small reso=
urces
--

commit b396fbe58c9de8a971b93378e647d16638aa6dbe
Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

PCI: Fix composite resource sizing

This commit adds calculate_win_gap_size() to pbus_size_mem() to account for
alignment gaps required when packing multiple non-aligning composite child
resources into a PCI bridge window.

Link: https://lore.kernel.org/linux-pci/20260903063124.9316-1-nbritton@exab=
it.io/

> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 7ca0e9f4ffb63..2980b499ef759 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1164,6 +1164,79 @@ static inline resource_size_t calculate_mem_align(=
resource_size_t *aligns,
>  	return min_align;
>  }
> =20
> +/*
> + * Bridge window gap size calculator.
> + *
> + * Calculates gap (empty space) necessary because of non-aligning compos=
ite
> + * resources (VF BARs, bridge windows).
> + *
> + * Rules:
> + *
> + * 1) Gaps are only necessary if there is more than one non-aligning
> + *    composite resource within a single bridge window.
> + *
> + * 2) If there are only two remainder parts that amount to less than win=
_align
> + *    together, the required gap is the difference of win_align and the =
sum of
> + *    remainder sizes.
> + *
> + * 3) On other cases, round each remainder part to win_align to get the =
gap
> + *    size. Sometimes, tighter packing might be possible but due to how
> + *    sizing and assignment are made in different phases, it is not alwa=
ys
> + *    possible to predict where each resource is assigned. Thus, the siz=
ing
> + *    has to play safe even if it may overestimate in some cases.
> + */
> +static resource_size_t calculate_win_gap_size(struct pci_bus *bus,
> +					      struct resource *b_res,
> +					      resource_size_t win_align,
> +					      bool optional,
> +					      struct list_head *realloc_head)
> +{
> +	resource_size_t safe_gap =3D 0, remainders =3D 0;
> +	unsigned int nonaligning =3D 0;
> +	struct pci_dev *dev;
> +
> +	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		struct resource *r;
> +		int i;
> +
> +		pci_dev_for_each_resource(dev, r, i) {
> +			resource_size_t r_size, remainder, aligning;
> +
> +			if (!pdev_resources_assignable(dev) ||
> +			    !pdev_resource_should_fit(dev, r))
> +				continue;
> +			if (b_res !=3D pbus_select_window(bus, r))
> +				continue;
> +
> +			if (!optional && pci_resource_is_optional(dev, i))
> +				continue;
> +
> +			r_size =3D resource_size(r);
> +			if (realloc_head && optional)
> +				r_size +=3D get_res_add_size(realloc_head, r);
> +			if (r_size <=3D win_align)
> +				continue;
> +
> +			aligning =3D ALIGN_DOWN(r_size, win_align);
> +			remainder =3D r_size - aligning;
> +			if (!remainder)
> +				continue;

[Severity: High]
Should calculate_win_gap_size() check and split each child resource against
its own required alignment pci_resource_alignment(dev, r) rather than the
parent bridge window's win_align?

During resource assignment in __pci_bus_assign_resources() ->
pbus_assign_resources_sorted() -> pci_assign_resource() ->
pci_align_resource(), each child resource r is aligned and split into an
aligning part and an adjacent remainder using its own alignment r_align =3D
pci_resource_alignment(dev, r).

However, during sizing in __pci_bus_size_bridges() -> pbus_size_mem(),
resources with r_size > align are excluded from aligns[order] while still
updating max_order, and pbus_size_mem() then passes min_align (for size0) or
add_align (for size1) as win_align to calculate_win_gap_size():

drivers/pci/setup-bus.c:pbus_size_mem() {
	...
			if (r_size <=3D align)
				aligns[order] +=3D align;
			if (order > max_order)
				max_order =3D order;
		}
	}

	win_align =3D pci_min_window_alignment(bus, b_res->flags);
	min_align =3D calculate_head_align(aligns, max_order);
	min_align =3D max(min_align, win_align);
	gap_size =3D calculate_win_gap_size(bus, b_res, min_align, !realloc_head,
					  realloc_head);
	...
	if (realloc_head && (add_size > 0 || children_add_size > 0)) {
		add_align =3D max(min_align, add_align);
		gap_size =3D calculate_win_gap_size(bus, b_res, add_align, true,
						  realloc_head);
}

When a child resource's r_align differs from win_align, this can omit the
required gap in three ways and cause pci_assign_resource() to fail with
-ENOSPC:

1. r_align < r_size <=3D win_align: Suppose a bus has a mandatory 64M BAR
(r_size =3D 64M, r_align =3D 64M) and two mandatory child bridge windows ea=
ch
with r_size =3D 20M and r_align =3D 16M. pbus_size_mem() computes size =3D =
104M
and min_align =3D 64M. In calculate_win_gap_size(), both 20M composite wind=
ows
are skipped by:

	if (r_size <=3D win_align)
		continue;

because 20M <=3D 64M, returning gap_size =3D 0 and sizing b_res to 104M ins=
tead
of the required 112M (64M + 20M + 20M + 8M gap). During assignment in a
104M window, the 64M BAR consumes the 64M-aligned region and leaves a 40M
region; placing the first 20M@16M window leaves no 16M-aligned block with
adjacent room for the second 20M@16M window.

2. min_align < r_size <=3D add_align when sizing optional resources for siz=
e1:
Suppose a bus has two mandatory 20M@16M child bridge windows (or three
18M@16M windows) plus an optional resource (such as a 32M SR-IOV BAR) that
raises add_align to 32M. The first call with min_align =3D 16M includes the
required 8M (or 42M) gap in size0, but the second call with add_align =3D 3=
2M
skips the mandatory 20M (or 18M) windows because r_size <=3D 32M, dropping
their required gap from size1.

3. win_align < r_align when calculate_head_align() reduces min_align:
Suppose a bus has two mandatory composite windows of r_size =3D 80M (or 96M)
with r_align =3D 64M and one 32M BAR (r_size =3D 32M, r_align =3D 32M). Bec=
ause
the composite windows have r_size > 64M, aligns[6] remains 0 while
max_order =3D 6 and aligns[5] =3D 32M, so calculate_head_align() reduces
min_align from 64M to 32M. Passing min_align =3D 32M as win_align computes
remainders modulo 32M (16M + 16M =3D 32M -> win_align - remainders =3D 0 for
80M, or remainder =3D 0 for 96M), returning gap_size =3D 0 even though two
64M-aligned composite resources and the 32M BAR cannot fit into the
resulting 192M window.

> +
> +			nonaligning++;
> +			remainders +=3D remainder;
> +			safe_gap +=3D win_align - remainder;
> +		}
> +	}
> +
> +	if (nonaligning =3D=3D 2 && (remainders <=3D win_align))
> +		return win_align - remainders;

[Severity: Medium]
Can returning win_align - remainders here underestimate the required gap
when smaller resources with r_size <=3D win_align are also present in the s=
ame
bridge window?

When a bridge window contains two non-aligning composite resources whose
remainders r1 and r2 sum to <=3D win_align plus one or more smaller resourc=
es
(skipped by r_size <=3D win_align) whose total size S is less than
min_align / 2, calculate_head_align() leaves min_align unchanged and Rule 2
sizes the bridge window to A1 + A2 + win_align + S. This assumes both
remainders r1 and r2 will share a single win_align block and leave a
contiguous S-sized region for the smaller resources.

However, during pbus_assign_resources_sorted() -> pci_assign_resource() ->
pci_align_resource(), candidate[2] in drivers/pci/setup-res.c evaluates
placing the first composite resource's remainder at the right end of the
window:

drivers/pci/setup-res.c:pci_align_resource() {
	...
	candidate[2] =3D DEFINE_RES(ALIGN_DOWN(empty_res->end + 1 - remainder, ali=
gn) -
				  aligning, size, type);
}

When r1 <=3D S and r2 + S > win_align, candidate[2] places the first compos=
ite
resource's remainder r1 into the trailing S-sized tail because doing so
maximizes the power-of-two natural_size of the remaining free space on the
left. Once the second composite resource is placed, the space intended for S
is split into two fragments (S - r1 at the right tail and win_align - r2 on
the left), neither of which is large enough to fit the smaller resource,
causing its assignment to fail with -EBUSY.

> +
> +	if (nonaligning >=3D 2)
> +		return safe_gap;
> +
> +	return 0;
> +}

[Severity: Medium]
Is an alignment gap also needed when nonaligning =3D=3D 1 and the single
composite resource's remainder is not aligned to a smaller sibling
resource's alignment?

Consider a bus with one composite child bridge window r1 of size 84M
(64M + 16M + 4M, align =3D 64M) and one normal sibling BAR r2 of size 16M
(align =3D 16M). In pbus_size_mem(), r1 has r_size > align so aligns[6] is 0
with max_order =3D 6, while r2 sets aligns[4] =3D 16M. Because 16M < 64M / =
2,
calculate_head_align() returns min_align =3D 64M.

In calculate_win_gap_size(), r1 has remainder =3D 20M (nonaligning =3D 1) a=
nd r2
is skipped because 16M <=3D 64M. Because nonaligning < 2, it returns 0 and
pbus_size_mem() sizes b_res to 84M + 16M =3D 100M with min_align =3D 64M.

When b_res (size 100M, align 64M, aligning =3D 64M, remainder =3D 36M) is
assigned by pci_align_resource():

drivers/pci/setup-res.c:pci_align_resource() {
	...
	candidate[0] =3D DEFINE_RES(ALIGN(empty_res->start, align), size, type);
	candidate[1] =3D DEFINE_RES(ALIGN(empty_res->start, align) - remainder,
				  size, type);
	candidate[2] =3D DEFINE_RES(ALIGN_DOWN(empty_res->end + 1 - remainder, ali=
gn) -
				  aligning, size, type);
	candidate[3] =3D DEFINE_RES(ALIGN_DOWN(empty_res->end + 1, align) - size,
				  size, type);
}

every candidate places b_res at either [K, K + 100M) or [K - 36M, K + 64M)
for some 64M-aligned address K, so b_res contains only a single 64M-aligned
block [K, K + 64M).

During pbus_assign_resources_sorted(), r1 (align 64M) is assigned before r2
(align 16M), consuming [K, K + 64M) and placing its adjacent 20M remainder
at [K + 64M, K + 84M) (or [K - 20M, K)). That leaves only [K + 84M, K + 100=
M)
(or [K - 36M, K - 20M)) for r2; both 16M intervals are shifted by 20M (only
4M-aligned) and straddle a 16M boundary, so __find_resource_space() fails to
assign r2 with -EBUSY.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021124956.4250=
-1-ilpo.jarvinen@linux.intel.com?part=3D7
