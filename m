Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF9F48D890
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 11:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790941875; cv=none; b=R9J2schYLAT573I8TqBiRzzsDFSwxnj5CLlxrF5H06phPW4LgzBv38jGiogN31mEfLSljQveJgiKhlufqkG2b8PocNfcit6Jl79hznkHrete37Btip8G1JSXezfFwpe9brLJmQeLIpJLn0oT1kFhqpnDGbSZAHJlORWpLl3dWH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790941875; c=relaxed/simple;
	bh=sjMQyamBNUIs3V8iWT+BD/au4npoQYbUAs/BGW77Yks=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F0/HV8MeRUrGn00uGBO0GJy3nQGecBXYfgepGtieErt77ryYEJVWLLISLUmsCZTJ4bElqI3JG3YgK7Cip3aUNjHzHrFDh2AMP6MvPpaYQ+7b5Gf7SvvFBwKQixl2CNFPXlb7Vt0L0E0BT+YQJ0UNRw9YwIHzbjp8aP9hHh8N8ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bC38wPag; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bC38wPag"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC091F000FF;
	Fri,  2 Oct 2026 11:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790941873;
	bh=fxfyIUw89OYRKoAeiZ9SNIqYWkFg/I4wdUzdtE2Qm1E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bC38wPagPmREDANK7DcIjtU0tr57OkEk0+4xBTlVIsWdLp46um4yJzZV1qbbgwB9o
	 2JBF/wrtNXq+0Ms/qzzEnPb7MEsoY4QO32wdSHf3c5LhfOWyKXscF21bT0hIozUE4S
	 582HTq8zStq/Mxvn5N9ypI7fNoDXR68oQ41r6CsS97tqhA2gcph+tFldkyjwnwOVhN
	 AcWSwR06DxSVxSjE61jLTBdo3T/r0YDUNkTnVpp9G9XCD7JrmVwNLepd0Z8BEby0oP
	 5U5YGpuD/3z3Yq6Sr7WZH9abUrYHEdzS/YmPn6QW1fpOVjabsqVrVpv4khUxKYuJfJ
	 yp5ss/chEC3lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/7] PCI: Fix composite resource sizing
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261002113319.6652-7-ilpo.jarvinen@linux.intel.com>
References: <20261002113319.6652-1-ilpo.jarvinen@linux.intel.com>
 <20261002113319.6652-7-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 11:51:12 +0000
Message-Id: <20261002115113.0FC091F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] pci: undersized bridge windows during hotplug due to ignored optio=
nal resources
- [High] pci: gap calculation ignores expanded sizes, undersizing optional =
bridge windows
- [High] pci: gap optimization incorrectly assumes perfect packing, causing=
 allocation failures
--

commit 17592808ea429ea63c8337b7e33d67bb459cf0c2
Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Subject: PCI: Fix composite resource sizing

This commit adds a bridge window gap size calculator to correctly pad
alignments for non-aligning composite resources back to back. The gap is
calculated based on the minimal alignment for the bridge window.

Link: https://lore.kernel.org/linux-pci/20260903063124.9316-1-nbritton@exab=
it.io/

> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 7ca0e9f4ffb63..9d828a59bd002 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
[ ... ]
> +static resource_size_t calculate_win_gap_size(struct pci_bus *bus,
> +					      struct resource *b_res,
> +					      resource_size_t win_align,
> +					      bool optional)
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

[Severity: High]
During the optional sizing pass, calculate_win_gap_size() is called with
optional=3Dtrue, but the gap requirement is evaluated using the unexpanded =
base
size from resource_size(r). It does not appear to consider the requested
add_size expansions from realloc_head.

If a child bridge's base size perfectly aligns to the parent's add_align
(resulting in a 0 gap here), but the child's expanded size is unaligned, wo=
n't
this result in an undersized parent optional window because it failed to
provision the padding gap for the expanded size?

> +			if (r_size <=3D win_align)
> +				continue;
> +
> +			aligning =3D ALIGN_DOWN(r_size, win_align);
> +			remainder =3D r_size - aligning;
> +			if (!remainder)
> +				continue;
> +
> +			nonaligning++;
> +			remainders +=3D remainder;
> +			safe_gap +=3D win_align - remainder;
> +		}
> +	}
> +
> +	if (nonaligning =3D=3D 2 && (remainders <=3D win_align))
> +		return win_align - remainders;

[Severity: High]
Does this optimization assume perfect packing of fragmented remainders,
violating the strict alignment constraints of the resources themselves?

If both resources require win_align alignment (e.g., both have size 5MB and
alignment 4MB), the second resource cannot be placed adjacent to the first
and must be bumped to the next 4MB boundary. Wouldn't this reduction in the
gap cause the second resource to fail assignment because the bridge window
is undersized?

> +
> +	if (nonaligning >=3D 2)
> +		return safe_gap;
> +
> +	return 0;
> +}
[ ... ]
> @@ -1345,7 +1416,8 @@ static void pbus_size_mem(struct pci_bus *bus, stru=
ct resource *b_res,
>  	win_align =3D pci_min_window_alignment(bus, b_res->flags);
>  	min_align =3D calculate_head_align(aligns, max_order);
>  	min_align =3D max(min_align, win_align);
> -	size0 =3D calculate_memsize(size, realloc_head ? 0 : add_size,
> +	gap_size =3D calculate_win_gap_size(bus, b_res, min_align, false);

[Severity: High]
When a device with optional resources (like SR-IOV BARs) is sized via a path
where realloc_head is NULL (e.g., during hotplug via pci_bus_size_bridges()=
),
pbus_size_mem() accumulates the sizes of those optional resources into the
base size because pbus_size_mem_optional() returns false.

However, the gap calculator is invoked here with optional=3Dfalse, which
unconditionally drops optional resources. Doesn't this cause their required
alignment padding gaps to be omitted from the bridge window entirely, leavi=
ng
the bridge window undersized?

> +	size0 =3D calculate_memsize(size + gap_size, realloc_head ? 0 : add_siz=
e,
>  				  0, win_align);
> =20
>  	if (size0) {
> @@ -1355,8 +1427,9 @@ static void pbus_size_mem(struct pci_bus *bus, stru=
ct resource *b_res,
> =20
>  	if (realloc_head && (add_size > 0 || children_add_size > 0)) {
>  		add_align =3D max(min_align, add_align);
> -		size1 =3D calculate_memsize(size, add_size, children_add_size,
> -					  win_align);
> +		gap_size =3D calculate_win_gap_size(bus, b_res, add_align, true);
> +		size1 =3D calculate_memsize(size + gap_size, add_size,
> +					  children_add_size, win_align);
>  	}
> =20
>  	if (!size0 && !size1) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002113319.6652=
-1-ilpo.jarvinen@linux.intel.com?part=3D6
