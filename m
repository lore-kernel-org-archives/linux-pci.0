Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28F82B2D7
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787562543; cv=none; b=N9TlO7nDoFej+XyKfY0mMeuY1xI5LRm8DxZzRL8+nKg2Ks7dGfL64kh7/YmE7M5Iy1g1wzwsUxznX1cwdbcIjI4BszWXslu2w/K+ENh+mdM5Bzrx0GLncI+FJ+3cfL21/8GhqkJrIJJKtjYcHDp4OnpS4bD1yykUqZpu0WreCmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787562543; c=relaxed/simple;
	bh=YH/gRl0g3VBBElQPn6iyLF8ozs3ITFKRTr96+BPH6wM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OgSlGvFyBwGLutXotER3hnlq5W1FYOBlnOUbwuTdhdbLE6iG9lBQ9/rf8TvxPulnJelp5sTfpBKvrfYlPEmp0avZB/iZQct+u9Cj0+4AGSw7ljprc18x+GaIYKN0TqTmJ5G7LAasihZs++RDolMEjqk36eecUxTivaf9MPuhrTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLOOXAeY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLOOXAeY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752F91F000E9;
	Mon, 24 Aug 2026 09:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787562541;
	bh=wtAoDzGJuHZ/uSYFQA45rh8hI1qp0bc37md0w9tkpVM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LLOOXAeYwvOppBhRw7buQxVwsgXIS9bJHDJoj2I2cedLMGAnp0t+IqwlSUMkP8lax
	 9xgDjpzW1xCUM8xiUlGzqIgIzGA+vzM7sXlfjEogVJYh/eJlvLfU1y04nP1M5H/wPd
	 ifl1od/a4S1KSC0Fzp/oN2FvtEYf33PqCB4G7PuvFHI99VZBZHxHJwG0hFh7Hw3uKD
	 EpCVnTrnXfEe7mOHqrRLIjU72DGJvI3FPPdx0gbJq3ZgzscO1HUnoGviPNsEuUqCI+
	 TtgFTH+Ai4rS++/S32JdndiJ24/v9Z9j7anQOjrHaGKjYay8MztLa/WyFLAiG9WwG1
	 sdtfzba575rAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] iommu/amd: Force identity mode for selected GPUs
 only
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vasant Hegde" <vasant.hegde@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260824085821.5422-1-vasant.hegde@amd.com>
References: <20260824085821.5422-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 09:09:01 +0000
Message-Id: <20260824090901.752F91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Missing NULL pointer check for `pci_upstream_bridge()` causes =
a kernel panic during boot on systems where the GPU is on the root bus.
- [High] The heuristic used to distinguish discrete GPUs (dGPUs) from APU G=
PUs is flawed and will incorrectly force identity mapping on many dGPUs.
- [High] Discrete GPUs break on SNP-enabled systems due to the removal of t=
he SNP check combined with flawed GPU identification.
--

--- Patch [1]: [PATCH v2] iommu/amd: Force identity mode for selected GPUs =
only ---
commit 8994b69ea108b9e83363d3bf65d86e8798e45ba5
Author: Vasant Hegde <vasant.hegde@amd.com>

iommu/amd: Force identity mode for selected GPUs only

This commit updates AMD IOMMU domain allocation to force identity mapping
only for specific APU GPUs, rather than all PASID-capable devices. It
introduces quirks_force_identity_mapping() to apply this targeted enforceme=
nt
and drops the previous SNP check.

Link: https://lore.kernel.org/all/20200824105415.21000-1-joro@8bytes.org/
Link: https://lore.kernel.org/linux-iommu/20260723061548.10187-1-vasant.heg=
de@amd.com/

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 4dc306a4b5c62..eef585918e607 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3165,6 +3165,26 @@ static bool amd_iommu_is_attach_deferred(struct de=
vice *dev)
>  	return dev_data->defer_attach;
>  }
> =20
> +static bool quirks_force_identity_mapping(struct pci_dev *pdev)
> +{
> +	int class =3D pdev->class >> 8;
> +
> +	/* AMD GPU vendor ID */
> +	if (pdev->vendor !=3D PCI_VENDOR_ID_ATI)
> +		return false;
> +
> +	/* GPU class */
> +	if (class !=3D PCI_CLASS_DISPLAY_VGA &&
> +	    class !=3D PCI_CLASS_DISPLAY_OTHER)
> +		return false;
> +
> +	if (pci_upstream_bridge(pdev)->vendor =3D=3D PCI_VENDOR_ID_ATI)

[Severity: Critical]
Is it possible for pci_upstream_bridge() to return NULL here?

If the GPU is located on the PCIe root bus (such as in an integrated SoC=20
design, or when passed through to a VM via VFIO), pci_upstream_bridge(pdev)
would return NULL. This would lead to a kernel panic when dereferencing=20
->vendor during boot.

> +		return false;
> +
> +	/* It is the GPU in an APU, force identity domain */
> +	return true;
> +}

[Severity: High]
Does this heuristic accurately distinguish APUs from standard discrete GPUs?

Standard discrete GPUs are typically plugged directly into motherboard PCIe=
=20
slots, which means their upstream bridge is the motherboard's root port=20
(e.g., an Intel or AMD root port, not an ATI switch). Since the root port=20
vendor is not ATI, this check would fall through and erroneously return tru=
e,=20
forcing standard discrete GPUs into the identity domain.

[ ... ]

> -	/*
> -	 * Do not identity map IOMMUv2 capable devices when:
> -	 *  - memory encryption is active, because some of those devices
> -	 *    (AMD GPUs) don't have the encryption bit in their DMA-mask
> -	 *    and require remapping.
> -	 *  - SNP is enabled, because it prohibits DTE[Mode]=3D0.
> -	 */
> -	if (pdev_pasid_supported(dev_data) &&
> -	    !cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
> -	    !amd_iommu_snp_en) {
> +	/* Apply device specific quirks */
> +	if (quirks_force_identity_mapping(to_pci_dev(dev))) {
> +		/*
> +		 * When memory encryption is active, some of these devices
> +		 * don't have the encryption bit in their DMA-mask and
> +		 * require remapping.
> +		 */
> +		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> +			return 0;
> +
> +		return IOMMU_DOMAIN_IDENTITY;
>  	}

[Severity: High]
Since the amd_iommu_snp_en check was dropped, how does this affect discrete=
=20
GPUs on SNP-enabled systems?

If standard discrete GPUs are incorrectly identified as APUs by=20
quirks_force_identity_mapping(), they will be unconditionally forced into=20
IOMMU_DOMAIN_IDENTITY here when SME is disabled.=20

On systems with SNP enabled, amd_iommu_identity_attach() will reject the=20
identity domain if Mode0 isn't supported, returning -EINVAL. Could this lea=
ve=20
the discrete GPU without a valid domain and break DMA entirely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824085821.5422=
-1-vasant.hegde@amd.com?part=3D1
