Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1CE1D5160
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 04:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783053607; cv=none; b=g3vy1loQFvV29mW5HWL3FQUWufLmKn8r8dDfh7waML45eJV9xRSWXReNg6OLz8W7QZhE1ur7i74KSBT3co7elzYvbOlloIW5m2rDoAjfteKJ+8nqegSlMwlD4Y+AqGH5ERjYA0zmQM/d5dxeuISA7sL+ppMjfQyMeKpyju0vpkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783053607; c=relaxed/simple;
	bh=C+XktNsBhK0LYE9zryqC38UoZONsHI8Uq+icM+FM66M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IZSbAi7FlsrUNshOjvyvLEo0CHAJPGq4CzhI9ZiR7u6HJBZvNrzkBW5w5QzTHSs9NrfTTtuYPGpuONvWptA7xEgzMjHny0W3i/huV8p9H+7bUYP9WIzDkyv3225s9uknGYho6xwK1zSFB6I9SFpULkk7IMmOIzEgKvrxAj4gQWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrToJRrw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrToJRrw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A290E1F000E9;
	Fri,  3 Jul 2026 04:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783053596;
	bh=wkoqqKrfH0FIHZqIMC/sYw4kR0DUZvuY2ULiDLlu/BQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RrToJRrwPPQGoDaxIHlelSjqLLFrg141DPkNtZMbSXdPGYeAiEL4X87SuV/pm9XeM
	 2dCVZ+Kh99kSknv917TZJz/nbGnYGE3heZNBUNhkzbIbjS069UFkMLyiJAIvuyGH42
	 eKAo2/6wXEU48yxM0uTovi3gdzzJHl2+W/1IHJKXfpyaqUxSWOlVbmvnRCEv1sBBB2
	 kTt8wRUYxvzz7DJKdsdhgMcIhWZry/ZJeJWI8EuX89BvbDJmDvlxQCEpid9Azxrng/
	 Fk3F/X9869Vnj9+rmi7ainTN0EiauuNwSgbE1TWqkGI7J9lLo2OfD0/WV9Sx50XFCr
	 zYaNLnRRAv3cA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/18] iommu/arm-smmu-v3: Co-clear pending CMDQ_ERR
 when CMD_SYNC times out
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <2ce44672e51a136c220d9c5f325ea20d850a249e.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <2ce44672e51a136c220d9c5f325ea20d850a249e.1783044582.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 04:39:56 +0000
Message-Id: <20260703043956.A290E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Sleeping in atomic context during Service Failure Mode (SFM) error=
 handling.
- [High] Race condition in teardown leading to UAF / NULL pointer dereferen=
ce in the threaded ISR.
--

commit 3f49807deb6de6a8ccbe2ea880ec3f8f51819f03
Author: Nicolin Chen <nicolinc@nvidia.com>

iommu/arm-smmu-v3: Co-clear pending CMDQ_ERR when CMD_SYNC times out

This patch adds a synchronous mechanism to drain pending CMDQ_ERRs when a
CMD_SYNC times out. It introduces cmdq_err_handler callbacks for both the
standard ARM SMMU-v3 command queue and the Tegra241 VCMDQ to prevent missing
ATC_INV timeouts if the generic ISR is delayed.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index c6e3d1be23403..4b4e8108d5944 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
[ ... ]
> @@ -2298,6 +2307,26 @@ static irqreturn_t arm_smmu_priq_thread(int irq, v=
oid *dev)
> =20
>  static int arm_smmu_device_disable(struct arm_smmu_device *smmu);
> =20
> +/* Drain a pending CMDQ_ERR, used by arm_smmu_cmdq_issue_cmdlist() */
> +static void arm_smmu_cmdq_err_handler(struct arm_smmu_device *smmu,
> +				      struct arm_smmu_cmdq *cmdq)
> +{
> +	u32 gerror, gerrorn;
> +
> +	guard(raw_spinlock_irqsave)(&cmdq->cmdq_err_lock);
> +
> +	gerror =3D readl_relaxed(smmu->base + ARM_SMMU_GERROR);
> +	gerrorn =3D readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
> +
> +	if (!((gerror ^ gerrorn) & GERROR_CMDQ_ERR))
> +		return;
> +
> +	__arm_smmu_cmdq_skip_err(smmu, cmdq);
> +
> +	/* Toggle only the CMDQ_ERR bit; other bits are left for the ISR. */
> +	writel(gerrorn ^ GERROR_CMDQ_ERR, smmu->base + ARM_SMMU_GERRORN);
> +}
> +
>  static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
>  {

[Severity: High]
This isn't a bug introduced by this patch, but could this hardirq handler
cause a scheduling while atomic bug when handling SFM errors?

Looking at arm_smmu_gerror_handler(), when the SMMU hardware reports a Serv=
ice
Failure Mode (GERROR_SFM_ERR), it calls arm_smmu_device_disable(smmu).

This in turn calls arm_smmu_write_reg_sync(), which performs a polling loop:

	return readl_relaxed_poll_timeout(smmu->base + ack_off, reg, reg =3D=3D va=
l,
					  1, ARM_SMMU_POLL_TIMEOUT_US);

Because readl_relaxed_poll_timeout() uses a non-zero delay (1us), it
internally uses usleep_range() which can sleep.

Since arm_smmu_gerror_handler() executes in hardirq context, will this sleep
lead to a kernel panic?

>  	u32 gerror, gerrorn, active;
[ ... ]
> diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iom=
mu/arm/arm-smmu-v3/tegra241-cmdqv.c
> index 666dd23b0c7ca..628a3a7cc0335 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> @@ -337,6 +337,28 @@ static void tegra241_vintf0_handle_error(struct tegr=
a241_vintf *vintf)
>  	}
>  }
> =20
> +/* Drain a pending CMDQ_ERR, used by arm_smmu_cmdq_issue_cmdlist() */
> +static void tegra241_vcmdq_handle_cmdq_err(struct arm_smmu_device *smmu,
> +					   struct arm_smmu_cmdq *cmdq)
> +{
> +	struct tegra241_vcmdq *vcmdq =3D
> +		container_of(cmdq, struct tegra241_vcmdq, cmdq);
> +	u32 gerror, gerrorn;
> +
> +	guard(raw_spinlock_irqsave)(&cmdq->cmdq_err_lock);
> +
> +	gerror =3D readl_relaxed(REG_VCMDQ_PAGE0(vcmdq, GERROR));
> +	gerrorn =3D readl_relaxed(REG_VCMDQ_PAGE0(vcmdq, GERRORN));
> +
> +	if (!((gerror ^ gerrorn) & GERROR_CMDQ_ERR))
> +		return;
> +
> +	__arm_smmu_cmdq_skip_err(smmu, cmdq);
> +
> +	/* Toggle only the CMDQ_ERR bit on this VCMDQ's GERRORN */
> +	writel(gerrorn ^ GERROR_CMDQ_ERR, REG_VCMDQ_PAGE0(vcmdq, GERRORN));
> +}
> +
>  static irqreturn_t tegra241_cmdqv_isr(int irq, void *devid)
>  {

[Severity: High]
This isn't a bug introduced by this patch, but is there a race condition
in teardown that could lead to a NULL pointer dereference or use-after-free
in this ISR?

In tegra241_cmdqv_remove(), the driver appears to free vintf objects and
nullify pointers before freeing the interrupt:

	tegra241_cmdqv_remove_vintf(cmdqv, idx);
	...
	free_irq(cmdqv->irq, cmdqv);

Since tegra241_cmdqv_isr() is a threaded IRQ handler, if a concurrent or
pending interrupt wakes the IRQ thread during this teardown window, could it
pass a NULL or freed cmdqv->vintfs[0] to tegra241_vintf0_handle_error()?

The tegra241_vintf0_handle_error() function immediately dereferences the
pointer:

	u64 map =3D readq_relaxed(REG_VINTF(vintf, LVCMDQ_ERR_MAP_64(i)));

Could this cause a kernel panic during device unbind or removal?

>  	struct tegra241_cmdqv *cmdqv =3D (struct tegra241_cmdqv *)devid;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783044582.gi=
t.nicolinc@nvidia.com?part=3D11
