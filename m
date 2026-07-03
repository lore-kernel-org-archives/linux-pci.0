Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FE83195FA
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 04:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783052998; cv=none; b=JD3i1M4KiLNLY9O2itrMVt2Lx/VRe7xQzEE0a32jCH+ZZ6qRBtp+yxO9s8f582lRH4mrQ48AA1xSDDqGSM5tgKBUu6MkYkf0P6V/NcpNVD8i+C2SXNHuuy4hE68tDxXe3LdSBzFdfCiafXs0zDBn18WNRLMvC5MlmwFGCI1stlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783052998; c=relaxed/simple;
	bh=OQLFOP9fUUoRsByYND27ZUghThOD7uK1QuC52U6sw2Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CTRyyMzS1ZfGrZUhC7pZ6AB5EHGoGY/A4/PhQ15quvDfnzmoZ6ShSSGZgeLS+ixvclA8rvGwvaDMoNSKZEqrkep5WKfiOM8p0HAP4/E6G/mURyYgmS7SSDoXUxYrfQDeyZVzWFgGad0SK+umRFoNULtM24zM2qLovcfzLG415fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcHZQMC7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcHZQMC7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1211F000E9;
	Fri,  3 Jul 2026 04:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783052986;
	bh=Jh6CTiF00VC1XdmxGbAU6q/qhgko/JufFV/0D+oGMDk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WcHZQMC7MqZBYM43jUe0d/86GeyZK4CfgsT+WVhNqNB34rktP3fUoZmPMLTkMiAVn
	 AWbpYFW+VplSKhepiY2aVsGLzu25AIHkrkrDGuQbpylPPIFkWBv7Z1Tt8ZjYDNC7qf
	 YL+FFPf4UMR/9M0Q+6U/9m5C2FfBGfd1YD7w2NxfXQKANMKWztswYoCs5pJPpSV5kL
	 UEFViYljnB7vI8y3BEt8JsqYAlltfme7HsRruMH2Lh+bKJ00/PlUGNrVrLuvrivVxp
	 +Qf6NbcK68aR/VcZNeswvbK2L34/1JDQCpHv/lNX+N5Aek6UNP13MOL8C4GdQr+XYE
	 m0VwIgIveZfpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/18] iommu/arm-smmu-v3: Skip remaining GERROR
 causes on SFM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <87ac4c46207f8e9903cc6a6f6f1b46995145cb64.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <87ac4c46207f8e9903cc6a6f6f1b46995145cb64.1783044582.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 04:29:45 +0000
Message-Id: <20260703042945.EF1211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling `arm_smmu_device_disable()` from the `arm_smmu_gerror_hand=
ler` hardirq handler triggers a sleep-in-atomic BUG because it polls a regi=
ster with a non-zero sleep delay.
--

commit 1a84214c7c4ffc13f27088bf53ea902723185640
Author: Nicolin Chen <nicolinc@nvidia.com>

iommu/arm-smmu-v3: Skip remaining GERROR causes on SFM

When the SMMU enters Service Failure Mode (SFM), the remaining GERROR
causes are skipped and acked early since the SMMU is being disabled.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index da29e523d78b7..8a4edefeec770 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2315,8 +2315,11 @@ static irqreturn_t arm_smmu_gerror_handler(int irq=
, void *dev)
>  		 active);
> =20
>  	if (active & GERROR_SFM_ERR) {
> +		/* SMMU is being disabled, so other errors don't matter */
> +		writel(gerror, smmu->base + ARM_SMMU_GERRORN);
>  		dev_err(smmu->dev, "device has entered Service Failure Mode!\n");
>  		arm_smmu_device_disable(smmu);

[Severity: High]
This is a pre-existing issue, but does calling arm_smmu_device_disable()
from the arm_smmu_gerror_handler() hardirq handler trigger a=20
sleep-in-atomic BUG?

arm_smmu_device_disable() eventually calls arm_smmu_write_reg_sync(),
which uses readl_relaxed_poll_timeout() with a 1us delay:

drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:arm_smmu_write_reg_sync() {
    ...
    return readl_relaxed_poll_timeout(smmu->base + ack_off, reg, reg =3D=3D=
 val,
                                      1, ARM_SMMU_POLL_TIMEOUT_US);
}

The polling macro invokes might_sleep_if(1) and usleep_range(), which isn't
safe in hardirq context.

> +		return IRQ_HANDLED;
>  	}
> =20
>  	if (active & GERROR_MSI_GERROR_ABT_ERR)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783044582.gi=
t.nicolinc@nvidia.com?part=3D8
