Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC8F46D2C1;
	Wed, 23 Sep 2026 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194885; cv=none; b=VdmDDPZlZKsjUVlwinPwq7RYNhPYThWYywQ/7hj5FXEAYRcRdP3YCwh6PkvviEZ5IE8tZxjWvPatY60DLalgSm2wJjhWaoqRRIrZzraXK7hZzfYXLBrKE2eKQMdibAk//cYi2YwrZX1GFX6GxJYDUN1DN6RXtXjAdV+2ibpXzD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194885; c=relaxed/simple;
	bh=bh3eNspHHAJDZhepmENS5XYy+ZenRHDY8B+RGm+FRis=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ww0i2EtzuAtgGPCtOx2bc85SPTFiGRYJbQxMtp7WgPHDgdFc5SQEET0HJGrKmtifZanWCxBt96brnJ7yg98IyJ9HCWfFB5EQyITD5h6IoqQksW0kW0MlctcfPGtJrLiY0Zt/oeN89bEr4gFvWyzeh1brl1zkuOSrE9hjxq+gxOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eiz5DYVl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eiz5DYVl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5295C1F000FF;
	Wed, 23 Sep 2026 20:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790194876;
	bh=bh3eNspHHAJDZhepmENS5XYy+ZenRHDY8B+RGm+FRis=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Eiz5DYVlNNtKf5sXuyu5iKVo3regRscjQOKw8yQPBgfxGIkracTHNHOMJGjT0u1Dn
	 Nw536gsgodEWstKklXW4VcUwPbkgjGFPWQKE6zqyDchZXaLik82L5RB7sxrtM4Uugk
	 Xd3LfbQv86QUUNosyThx0owGS/xMRii7Jzv/X6LD1M5+gWcmNhzbuzaf5D+Sdb6iT5
	 +ZairS0FhaoxNXmhWlgfZGpbFEm6mwejlISPwQwwyy7CmQQSnvEZ0ofZ8SnPFRvSBR
	 LSYw2rtj63kX9LZx7cZpTjrArbTY3SjoGT+AxQakWn8Cr/VeLrAN6mCgfIMl8N38xN
	 iyA3dnlICFgcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/17] iommu/arm-smmu-v3: Introduce per-cmdq
 cmdq_err_handler callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <805f64a69c8a6e9aca32d66a0fbe60f333e40865.1790188510.git.nicolinc@nvidia.com>
References: <cover.1790188510.git.nicolinc@nvidia.com>
 <805f64a69c8a6e9aca32d66a0fbe60f333e40865.1790188510.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 20:21:15 +0000
Message-Id: <20260923202116.5295C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> A subsequent change will need arm_smmu_cmdq_issue_cmdlist() to co-clear a
> pending CMDQ_ERR after a CMD_SYNC poll timeout. And this needs to be done
> for both smmu->cmdq and tegra241-cmdq.
>=20
> Add a cmdq_err_handler and a paired cmdq_err_lock to struct arm_smmu_cmdq.
> arm_smmu_gerror_handler() now takes the per-cmdq cmdq_err_lock when acking
> CMDQ_ERR. It already covers a concurrent ack from cmdq_err_handler via its
> existing early-exit on no-active-bits.
>=20
> Impl functions and caller will be added in the subsequent change.
>=20
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790188510.gi=
t.nicolinc@nvidia.com?part=3D9

