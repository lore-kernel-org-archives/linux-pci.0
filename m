Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8555531E820
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 04:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783053160; cv=none; b=g4BDxopJ1IRbgVPMF00wEbLC5Fi+D5Cqj3ad/lvQM3atqKsRjmXDdXDRrtxD4chVovBJJOqrf0D0mSBQtl4wHnMyY2vnZ9mvLCRq0i3XPz0ZvafqH91r2iYyYtfeAw9FsP2qDY31Dv9xhCdL/CFRd/w3dcG7r5X9noh/RdMDGfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783053160; c=relaxed/simple;
	bh=jfTRUnp9W5Bq5ppuTgCmSq1VyFFkcVbMry8hxNJMjRc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XGDISIv0XKonpWh8af/JYeR/PiUOEuTXYI8h6Q5bHEsSCjaO0n0RxQ4g8gprU3XtaJJfO2CtBzOJeGsjLAC1yLu8MGyCSzsvc7/fZvbN4cGTKCtVRp+xK36PujS6i138cCDcypuXvmR5fyNVJTtGbaFzFTU2nP034h+FGUrMcp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5A8YfZX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5A8YfZX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9011F000E9;
	Fri,  3 Jul 2026 04:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783053148;
	bh=7a0AsVt1eXzDMAfYB6+idTT9DOjSu7L1XRhy9NM1jVM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c5A8YfZXnbmJrXtcGjpgU+HUhF4HebfbX3w0zHJl9FQwQvTVh2w95njx47oXMhqYb
	 eyES2Zby4Qyitu/shA6ka7IIAkk43JsXGEc6i6947xwms3bUff1a4yaBCRSaZi3uVa
	 XDVVeAtR6gFdUKmAnOPdYKiu8oIcvkNAGaEaup0q68tNdkydoSGp/dmOWjRPEhq+22
	 4oM1pJTTsOCKYkmTDmkzxIhXsMN12snW+sBJgYfdpJGeVjkl/G6msjQBlaQVs5z8LJ
	 fZTpzWIT/ktSb4qnHKnTCb0yLbXZOVDQ/dFEYYggh8eW4ZEt35j77NDYas/COU8L18
	 A63IgrglSOIuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/18] iommu/arm-smmu-v3: Introduce per-cmdq
 cmdq_err_handler callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <df41122bd28b74dbe2de09d6cbe6c636e647c93b.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <df41122bd28b74dbe2de09d6cbe6c636e647c93b.1783044582.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 04:32:28 +0000
Message-Id: <20260703043228.7F9011F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `arm_smmu_device_disable()` sleeps while called from hardirq conte=
xt in `arm_smmu_gerror_handler()`.
--

commit d1df4f7525ea4b8d14160727c6a78de7c62b7cbb
Author: Nicolin Chen <nicolinc@nvidia.com>

iommu/arm-smmu-v3: Introduce per-cmdq cmdq_err_handler callback

This patch adds a cmdq_err_handler and a paired cmdq_err_lock to struct
arm_smmu_cmdq. It updates arm_smmu_gerror_handler() to take the per-cmdq
cmdq_err_lock when acking CMDQ_ERR.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 8a4edefeec770..c6e3d1be23403 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
[ ... ]
> @@ -2317,6 +2322,8 @@ static irqreturn_t arm_smmu_gerror_handler(int irq,=
 void *dev)
>  	if (active & GERROR_SFM_ERR) {
>  		/* SMMU is being disabled, so other errors don't matter */
>  		writel(gerror, smmu->base + ARM_SMMU_GERRORN);
> +		/* Release before arm_smmu_device_disable() that sleeps */
> +		raw_spin_unlock_irqrestore(&smmu->cmdq.cmdq_err_lock, flags);
>  		dev_err(smmu->dev, "device has entered Service Failure Mode!\n");
>  		arm_smmu_device_disable(smmu);

[Severity: High]
This is a pre-existing issue, but since the added comment explicitly mentio=
ns
that arm_smmu_device_disable() sleeps, can this cause a scheduling while
atomic bug?

Looking at the call chain, arm_smmu_gerror_handler() is registered as a
hardirq handler, and arm_smmu_device_disable() eventually calls:

arm_smmu_device_disable()
  arm_smmu_write_reg_sync()
    readl_relaxed_poll_timeout(..., 1, ARM_SMMU_POLL_TIMEOUT_US)

Because the polling timeout is called with a non-zero delay of 1 microsecon=
d,
it expands to might_sleep_if() and usleep_range(), forcing the kernel to sl=
eep.

While releasing the spinlock avoids a deadlock, does sleeping directly insi=
de
the hardirq context still risk a panic when handling a Service Failure Mode
error?

>  		return IRQ_HANDLED;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783044582.gi=
t.nicolinc@nvidia.com?part=3D9
