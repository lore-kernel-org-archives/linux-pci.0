Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12F2374E45
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 00:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224161; cv=none; b=RLmN2oFSPwYgADqz5ApM49BBXGX9RJZfw6aQtUDQqYw7jofdqSh9CsNnc7nlZSwvzsOtWnG0y8KDJGGZilPYU80vluMfqyDPfKoyag709fMAZBUX9FeGTq49ZLhTzHsuIBKyOkNugdqdyEd4GueE73ZafpsWcV71NOcC51PGf3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224161; c=relaxed/simple;
	bh=vlQX3jADO1ATLjaXbbMsuuPr/YN1WTzSMEnJyOnHDiU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f5MMLximWOgE48RFXIs+VyF0/kGGzbso13sstW7aOrgCIxSax5kOl6O8aPMiQW3o9f2sC2jrkBpSaTbq2DJA5MWvcnqt2TTMaYbQt7QNxPhBotnnkAtB1D/ZqKSdoyIbAskMd45xXip4MPCufcCj6piHCuO+JLh9f8ZJUT9R9D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoRG2i1x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoRG2i1x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450671F000E9;
	Tue,  1 Sep 2026 00:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788224159;
	bh=7VpmnnMkuFN1J+RkgqIQI3wJBj0woMrq9iO+dMNtt88=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eoRG2i1xmnXOC9h/gB1oSAahFK1Hjq51qTkRPdb46rA8r+PKW70nGAzR3LKPKsHRK
	 hgkHcatPWatXLqi9vyH81FvBvThnhN+9lyFUIdAZpRWWMJumSvZPgj3fQ2B/GyEARz
	 DVTLfoAZQBrCIGuPJLDVBGms7aAB8o3+hI3jSAACTOcavnQmYyyI/j07xkc6ENEA6G
	 Fp5HSToB1Fp1xzD/zg/kMg0VRQx0CRRgvXvKoPwiNnBVZXCT8df40r1tACU/2FvWS2
	 t/eC2HO8fahynDlKadDOg+YRiE7FolWuQ/sFlShAeYz5d2pu/v2Yrqno9KslpAUax1
	 5qw2mAhpa4kbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/13] iommu/arm-smmu-v3: Disable the queue IRQs
 before disabling the SMMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <a6fba7f7a01f5955dfb44d34adc6262c8534e829.1788222486.git.nicolinc@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <a6fba7f7a01f5955dfb44d34adc6262c8534e829.1788222486.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 00:55:58 +0000
Message-Id: <20260901005559.450671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The system shutdown path disables the SMMU without quiescing queue=
 IRQs, leading to an infinite loop in the kernel thread.
--

commit 723b797a0d5bc30d8469f53716a51e3b4d1bb03c
Author: Nicolin Chen <nicolinc@nvidia.com>

iommu/arm-smmu-v3: Disable the queue IRQs before disabling the SMMU

This commit addresses an issue where disabling the SMMU while queue IRQs are
running leads to commands being issued to a queue consuming nothing. It
ensures that the queue IRQ threads are quiesced by disabling the IRQs before
the SMMU is disabled in device reset and disable action paths.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 64540cfb73244..d45d97f356cf0 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
[ ... ]
> @@ -4992,10 +5001,22 @@ static int arm_smmu_device_disable(struct arm_smm=
u_device *smmu)
>  	return ret;
>  }
> =20
> +/* Quiesce the queue IRQ threads, e.g. before disabling the SMMU */
> +static void arm_smmu_disable_irqs(struct arm_smmu_device *smmu)
> +{
> +	if (smmu->combined_irq)
> +		disable_irq(smmu->combined_irq);
> +	if (smmu->evtq.q.irq)
> +		disable_irq(smmu->evtq.q.irq);
> +	if (smmu->priq.q.irq)
> +		disable_irq(smmu->priq.q.irq);
> +}
> +
>  static void arm_smmu_disable_action(void *data)
>  {
>  	struct arm_smmu_device *smmu =3D data;
> =20
> +	arm_smmu_disable_irqs(smmu);

[Severity: High]
This is a pre-existing issue, but since this patch explicitly aims to fix
the vulnerability where the SMMU is disabled without quiescing the IRQs,
does the system shutdown path also need to be updated to call
arm_smmu_disable_irqs()?

Looking at arm_smmu_device_shutdown() which is called during system shutdow=
n:

static void arm_smmu_device_shutdown(struct platform_device *pdev)
{
	struct arm_smmu_device *smmu =3D platform_get_drvdata(pdev);

	arm_smmu_device_disable(smmu);
}

The shutdown path directly disables the SMMU without first quiescing the
threaded IRQs. Because devm callbacks do not run on shutdown, the IRQ handl=
ers
remain active while the hardware is disabled.

If a pending PRIQ or EVTQ event triggers, the threaded handler
(e.g., arm_smmu_priq_thread) executes and calls arm_smmu_page_response(),
which attempts to insert a PRI_RESP command into the CMDQ without waiting f=
or
a SYNC. Since the SMMU is hardware-disabled, it will not process commands a=
nd
the CMDQ software ring buffer quickly fills up. Once full,
__arm_smmu_cmdq_issue_cmdlist() enters a while (!queue_has_space(...)) loop
which either spins tightly or times out every second, looping indefinitely
without any breakout condition.

Could we also add a call to arm_smmu_disable_irqs(smmu) in
arm_smmu_device_shutdown() to prevent this infinite loop?

>  	if (smmu->impl_ops && smmu->impl_ops->device_disable)
>  		smmu->impl_ops->device_disable(smmu);
>  	arm_smmu_device_disable(smmu);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788222485.gi=
t.nicolinc@nvidia.com?part=3D7
