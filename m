Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDD93955CA
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 23:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789083390; cv=none; b=qhcLB75+IwzhU1SCaz7HePxm35Gueu8ZCHonwbFBuNoNV/8Y6xO8tYx7kc8e+La+ZzDlwoG05ZPJU1UsqWY/HKsCwvxZ8ukBXhq0zxwPCFmMFur/7YYM8gJ/yNgPKUxpgS0rBaXF3McVEiAnC1tW4KmteP1sJFyaduNHgtvJgP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789083390; c=relaxed/simple;
	bh=Kh3LqZt+C5aQJDhj2ItllGi3kpmLQfvdEdyrg8YqqnE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MFpZXJ8R6QzHuOggrQGoAc0Qu/B6zsuhmGy5PgxhrnWmsT9BWhqWUkeMs/HME6Edm9jURhP6M2ZmjQwG8KgUdB6IF/Kn0qtjKmAvtyDPPTre0fs98PJRxGEBzhVzxS5F+nL1pkg6c8IX6IWJfcyEiWxwlXmMXh+36Ixk5Tx/e0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNmmNqul; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNmmNqul"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9D51F00893;
	Thu, 10 Sep 2026 23:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789083386;
	bh=Kh3LqZt+C5aQJDhj2ItllGi3kpmLQfvdEdyrg8YqqnE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lNmmNqulw6eio4ZwmUk3imF541aUa6bXunJqaANGoZm+GTNAqcLe8CM+CS8J3wxwD
	 dIdSlpF1zifvef0++TDoPYz/mGBuRDwI9NDIGcA/gg/TgNBZGq1Pu3XKwClVCHdctd
	 KzesONBptSWCJsCfMNIOwK+9oLPuwiI/+wRutAvX5i4S4TARj30jYs3/20cBpTGwn8
	 Un/R9dxuqXfeUg7YNaLkiWOU9Sftq3LQbY4NZERg9SxLWGj478XmrrlTWQvFuONFLl
	 HBBNtSgI9eWLBxPZxA2KIZ/kjOSMgBA47qaT14LdzNVFwdvnhyOlwmGQfXngiKqOG0
	 tg8cYp+H8S8tg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/15] iommu/arm-smmu-v3: Disable PRI when no IRQ
 handler is registered
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <e35aa8feef5208fffa7faba93725ceeb0ee2be93.1789081084.git.nicolinc@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
 <e35aa8feef5208fffa7faba93725ceeb0ee2be93.1789081084.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 23:36:25 +0000
Message-Id: <20260910233626.5A9D51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> arm_smmu_setup_irqs() can leave the PRIQ without any registered handler if
> its IRQ is missing, its request fails, or the combined IRQ request fails.
> These paths warn but leave ARM_SMMU_FEAT_PRI set.
>=20
> This function itself would then go on to enable IRQ_CTRL_PRIQ_IRQEN, even
> though no handler will drain the queue. A later patch also enables PRI on
> such endpoints. The caller already enabled CR0_PRIQEN before this function
> even runs.
>=20
> Clear ARM_SMMU_FEAT_PRI in all three failure paths, so that subsequent co=
de
> treats PRI as unavailable. And disable CR0_PRIQEN after the setup function
> returns.
>=20
> A kdump kernel doesn't service page requests: strip FEAT_PRI when detecti=
ng
> features, so downstream PRI setup is skipped.
>=20
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789081084.gi=
t.nicolinc@nvidia.com?part=3D9

