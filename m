Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A344BE43A
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490895; cv=none; b=RXTO/4kMXggdTp+8KxHZfrUwSXSkc/FxSid3rKTZpU+0JkA/z9TsHju4fd28VNWYuy0ME/UCDeqfsl3YL98zBe6JaFrgMrm/NC1BFunWpGXZYzs34qLCpPSR80bHSAYUcmvS19B8r8Xb5otm1nT4GAT1MXM7FlJfo7bn+5RT6L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490895; c=relaxed/simple;
	bh=BO8yluQOHwQc/eFGoJQJPbjYzmeevEJlqdaMAzBjzZY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TCeXMMrvc02zo9r7kUCBWSKf4EffzxgwmdkcdEQg9e6VhsZU0HHFvqntgmybC5mhuo7ztpfy66aFj6eYAacaH01hyfnACq46jvacTNYXZiGjRf2Dgox1fo9yfUTuVM6i16F1Pl1s3bR54Rv8wqNOYhD8+nA2KCGu4yRFQFET7mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2gMp9e+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2gMp9e+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5AA1F000FF;
	Tue, 15 Sep 2026 16:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789490880;
	bh=BO8yluQOHwQc/eFGoJQJPbjYzmeevEJlqdaMAzBjzZY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N2gMp9e+8EHtkcE/jPovtgJI+8vmR0q6HOKK+SQkhJpUUbn+EpzzG5HGHrKbAYjFi
	 HBfIimPdy+47hEckG4e8pVZ76rqyU3u7SfPD/IBla/X+DQV70gPdYT+FsfHVit/6M/
	 NNUU7kKoHog9a7xnQ7Lu6aIhlRWYPTOu+QNXLUktwKa+O0qTpnAQl5I+dbJyknlZAv
	 r0mQzhqvafdo5Gw81+IjRlcndMajxlAtS1DccTg2YwN4sJwuTYtt8A26mQlTuaoYrI
	 It82bm3AVH1O0/l4KsthZzgfzvpo0NtxJZSxlAcrjmaVjx+9fFs9Bo14/GK7yiwyDW
	 qoDdUyiMQsPJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/15] iommu/arm-smmu-v3: Allocate IOPF queue without
 FEAT_SVA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <04fab7d8ebfc7e5d365f42569928d015d9c8b781.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <04fab7d8ebfc7e5d365f42569928d015d9c8b781.1789446520.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 16:47:59 +0000
Message-Id: <20260915164800.6B5AA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> arm_smmu_init_queues() allocates the IOPF queue only for FEAT_SVA together
> with FEAT_STALLS. This queue has no SVA dependency, and FEAT_STALLS alone
> can produce events that need IOPF.
>=20
> On HW with FEAT_STALLS but no FEAT_SVA, a master with the "dma-can-stall"
> device-tree property has master->stall_enabled set at probe. Then also wi=
th
> CONFIG_ARM_SMMU_V3_SVA=3Dy, arm_smmu_enable_iopf() sees stall_enabled, ca=
lls
> iopf_queue_add_device(NULL, ...) at fault-handling domain attach, which c=
an
> oops on mutex_lock(&queue->lock).
>=20
> Allocate the queue whenever FEAT_STALLS is present. Also select IOMMU_IOPF
> so iopf_queue_alloc() is always available without CONFIG_ARM_SMMU_V3_SVA.
> Since IOPF does not depend on SVA, drop the SVA guards from its enable and
> disable paths.
>=20
> Fixes: 395ad89d11fd9 ("iommu/arm-smmu-v3: Add stall support for platform =
devices")
> Cc: stable@vger.kernel.org # v5.14
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789446520.gi=
t.nicolinc@nvidia.com?part=3D6

