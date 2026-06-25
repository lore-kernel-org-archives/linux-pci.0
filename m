Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0B23BCD26
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 06:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782368408; cv=none; b=FI8FksTUPyEX1W+S+S47dAes0D448tsl+CWW9fFsmwGuEP102CsaEmn4wlD82ANxGKxjX3pboh4vhnecHH9zvEkmxdAXFltexlcvTtql+pcRMHGdOazRYHej3shk+r5ejOyj9V7bT3lLNoRBpGV+tiFjficot/PnxIKneNg85RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782368408; c=relaxed/simple;
	bh=+mLI8Uyaj/930IFzM83KxN7uTqAgveFGJvQ7pHmre38=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UhZ3Du4Bbmfi/Q4MXt3DvuP0gH7qT05HyQmOUb0HZxOb29EH4itLRpfUZpMT1gzYLsV5fqUDvMz2SvqxWt78HZ2JmeotG8bGgm2Xzu6kDeX/zgZ/4I4UHo2uL/LyWOdI2XIC2GW1WxoGeK0zWqE87vGgWrfwSKfPtC1A7OqAjYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtD/2ZFp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtD/2ZFp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E788A1F000E9;
	Thu, 25 Jun 2026 06:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782368407;
	bh=WmdeSPT+baRzcJjQeJ5Y42WFPGFIEsGo+zKWPdUA8oY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RtD/2ZFpxvWS7knpLgukjHPbbL+AZzJDGFcJIsNd/Wt2lHxeKRA5DByImdCK1seNv
	 w1xdy5mjuNnUDjgMhHE/ox+/0bx2FdYhc8lOiuBGi6WdLBJM4hCjavbwieRTon0M7D
	 Mz/ugMiEAQv30ExSvWhjrU38HsArfdnYAUiXqdEwzv734a6JRxAmB4zV0FLxfnE6q1
	 IdHgIkNSfznMF+5x8OZeNlSfRubXHI7+sj79gQYcpZ2LslYpjLgTZ8FICz23B/uCBs
	 It10OPIEe9cLttHQGpVLxI9Iy2T0HsrWTJrViSqMd0gDBeZPFuRA/0Xlqk94QDGTE1
	 GnffPkyUyHNpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/8] PCI: vmd: Replace hardcoded values with enum and
 defines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260625082940.1290740-6-szymon.durawa@linux.intel.com>
References: <20260625082940.1290740-1-szymon.durawa@linux.intel.com>
 <20260625082940.1290740-6-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 06:20:06 +0000
Message-Id: <20260625062006.E788A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Leak of dynamically allocated resource names on the vmd_probe er=
ror path.

Pre-existing issues:
- [High] Missing pci_free_irq_vectors() calls in error paths and during dev=
ice removal, leading to vector leakage.
- [High] vmd_cleanup_srcu() destroys SRCU structs before devm-managed IRQ h=
andlers are unregistered.
--

commit 415d4461cb0ec06aaac750c476d8975aa2ffae22
Author: Szymon Durawa <szymon.durawa@linux.intel.com>

PCI: vmd: Replace hardcoded values with enum and defines

Add enum vmd_resource type to replace hardcoded values. Add defines for
vmd bus start number based on VMD restriction value. No functional
changes.

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index c0a953df5f238..9ff82a24e859c 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
[ ... ]
> @@ -794,7 +806,8 @@ static void vmd_configure_cfgbar(struct vmd_dev *vmd)
>   *
>   * Function fills resource buffer inside the VMD structure.
>   */
> -static void vmd_configure_membar(struct vmd_dev *vmd, u8 resource_number,
> +static void vmd_configure_membar(struct vmd_dev *vmd,
> +				 enum vmd_resource resource_number,
>  				 u8 membar_number, resource_size_t start_offset,
>  				 resource_size_t end_offset)
>  {

[Severity: Medium]
Does this memory allocation lack proper cleanup in error paths?

In vmd_configure_membar(), resource names are allocated dynamically:

    .name =3D kasprintf(GFP_KERNEL, "VMD MEMBAR%d %s", membar_number / 2, .=
..),

If vmd_enable_domain() fails after these names are successfully allocated,
the error propagates to vmd_probe(). The error handling block at the
out_release_instance label returns without explicitly freeing these allocat=
ed
strings, which leaks memory.

[ ... ]
> @@ -1104,8 +1119,8 @@ static void vmd_remove(struct pci_dev *dev)
>  	pci_remove_root_bus(vmd->bus);
> =20
>  	/* CFGBAR is static, does not require releasing memory */
> -	kfree(vmd->resources[1].name);
> -	kfree(vmd->resources[2].name);
> +	kfree(vmd->resources[VMD_RES_MBAR_1].name);
> +	kfree(vmd->resources[VMD_RES_MBAR_2].name);

[Severity: High]
This isn't a bug introduced by this patch, but does this function omit the
required call to pci_free_irq_vectors()?

The PCI subsystem guidelines require that after a successful call to
pci_alloc_irq_vectors(), every error path and device removal must explicitly
call pci_free_irq_vectors() to prevent leaking IRQ vectors.

If init_srcu_struct() or devm_request_irq() fails in vmd_alloc_irqs(), or if
any operation fails in vmd_enable_domain() after allocation, the function
returns without cleanup.=20

Similarly, this vmd_remove() function completes tear-down without freeing=20
the vectors. Exhausting system IRQ capacity could prevent future allocation=
s.

> =20
>  	vmd_cleanup_srcu(vmd);

[Severity: High]
This isn't a bug introduced by this patch, but does cleaning up SRCU here
create a race condition with the devm-managed IRQ handler?

During device removal, vmd_remove() calls vmd_cleanup_srcu() to destroy
the SRCU structs. However, the driver's IRQ handlers were registered using
devm_request_irq(), which means they aren't deregistered until the devres
cleanup phase executes after vmd_remove() returns.

If a spurious MSI interrupt fires during this window, the handler will run
and invoke srcu_read_lock() on the already destroyed srcu_struct:

drivers/pci/controller/vmd.c:vmd_irq() {
    ...
    idx =3D srcu_read_lock(&irqs->srcu);
    ...
}

Could this use-after-free on per-CPU memory lead to memory corruption?

>  	vmd_detach_resources(vmd);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625082940.1290=
740-1-szymon.durawa@linux.intel.com?part=3D5
