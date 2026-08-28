Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E7733E355
	for <linux-pci@vger.kernel.org>; Fri, 28 Aug 2026 22:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787954427; cv=none; b=Ft1wfsDdYYAAw5LFo/1b3FWv0J1Jyq97U8AQU7m41sPMwFr07XH/6aXEZYwu4CFcvfmP8+AjUsqjOBYX8VTm+MgKtWzegL9IIlWsuzNGIxjxMTH/bgNIWbdy2kUw43kSNX+6+YbkPabB0u5hPkO+ZthzZlc3HwYqJNWm5CEQdmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787954427; c=relaxed/simple;
	bh=/TCvAcFf21i13VycFB1QIPxFdEe9xcJBrAiYoZ54BqY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m3JOdPkMne3Z7Dh5Doxueo7XusfpWcfvknmnhi0nCJyQ9iNDy4r9cG7yHI5SllSBFEvYkNaAKivBhoF5V6WELgARIQaGn0oNtEAUm2d0uY6498EwgW/00JVc6NPFBa4MQ16BPtd6BZ2sSWa47lvdwAzT0R5laLa2XcGtrFRlhok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJy4FW3P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJy4FW3P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561491F00A3D;
	Fri, 28 Aug 2026 22:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787954425;
	bh=xvMtLl1GluBnw1OslGitkg1x0UjAoDJ77bpqpwgE3H4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TJy4FW3Pf75ooZ66wCFYe2jvSWD//MygEb7QXAry2MVkGjFDefWjNzDvrjLHqzTlq
	 R9YtL/RzGyaBmy9H7UL1pDx+6JWE0W4RK7k3dyX+0x764pmCs6JwXViNt4DvsLxZ2U
	 KhvmVLx89dgW/iXrLarkYfS8YlGhGdKJcCxQ+3Qw/X9xsJZLDBGZ4pPtxTvzsAdPG7
	 dSteuVZUkO+wDVnAZeM7AOobwaIPibxhUSchEv6ARQvvE8BcLZhBFKNVWn4vlHyawV
	 bkaD/iSRYDnQxpxokbatmmmpGhOGwfo0gd5FNtMOKbjbgNpdWKOGYPQ19wuVVlIFl3
	 /xIjeogkGFLTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: Reserve prefetchable window headroom for
 Resizable BARs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geramy Loveless" <gloveless@jqluv.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <5524e9e5-ecac-41c8-b11a-60a85f82fa17@jqluv.com>
References: <5524e9e5-ecac-41c8-b11a-60a85f82fa17@jqluv.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 22:00:24 +0000
Message-Id: <20260828220025.561491F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Fatal 64-bit size truncation using `roundup_pow_of_two()` on 32-bi=
t platforms.
- [High] Stripping `IORESOURCE_PREFETCH` silently breaks write-combining (W=
C) mappings for control BARs.
- [High] ReBAR headroom reservation is erroneously added as a mandatory siz=
e requirement instead of an optional one, potentially causing total resourc=
e allocation failures.
- [High] BAR demotion permanently strips the PREFETCH flag, making fallback=
 to the prefetchable window impossible if 32-bit space is exhausted.
- [Medium] Hardcoded BAR 0 incorrectly assumes Resizable BAR capabilities o=
nly exist on the first BAR, breaking headroom reservation for GPUs with dif=
ferent topologies.
- [Medium] Upstream bridge windows are permanently pinned if a non-display =
device shares the switch topology.
--

commit ab6d281d10e22bc05fa969730e7cb1fb4d1cc31e
Author: Geramy Loveless <gloveless@jqluv.com>

PCI: Reserve prefetchable window headroom for Resizable BARs

Firmware typically sizes prefetchable bridge windows for the boot-time
BAR size. Behind a fixed PCIe switch fabric, there is then no room for a
driver to grow a Resizable BAR afterwards. This patch reserves prefetchable
window headroom and demotes small prefetchable BARs below 4 GiB to enable
ReBAR on cascaded switch fabrics.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index de9bbccda21fd..57a5926a273c6 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
[ ... ]
> +	for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> +		r =3D pci_resource_n(dev, i);
> +		if ((r->flags & (IORESOURCE_MEM | IORESOURCE_PREFETCH)) !=3D
> +		    (IORESOURCE_MEM | IORESOURCE_PREFETCH))
> +			continue;
> +		if (r->flags & IORESOURCE_PCI_FIXED)
> +			continue;
> +		if (pci_resource_alignment(dev, r) >=3D max_align)
> +			continue;		/* an alignment-setting BAR, keep it */
> +		if (resource_size(r) > PCI_BAR_PACK_CAP)
> +			continue;		/* not a small control BAR */
> +
> +		r->flags &=3D ~IORESOURCE_PREFETCH;

[Severity: High]
Does stripping this flag silently break write-combining mappings? When the
driver calls pci_ioremap_wc(), architecture code like x86 PAT checks the
IORESOURCE_PREFETCH flag to permit write-combining. Removing it forces
critical MMIO regions like GPU doorbells to fall back to strict uncacheable
mappings, which might degrade performance.

[Severity: High]
If the 32-bit non-prefetchable window is exhausted, does clearing this flag
prevent a graceful fallback to the prefetchable window? The commit message
states that it will gracefully fall back, but pci_bus_alloc_resource()
strictly forbids allocating a non-prefetching resource from a prefetching
area, which might leave the device unassigned and unusable.

> +		pci_info(dev, "%pR: assigned from the non-prefetchable window to pack =
the prefetchable window\n",
> +			 r);
> +	}
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, quirk_pci_pack_prefetch=
);
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index e8c94aa1d3c12..aa02b8454269a 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
[ ... ]
> @@ -1343,15 +1392,29 @@ static void pbus_size_mem(struct pci_bus *bus, st=
ruct resource *b_res,
>  				aligns[order] +=3D align;
>  			if (order > max_order)
>  				max_order =3D order;
> +
> +			size +=3D pci_rebar_reserve_size(dev, i, &rebar_align);

[Severity: High]
Could this cause total resource allocation failures? The ReBAR headroom is
being added directly to the size accumulator, which dictates the mandatory
size required for the bridge window. If it were added to children_add_size,
it would dictate the optional reallocation size. If a parent bridge lacks
sufficient contiguous address space, this might cause the entire bridge
window allocation to fail completely.

>  		}
>  	}
> =20
>  	win_align =3D pci_min_window_alignment(bus, b_res->flags);
>  	min_align =3D calculate_head_align(aligns, max_order);
>  	min_align =3D max(min_align, win_align);
> +	min_align =3D max(min_align, rebar_align);
>  	size0 =3D calculate_memsize(size, realloc_head ? 0 : add_size,
>  				  0, win_align);
> =20
> +	/*
> +	 * A window that reserves ReBAR headroom is larger than its own
> +	 * alignment (e.g. 32 GiB BAR + doorbell =3D> 33 GiB > 32 GiB). The
> +	 * parent only reserves alignment padding for a child window when
> +	 * its size <=3D its alignment, so round such a window's alignment up
> +	 * to a power of two >=3D its size; sibling 32 GiB BARs behind one
> +	 * switch then each land in a properly aligned slot.
> +	 */
> +	if (rebar_align && size0)
> +		min_align =3D max(min_align, roundup_pow_of_two(size0));

[Severity: High]
Does this cause a fatal 64-bit size truncation on 32-bit platforms? The
size0 variable is passed into the roundup_pow_of_two() macro, which only
safely supports unsigned long. On 32-bit platforms with 64-bit physical
addresses, this might assign the bridge window an undersized alignment.

> +
>  	if (size0) {
>  		resource_set_range(b_res, min_align, size0);
>  		b_res->flags &=3D ~IORESOURCE_DISABLED;
[ ... ]
> +static int pci_release_rebar_bars_cb(struct pci_dev *dev, void *data)
> +{
> +	struct resource *r;
> +	unsigned int i;
> +
> +	if ((dev->class >> 16) !=3D PCI_BASE_CLASS_DISPLAY)
> +		return 0;
> +	if (pci_rebar_get_max_size(dev, 0) <=3D pci_rebar_get_current_size(dev,=
 0))

[Severity: Medium]
Does this hardcoded index correctly handle devices that might have a
Resizable BAR at a non-zero index? By explicitly checking only BAR 0, this
might skip headroom reservation for devices like Intel DG2 GPUs that have
their ReBAR on a different index, causing them to fail with -ENOSPC later.

> +		return 0;
> +	pci_dev_for_each_resource(dev, r, i) {
> +		if (i >=3D PCI_BRIDGE_RESOURCES)
> +			break;
> +		if (r->parent && (r->flags & IORESOURCE_MEM_64) &&
> +		    (r->flags & IORESOURCE_PREFETCH))
> +			pci_release_resource(dev, i);
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Release the now-empty prefetchable bridge windows bottom-up so the si=
zing
> + * pass re-sizes them (with pci_rebar_pref_reserve() reservation) to fit=
 the
> + * BARs a driver will later grow.
> + */
> +static void pci_release_rebar_windows(struct pci_bus *bus)
> +{
> +	struct pci_dev *dev;
> +	struct resource *w;
> +
> +	list_for_each_entry(dev, &bus->devices, bus_list)
> +		if (dev->subordinate)
> +			pci_release_rebar_windows(dev->subordinate);
> +
> +	if (!bus->self)
> +		return;
> +	w =3D &bus->self->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
> +	if (w->parent && (w->flags & IORESOURCE_MEM_64) && !w->child)

[Severity: Medium]
Will this permanently pin the upstream bridge window if a non-display device
shares the switch topology? Since pci_release_rebar_bars_cb() restricts BAR
releases strictly to PCI_BASE_CLASS_DISPLAY devices, any non-display sibling
with a prefetchable BAR will retain it. This leaves w->child populated, whi=
ch
prevents the upstream window from being released and resized.

> +		pci_release_resource(bus->self, PCI_BRIDGE_PREF_MEM_WINDOW);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/5524e9e5-ecac-41c8-=
b11a-60a85f82fa17@jqluv.com?part=3D1
