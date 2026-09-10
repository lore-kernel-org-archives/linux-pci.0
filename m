Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A79399036
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 23:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789083360; cv=none; b=UsJqzdXx+gQjLbCQnpLQmkTTGk4IX9ldm1nXsbg1HWUM++Rk9q3RJ3T9viiNP+eWQa9wjvnLBoRNGTIwjGtfu0KzOVyX+jzqc+ZCtMlTa3Y9StwelyVXf9ueMiVvaA5XeBqxL7P3fBKjUHYRkse5xKxT6Z33tLXuRpyzKwjOOKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789083360; c=relaxed/simple;
	bh=x2YBQUhJE5SYnuXJDyx1k5YrcNn3s0ZSz7nrDtiJMDU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AFTy23Fj4WrTzRy40/vc0rsDCJQtT8v8fhG2l65uJ+KIJTAFYzBTNAxjRw36uBjyP8vGGP7eVoDBIus32i6fLlEbuwOlW8ibaKTwp/1/lVWjC0nUkDTj85mDp8iWooENeFTqHRB5OqcD0xzzgmKwR8eA6d5v3PpM/3qii4pBurM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyXQtBkp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyXQtBkp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CF41F000FF;
	Thu, 10 Sep 2026 23:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789083358;
	bh=o1GU8dNxKh0krn0UUbUin2lHafQ642VItWwVlezz+Tk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DyXQtBkpmdSbpGTGVXT3zXfyy7ye0/DKqjXFwf6LGDDkneuTLymapIpwQzwpD93mb
	 d6Qd9BAosaxDDGJJwO/2mzNYokd+52sYJPyyRby1a1BkSi9wHRyrNt1U2gCZUL8a2k
	 CAaC5iNY7Z8cugcQ+wRRuRxRfOKYyNEgjkLvK9WxkACs5hLz+lcy5uzDMxZUxlwZVe
	 PUvR67CcJtqnBKEygrFN85EHqAdNOGdzEFj3Q5U7kNuImlibZZ8a4FvoeAledU02qA
	 ccnszp1MWTnurT1LQL5PeyFZZDO1GPqaBFr+A7LpIvhqgpU3tblxeABcK79pkOup/S
	 w5xc7IOhO76Ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/15] iommu/arm-smmu-v3: Support PRI Page Request in
 arm_smmu_handle_ppr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <cbe6e6f578af848f4efdd8d1050181032effae37.1789081084.git.nicolinc@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
 <cbe6e6f578af848f4efdd8d1050181032effae37.1789081084.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 23:35:58 +0000
Message-Id: <20260910233558.A6CF41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `cond_resched()` in the PRI queue polling loop, potentiall=
y causing soft lockups.
--

commit 3323ab058351966ce0deb549fa5694bcbf787b2e
Author: Nicolin Chen <nicolinc@nvidia.com>

iommu/arm-smmu-v3: Support PRI Page Request in arm_smmu_handle_ppr()

This commit converts PRIQ entries into iopf_faults for PRI-enabled masters
and reports them. It also discards PASID Stop Markers prior to fault
reporting and keeps the LAST-page DENY path for unknown StreamIDs.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 43a6029cef430..c631c6344685d 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
[ ... ]
> @@ -2380,9 +2381,47 @@ static void arm_smmu_handle_ppr(struct arm_smmu_de=
vice *smmu, u64 *evt)
>  	last =3D FIELD_GET(PRIQ_0_PRG_LAST, evt[0]);
>  	grpid =3D FIELD_GET(PRIQ_1_PRG_IDX, evt[1]);
> =20
> -	dev_info(smmu->dev, "unexpected PRI request received:\n");
> -	dev_info(smmu->dev,
> -		 "\tsid 0x%08x.0x%05x: [%u%s] %sprivileged %s%s%s access at iova 0x%01=
6llx\n",
> +	/*
> +	 * A PASID Stop Marker (LRW =3D 0b100) does not expect a response and
> +	 * must be discarded before fault reporting: see the documentation
> +	 * at iommu_report_device_fault().
> +	 */
> +	if (last && !(evt[0] & (PRIQ_0_PERM_READ | PRIQ_0_PERM_WRITE)))
> +		return;
> +
> +	mutex_lock(&smmu->streams_mutex);
[ ... ]

[Severity: High]
This is a pre-existing issue, but missing a cond_resched() inside the queue
draining loop could potentially cause soft lockups:

drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:arm_smmu_priq_thread() {
	...
	do {
		while (!queue_remove_raw(q, evt))
			arm_smmu_handle_ppr(smmu, evt);

		if (queue_sync_prod_in(q) =3D=3D -EOVERFLOW)
			dev_err(smmu->dev, "PRIQ overflow detected -- requests lost\n");
	} while (!queue_empty(llq));
	...
}

Could a faulty or malicious PCI device flood the PRI queue with requests
faster than the CPU can consume them?=20

If the outer loop continuously polls the hardware producer index via
queue_sync_prod_in(), preventing queue_empty() from returning true, would
the host CPU get stuck in an infinite loop inside the IRQ thread?

Since arm_smmu_priq_thread() runs as a threaded IRQ handler, wouldn't this
starve other normal tasks on the CPU and lead to a soft lockup or RCU stall?

Does it make sense to include cond_resched() in this loop, similar to what
is done in arm_smmu_evtq_thread()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789081084.gi=
t.nicolinc@nvidia.com?part=3D10
