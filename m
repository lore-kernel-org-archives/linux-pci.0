Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD46E33D4EC
	for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062288; cv=none; b=ClNBbhnTSz0ud8aki2f4R1qHlaknpv+lY/w63oXdS7MRn4Kq1B37U4iXUDQfMgD40Pi/xao5xtesdlfTHud9BwNOYy5dfK2HfRs9Ebx3euaVAMIhpvrzepQj/MAfaCJWq+pWyA4nuALI5taCQHOkGA4NBmGeLKzFRlQO/pA6BcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062288; c=relaxed/simple;
	bh=pmRr1WoVRXfZjFNFusCm46LD9YTmkOvWPKxoItv4qlc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=peWiJTL+zis6CPVOMOVV1+vbnTiBvmGZXGcbicmwirE8Ieab5yWCY4aPTgYp5PLJ3hJMQt/im1Lun4PXFoFJAgiU6oVBE3xQHvGkcHAhRsBqaFIFCsiQoky/V8/1mex40W9LQXQjLkcY57uWdD7RhOJ3QB0O25xkBIRtcRNwCjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFFB9O7K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFFB9O7K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292921F00893;
	Fri, 29 May 2026 13:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780062287;
	bh=EdQrJjPAsSpUbObAtne4pbjhOdwwDLrsEj+qOR0M7DM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IFFB9O7Kf6KgJChMYmyqOHL8L8rHY8Y5B4YGqBGxWaClEYPdHYR5fDvqiYZcuJSbZ
	 6oWVa5U1ZxcWSjEcVV7ib+vZp65PCoTTmV38n06sX+ZzNczYKdhfkojqvxBMw9NR5G
	 JooBixVXqmNAmuzteDq4IP8RPPKprDLbD+2cC46unb2dk1RxYZND6drlxxrgVHqTXB
	 Q0d1rca5+GeGsCDzcnheAwAQQPDuesxsP2qZAzyj6KDhi5z1cqrQyI2BNpuTbdfoRP
	 wa+Uz1bLSeYFsq8nhfUOflfA+4i8ccm8UKOr3LCd2wPLb0EAcQS/ljvPEegO/wpIWK
	 cnsG6s3/oxoPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/6] iommu/arm-smmu-v3: Standardize ATS enablement
 failure reporting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260529111208.387412-5-praan@google.com>
References: <20260529111208.387412-5-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 13:44:46 +0000
Message-Id: <20260529134447.292921F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The error message drops the specific device context.
- [Low] State-mutating function call placed inside WARN() macro condition.
--

commit f858943c568bf1c4936c2371054b39b080e8ae6a
Author: Pranjal Shrivastava <praan@google.com>

iommu/arm-smmu-v3: Standardize ATS enablement failure reporting

This commit moves failable ATS configuration to the probe phase and
updates the commit phase to use WARN() for enablement failures. Since
hardware capabilities are verified earlier, failures here are considered
kernel bugs.

Link: https://lore.kernel.org/all/cover.1779392420.git.nicolinc@nvidia.com/

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
[ ... ]
> @@ -2956,8 +2956,14 @@ static void arm_smmu_enable_ats(struct arm_smmu_ma=
ster *master)
>  	 * ATC invalidation of PASID 0 causes the entire ATC to be flushed.
>  	 */
>  	arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
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

[Severity: Low]
Does placing a state-mutating function like pci_enable_ats() directly inside
the WARN() macro condition hide essential hardware configuration logic?

While Linux's generic WARN() macro currently evaluates its condition exactly
once, placing this logic inside an error-reporting macro can degrade code
readability and break developer expectations. Could the function call be
extracted and its return value evaluated instead?

[Severity: Medium]
Does this change drop the specific device context from the error message?

The previous dev_err() call automatically prefixed the log message with the
specific device's identifier (like its PCI BDF address), which is crucial
for determining exactly which hardware component failed. By switching to a
generic WARN(), this device context is lost.

Would it be better to use dev_WARN(master->dev, ...) or explicitly include
dev_name(master->dev) in the format string to preserve observability for
debugging specific hardware failures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529111208.3874=
12-1-praan@google.com?part=3D4
