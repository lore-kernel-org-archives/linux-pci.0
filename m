Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAFE4AF69C
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 16:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490900; cv=none; b=QKitsL/KAXUdIFLVINQkf0Lj6bVQhzGhOtrU27mgrbqZJbIq2SPNJ5MjLGbU9TbQvrf3FNGmC31WPXPPMGNx9hetmjIg/5KdGBs9ZVWtsbVWO9wNHh5tmYI5a/Piy7EZl6TT3/abV0Uls7MYc9jCKkBxHZKKnfNBqEZCojdnIt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490900; c=relaxed/simple;
	bh=4zF+DHsEcdwrrMtUlRRt6IbpEpr8NT0RN93O+KMukQQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rbCwZOyBsp3cRYoq6SoDtYDykI56xQ7U6d7HV5d+Amrm3cppPsTwbmz/MMvlwvEEo88YfncAH0mfGSwwM4MG1+8N3gNxkNIRgror/tDVTolDsisIqhEBavQ3yplokeZJqmwWZx/7Stt5Ggaud99pvjjxCmb5zCbrUnTa3iPZKMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdJ2V06Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdJ2V06Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D2D1F0089E;
	Tue, 15 Sep 2026 16:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789490887;
	bh=4zF+DHsEcdwrrMtUlRRt6IbpEpr8NT0RN93O+KMukQQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kdJ2V06QDFdQ5MaCf8W8uQmdhfXqR8Z5ayj9bezmEUc4EiAkWaB6JVMlBBScavQYT
	 VgZHXFa8+cMdVyOVMzZsIkoyS7njYP2+ewjYSZD2G5KDpLhth/ewJ5wp0l0AnSIJ2b
	 bZ5uO3icAY5QR4MF9lCP8Bsnzis4L+QWUofvbmZIZUWTwTgwHmy1m2OUQw4aXEtj8O
	 YIrtGXMc9hfcK8g8d+W8VXfyQMcFz3NaBN0j8jc7mEeftTXcMw7XTHTE+BPyyZR75Y
	 v2erojXpdbp2rWrt6MDvXGHqZYEEDn+LkYc7e2LDxNOE6UyTjXa+AzhYG6nHzn2cJf
	 aRd5GUuJNMe0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/15] iommu/arm-smmu-v3: Add
 arm_smmu_attach_release()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <f74817bb45a4bfcda966d9b5ca366c649b6dfe46.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <f74817bb45a4bfcda966d9b5ca366c649b6dfe46.1789446520.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 16:48:06 +0000
Message-Id: <20260915164806.F3D2D1F0089E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The IOPF teardown is done in arm_smmu_remove_master_domain() when releasi=
ng
> the master_domain on detach, under the global arm_smmu_asid_lock mutex.
>=20
> A later change will add an IOPF workqueue flush to that teardown, which c=
an
> block on a user-faulting page-fault handler. Holding the arm_smmu_asid_lo=
ck
> across it would stall every unrelated attachment in the system.
>=20
> Split the teardown out of arm_smmu_remove_master_domain(), to a new helper
> arm_smmu_attach_release() that runs after arm_smmu_asid_lock is released.
>=20
> No functional change: the old master_domain belongs to no other device, so
> freeing it outside the lock stays safe, still under iommu_group->mutex.
>=20
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789446520.gi=
t.nicolinc@nvidia.com?part=3D2

