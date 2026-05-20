Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4C038331F
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 21:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779312828; cv=none; b=klV+aJTu/YwcffpVRXCG3ax2XOUXtTOqOEkDlCMmhoKf5sr3qnaa/4DXpCJxbUQ+LriQAzVsLfqTNvI+o87rYIUjg8CMe0z84MaHJQO363Vo9wbR7FI2/1ZuS0S9yzL996CYGxjgpW4FPwVxlhiwxyLMm6LjioiM54jmfWaqbk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779312828; c=relaxed/simple;
	bh=DyAuU4ZUYtOgIFriFcMLyGROrWto0g3nZ9dc+RBaZMI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nHq73A9nJWJI4mivedEq/CmNAHhUfTidxnE73zjVinuzHYznAw6DxET0z+xwfE79tRrUtoJZPme71UQ8YrpLjbWorM08g6d3HMh1roEbxV4sBJyim4CGUncfJgd2DXzzsH70Pc4HVMDiqVrll+i2Prs/gzlufREu4du7b+0aoJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdB4bVCk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdB4bVCk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91161F00A39;
	Wed, 20 May 2026 21:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779312826;
	bh=/DZDxQ5tcWN+JwEcfXo8wv5YOKToOd90nJUBldSvg2I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FdB4bVCkE3T2dDRCp49GPlk4ao/MvIX/tMJ4Xmd42q5ObBPvEe0AFYBDUsW9A7EzL
	 2kHyiBHlmlQl3sTqV2QB/xY5cBp2NY+wcFgNTFvzFm9WyDRV6OgugnmQUzNLySgVP7
	 SHskb15OkDG7+Yld0MgdhHDOc2r0mHb90KX6936U63aZJUneYyFrXu+EhNIsjqR9Mx
	 D4zCVKPTyjMnYgS7pV7kuaM9Vb7sz1s9F92E44Eb0s9kRogzArHDhARX6DDMUNPoNJ
	 nae5PFGZWJBeM+Jz1QEqPZzVw9/j4QHrLl2wimB7wU7qf3nO4SpZO+lcSQW3ynNped
	 e2hFTe0MKw5mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <b6d2f24356621c504e47633d9e96a7274c2859f3.1779304390.git.nicolinc@nvidia.com>
References: <b6d2f24356621c504e47633d9e96a7274c2859f3.1779304390.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 21:33:46 +0000
Message-Id: <20260520213346.A91161F00A39@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Silent failure to enforce ATS requirement leads to device malfunct=
ion.
- [High] Inconsistent STE configuration (Mode 1 vs Mode 2) for BLOCKED doma=
ins when ats_always_on is true.
--

commit 592bdfd18801a5a10cbb239b47e71f0772eea39e
Author: Nicolin Chen <nicolinc@nvidia.com>

iommu/arm-smmu-v3: Allow ATS to be always on

This patch modifies the ARM SMMUv3 driver to allow ATS to remain active even
when a device's default substream is attached to an identity domain. It does
this by retaining a CD table and ensuring the STE stays in Mode 1 for devic=
es
that require ATS to be always on. It also ensures the STE is not downgraded
to Mode 2 when the last active substream becomes inactive.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index e8d7dbe495f03..5c9d4bb542249 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
[ ... ]
> @@ -3875,6 +3895,8 @@ static void arm_smmu_attach_dev_ste(struct iommu_do=
main *domain,
>  		.old_domain =3D old_domain,
>  		.ssid =3D IOMMU_NO_PASID,
>  	};
> +	bool ats_always_on =3D master->ats_always_on &&
> +			     s1dss !=3D STRTAB_STE_1_S1DSS_TERMINATE;

[Severity: High]
Does this explicitly force ats_always_on to false for BLOCKED domains?

If s1dss is STRTAB_STE_1_S1DSS_TERMINATE, the device will initially use
Mode 2 (CFG=3DABORT), which disables EATS and appears to contradict the goal
of always keeping ATS on for these devices.

Additionally, if a PASID is attached (upgrading the STE to Mode 1) and then
subsequently removed:

arm_smmu_blocking_set_dev_pasid() {
    ...
    if (!master->ats_always_on &&
        !arm_smmu_ssids_in_use(&master->cd_table)) {
            ...
    }
}

The revert operation is skipped here because master->ats_always_on
evaluates to true, leaving the STE permanently in Mode 1.

Can this create an inconsistent state machine where the initial Mode 2 state
could trigger fatal URs for ATS requests, but detaching a PASID silently
leaves the device in Mode 1?

[ ... ]
> @@ -4215,6 +4237,42 @@ static void arm_smmu_remove_master(struct arm_smmu=
_master *master)
[ ... ]
> +static int arm_smmu_master_prepare_ats(struct arm_smmu_master *master)
> +{
[ ... ]
> +	if (!pci_ats_required(pdev))
> +		goto out_prepare;
> +
> +	/*
> +	 * S1DSS is required for ATS to be always on for identity domain cases.
> +	 * However, the S1DSS field is ignored if !IDR0_S1P or !IDR1_SSIDSIZE.
> +	 */
> +	if (!s1p || !master->smmu->ssid_bits) {
> +		dev_info_once(master->dev,
> +			      "SMMU doesn't support ATS to be always on\n");
> +		goto out_prepare;

[Severity: High]
If the SMMU lacks the necessary features to support ats_always_on when it is
strictly required by the device, should this code return an error like
-EOPNOTSUPP instead of returning success?

Returning success here allows the IOMMU probe to succeed without configuring
ats_always_on. When the device is later attached to an IDENTITY or BLOCKED
domain, it will be configured in a mode where EATS is ignored.

Could this result in the SMMU aborting ATS Translation Requests as
Unsupported Requests (UR) on the PCIe bus and triggering AER errors, rather
than cleanly failing the probe when the hardware requirement cannot be met?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779304390.gi=
t.nicolinc@nvidia.com?part=3D3
