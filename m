Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3754249BD8B;
	Wed, 23 Sep 2026 20:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195176; cv=none; b=JC5jHY2gkCv7lzBI/sMJNvwCr9TFSy7wLNGOtpDOTOe7wIzBs/4GdTLmF/joYWx3P/Sr9YSnj7/XxElwD4Q3CIlrN1dXJzyEVR9oTn5zS9GW8ZelbJuv+5bLYR6s+y0KlbAoCyZYwWay/0rs3W4URyi5cto8QKqBHvmucvLjLxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195176; c=relaxed/simple;
	bh=UFwD1lOQb7J1iHurNoSdOlona+Nrr9gA45uPtzPqGw0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G60kSIruOj/9CvevAOAWCuswO/NgDsO2NC/pmVfqehcIYa6ZgcNEYba75nSwxquzqb72vAVsnDvoxu6SP+VcVSpRY3SE17FyIdIi1lDvqgn7sERKwBbXFJ3CVKNVLnU4lqAWq4hRYhssk4EVR1yAhqVIphakJE4K3FnS1Rs3Yuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFARdKtn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFARdKtn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBD31F000FF;
	Wed, 23 Sep 2026 20:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790195170;
	bh=UFwD1lOQb7J1iHurNoSdOlona+Nrr9gA45uPtzPqGw0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hFARdKtnmUSatxH0HYovCiZiPl1yElvurhCzHgX97t6Fq/gwiRTz+PNYhByaQ9XqJ
	 Ro/qqxVzVFVsxL2qXjt82mXQlEeGBw3kFke/trZ3FmseNBgNcl0qaj6JsMeQOxTZg6
	 h136bMsOtDOnuvwXur6lYHnhCjruUx9vXIOQh2JcVCgiE0Prg/CoAGH4MCHngVvX/H
	 py9iKRM6t+X6ktQqU3V5ibI9R0Z0OAbwsGP5nSTer4wi8pZKkpqpUmISVQB4oQyPkn
	 jwyY63Rh1IHtMC9HAV7E7bTGQAW9dhn9zkub9a9NSxTfBkinXJqsZ0v1m/gYe121vk
	 JSF/iRMmRz57w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 16/17] iommu/arm-smmu-v3: Thread
 arm_smmu_master_domain on a per-master list
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <c8b198a773d7de1bfd6202a9fa724e4786b5bf1b.1790188511.git.nicolinc@nvidia.com>
References: <cover.1790188510.git.nicolinc@nvidia.com>
 <c8b198a773d7de1bfd6202a9fa724e4786b5bf1b.1790188511.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 20:26:10 +0000
Message-Id: <20260923202610.9FBD31F000FF@smtp.kernel.org>
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
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790188510.gi=
t.nicolinc@nvidia.com?part=3D16

