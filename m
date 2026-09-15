Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1E248094C
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491194; cv=none; b=aNtztpOz6WFiQE8o5oOfHn/8wev6JMuHWdlPgO2xH8PFqtXdfvPCATntxW2rFFyOdp5XPzKh/aI68M7c0Ev4O7kXAykfLm9D7MiroKI/XTYyx9vBmYUtixlMG2a3zaQOP4F1uv+R8USuT0awiu/ftrvTuOgAxgHjIftD7fC1vfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491194; c=relaxed/simple;
	bh=XFxy4TZANyqXM5x7Gq95P4NW53n1zDuZXcuG4u3l83Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YtLt3DzNnGz2XLiephY43x3dbROIFUqJll/a0N/xFua/hfoHnoMcrh3ILfIgJzNS7rzMZ1aMLd1iICLZ7Xo3XWKkrxCLDlEAwuSKR/rbDBGBBeh2Zp+hrofOfsqbo1hzRlMKJULn1j7acFnGYaJK8y9bhYh1G2NbtM7TB/s0Fvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lw9Fym3l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lw9Fym3l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83EF21F000FF;
	Tue, 15 Sep 2026 16:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789491193;
	bh=XFxy4TZANyqXM5x7Gq95P4NW53n1zDuZXcuG4u3l83Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lw9Fym3ljysAL0zRCe0XsMXpwFmq8RaUtjqWq2s/UchLjfkAXDeCbXJ6pzuP02eNr
	 IYe/hd61JiwQ7vWiGrpFFXz8mRh6j1Be7uISsKtyHT6uRhkFiWC5F5COZxZlwWmWwT
	 O9Tu1oB5FJ7ZpPc6MucPipQ0fsGRMn8/h3iaiADdCSoxdKpS3kPCPm62OFioTZOdXt
	 S5OtnMlIOEFlzH3IUw9lvliNtuhWlQWAgz29NgVRCzbPXqbB5LsiC/DndrpFb23+2m
	 6ZdlBDZaKuoewnvPZSRtqgd9y8+fqgEKntbFxuB6DCrNEipntbi5U6xvw2+8ub0AMv
	 to3h5AHuOfhkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/15] iommu/arm-smmu-v3: Disable PRI when no IRQ
 handler is registered
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <ea41f8fede603737093390772bf6dba393593407.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <ea41f8fede603737093390772bf6dba393593407.1789446520.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 16:53:13 +0000
Message-Id: <20260915165313.83EF21F000FF@smtp.kernel.org>
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
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789446520.gi=
t.nicolinc@nvidia.com?part=3D9

