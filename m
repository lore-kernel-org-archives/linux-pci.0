Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8253E1201
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491107; cv=none; b=qMqlc+wuNrYWijwMwTzckAc1mgDK3sJwyptOqHW7zYZQGSFi+GE0FpX0DYHtryB4oeblc/9KjiiKuspfkj0GNUwuGxH5EqyxVmP103jUKOrlUubYRSwOCnsXZja4Yh4iBUJGar83L2qqScoYugcy1nx9vMV9+9SjwUL6OEujmtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491107; c=relaxed/simple;
	bh=3/oXh1rz9hkfLr2HUiG9Dpabnw74eUAZmWFiLVRffE8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SRRnEdoKAekNXffwzeUK9+H1kemYDPlr/BuMAM9wiDNrbqx9u+6mLQqs9n8HSW/Zp6EUq4++8lX6COniPqdjHFRHVawqEKm8fhrsvt7bn5SiiWkZA0azsQDMHwiPvwHTleVkAAk4Azi8ZkrQungyP9j8MwjfRGTbS0Om38oVNx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dI0OKXx6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dI0OKXx6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B091F00893;
	Tue, 15 Sep 2026 16:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789491106;
	bh=3/oXh1rz9hkfLr2HUiG9Dpabnw74eUAZmWFiLVRffE8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dI0OKXx6LnlnkJ7ohowIzYI8LMe2xF4QcRlAph2YmH4TA3v4zZGJuJ5DavaqcHq/U
	 q6xflpxXg71nXVOCc6V4tc+yJreEWYP+ZZe2qchKD0bWNa3nvaQ/tLeeJwTnO1VyvM
	 oEPqKjskewYfAW24r/YSnrQ1ixPV6KNxIGNWZSkHpUpgK6wQFiMYQ24Lc7Elzkmg4x
	 sYbbGohFHPUPsDyrUlJzK4PjxsQUOGqP9G+Wgp0VCj80q+UwuK3m0aesfJsPMJDo/n
	 PDyd3wEhs8rwPr30tF1QnsW44eIVOL+UYYbepOYRtslPUuYxzQiPilnVQ9U1rUIB4m
	 EiME8Ym8GVTQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/15] iommu/arm-smmu-v3: Disable the impl before
 disabling the SMMU on shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <3747b39aa5898f450535847760d9cebde37684e1.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <3747b39aa5898f450535847760d9cebde37684e1.1789446520.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 16:51:45 +0000
Message-Id: <20260915165146.06B091F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> arm_smmu_device_shutdown() only calls arm_smmu_device_disable(), and never
> the impl_ops->device_disable() hook. On tegra241-cmdqv, that hook quiesces
> every VINTF through tegra241_vintf_hw_deinit(), which issues a CMD_SYNC on
> the shared CMDQ while it is still enabled.
>=20
> arm_smmu_disable_action() already runs this hook before disabling the SMM=
U,
> to cover an unbind or a probe failure, and no devres release ever follows=
 a
> reboot or a kexec to run it again. Have arm_smmu_device_shutdown() call it
> directly, instead of reimplementing part of what it already does.
>=20
> Fixes: 9ff145a25c5c ("iommu/tegra241-cmdqv: Fix CMD_SYNC use-after-free o=
n teardown")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789446520.gi=
t.nicolinc@nvidia.com?part=3D1

