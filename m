Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1135F3195F0
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 04:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783052546; cv=none; b=LvPBhgxzZGUnWC+jm57u+6doPyTKSUlAUnXjGHTLd2J4XRB+L7J7grRCvEsznrKtBw+YGYWY3wimKdWMXi4UU0xStC2bsaCXys4QI7itNEYmLydTelbulsr+lIsPVOom/9VjvbE9vN+9gRIpMiHNQSZGK75Qyoj5fZoe8v6dQHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783052546; c=relaxed/simple;
	bh=dsWnfsQogslVRFt78YDPYVVXHJYjIXnk9lLCww3lyaY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u/1nZMkI/iDbN8m7Gq1Vav2bZxBI3PAbfLK6QM9Yzj5df9OV4B5aD7byOeXq90tSmadVAJ8bGVFiS4j8Pm4Xxs0eLEyfMYsWFrZBl6y5AENHrXgcbTfAOfxxdy+zUEEC7yJJ6EqKdSkZIr65kjXcb0hk/bqbnWnVLwwQfl9bj3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMGJF8zZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMGJF8zZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A2D1F000E9;
	Fri,  3 Jul 2026 04:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783052537;
	bh=dsWnfsQogslVRFt78YDPYVVXHJYjIXnk9lLCww3lyaY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jMGJF8zZm8Xyzma1RTUQtphaHTaSsbVl0ww4NtBXMup6GdlgrtvTsMLWrpHatJzpu
	 J3C94XOsmsHtDmnhtwW2egCLHsKN9IitsMCmMMeQMIHuVFyRW2Xcf8dKzu8kK8V9BJ
	 F8wjyh2Fd2JlsUu13cIxdSnp49P6umkUzs7XXjjlsmBBmThHbdw84xo5g2U0t6DpNh
	 raADjgfe91fp+u3pNzEulEsy080h/ZnoI4j9bHlYX7ZwWnasBnvzw10dRaeMTgDW5d
	 acXNJIIwKk8zLIJs+Ndpwlr+KPCmv1AxyY2dMoUhdoQSOv6C+BTX/K3jMHu8pv33BW
	 t5HpD5Pb7pAwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/18] iommu/arm-smmu-v3: Introduce
 arm_smmu_cmdq_batch_issue() wrapper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <0abc2e92551aeb483091a975915eb5dfe07dc007.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <0abc2e92551aeb483091a975915eb5dfe07dc007.1783044582.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 04:22:16 +0000
Message-Id: <20260703042217.11A2D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Both arm_smmu_cmdq_batch_submit() and arm_smmu_cmdq_batch_add_cmd_p() call
> arm_smmu_cmdq_issue_cmdlist() to flush batches. A future change will retry
> the issued commands on -EIO, using the arm_smmu_invs carried in the batch.
> So, a single hook point is preferred.
>=20
> Introduce an arm_smmu_cmdq_batch_issue() wrapper, so a retry logic will be
> simply filled into the wrapper.
>=20
> No functional changes.
>=20
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783044582.gi=
t.nicolinc@nvidia.com?part=3D12

