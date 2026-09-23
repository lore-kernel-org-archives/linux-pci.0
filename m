Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27E547A88C;
	Wed, 23 Sep 2026 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195157; cv=none; b=SAJ95bF7kPBw3qMh9rjgbTnrWboK17jTlqEIgwUodOadQEMzZAGNnzptdANA+vGTS1Gi6JJuWVtnzu+GLd6DnMzO74fdNxaOPoXDBBhuG3weqw5mxcQHQTfFwWK71qMW9iUbLdivNnIZep0t4elkRE8LhAhZi9Ai1teANj7BNLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195157; c=relaxed/simple;
	bh=LUgNtkETRo91sfxTZQ97xVEu2uU+IVqRin1+5YncvoM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YXE9JmRqGkyU6+cul/9GyepAbbjykusrTjCLS/QVEIcP9hqIRJp3m/X6KJu0WEIR0HUZra3hyUONCKZXWvOBErPAGy/YO88N+9cbb2tH8adsjzyiEMY56Xe2ixXoWSBfAOKpqW9x9ASizKfFvPcGF7USu0/R+kR6s1CftZob2tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gi3Dd+S0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gi3Dd+S0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71CE1F000FF;
	Wed, 23 Sep 2026 20:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790195150;
	bh=We/Cf1XHesAYZ8GPMWa4IPADZjvuqsstZ6a6zWPSlT0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gi3Dd+S0fNya6hxseBBC9WGow5tZ/HQbLRQsogdPffeQ5sNd2YivSE56Rqy5wAXJg
	 9pgPKyX/AHXFadA4cnHOrnRh2NsAa/EXUb7Ucu/t174gHGorQF7wm9x1XI/c7enyxd
	 +8/5pbkPnSxFKQ9MF9167at2dN0XWfE3Zwo8od+KZgpOlfXT1XA/raSjIHZPChtG1i
	 EWUryEYnuxM4DhaFfl2Az6tTgMb6z+r7xOoKS8i30ka+cY4clwSJyO5ESS4ke9BAWU
	 GPqSgg+DQQJcEtV4wfGYUS4NcnZtXoFG5EazWIgcZAOTREg7dPfIotWVrnXi/KMkcd
	 KYREx2scWRayQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/17] iommu/arm-smmu-v3: Add streams_lock for
 atomic-context SID->master lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <5ddbd81323f86d045072ebf410a6f87da4f2796f.1790188511.git.nicolinc@nvidia.com>
References: <cover.1790188510.git.nicolinc@nvidia.com>
 <5ddbd81323f86d045072ebf410a6f87da4f2796f.1790188511.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 20:25:49 +0000
Message-Id: <20260923202549.E71CE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> A subsequent change will look up arm_smmu_master entries by SID from insi=
de
> arm_smmu_cmdq_batch_retry(), which runs with invs->rwlock read_lock held =
in
> IRQ-disabled context, and so cannot take the sleeping streams_mutex.
>=20
> Add a spinlock_t streams_lock that protects rb_root mutations alongside t=
he
> existing streams_mutex:
>  - atomic-context readers will hold the spinlock alone
>  - writers (insert/remove paths) take both
>=20
> A reader under the streams_lock uses all the streams of the found master,
> so the insertion has to be all-or-nothing: make arm_smmu_insert_master()
> initialize all the L2 strtabs first and then insert all the stream nodes =
in
> one critical section, making a master found via any single SID always ful=
ly
> initialized.
>=20
> Update the lockdep assertion in arm_smmu_find_master() to accept either of
> the locks so the helper is callable from both contexts.
>=20
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790188510.gi=
t.nicolinc@nvidia.com?part=3D13

