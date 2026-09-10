Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E185449E130
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 23:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789083127; cv=none; b=Hqk3qp/sK80vVDAk0CyGWjN8d8KCWj1CCj2/ZEovscOI18DBkUxVMpCyt3wXuUiUWlg/9cxH8Mq5dr6R3t30t5M/zYilhDTsABxrZX869fxntSWaAUypENeVENtJ0+y9CxCpIe/OpwAkyRdYKwTj8ysltQPm7INOb+tO3Qy90qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789083127; c=relaxed/simple;
	bh=uikVSOznQycPoBtowQZ98ZzxXzmswNtgjUpM6scH0qM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KwQiVOq8/liBt+GvFYNhK+nzif1XsU7ZUYQOOOHPqxWlgJtzOULpzO3H8CYqCS7idWJPBi/d6XqvoZC/SjTUiKy/JlJT17q9J0B+UBxv6Nqwidy64H1vVEyLtQAEl3QXwu1sgrR752wWAhGuKZuhwjjkBneR0pcF9TIm1Fggpxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WP6ppwNY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WP6ppwNY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7FD1F000FF;
	Thu, 10 Sep 2026 23:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789083125;
	bh=uikVSOznQycPoBtowQZ98ZzxXzmswNtgjUpM6scH0qM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WP6ppwNYrFvyoxK/uHGTdQycRpbwZdJTVM8ptA4PLoJ0zvZOZuWATE8Wcvxt20Ewa
	 +ZxyDtECQOlSrT3clkMicSQ5e3NjiveGxGjE+ZBu0Gaq9pVcOqe6odEJGzo6YLZBsZ
	 TxFYBUAEcx0Gl7da17KiXXlRv9i0Cb9RmWHIz6tgSyfjOhbQZn/JInD5/z5twofXJ9
	 U9aeNCXqGF1fmVHf8VBg/hPnCtdO8NE955QMBgUFlwx3vNZGPdpxIWEwAGpvEFxlPn
	 AtE7ITZwn5XXFQ2CJN5Eo40rh62JTe8pJ0AynfXHNp89BJAM/XsyLpCF44L9B8y1z4
	 NkDiqIRrXJnHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/15] iommu/arm-smmu-v3: Disable the impl before
 disabling the SMMU on shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <61536b87c45164b1f581ee4358574ee7822e212d.1789081084.git.nicolinc@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
 <61536b87c45164b1f581ee4358574ee7822e212d.1789081084.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 23:32:04 +0000
Message-Id: <20260910233205.3D7FD1F000FF@smtp.kernel.org>
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
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789081084.gi=
t.nicolinc@nvidia.com?part=3D1

