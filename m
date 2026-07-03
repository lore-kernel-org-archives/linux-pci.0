Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615553164D8
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 04:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783053134; cv=none; b=cexcbYlt3Unl5uvhfLvS9ge+gBdP/Hu1KTrrF43KLBMRh13os0LTAO+itmEotATnJa5bJfU12P4W9vOE8hCgcJG3JCCRpV6juN03RFPJQJlYo+tb7Vgtg0bEqGgr4kJ2OFycqAEtDPwoS7VH8RMJNt05inihD095TVjRcngni4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783053134; c=relaxed/simple;
	bh=Hh5soX1nAMz3fXS4zM7a5WzYh4FlybYfLsjYlSnvFoc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qM649GvjVklHotZLR8MsDjrOx0n4LQNW9CJ94FkAE6YITfv27bMVNtG60XKQmGFgAH4IZFqnCMNP4uah9KprdjwlTsQd3w944Uhk9wG6ZSnqVk+IIIWvttJ3Wi2w00fweo8hUJA5hNN3hEySpD/hg3jOnr2cTsTTKsw7r4taHmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5jg6bEF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5jg6bEF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87811F000E9;
	Fri,  3 Jul 2026 04:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783053122;
	bh=Hh5soX1nAMz3fXS4zM7a5WzYh4FlybYfLsjYlSnvFoc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B5jg6bEFN2P/NKAOTCnqAcK20stLVohUjgv5/szPrenshEUSdR89Gv7jPPDb7Pk5+
	 cTiND04hbYHmAU1Ydkk/L7Jp2UQYVeqzQxLGeO0PZMmHG2ElixILowEYpgjY6ocZFm
	 mWnOL3MWovLL0A/OCukdQ2fFXTmkpyOnn8xT3j8ItNx2E0LXaudd8JkCrIVwT1MM4W
	 JmxNO7bXA2tpahTtxR7h0lFdwVT7ZiLRRgvol2eJdSPoAlV3QZ8PxlNKFiFxWqbsJG
	 MajYT+i2dfhOceu4ue1VTaha+X2cbACpUj6Ve/e8C86+ZSx5D/ONoeVM8JBOs9i1Sw
	 +MPeu55JOFSUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 17/18] iommu/arm-smmu-v3: Thread
 arm_smmu_master_domain on a per-master list
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <125050356f56c476c772b6348b09c0bd95a3377b.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <125050356f56c476c772b6348b09c0bd95a3377b.1783044582.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 04:32:02 +0000
Message-Id: <20260703043202.B87811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> A subsequent change needs to enumerate, from the CMDQ error path in atomic
> context, every domain a master is attached to so it can mark this master's
> ATS entries broken in each domain's invs after an ATC invalidation timeou=
t.
> The existing per-domain smmu_domain->devices list tracks the inverse
> direction (masters in a given domain), so introduce a per-master list.
>=20
> Add a second list_head master_elm to arm_smmu_master_domain, threaded onto
> a new master->master_domains list under master_domains_lock. The CMDQ err=
or
> path walks the list while holding smmu->streams_lock; that path runs under
> the invs->rwlock read side, which is itself sleepable on PREEMPT_RT, so a
> plain spinlock_t suffices for both. The attach and detach sites now take =
it
> with spin_lock(), nested inside the existing devices_lock critical section
> that already disables IRQs; it is a leaf in the lock order, so no inversi=
on
> is introduced.
>=20
> No functional change.
>=20
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783044582.gi=
t.nicolinc@nvidia.com?part=3D17

