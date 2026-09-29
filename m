Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A115E3AE6F5
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 04:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790655116; cv=none; b=WQ1i0KDYQ8pO/n6YUrmVXsanCUA2rY8XtnpWJYbXgkArYertHXevZOVJmCf3sPt4CdheQETgWFt++10znDLbiVKIVZfrb2q0PZF2NOyGsvZjFlcdO3YBypNtLjOiCCetExWibblTLj1qKBJamlqJgKsXzpbGMyW3E+T6Z1t+ry4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790655116; c=relaxed/simple;
	bh=lfIox68+6h0lc3ep4KXVFSqWxVE7ccglJjL4pjwhRZs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UklGmZE5+yzOPV0RZyFsBIm/7StVe4hT6TBatztwASG28tvkw7o2F/YZ/+YFoLT9Hf4q7a89CRdMLmCrgI18dF+FgMiiSkkbtBOp3mLNJ7mCGJW/FfGWY+HpKKl0QV7SlVO66PUThhGfw+ZUPMu40Bd3/JmFMR1ENiw0x1vbVPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oa/186se; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oa/186se"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1A91F000FF;
	Tue, 29 Sep 2026 04:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790655115;
	bh=QKb+znL6NjjDP5aOo1E37cl8tz2JiXTN+NDtnOFjv+c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oa/186seuDNmefmxWqMLPEK/hzv88YTALBc4ptKmCd3igzcbRb2v7abHmaEGT5b0m
	 DKzuq5LD/8F/6Xc4WntBauhNByLcWCXHiI+6ZygW7swhIfrZ7KTI9Nvh4Jkq6LoNbU
	 hZc1/xdHLkm0HXsUPejWwpFXjIuE1SlZ6HlpcgG5JANGEkvTFSd6cnliRREdKsGgjm
	 QN72ULRY0QvJPC9Sb29D0jmZfLnNNbs0mlixqscWO72r6utyOJibqtT3N9CSnFj/GO
	 BWMerjEJhtdHAE/qf6Bo38x9WqNPFv1G9Mjv7K8P+tnz9h/Ne78i1nMDn1eMG5fkmk
	 +W/26mabtifEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 03/16] iommu/arm-smmu-v3: Add arm_smmu_drain_queue()
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260929034510.2023173-4-praan@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-4-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:11:54 +0000
Message-Id: <20260929041155.0C1A91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] iommu: missing final condition check in arm_smmu_drain_queue() p=
olling loop
--

commit d3de0e0ff6c17b4b4b52184a4e8af1a09c29b369
Author: Nicolin Chen <nicolinc@nvidia.com>

iommu/arm-smmu-v3: Add arm_smmu_drain_queue() helper

This commit adds a sleepable, counting-based arm_smmu_drain_queue() helper
to replace queue specific polling loops. Its until_empty mode serves suspend
and runtime PM routines that drain the CMDQ.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 06b7de2e6e4b6..84b56849f6dc4 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c

[ ... ]

> @@ -948,6 +948,87 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smm=
u_device *smmu,

[ ... ]

> +	while (true) {
> +		/* Accumulate the entries consumed since the last poll */
> +		prev =3D cons;
> +		cons =3D readl_relaxed(q->cons_reg);
> +		drained +=3D Q_POS(&q->llq, cons - prev);
> +
> +		prod =3D readl_relaxed(q->prod_reg);
> +		undrained =3D Q_POS(&q->llq, prod - cons);
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
> +		 * Q_POS() would wrap and undercount drained: that could trigger
> +		 * a spurious warning too, if the queue was never once observed
> +		 * empty. Yet, that much consumption in such a short interval is
> +		 * unrealistic. WARN it only, as a stuck consumer is a real bug.
> +		 */
> +		if (WARN_ON(ktime_compare(ktime_get(), timeout) > 0))
> +			break;

[Severity: Medium]
Is there a missing final condition re-evaluation after the timeout check in
arm_smmu_drain_queue()?

If the thread executing this loop is preempted for more than the timeout
duration immediately before the ktime_get() check:

arm_smmu_drain_queue()
    if (!undrained)
        return 0;
   =20
    [ ... thread preempted by hypervisor for >1 second ... ]
   =20
    if (WARN_ON(ktime_compare(ktime_get(), timeout) > 0))
        break;
       =20
Could this sequence result in a spurious timeout?

Even if the queue was fully drained while the thread was scheduled out,
when the thread resumes it will immediately evaluate the timeout as
exceeded without checking the queue state one last time.

This would trigger a WARN_ON stack trace and return -ETIMEDOUT, which could
then cause caller operations like PM suspend to fail.

> +
> +		/* The consumer might be a threaded IRQ handler. Yield to it */
> +		usleep_range(100, 200);
> +	}
> +
> +	dev_warn_ratelimited(smmu->dev,
> +			     "queue drain timed out at prod=3D0x%x cons=3D0x%x\n",
> +			     prod, cons);
> +	return -ETIMEDOUT;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929034510.2023=
173-1-praan@google.com?part=3D3
