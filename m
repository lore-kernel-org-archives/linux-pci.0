Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8FE2BDC23
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780598022; cv=none; b=ez65m1TNB1KG3WsRJF9UQsrwSbKbe8DLrpZXq1XUXqd9xpPx56rDiw6wAAHjGV7WcjzeW+oYFnyxIpaFZHk5J01btN3hc705+CjJd2vjwVY2gZCgyBW9Mn5CfxErImP1aFgXsSsxS6R6OXDG95J9Vtidv0D8mMSAhMXF43IMsW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780598022; c=relaxed/simple;
	bh=pjSfMWw407l8gjz/O1RwPZUovHMC1OiDCvlet4N1ju8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LeU5pio9p0OxpyIW5KCbq/Fw+H2Ul7BApXjMa4aQeOfvfWL0o2frAPEYNgUkoAA3OlE2YnBoWMAQ2+yi+pq48+SJXVhOQiRoZFKOaZL5gfzXu4rJsoZTB5wpGwk4mAaShpeDr81IwQ77PLGz5G5uSzdBBUuaQClaTbaoEzp5t2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KV2KjPEW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KV2KjPEW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AAC1F00893;
	Thu,  4 Jun 2026 18:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780598021;
	bh=3e8BuONS6oiRqEf+c+qwSmQ1KSs2aWn7XRogOypvv+g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KV2KjPEWrBZMuyLsDeOjCiD35W48ZnZCS/nml7uIBNBC0rQbB2rt1DqJUBNCCyjTg
	 9cIDWlLqzHq1OiFS3L/SfjDm1QsAmxJBnhve5b2zAp1TQE8a15LYrKgt8mZHcAPgnf
	 PVC8slKOenkGuYRNsHryufzzG3/YQW+hn2snjegtceC0gdCP7x43mnkbcWYEF2Jyta
	 EBYVcteoE9cZhcWOjdDKupqOymAECzSX/Oj7r+XvfGB4CSG4Pbbk6aybhYCVwAsNdM
	 91BkuzzFWczGIyJRAh5Imf8gGapzyb0RNlXBDN6KUqCBzj/3ByZcN9EUOpgQvw0hJQ
	 zR2MlHZPkC6WQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/4] iommu/arm-smmu-v3: Standardize ATS enablement
 failure reporting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260604182116.3179005-4-praan@google.com>
References: <20260604182116.3179005-4-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 18:33:40 +0000
Message-Id: <20260604183341.15AAC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The newly introduced WARN_ON() in arm_smmu_enable_ats() can be tri=
ggered from userspace for a Virtual Function (VF) due to an ignored probe-t=
ime error, potentially crashing the kernel.
- [Low] The newly added inline comment and commit message contain factual i=
naccuracies regarding STE programming and probe-time validation.
--

commit e98cc7d134471b7c205436036caf90a8f69d9088
Author: Pranjal Shrivastava <praan@google.com>

iommu/arm-smmu-v3: Standardize ATS enablement failure reporting

Update arm_smmu_enable_ats() to wrap the pci_enable_ats() call in
WARN_ON(). Since probe-time checks now preclude configuration errors
any failure during hardware enablement is considered a kernel bug.

> Since probe-time checks now preclude configuration errors
> any failure during hardware enablement is considered a kernel bug.

[Severity: Low]
This isn't a bug, but the commit message states that probe-time checks
now preclude configuration errors. As noted below, the return value of
pci_prepare_ats() isn't checked during probe, so this description doesn't
seem to match the actual driver behavior.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index e8d7dbe495f03..a9bec5c7cbf98 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3065,7 +3065,12 @@ static void arm_smmu_enable_ats(struct arm_smmu_ma=
ster *master)
>  	 * ATC invalidation of PASID 0 causes the entire ATC to be flushed.
>  	 */
>  	arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
> -	if (pci_enable_ats(pdev, stu))
> +
> +	 /*
> +	  * Since pci_prepare_ats() has already verified the HW capability
> +	  * and programmed the STE, pci_enable_ats() should not fail here.
> +	  */

[Severity: Low]
This isn't a bug, but there's a typo in the comment here. pci_prepare_ats()
programs the STU (Smallest Translation Unit) in the PCI ATS capability, not
the STE (Stream Table Entry), which is SMMU-specific.

> +	if (WARN_ON(pci_enable_ats(pdev, stu)))
>  		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
>  }

[Severity: High]
Is it possible for pci_enable_ats() to fail here and trigger this warning f=
rom
userspace?

Looking at arm_smmu_probe_device(), the return value of pci_prepare_ats()
appears to be ignored:

arm_smmu_probe_device() {
	...
	pci_prepare_ats(to_pci_dev(dev), stu);
	...
}

If a Virtual Function (VF) is probed but its Physical Function (PF) has a
mismatched STU, pci_prepare_ats() would fail silently during probe. Later,
when userspace triggers a domain attach (e.g., via VFIO),
arm_smmu_enable_ats() would call pci_enable_ats() on the VF, which fails and
triggers this newly added WARN_ON.

Also, if the error is ignored here and the driver continues as if ATS is
enabled, could this trigger a second WARN_ON(!dev->ats_enabled) in
pci_disable_ats() during domain detachment?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604182116.3179=
005-1-praan@google.com?part=3D3
