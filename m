Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95168379EEA
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957809; cv=none; b=SAg5zdx/5R0do0oOSUQibaRcct3s98+Vz89MOlOQWgaqXUXYk2nUEk2GYWG1tQh3UnAXIdZG1w00k45E+ZH3zUil4CvA9fc/l6zwIBVZtbEf7XUkO8qjBmnSB0yQ4JXPgjgcKytE+QxqewzhAxhpBZwN2Nsr4CGvi43hy8cmlbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957809; c=relaxed/simple;
	bh=Rk/BdAMP7qefmujwgCYGDbbuNqVYp63y3zNFC/VHcGc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FAo6HEJ4HhIjIqRIhRqxDb/fqzR43+xAzwxwBaSiAfZqDX8FmFzL6dv1evDOfsPz6yh8qX/QZFfMOuxxSMcA2Xp7oVThy5fVzK0Co6xCvzJPyklO5+d1fPCUdN+0Y/PE91Im8Y0tcuQhgova1gR/Z8qwMyWQhpTzMrT1knXG/3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhMbTx1e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhMbTx1e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4436C1F000E9;
	Thu, 28 May 2026 08:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779957808;
	bh=KxQ9zzcefvPvzO6DQisMAYWdjWgJjxcbUHIGlFIRodg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LhMbTx1e3ghz8aE7a1FZm3scVAIkd1M5YqfP8h94X1db2jgXuPZAlZ7LHYYm5J8H0
	 SaxtBzxGd0zgDD+q4bnnW76S/l+q7dlejS6VBgs3JhGwUFD8z9yDJXKSqwEBdfcbAA
	 7m8EyPRIhCaV0UtTR5npyUVVf0XI4Y7oCVHd5y+9/+GEyntiyUKMLF9iS54LO6d20q
	 HN6575d9olGN8affzIUVYzw//YAUFSG1YZpwOrQz3mQEz220JL1tNZRgYlOq2bVnxR
	 /AXpDxSJMiL2TzaXxk9P5vFZI3C+erklXkh+o0hjwhA6na8nRim5ylC+HKE6m1tkoe
	 1JTD1IZpNVuow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/11] iommu/arm-smmu-v3: Add
 arm_smmu_drain_queue_for_iopf() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <a62db13ab63916e9a62cddeec41a74a98cdf6a8f.1779944354.git.nicolinc@nvidia.com>
References: <a62db13ab63916e9a62cddeec41a74a98cdf6a8f.1779944354.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 08:43:27 +0000
Message-Id: <20260528084328.4436C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Unbounded exponential udelay() in queue_poll() defeats cond_resche=
d() and stalls the CPU.
- [High] Missing final queue state check after queue_poll() timeout leads t=
o false positive timeouts.
- [High] Spurious success when the queue is completely full due to flawed _=
_queue_consumed() logic.
- [High] Comparing a continuously advancing cons pointer against a stale pr=
od snapshot using __queue_consumed() causes false timeouts under sustained =
traffic.
--

commit 14bcb1387d4a8bb96abcbd316d76e0715f493ccd
Author: Nicolin Chen <nicolinc@nvidia.com>

iommu/arm-smmu-v3: Add arm_smmu_drain_queue_for_iopf() helper

This patch adds a helper to drain an SMMU EVTQ or PRIQ up to a snapshot
of the PROD register. It reads CONS from MMIO each iteration and calls
cond_resched() to avoid starving the threaded IRQ handler.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index cf41b3cf5985f..4794a15f351c4 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c

[ ... ]

> @@ -894,6 +894,33 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smm=
u_device *smmu,
> +/* Drain an SMMU EVTQ or PRIQ to a PROD snapshot taken on entry */
> +static int arm_smmu_drain_queue_for_iopf(struct arm_smmu_device *smmu,
> +					 struct arm_smmu_queue *q)
> +{
> +	struct arm_smmu_queue_poll qp;
> +	u32 prod, cons;
> +	int ret =3D 0;
> +
> +	/* Snapshot PROD; entries [old_cons, prod) are the cohort to drain */
> +	prod =3D readl_relaxed(q->prod_reg);
> +	queue_poll_init(smmu, &qp);
> +	qp.wfe =3D false; /* No SEV on EVTQ/PRIQ PROD advance */
> +	/* Read MMIO each iteration; llq->cons is the threaded handler's */
> +	do {
> +		cons =3D readl_relaxed(q->cons_reg);
> +		if (__queue_empty(&q->llq, cons, prod) ||
> +		    __queue_consumed(&q->llq, cons, prod))

[Severity: High]
Does __queue_consumed() return true when the queue is completely full?

If the queue is full, Q_IDX(cons) =3D=3D Q_IDX(prod) and Q_WRP(cons) !=3D
Q_WRP(prod). This matches the second half of the condition in
__queue_consumed():

((Q_WRP(q, cons) !=3D Q_WRP(q, prod)) && (Q_IDX(q, cons) <=3D Q_IDX(q, prod=
)))

If prod is snapshotted exactly when the hardware queue is full, this would
exit immediately without draining anything.

[Severity: High]
Can the 1-bit wrap logic fail if cons advances more than a full queue size
past the prod snapshot?

Since unrelated traffic continues to advance both prod and cons, if the
polling loop is preempted and cons advances exactly two wraps ahead of the
snapshot, the 1-bit counter will wrap.

This could make cons appear to be behind prod again, preventing the
condition from converging and causing spurious timeouts under sustained
load.

> +			return 0;
> +		cond_resched();
> +	} while (!(ret =3D queue_poll(&qp)));

[Severity: High]
Will the exponential backoff in queue_poll() defeat the purpose of calling
cond_resched()?

queue_poll() doubles qp->delay on each iteration, eventually calling
udelay() with very large values (up to roughly 500ms given the 1s timeout).
Since udelay() does not yield, this creates a long busy-wait that completely
stalls the CPU.

If the IRQ handler shares this CPU on a non-preemptible kernel, could this
prevent the handler from making progress and cause a soft lockup?

[Severity: High]
Is a final state check needed after queue_poll() returns a timeout?

If cond_resched() yields the CPU for a long time and the task is scheduled
back after the 1-second timeout expires, queue_poll() will immediately
return -ETIMEDOUT.

The loop will then exit without checking q->cons_reg again, even if the IRQ
thread fully drained the queue during the sleep. Could this lead to false
positive timeouts?

> +
> +	dev_warn_ratelimited(smmu->dev,
> +			     "queue drain timed out at prod=3D0x%x cons=3D0x%x\n",
> +			     prod, cons);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779944354.gi=
t.nicolinc@nvidia.com?part=3D3
