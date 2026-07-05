Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FB8370D54
	for <linux-pci@vger.kernel.org>; Sun,  5 Jul 2026 22:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783290506; cv=none; b=efHaLd2z4cuhDEXGMd8JXovVmBGhU55GcYfvA8wxuRgSxGKohpy+VtPyZBq3LWTtq5INXvpk4i99TnWqrVekoq0LFHMfkLjashj8pa2pnYjLK13p4+baz3UYtP0KE5dgOjApDjQxpUJXYPcqBxx/r9/crenTwiY+luKYRmXFkag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783290506; c=relaxed/simple;
	bh=XVtJ5dGybOsgTqYw1DooCZyJIzwXn2iNNSIQPP3fecA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aROP8LWG1FX7oD+r+dAigE2QUH+4YJM9LNpMElHihBkLg83WBc91PZN/VBM4JA84hDl5a55niODooNQoe627q67iCClvGlKqfpW34Fj5YXf9vb7GSdcdaBgvKYGwroWm3LlCKo0xgi+Li9YNYj3Ajsorm3ge6FhOHODrNbIOO4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsfJr6CJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsfJr6CJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BA41F000E9;
	Sun,  5 Jul 2026 22:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783290504;
	bh=Bqx5rbSc2dqxWJf5WcZMsGSBzgaFueEu3lTmwz4lwew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UsfJr6CJsj4LzDE9pmK6aNHTbdPS+EUsSlvDgm+Jz0hl+k/pz+JOHH56bdyu45cph
	 Np0l0arRlXWLWiXxWB3Os9BuOzIjBYuD9D9eQdz4pufvYRo+W5LBlZeOQABGaLjPkb
	 +Q8PhA3dqiU5f+W+5vcdER8U4fRbzI8X/w4I7p8QP/rptpt97TdBya7YRbN+1tYFYP
	 s/3jCSv2YvkBETPm1H3b4SlgtlnXbgvO8c55ni42FHfGCPjEI8B0pg/iEa2zkSK3qz
	 froiVi5S2sEFa5Q7zlGom/qfpXil8vHuC0O7AXFKFCXl4l+RG8WzaX9P79zUctkBaQ
	 blfsviuJSRz8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/15] PCI, device core: Add private memory access for
 DEVICE_TRUST_TCB
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dan Williams" <djbw@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260705220819.2472765-14-djbw@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260705220819.2472765-14-djbw@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 22:28:24 +0000
Message-Id: <20260705222824.C4BA41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing pci_tsm_disable_dma() in pci_dma_configure() error path an=
d pci_dma_cleanup() to revoke TCB DMA access.
- [Low] Invalid syntax in __must_hold attribute for pci_tsm_enable_dma and =
pci_tsm_disable_dma.
--

commit 02fe1d53a8bdd83c53510c3c6636b82d7cd34b02
Author: Dan Williams <djbw@kernel.org>

PCI, device core: Add private memory access for DEVICE_TRUST_TCB

This commit introduces the DEVICE_TRUST_TCB trust level to allow devices
within the Trusted Compute Boundary to access private memory. It updates
the PCI DMA configuration to validate DMA access with a TSM driver when a
device is TCB-trusted.

> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index f36778e62ac1a..e6a4bc3ca9b06 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c

[ ... ]

> @@ -1688,16 +1690,21 @@ static int pci_dma_configure(struct device *dev)
>  	 * the standard ACS capability but still support ACS via those
>  	 * quirks.
>  	 */
> -	pci_enable_acs(to_pci_dev(dev));
> -
> -	pci_put_host_bridge_device(bridge);
> +	pci_enable_acs(pdev);
> =20
>  	/* @drv may not be valid when we're called from the IOMMU layer */
> -	if (!ret && drv && !to_pci_driver(drv)->driver_managed_dma) {
> +	if (ret || !drv)
> +		return ret;
> +
> +	if (device_tcb_trusted(dev))
> +		ret =3D pci_tsm_enable_dma(pdev);
> +
> +	if (!ret && !to_pci_driver(drv)->driver_managed_dma)
>  		ret =3D iommu_device_use_default_domain(dev);
> -		if (ret)
> -			arch_teardown_dma_ops(dev);
> -	}
> +
> +	/* undo {of,acpi}_dma_configure() */
> +	if (ret)
> +		arch_teardown_dma_ops(dev);

[Severity: High]
If iommu_device_use_default_domain() fails, does this error path need to
call pci_tsm_disable_dma() to revoke the TCB DMA access granted above?

Also, when the device driver unbinds, should pci_dma_cleanup() be updated
to call pci_tsm_disable_dma() as well?=20

Without these cleanup calls, it appears the TSM could incorrectly maintain
DMA authorization for a device even after a probe failure or driver unbind.

[Severity: Low]
On a related note regarding the TSM core API modified in this series, are
the __must_hold() attributes in drivers/pci/tsm/core.c syntactically
correct?

drivers/pci/tsm/core.c:pci_tsm_enable_dma() {
    ...
    int pci_tsm_enable_dma(struct pci_dev *pdev)
        __must_hold(&pdev->dev->mutex)

Since dev is a nested struct within struct pci_dev, not a pointer,=20
shouldn't this be &pdev->dev.mutex to avoid compiler errors? The same
appears to apply to pci_tsm_disable_dma().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705220819.2472=
765-1-djbw@kernel.org?part=3D13
