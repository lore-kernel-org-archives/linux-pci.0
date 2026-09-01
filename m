Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611BE36EA99
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 00:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223571; cv=none; b=G9z7DFOcjnb+a5QrW72DCEYcCjWg4Acc2dZp9rC0S79YL80NIa89ikCnZq0gMc7bqkBTIkYhxggmKXSa67kWC7nbRAwhd3YbGIuVVc0opsXpar8EMACyjwB3R5/MSAhFfYuBcIBUZJ61bLnVMEsEdfmBsYPn2HF/ZLPq7L5RllE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223571; c=relaxed/simple;
	bh=i5SYbucZLhWC1gPJpiy7JMos5gXwUaqAL0jHyU/c+Us=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Umeju2khZ1cg4ceTtSL9C74mlA021WvNpqiPRlo9GZBegQPEWi+oK+aEapq5DAHqVCBy3+GcpxvMUTamIqNZuV+foEIK/uqVLYNVrw/hzFmy5vc00FU8hnEWYmzgOkzMGPjzL8vDks7Zul3lGb+/KNHPAMUqaNYqXqq7erVYOn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfO+JFEr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfO+JFEr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5F71F000E9;
	Tue,  1 Sep 2026 00:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788223569;
	bh=i5SYbucZLhWC1gPJpiy7JMos5gXwUaqAL0jHyU/c+Us=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KfO+JFEr27FvAdrN/hVKVOo+oRNLvpa5Qz793OS/Dh1e+tIIVZ824Bb6+qf7iKxGT
	 8lp2WyJA7kluFSKkOxIzOuVW3uM9fwnSFeNfdouTtVHxpKOA4CUSWj8yRoHBfqgTLs
	 2vuQvYJ9R48xRLnSedgB5l5JPiCWjgo8VwY7jG47rxrJDcT8XvEQecdRJNrK10VZ7g
	 tflPOdjuFIJkGYpXMA7xUGLfp+s1sld+kO+wlAQAN3R8Q9oYKEfCPyiL5xYglKQxhq
	 pvVSVbRS6VuWvUilDGIvjju4/8T7yQNM4QlJevFplFM0+mZyedx4v0eieo4m6FkJ6n
	 lKG+a6DHfLi+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/13] iommu/arm-smmu-v3: Allocate IOPF queue without
 FEAT_SVA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <1e9c1a2aecfda2c0b1a8505b2c11a0c0a29b7405.1788222485.git.nicolinc@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <1e9c1a2aecfda2c0b1a8505b2c11a0c0a29b7405.1788222485.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 00:46:09 +0000
Message-Id: <20260901004609.CF5F71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> arm_smmu_init_queues() currently allocates smmu->evtq.iopf only when both
> FEAT_SVA and FEAT_STALLS are advertised by the SMMU. The FEAT_SVA gate is
> unnecessary: iopf_queue_alloc() is a plain workqueue allocator with no SVA
> dependency, and FEAT_STALLS alone can produce events that need IOPF.
>=20
> On HW with FEAT_STALLS but no FEAT_SVA, a master with the "dma-can-stall"
> device-tree property has master->stall_enabled set at probe. Then also wi=
th
> CONFIG_ARM_SMMU_V3_SVA=3Dy, arm_smmu_enable_iopf() sees stall_enabled, ca=
lls
> iopf_queue_add_device(NULL, ...) at fault-handling domain attach, which n=
ow
> oopses on mutex_lock(&queue->lock).
>=20
> Drop the FEAT_SVA term so the IOPF workqueue is allocated whenever the SM=
MU
> can produce IOPF events, and select IOMMU_IOPF from ARM_SMMU_V3 as well, =
so
> iopf_queue_alloc() has a real implementation instead of the NULL-returning
> stub when CONFIG_ARM_SMMU_V3_SVA is unset.
>=20
> IOPF is orthogonal to SVA anyway. So, drop the CONFIG_ARM_SMMU_V3_SVA gat=
es
> in arm_smmu_enable_iopf() and arm_smmu_disable_iopf().
>=20
> Fixes: 395ad89d11fd9 ("iommu/arm-smmu-v3: Add stall support for platform =
devices")
> Cc: stable@vger.kernel.org # v5.14
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788222485.gi=
t.nicolinc@nvidia.com?part=3D5

