Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1CE49E130
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 23:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789083116; cv=none; b=akLjZIAKS17/0m2F9r5dLU2HphT/lAQ9g+zGM97BGKBHvKt800DeT8iX533QgRUOmpBU8Si8XtZ83a6/2eb7mlyovNHm6d4/GRUyCaBQFDwXnzUV/6oRpxqO697nJBaOQJeYbp2rNMNni5AktqPClH4v3wGcBr75yKRtK1YcXw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789083116; c=relaxed/simple;
	bh=bjBoBwoiFMFFdpFX+/sWub7hbE5ZlF+GoKjThGAbv/k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CITAgdMBIGKixYgLbOu6DeTH7CAzlr3DRrMymVoHOVKGiBjn5r5edcwrIeBQdoXf5sCAv3I9zJQs07q9a6YKsLLHWcENyxW1egffnr9Yd1p7Olkjmh++GqdFuWacI+IavqzvrjfZgJXPQmQ8L50maiLTQY8kSmpdvTZjS1f3mng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtSpAl71; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtSpAl71"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9318A1F000FF;
	Thu, 10 Sep 2026 23:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789083114;
	bh=ECHLqvBgG1NF6vnimbHD9NPvJUUGV8Rh6mVQjgpuXoM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TtSpAl71hJEKKr3LkW0gHHFd9H7YVFO8gpNXaCTV/QI1uruC8KWs8pRuZ9yifPzA1
	 7fLTI9O7cwrjPFUWRv0lradeMnJCUKObjVxoZW2Lzv7CuVGSeyFoDeTizhDGLoBzVE
	 Ex2v0KvHPxcQHJWLz3ItK2MSMH+XVEo+nOiJOPqP8uvFf1acQDRshCuBTDH48vLqw/
	 K1vViLUnZGp/J9yvEdGYNM5k5qEXsBr0qw05I5CHOecOZfonrHx2n2Kq9fy5BNtPQN
	 GZGlpFAXLGM4oAUSQ69X9FvvS7wVkCEe4AHQAwpu/pKwjj2AI5+ENThuLEIn+dT3cv
	 jTAqQ0gSsJatw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/15] iommu/arm-smmu-v3: Drain in-flight fault
 events on domain detach
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <e98a3f1b8964c9f4785ec6dd6c001b7aba4f1cdd.1789081084.git.nicolinc@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
 <e98a3f1b8964c9f4785ec6dd6c001b7aba4f1cdd.1789081084.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 23:31:54 +0000
Message-Id: <20260910233154.9318A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing final condition check after timeout evaluation in `arm_s=
mmu_wait_for_queue_drained` causes false timeouts.
--

commit 69f47c0ae54518e91f78d4c86bc275dd8b087d48
Author: Nicolin Chen <nicolinc@nvidia.com>

iommu/arm-smmu-v3: Drain in-flight fault events on domain detach

When a device leaves a domain, fault events for the old domain may remain
in the SMMU event queue or the IOPF workqueue. If the IOMMU core frees that
domain before those events are handled, the work may use freed memory.
This commit starts with the hardware queue by using
arm_smmu_wait_for_queue_drained() to poll the EVTQ when an IOPF-enabled
attachment ends.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index b908a8af31442..ef1fddad7868e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -948,6 +948,89 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smm=
u_device *smmu,
[ ... ]
> +static int arm_smmu_wait_for_queue_drained(struct arm_smmu_device *smmu,
> +					   struct arm_smmu_queue *q,
> +					   bool until_empty)
> +{
> +	ktime_t timeout =3D ktime_add_us(ktime_get(), ARM_SMMU_POLL_TIMEOUT_US);
> +	u32 cons, prod, pending;
> +	u32 drained =3D 0;
> +
> +	might_sleep();
> +
> +	cons =3D readl_relaxed(q->cons_reg);
> +	prod =3D readl_relaxed(q->prod_reg);
> +	/* The exit target: the number of entries in the queue at entry */
> +	pending =3D Q_DIFF(&q->llq, cons, prod);
> +
> +	while (true) {
> +		u32 prev, undrained;
> +
> +		/* Accumulate the entries consumed since the last poll */
> +		prev =3D cons;
> +		cons =3D readl_relaxed(q->cons_reg);
> +		drained +=3D Q_DIFF(&q->llq, prev, cons);
> +
> +		prod =3D readl_relaxed(q->prod_reg);
> +		undrained =3D Q_DIFF(&q->llq, cons, prod);
> +
> +		/* Exit on an empty queue, regardless of until_empty */
> +		if (!undrained)
> +			return 0;
> +
> +		/* Snapshot mode: exit once the pending entries are drained */
> +		if (!until_empty && drained >=3D pending)
> +			return 0;
> +
> +		/*
> +		 * A timeout means the consumer might be stuck. In theory, if it
> +		 * moves 2 * qsize entries or more within a single poll interval
> +		 * Q_DIFF() will wrap and undercount drained: that could trigger
> +		 * a spurious warning too, if the queue was never once observed
> +		 * empty. Yet, that much consumption in such a short interval is
> +		 * unrealistic.
> +		 */
> +		if (ktime_compare(ktime_get(), timeout) > 0)
> +			break;

[Severity: Medium]
Could this result in a false timeout if the task is preempted or delayed ju=
st
before the timeout check?

If execution is interrupted for a duration exceeding the timeout *after*
reading the hardware registers and evaluating the exit conditions, but
*before* checking the timeout:

1. The hardware might successfully drain the queue while the task is
   preempted.
2. When the task resumes, ktime_compare() returns true, and the loop breaks.
3. The function returns -ETIMEDOUT unconditionally without re-evaluating the
   hardware state.

Standard kernel polling macros (like read_poll_timeout) typically perform a
final re-evaluation of the exit conditions upon timeout to handle such
scheduling delays.

A false timeout here would lead to skipping the teardown and leaking the
domain to prevent a Use-After-Free, as handled in a subsequent commit
("iommu/arm-smmu-v3: Flush in-flight fault work on domain detach").

> +
> +		/* The consumer might be a threaded IRQ handler. Yield to it */
> +		fsleep(100);
> +	}
> +
> +	dev_warn_ratelimited(smmu->dev,
> +			     "queue drain timed out at prod=3D0x%x cons=3D0x%x\n",
> +			     prod, cons);
> +	return -ETIMEDOUT;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789081084.gi=
t.nicolinc@nvidia.com?part=3D4
