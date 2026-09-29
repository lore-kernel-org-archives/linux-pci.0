Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A6E3B8D78
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 06:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664114; cv=none; b=GXDrZjlmSCka15dPBbA2FTAXAh9eIDmmkTwMNbeutY3Ys0YvYoggWHl2hNcH0wU+4NBxskkNUxsNrwzaJHeAE2RicsmHxSf0QvS4EOTORaG48ik4+J0u0KMmaX+yoPF5AwYExoXWKdzOrtfqcPpklAeGpxx0783DrinQQ9eP7yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664114; c=relaxed/simple;
	bh=UiGqaQKr8Zs4TZbHgbh1QOgNqwoGWG6cblrHe+xKa4Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b6GZ9Mkcbv3LqVoLEgO3NauhDS2kTnnvs6QxqSmr8rlbwwcsC1R2at8LukBwusJUeKy2q+EvCDa0zcoEcujVHK0uJqS4Gornm1Hvq7gHtRIIkKB+3Pb07AaBHQIJ2jW/Jdb88LQ/rXwfRJm/SQ/2BBzJU4cOt7llB4W7qNF/Oiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7jXOJ4L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7jXOJ4L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E451F000FF;
	Tue, 29 Sep 2026 06:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790664112;
	bh=EXJxODfeImLQkbPcETNdhRZLSYB2OhMcC8+XbEW76ko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J7jXOJ4L4r7kENbuSiJSxthhurBbofmVf2RlxLQC1GgVRVLihN02Fk1IcC87gVGmt
	 m73pVPBTb92TIUwVF7+5VEeNX80ykG0evp+qvmhCqvgCT3s5+AYWcwOVPmszdeDz02
	 TZrERHLJsfRRl7TxciqH7hG6Pb41XyN7BSYMoUdI6yypxtM+FL6qN6uBziJxArVkXi
	 zLKhzKO70K9sOguFkU6OD9pRA+fuNdGF9p4RycSuSSjnkxBnDcj34GKUpSiF83IJXy
	 rCuRNA2czONcewbSlZoi5eMGhl2l/Q5ZD91IAYr3a1uICALVwwO8f4BFj4M2AlxHpA
	 DrPVWyTyqaXIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 15/16] iommu/arm-smmu-v3: Invoke pm_runtime before
 hw access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260929034510.2023173-16-praan@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-16-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:41:52 +0000
Message-Id: <20260929064152.C5E451F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] pm: power domain leak in arm_smmu_disable_action()
- [High] irq: CPU livelock in threaded queues due to uncleared events
--

commit 13dd005a8c8b5e0160d4c5b2b42bd2a26eae301e
Author: Pranjal Shrivastava <praan@google.com>

iommu/arm-smmu-v3: Invoke pm_runtime before hw access

This commit introduces pm_runtime helpers before accessing hardware across
the driver to avoid sleeping and deadlocking during transient power states.
It uses lockless checks and non-sleeping runtime PM gets in threaded
interrupts, and explicitly manages PM state around device disable paths.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 2a1b5ce6ff1cf..89ffa83464780 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
[ ... ]
> @@ -2460,6 +2478,40 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, v=
oid *dev)
[ ... ]
> +	if (!arm_smmu_rpm_get_if_active(smmu)) {
> +		dev_warn_ratelimited(smmu->dev, "client device is suspended, dropping =
event\n");
> +		return IRQ_HANDLED;
> +	}

[Severity: High]
Can this cause an interrupt livelock?

If arm_smmu_rpm_get_if_active() observes the RPM_SUSPENDING state, it retur=
ns
false, which means this returns IRQ_HANDLED without dequeueing the event or
updating the hardware CONS pointer.=20

Because the event is left in the queue, won't the SMMU hardware continue to
assert the level-triggered wired interrupt line, resulting in an infinite C=
PU
loop that deadlocks the suspend sequence?

>  	do {
>  		while (!queue_remove_raw(q, evt)) {
[ ... ]
> @@ -2518,6 +2571,18 @@ static irqreturn_t arm_smmu_priq_thread(int irq, v=
oid *dev)
[ ... ]
> +	if (!arm_smmu_rpm_get_if_active(smmu)) {
> +		dev_warn_ratelimited(smmu->dev, "client device is suspended, dropping =
page request\n");
> +		return IRQ_HANDLED;
> +	}

[Severity: High]
Similar to the evtq thread above, does returning IRQ_HANDLED here without
consuming the hardware queue entries leave the interrupt line asserted?
Could this lead to a CPU livelock during transient power states?

>  	do {
>  		while (!queue_remove_raw(q, evt))
[ ... ]
> @@ -5116,14 +5227,37 @@ static int arm_smmu_device_disable(struct arm_smm=
u_device *smmu)
>  static void arm_smmu_disable_action(void *data)
>  {
>  	struct arm_smmu_device *smmu =3D data;
> +	int ret;
> =20
>  	/* If the SMMU is already suspended, nothing to do */
>  	if (!pm_runtime_suspended(smmu->dev)) {
[ ... ]
>  		arm_smmu_device_disable(smmu);
> +
> +		/*
> +		 * A PM ref was only acquired via arm_smmu_rpm_get() to
> +		 * guarantee power for the MMIO register writes in
> +		 * arm_smmu_device_disable().
> +		 *
> +		 * Drop the PM ref, we intentionally do NOT invoke a
> +		 * synchronous put/suspend here since the HW was already
> +		 * disabled above. Calling put_sync would invoke
> +		 * arm_smmu_runtime_suspend(), redundantly attempting to
> +		 * do the same. Any pending autosuspend timer is cleanly
> +		 * cancelled by pm_runtime_disable() immediately below.
> +		 * The core code ensures the power management here.
> +		 */
> +		arm_smmu_rpm_put(smmu);
>  	}
> =20
> +disable_pm:
>  	if (pm_runtime_enabled(smmu->dev)) {
>  		pm_runtime_dont_use_autosuspend(smmu->dev);
>  		pm_runtime_disable(smmu->dev);
>  	}

[Severity: High]
Does this sequence strand the attached PM domain in the ON state?

The code calls an asynchronous put (arm_smmu_rpm_put() invokes
pm_runtime_put_autosuspend()) immediately before calling
pm_runtime_disable(). Disabling runtime PM while a device is active cancels
any pending autosuspend work and freezes the power state as RPM_ACTIVE.

Subsequent driver core calls to pm_runtime_put_sync() would then see
disable_depth > 0 and fail with -EACCES without suspending the device,
resulting in a permanent PM domain power leak preventing deep SOC idle stat=
es.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929034510.2023=
173-1-praan@google.com?part=3D15
