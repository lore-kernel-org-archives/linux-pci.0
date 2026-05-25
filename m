Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF1029D29F
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 20:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779740648; cv=none; b=uHCHj7QLdl3Df4eSJJ/yAGzN2JkCA5T4C/ljFvHOHPLipTPRO5b5s/9Z2esi4dH3CilFGFxn/7SCuCdyld5h3qX4nL06ExEN0jr3b2Cqoj7qcPnfifbcHCAZHXhOWZGJsvBN84xpAvAPSJ/IaKk/9CGnR0FIn4Iju6uCvRzZDuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779740648; c=relaxed/simple;
	bh=X1izQz2LlKuj69ls6AQtwEY1j/0NHtdEVlSxLzPSmM4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tZHdQK8R+XARi4VMdtrLwU6xR2OFzjRIe1PQEKaGoXLreoelvQpaXkKciacVuTFLQ5jMV4vkf/GQr59g+3LHpJOvzKExS+KLrwvwjBWhmQuNDQvI6cO0wtpryhOINcc4Sb1TItmfTo9BjwvILQXqm7yyUtOxI8LijBbg0UzFh+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OriMLob0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OriMLob0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177D11F000E9;
	Mon, 25 May 2026 20:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779740647;
	bh=2lOfLTNRQ57ip1NkIwasbWHqkhH0eZN0KbvPRhxEKXI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OriMLob09RmReG7RnmN4FaxDUEVF3lwjEpa2TqqjgQBjvjjacQhzhhEQSP4HIdrxX
	 3mCZB8xQMF/V9F6Ka9hVLQm+Of0gUvPNadzuttqUq4JWsgZMJf/e51dlfUCcgqKMEA
	 d3J+7APTIRZIxyyNuPx0eGVrimQ1wXKA6+oBdBzJaX7IQ6TR+rlbLZ7SH/wxdBQcny
	 i7ruiXhAF9mZd8DV1Ym2D/Z7twA6KO+0B8Q+E+PXnltXpAhZ74PF2+jGabv59Ux7Tg
	 oIaNP64ov6WV+l61IAKdbT9F1NJa7a8OUCP/TvZ0Z7hvvz/LOR4TsY0j1etsy9Ktrv
	 +KQ6neEExh4Pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/5] iommu/arm-smmu-v3: Fix ATS state tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260525184347.4059549-4-praan@google.com>
References: <20260525184347.4059549-4-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 20:24:06 +0000
Message-Id: <20260525202407.177D11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Direct return on `pci_prepare_ats()` failure bypasses required cle=
anup, leading to memory leaks, dangling pointers in the SMMU's RB-tree (pot=
ential Use-After-Free), and left-over PASID configuration.
--

commit 89f07c4b4ad178ffe815778fc25432a3966e94a5
Author: Pranjal Shrivastava <praan@google.com>

iommu/arm-smmu-v3: Fix ATS state tracking

This commit addresses an issue with ATS state tracking during a two-phase
commit. It moves failable ATS configuration to the device discovery phase
by calling pci_prepare_ats() early and failing the probe if it returns an
error.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c

[ ... ]

> @@ -4264,9 +4270,16 @@ static struct iommu_device *arm_smmu_probe_device(=
struct device *dev)
>  		master->stall_enabled =3D true;
> =20
>  	if (dev_is_pci(dev)) {
> -		unsigned int stu =3D __ffs(smmu->pgsize_bitmap);
> +		struct pci_dev *pdev =3D to_pci_dev(dev);
> =20
> -		pci_prepare_ats(to_pci_dev(dev), stu);
> +		if (pci_ats_supported(pdev)) {
> +			unsigned int stu =3D __ffs(smmu->pgsize_bitmap);
> +			int ret;
> +
> +			ret =3D pci_prepare_ats(pdev, stu);
> +			if (ret)
> +				return ERR_PTR(ret);

[Severity: High]
Does this direct return bypass the required cleanup for the master structur=
e?

Earlier in arm_smmu_probe_device(), the master structure is allocated and i=
ts
streams are inserted into the smmu->streams RB-tree using
arm_smmu_insert_master().

Returning ERR_PTR(ret) directly here leaves the master object and its
allocations leaked, and leaves dangling stream nodes in the smmu->streams
RB-tree.

If the SMMU later receives an event for this stream, could the driver
traverse the RB-tree, find the leaked stream, and attempt to access
stream->master->dev after the PCI subsystem has freed it, resulting in a
use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525184347.4059=
549-1-praan@google.com?part=3D3
