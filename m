Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54333367F36
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 22:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780007594; cv=none; b=EV2QyG0MrfHfd/gMMoHY4BAjU4IcCi8ORzKq/iq5eYM6Yr47mqreoxh4uz6AoFN8OupTtuNFxoMU/Gj/YgUZvAx2KtxbsSkFW9kjNL9cq9eVJms3czS2uoTLBt5J98rzVJC2QdaWu6nDD4/g4cWvhS5tKmq4LCxKnH36EUni+l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780007594; c=relaxed/simple;
	bh=YHBk/342jSaKJVHB6+BkQf8zofvc2GxuSCPBmaR4/98=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PVelC2okm7Pb7JpWsc0AYAxzQkRHm4nkRdZh2dAiCL1PB8DA+lT6PIs8LrIfvO8CaRMUAruvM9F2oSe3cxemkh3pNMWu9Qq5mn/OYb8Vlvqv1oIKSmWb4mlMyeGF31LQx70dhNy0j3nnGVCXpI8thtNrvBWGAdIF2WYJCP19ov0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1fODRJV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1fODRJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B331F000E9;
	Thu, 28 May 2026 22:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780007592;
	bh=/6gvDCOzsg2F0Qx+iwbRC0ExzMie7y07wG/iysbaUek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z1fODRJV6Kke5cXmXJ7xpvB29ymkxXisvi8ogYKz45OMhojS1WVcrVZZXwLcYIx8U
	 m8/uwFfv6n7+Bp4DhxKFkC0+Nrgk7WkjvaY7QRUcloGdGzWvC2dLwlV/6AYlELC/AY
	 ESNJyYQWatFuqgEjYACx0SYaOZW8TspAqY1nQc/R/3Gr6838x8GO76GPp7IRoTQhRF
	 RixG30/Tz4yyHLpdT2OkPMVu5mCIoj5hjo1HYHaxrJlKnU8x53FlzCGqMfS1AzUvCO
	 LyhT5iFYwHz6WERsTRyPWcFVD+yJvRa1l6Y93gcvo+/C65IYZbydhW62cTLZ/Otjvg
	 U9i4kuPUrAMXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/7] iommu/arm-smmu-v3: Standardize ATS enablement
 failure reporting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260528202353.3422206-5-praan@google.com>
References: <20260528202353.3422206-5-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 22:33:11 +0000
Message-Id: <20260528223312.78B331F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] ATC Invalidation is sent before ATS is enabled on the PCIe endpoin=
t, violating PCIe specifications and causing Unsupported Request (UR) compl=
etions.
--

commit a735f1337ddc38ee7c9d344d6b05b83e1d9050f4
Author: Pranjal Shrivastava <praan@google.com>

iommu/arm-smmu-v3: Standardize ATS enablement failure reporting

The SMMUv3 driver currently has a two-phase commit in its ATS enablement
flow. This commit updates arm_smmu_enable_ats() to use the WARN() macro
for any subsequent enablement failures during the commit phase since probe
checks now preclude software configuration errors.

Link: https://lore.kernel.org/all/cover.1779392420.git.nicolinc@nvidia.com/

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index a10affb483a4f..aaebd72bc48dc 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2956,8 +2956,14 @@ static void arm_smmu_enable_ats(struct arm_smmu_ma=
ster *master)
>  	 * ATC invalidation of PASID 0 causes the entire ATC to be flushed.
>  	 */
>  	arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to send an ATC
invalidation before ATS is enabled on the PCIe endpoint?

According to the PCIe Base Specification, if the Enable bit in the ATS
Control Register is clear, the Function must respond to Invalidate Requests
with an Unsupported Request (UR) Completion status.

Since the SMMUv3 architecture treats a UR completion to an ATC Invalidate as
an ATC_INV CERROR, doesn't this halt the command queue and raise a Global
Error (GERROR) interrupt?

Looking at the driver's GERROR handler, it handles this by returning
without advancing the CONS pointer past the waiting CMD_SYNC. Because the
UR is a hard error rather than a transient timeout, wouldn't retrying the
CMD_SYNC continuously fail, resulting in an infinite GERROR interrupt loop
and a completely stalled SMMU command queue?

Should pci_enable_ats() be called before sending the ATC invalidate command?

> -	if (pci_enable_ats(pdev, stu))
> -		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
> +
> +	/*
> +	 * Any failure at this point is a kernel bug. pci_ats_supported()
> +	 * and pci_prepare_ats() have already verified the hardware capability
> +	 * and programmed the STU. Thus, pci_enable_ats() should not fail here.
> +	 */
> +	WARN(pci_enable_ats(pdev, stu),
> +	     "Failed to enable ATS (STU %zu)\n", stu);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528202353.3422=
206-1-praan@google.com?part=3D4
