Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C2336EA99
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 00:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223592; cv=none; b=TuFPhdA7MZKNwZw+tgSbau+Mzzgd7JYfL2s9z39KPiCMLpxRTCrqSKL+2VqQWnq8NvXCQc0Mnbglk1AkbrvmEqVAo9D5ommUXw8KIGnGu3eqgmayZml/4O2yRsTaULcMawKLf8l+nXLdcPqSlLhy4bjjhoJ8GsmzeQNpicJ4wUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223592; c=relaxed/simple;
	bh=fiaBs39aK9pid0Afa8LaG1imPM6emZ6Rlnju5NqG3ew=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I+ts6J0QJLMmOYpiTMjJmLrxer8VI4iqCxlt+gq9orH4Di4b6t/Lub4WBt/GDDvqXQ7kpuTwQnxwbauRMQL0HpPR4lf3LLpvWe6cc5ElkhvIfaHqc+IaT45HitMw5DtxAspqe6UCrm1cTyBZYrnPt8NPgEdYVyI7jqJZa8FwVs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwWgOgq3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwWgOgq3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738DE1F000E9;
	Tue,  1 Sep 2026 00:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788223590;
	bh=fiaBs39aK9pid0Afa8LaG1imPM6emZ6Rlnju5NqG3ew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fwWgOgq3YyCKW2Sb/+23A1udInhPSdy3EDGyy5gwmUOXj9zWgJRmBpAY10e/DPKut
	 eoTcqGf4+lpcsz5dHd2bbsro2tf7ymN70gQHT4pRrIoaYY76pkR1Z2dIvh/8bHC1nL
	 z5/FoD3HTZC4lYmxG4jugPmPxm6wdWg5voNmET17p8Fe2CcQa4fYXd5zDxHCodi8pU
	 fwkebH4Q8nUnAlNQ8KUCtllzHzxwgKdPJ56dcxLzc5Q29oI1O/65GCIsxxDVN7MNO5
	 kfsSPlsUdpUbA8XTKP5GLV/AbMb3MP2RUuuxPkH5h5hEIcYX0wEWjN0RqkLrPciMUx
	 UBMqgOkop6d2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/13] iommu/arm-smmu-v3: Add
 arm_smmu_attach_release()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <7dcf4aaa538a6a14626f5e2854141f14268250fa.1788222485.git.nicolinc@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <7dcf4aaa538a6a14626f5e2854141f14268250fa.1788222485.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 00:46:30 +0000
Message-Id: <20260901004630.738DE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The IOPF teardown is done in arm_smmu_remove_master_domain() when releasi=
ng
> the master_domain on detach, under the global arm_smmu_asid_lock mutex. B=
ut
> the teardown must drain any in-flight IOPF (for the old domain), before t=
he
> master_domain is freed via iopf_queue_flush_dev() calling flush_workqueue=
()
> that can block on user-faulting page-fault handlers. Doing so while holdi=
ng
> the arm_smmu_asid_lock would stall any unrelated attachment in the system.
>=20
> Split the teardown out of arm_smmu_remove_master_domain(), to a new helper
> arm_smmu_attach_release() that runs after arm_smmu_asid_lock is released.
>=20
> Since no other device would use the old master_domain that is being freed,
> it's safe to move out of arm_smmu_asid_lock (still under the protection of
> iommu_group->mutex).
>=20
> Note: this is a pure refactor; no functional change.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788222485.gi=
t.nicolinc@nvidia.com?part=3D1

