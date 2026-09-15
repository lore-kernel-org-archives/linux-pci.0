Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD89E4BA1D4
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 16:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490898; cv=none; b=LCf9gYZHWxUa4QxIOOLaM4IhjXhsTkkQCDwCQ2dPFxlA7SXS4d9D67mLc4T3YeLcISWw0nXoFeAEgOtAFiD3jPVcG+klOuBt4u7m+NmOawlC9t7dS631t674hhLi70NCmvHRib1faHYbr7/8ZG+ix2xOJR8532QbfyL+lMVy7aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490898; c=relaxed/simple;
	bh=C7GnHbAQ9r8Q6O5Wo9Dk2VANNbEG8xj++nlUmjyuaTA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tfC7TMgzOpDj/jWDsSwAzA8hF1z3HHWJqm1iDtqwRXm3msXWc1zoOLLLFNyncMKO8OohXwP2B4dBt/JD3ZFLX9pO8pxkUFWYurxaEXgB1hjS17ARqSI0zSXlenbA9STybAAY7QLel8WEnzOCx4S1kYa9iA0xIR5CYQ8AhwgxvjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBG8kxOe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBG8kxOe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1907F1F00898;
	Tue, 15 Sep 2026 16:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789490886;
	bh=C7GnHbAQ9r8Q6O5Wo9Dk2VANNbEG8xj++nlUmjyuaTA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TBG8kxOe5Zt8bqH/wFWAM+eqJKJH75mkQf615jEOAWS7d4uNLRpMTLsipvrIzFlwk
	 PzmlZeAg+PsExpJbLy3kCe+wRhHK392QDLpSULxr+zzIoYe1Jc8eAg6TG7qlvPn9CJ
	 dbTpQElsxWoZ3LDvTjf0BAkZskP6cfy4ocgaY3HtR68LYxjirOXLIhn+DnFQ5KfmeM
	 0hhGSFePZGkwisUPcnXQs6jmlHZeBsVhtHT3JmDO8+lz4D1833a4Ca+oUyRg0xn2+n
	 rwBQKGFYueL0PolTSP5HdzzduzvTEXanbuYRVGoysT3CJHTECgGwIz8Bjpd3glyykh
	 aSkBFVb+dqz4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/15] iommu/arm-smmu-v3: Disable the queue IRQs
 before disabling the SMMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <0ca69e93a9370e4e172e4335104859648b8755c2.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <0ca69e93a9370e4e172e4335104859648b8755c2.1789446520.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 16:48:05 +0000
Message-Id: <20260915164806.1907F1F00898@smtp.kernel.org>
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
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789446520.gi=
t.nicolinc@nvidia.com?part=3D8

