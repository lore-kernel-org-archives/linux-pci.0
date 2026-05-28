Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0313137BE7C
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 08:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958791; cv=none; b=CYSimL00JN0veMwy/g0+8n8qAamkj9ylsbMujCLyeqZHCHa4l5xjnrdtHpTY5jZtieSNaYLdY7gEJJmhtcrRciOHZLMfy/g5a3Yn2Fm6mdtB8TyPmByUwKdw9ZguRwJYfevWuRfa6lSYov1x+j1eucmyUAn5BW9Mrg6wDpdBTMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958791; c=relaxed/simple;
	bh=zPDDn28jxSYY9h0mMdk5wTP1lKGYJVvB3/cS7aenkAA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TfYGsf8Kunm99hlBdpEQGrJMwcOHa6XWG+nND2j1wuEtMWsBc+cWcDywJ0yFQNQJm1SMDLF+t5a7g4bK6gSQBRVJLQ6WzEhW9CaMC7dzIECIBNZPOm9lDna9oGmEbp+2dAgZFegtvP90021T3IZoiRtIiiLfrfrWrl+LI+K5hnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eY7hCa0V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eY7hCa0V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69101F000E9;
	Thu, 28 May 2026 08:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779958789;
	bh=Lp4jCvXB8WSksztNeF7c+KdTupT3/plHSWl3xdlMR+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eY7hCa0V4SCUa/yjC/ZjWFP300uFZye8RJD457QT1QK1u/3JAz58MPYzzi9339MSc
	 1B5MA0FYQuEJ2qvw/jdhKUw1ZTSvfXSSEQhHYvl0UODg03dcsuk9mCfXg7oKosy3rK
	 eCdkv4NXvfr7hOGJ6ojAO7u7NCC3hNSrrM+yOnYBXqcMgMxzzvqH/yfGRTxUUvo8lE
	 /lb7m1SdrjtkZtnR/fwr3fWe8tsXUC7hHnO8lT5PQ+nx1cfZOBaIIXmTAsw01wNrv+
	 m3JkJSpEfWibRtcuaUOKoZ0NSV4xXWCF7rA7dVPZ3+5AIPThXDYnQxkXucq8Vk8oFK
	 SPOR02dxG7BZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/11] iommu/arm-smmu-v3: Allocate IOPF queue for
 ARM_SMMU_FEAT_PRI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <a02e498421b4ce702900d015881fd351c28ceadf.1779944354.git.nicolinc@nvidia.com>
References: <a02e498421b4ce702900d015881fd351c28ceadf.1779944354.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 08:59:49 +0000
Message-Id: <20260528085949.B69101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The condition for allocating the IOPF queue incorrectly mandat=
es `ARM_SMMU_FEAT_SVA`, leaving `evtq.iopf` NULL on platforms supporting ST=
ALLS or PRI but lacking SVA. This leads to a fatal NULL pointer dereference=
 in `arm_smmu_enable_iopf()`.
--

commit 4cb5a675156f4120c4c0531ad8a519bcc597afe7
Author: Nicolin Chen <nicolinc@nvidia.com>

iommu/arm-smmu-v3: Allocate IOPF queue for ARM_SMMU_FEAT_PRI

arm_smmu_init_queues() allocates smmu->evtq.iopf only when FEAT_SVA and
ARM_SMMU_FEAT_STALLS are both advertised. A subsequent change will add PRI
support on top of the IOPF infrastructure, so the IOPF workqueue must also
exist on SMMUs supporting FEAT_PRI without FEAT_STALLS. Extend the
allocation condition to include FEAT_PRI.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 72fd5caa27368..87e4880a145f1 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4504,7 +4504,7 @@ static int arm_smmu_init_queues(struct arm_smmu_dev=
ice *smmu)
>  		return ret;
> =20
>  	if ((smmu->features & ARM_SMMU_FEAT_SVA) &&
> -	    (smmu->features & ARM_SMMU_FEAT_STALLS)) {
> +	    (smmu->features & (ARM_SMMU_FEAT_STALLS | ARM_SMMU_FEAT_PRI))) {

[Severity: Critical]
This is a pre-existing issue, but does mandating ARM_SMMU_FEAT_SVA leave
evtq.iopf as NULL on platforms that support STALLS or PRI but lack SVA?

The SMMU driver sets master->stall_enabled =3D true if ARM_SMMU_FEAT_STALLS=
 is
present (e.g. when dma-can-stall is true), without requiring the runtime SVA
feature bit (ARM_SMMU_FEAT_SVA).

If a userspace application (e.g., via IOMMUFD) creates an HWPT with
IOMMU_HWPT_FAULT_ID_VALID and attaches a device with STALLS enabled but SVA
unsupported, arm_smmu_enable_iopf() will be invoked.

Since it only performs a compile-time check for SVA
(IS_ENABLED(CONFIG_ARM_SMMU_V3_SVA)), it proceeds to call:
iopf_queue_add_device(master->smmu->evtq.iopf, master->dev)

Since evtq.iopf is NULL, will iopf_queue_add_device unconditionally
dereference it at mutex_lock(&queue->lock) and cause a kernel panic?

>  		smmu->evtq.iopf =3D iopf_queue_alloc(dev_name(smmu->dev));
>  		if (!smmu->evtq.iopf)
>  			return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779944354.gi=
t.nicolinc@nvidia.com?part=3D8
