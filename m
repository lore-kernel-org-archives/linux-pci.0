Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF86B3E3C72
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779971111; cv=none; b=qPgjGlrFD6cP3ZbCXqRA4gYHnCETT1oQT1vrZSK9XvMWTtt3kLsx9QwP47IgAi1965Ej7QgtNInk/3VITtDlOZ+vMblA0mr0ecW2m/pzRIpqN3JpJMBukrtKCA4LAga6G6/6GKSpGTh4KyPud+L1osymzynZW315yX0eCpKRfjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779971111; c=relaxed/simple;
	bh=SZzyV6zVpfcAUlErInHgwGuTjTzARo3+txHuiCbZ0AA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bMVOkLTSNQXjOHvYjl9PJB32esFMdKrgXscIkBl6UdhSduS3c3/XxuOTbuixi+XDc5D4wGDcKDShxIr9aCx7wsOfWb2kUI9dUmpyhQsydKVkOp0hAJpSg/pH2yeQZbbeVfOY+LFVxkxjSlw39DrxM00IOWczdBKBXaMNcLR4eDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYosvVxd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYosvVxd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899271F00A3A;
	Thu, 28 May 2026 12:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779971109;
	bh=VlV2+U7Meti+TsbG8mNI6A6wt6Uxrmad1CHHgXpKHfA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iYosvVxd99lBrNZe0lrEY+1lzSdKkcae/Gcmn5rjh2gCdlqauYMb9BvuHSEZqBbgX
	 qPTAMDrttHqnQBGoDHmnWnDd1340XuIqHvEF1pIfMTGpg6mR3zTM4diNul/DIGSKjp
	 T6LfwkAUosbcN/y9JwGgpZ2qrEQcA3dyldvkf/kd3FF08BPbfy4EOodkhZB0Dh9/cn
	 JeKCgmxibz82AyN60kyc6dG+yTPWqkOafuIltpd9oMVhd0jfYnIs4an1PLth+Vlxjd
	 xHpcYhkrpYLIYrydAZ8WuuJtkOs7YOhX3+RF/Pp5GBAlV12QaRopHnniLEYq2mExsN
	 uGg4B0lA8O4tQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 7/9] cxl/pci: Orchestrate CXL reset for affected
 memdevs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260528083154.137979-8-smadhavan@nvidia.com>
References: <20260528083154.137979-8-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 12:25:08 +0000
Message-Id: <20260528122509.899271F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] cxl_reset_disable_memdevs() fails to update cxlds->media_ready to =
false when disabling CXL.mem.
- [High] Missing wait for pending DMA transactions before blocking the IOMM=
U for sibling PCI functions.
- [High] Early PCI config state restore re-enables bus mastering while the =
IOMMU is still blocked.
- [Medium] Mixing goto-based error handling and scope-based cleanup helpers=
 in the same function.
--

commit 1e8789977f0aca50924f7c6f37e03c4dc2387cd7
Author: Srirangan Madhavan <smadhavan@nvidia.com>

cxl/pci: Orchestrate CXL reset for affected memdevs

This commit adds a reset flow for CXL devices that coordinates the target
function, sibling functions, and active memdevs. It collects regions,
flushes caches, saves and disables functions, and then executes the CXL
reset before restoring PCI config space and re-enabling CXL.mem.

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index c755c18c8d84a..486c447e98f3f 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c

[ ... ]

> +static int cxl_pci_functions_reset_prepare(struct cxl_reset_context *ctx)
> +{
> +	int rc, i;
> +
> +	ctx->nr_siblings_prepared =3D 0;
> +
> +	for (i =3D 0; i < ctx->nr_siblings_locked; i++) {
> +		struct pci_dev *sibling =3D ctx->siblings[i];
> +
>  		pci_dev_save_and_disable(sibling);
>  		rc =3D pci_dev_reset_iommu_prepare(sibling);

[Severity: High]
Is it safe to block the IOMMU here without waiting for in-flight DMA
transactions to drain?

pci_dev_save_and_disable() disables bus mastering, but any transactions
already in flight might be dropped by the IOMMU and raise AERs (Advanced
Error Reporting faults) if we don't wait for them.

The target device correctly drains its transactions using
pci_wait_for_pending_transaction(), could we do the same for the sibling
functions here?

[ ... ]

> +static void cxl_pci_functions_restore_state(struct cxl_reset_context *ct=
x)
> +{
> +	int i;
> +
> +	for (i =3D ctx->nr_siblings_prepared - 1; i >=3D 0; i--)
> +		pci_restore_state(ctx->siblings[i]);
> +}

[Severity: High]
Does restoring the PCI config space here re-enable bus mastering while the
IOMMU is still actively blocking requests?

pci_restore_state() restores the entire saved PCI config space, including
the PCI_COMMAND register with the PCI_COMMAND_MASTER bit set.

Since the IOMMU is not unblocked until pci_dev_reset_iommu_done() runs
later during cleanup, could this allow the device to issue DMAs (or
MSI/MSI-X interrupts) that will trigger IOMMU faults and AERs?

[ ... ]

> +static void cxl_reset_disable_memdevs(struct cxl_reset_context *ctx)
> +{
> +	int rc, i;
> +
> +	for (i =3D ctx->nr_memdevs - 1; i >=3D 0; i--) {
> +		struct cxl_memdev *cxlmd =3D ctx->memdevs[i].cxlmd;
> +
> +		if (!ctx->memdevs[i].active)
> +			continue;
> +
> +		rc =3D cxl_set_mem_enable(cxlmd->cxlds, 0);

[Severity: High]
Could this leave the device state indicating the media is active when
physical memory decode has been disabled?

cxl_set_mem_enable() disables CXL.mem on the device, but
cxlds->media_ready isn't updated to false here. If the system subsequently
attempts to access this memory, could it result in unhandled unsupported
requests (UR) and trigger fatal bus errors?

[ ... ]

> +static int __maybe_unused cxl_do_reset(struct pci_dev *pdev, bool mem_cl=
ear)
> +{
> +	struct cxl_reset_context ctx =3D {
> +		.target =3D pdev,
> +	};
> +	int rc;
> +
> +	/*
> +	 * Snapshot the CXL r3.2 9.7 device reset scope before taking
> +	 * cxl_rwsem.region. Hot-added functions after this point are not
> +	 * coordinated by this reset operation.
> +	 */
> +	rc =3D cxl_reset_collect_siblings(&ctx);
> +	if (rc)
> +		goto out;
> +
> +	rc =3D cxl_reset_collect_memdevs(&ctx);
> +	if (rc)
> +		goto out;
> +
> +	scoped_guard(rwsem_write, &cxl_rwsem.region)
> +		rc =3D cxl_do_reset_locked(&ctx, mem_clear);
> +
> +out:
> +	cxl_reset_context_destroy(&ctx);
>  	return rc;
>  }

[Severity: Medium]
Is it intended to mix goto-based error handling and scope-based cleanup
helpers in the same function?

This function uses "goto out" for early error paths, but then uses
scoped_guard() below. The cleanup subsystem guidelines in
include/linux/cleanup.h state that goto and cleanup helpers should never be
mixed in the same function, as it can create confusing ownership semantics
and increase the risk of double-free or resource leak bugs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528083154.1379=
79-1-smadhavan@nvidia.com?part=3D7
