Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620A523395D
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 23:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789082918; cv=none; b=CkaCQ6TVuYmAsf55b50VMWufS/hEpqmULbJIejDZNYWpdvGGtPrZELM0zEsIsjP34ctqd1wnummYAdxtlMKIcz86KtNyQF9RATlkBFXegYIARCoIcOxGAg7R3t5AmjvOFM37RMwcMcqrTj7MwORWsETx0kwcRThK+nJqzpr1yqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789082918; c=relaxed/simple;
	bh=z+dsKhqjPMy/FKdvEsJ7V/7v27N/VlNLP5u1FhDPIuU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pT1qr6xMRvIspioVIOx9xDNJrYRyxP8qwtqRrp12Dsigckyc8+E5B+NfWn3wh8doKgNtS2luk/NH/hTg66K5OZI96awkv89aev0Yb+W1R31pDUOverzaU4Me0CQYxNefzlbEncSFPouL+wstyZ/La6kGxwfdnDh71M8qFFZrXao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0agUH82; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0agUH82"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43731F000FF;
	Thu, 10 Sep 2026 23:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789082916;
	bh=z+dsKhqjPMy/FKdvEsJ7V/7v27N/VlNLP5u1FhDPIuU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=o0agUH82b7AFKv1n0oNyhwcwqLpkQov7FP90jzduy/kVeCtfu57iBfeSoAJjEZhK8
	 6XHa5QRZ3YaNhO/RTRE2XByC6L9l2KGJeyY3VsvYryufsDByyleQ2GHFjxeQo53qLf
	 Zl+PDPFz1Sles1dyKEVz5/cxT1uUqiVbr56H4WdFiui1+mrO/lwWkxNZ2Ux/Kb/9DL
	 /v0h00j6KqM0Ykd/naZXDPzOmuF+iSmFKLHhRaMHnRcTn7gv/4szMvctA4cllMlzm7
	 oMVnli5JSm6meXEGJsbWgvs6XI9cHPFB6ii/bPM8pnW6eqq+RBBHM6QmF7tDtmmHfA
	 xDkC0bzXRo8DQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/15] iommu/arm-smmu-v3: Disable the queue IRQs
 before disabling the SMMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <5a18a20a17a08722098fad6d5229e2e2f82074ce.1789081084.git.nicolinc@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
 <5a18a20a17a08722098fad6d5229e2e2f82074ce.1789081084.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 23:28:36 +0000
Message-Id: <20260910232836.C43731F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The EVTQ, PRIQ and combined IRQ handlers are threaded and issue commands =
of
> their own, e.g. a CMDQ_OP_PRI_RESP for a page request. Disabling the SMMU
> while one is in flight hands that command to a queue consuming nothing, so
> its poll waits out a full timeout.
>=20
> Two paths disable the SMMU while those IRQs are still requested: a failing
> arm_smmu_device_reset() returns to a probe that disables the device itsel=
f,
> and arm_smmu_disable_action() covers an unbind or any later probe failure.
> Both can run after arm_smmu_setup_irqs() requested the IRQs.
>=20
> Disable those IRQs first in both paths, so that no handler is left running
> once the SMMU goes down. arm_smmu_device_shutdown() needs no change of its
> own here, since it already just calls arm_smmu_disable_action().
>=20
> Also clear an IRQ number when its request fails or is skipped for a missi=
ng
> ARM_SMMU_FEAT_PRI, keeping disable_irq() to the IRQs that this driver tru=
ly
> owns.
>=20
> Note that the IOPF queue needs no such care of its own, as devres frees t=
he
> IRQs before running the release action of that queue, which came earlier =
in
> arm_smmu_init_queues().
>=20
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789081084.gi=
t.nicolinc@nvidia.com?part=3D8

