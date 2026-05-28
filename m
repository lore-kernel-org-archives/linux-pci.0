Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D3C321445
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962942; cv=none; b=qFkIaOVEUa62vxpKGbq4JGkc0zQdbe9mJihPJcjDVrNFqdyeQPdfr2MM7ZSZmaHTGpqvP+XdrEAmDp2Rczse8andTvC6AphOnpS1xgqNKm9v+nC6Cg1q6jOT2QQHVnr3effzCSMuEnVQo4kjwsPxnS2+RaDB9r0enpTNlX7w9/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962942; c=relaxed/simple;
	bh=wrz/BsYzYyUaCxhKS5G+FqD/zUsswld3UAzi2ZPlI8s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hXsvgNEV1LG9b6tdg0MHiKHpltSHArIWJl4U7uKgwoXQSsS7ZxINjLjOtwH0Fk/p/YM9Z6MdhOW9vt83KXarEOzl9uC7UCLKB1/D0Oxx0q7Z8nUoa9bUELKHsUuwR71Lo8eY07pHHSUcSaRm+jCRPxqnfuW5GCYbn++hBtrRbx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6eza43K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6eza43K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784D31F000E9;
	Thu, 28 May 2026 10:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779962940;
	bh=sM8TM3MMoKPMnhJHbmCL4v2DAbWdM/KWn7OxtiejmGQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e6eza43K3SiwQC99gpRRdhDKJGFDbkaSvlzSNdrnYHlQUOmZNWvR7bfR7I/+AdJ0e
	 c7elI6nnHmw8eijGi9VzN0u5wUolmRsK+Mu2K2iEvzsyOt6bfPS8a+9KxzgQoGwMnI
	 KZV0dVAS7/zyu/6GAZRhfUPkGBBPmrZ8AvEzEwtUdFQ9bTXyhsDuOSUcmUog9xyoZP
	 56onU1hYqZSCxDyKEcAQdjCW6xAI30Do2ts9UfFUGgbh8LuPQBhn5f0RX9zOhhNne5
	 1AYIYMk4psiYRAGWPbYmMPl133y9EsD0NwoUjGGEEKa8ORizkeoQyPVRzp5vjXGbuX
	 YufQswOPe+SeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/9] cxl: Add reset-idle and cache flush helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260528083154.137979-4-smadhavan@nvidia.com>
References: <20260528083154.137979-4-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 10:09:00 +0000
Message-Id: <20260528100900.784D31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Dereferencing an ERR_PTR as a device pointer leads to a kernel pan=
ic.
- [Medium] Using a pointer address as an XArray index creates an unnecessar=
ily deep radix tree, wasting memory.
- [Low] Silent truncation of region size when calling cpu_cache_invalidate_=
memregion() on 32-bit systems.
--

commit 87c5409ded1cea23c3df266a42ac4769f6e16636
Author: Srirangan Madhavan <smadhavan@nvidia.com>

cxl: Add reset-idle and cache flush helpers

This commit adds helpers to collect CXL regions affected by a memdev
reset, verify they are idle, and invalidate CPU caches for those regions.
These helpers use an xarray to track regions and prepare the data path
for the actual reset orchestration.

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index d1f487b3d809a..318744695f628 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
[ ... ]
> @@ -926,3 +928,171 @@ int cxl_port_get_possible_dports(struct cxl_port *p=
ort)
[ ... ]
> +static int cxl_reset_add_region(struct cxl_reset_region_context *ctx,
> +				struct cxl_region *cxlr)
> +{
> +	int rc;
> +
> +	if (!cxlr || !cxlr->params.res)
> +		return 0;
> +
> +	rc =3D xa_insert(&ctx->regions, (unsigned long)cxlr, cxlr, GFP_KERNEL);

[Severity: Medium]
Since kernel pointers have their highest bits set on 64-bit systems, won't
using the pointer address as the XArray index force the radix tree to its
maximum depth and unnecessarily waste memory?

Could cxlr->id be used as the index instead to deduplicate regions more
efficiently?

> +
> +	/* A region may be referenced by multiple affected endpoint decoders. */
> +	return rc =3D=3D -EBUSY ? 0 : rc;
> +}
[ ... ]
> +static int __maybe_unused
> +cxl_reset_collect_memdev_regions(struct cxl_reset_region_context *ctx,
> +				 struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint;
> +
> +	if (!cxlmd || !cxlmd->cxlds)
> +		return -ENODEV;
> +
> +	endpoint =3D cxlmd->endpoint;
> +	if (!endpoint)

[Severity: High]
If cxlmd->endpoint hasn't been successfully probed and attached yet, it
holds an ERR_PTR value rather than NULL. Will this check fail to catch the
error pointer, allowing it to be passed into device_for_each_child()?

If so, dereferencing &endpoint->dev would cause a kernel panic. Should this
check use IS_ERR(endpoint) instead?

> +		return 0;
> +
> +	return device_for_each_child(&endpoint->dev, ctx,
> +				     cxl_reset_collect_region);
> +}
[ ... ]
> +static int cxl_reset_flush_region_cache(struct cxl_region *cxlr)
> +{
> +	struct resource *res =3D cxlr->params.res;
> +	int rc;
> +
> +	if (!res)
> +		return 0;
> +
> +	rc =3D cpu_cache_invalidate_memregion(res->start, resource_size(res));

[Severity: Low]
Can this silently truncate the region size on 32-bit systems?

The function cpu_cache_invalidate_memregion() takes a size_t for its length
parameter, while resource_size() returns a resource_size_t. On 32-bit
systems with PAE enabled, resource_size_t is 64-bit while size_t is 32-bit,
which could cause regions larger than 4GB to be partially skipped.

> +	if (rc)
> +		dev_err(&cxlr->dev, "Failed to invalidate CPU cache [%pr]: %d\n",
> +			res, rc);
> +
> +	return rc;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528083154.1379=
79-1-smadhavan@nvidia.com?part=3D3
