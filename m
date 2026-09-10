Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FCC2F6931
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 23:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789082918; cv=none; b=uv4BW+rsHNTdiPTQ27lgcqmATKAz4gLZjZ95KlptAv5dKlYkYKt6WIXAZRmZRb4FR2NYigFsrykvq/TnusmFC+IELrCJg8TYt66LCeOExFon7eia0/SYn4gCU4pdWwYxz3xnKqKi7WncXkzfX9f5bkKeJSaP5U2cdoEuv5BNHCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789082918; c=relaxed/simple;
	bh=artqFvkWKo5uErbk/ogd+8ev4ytKACPCNzpOwBF3XMA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XO3TJWq+fsCW3zZBufeI8aMf6cPxCjgN/EAcCQqJT40xxmwre+yNDm6yuECLD8ksFuqrGzJyRjtFmiotCS4EI7LobMG4018qP5uSiVyf6zuYN9ejSfm0xPlEz9vn+g5gbmYOSgYdWdFR1zuZSWTf77Of3o80uYf2bCHPXAFTGQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICxvc/WQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICxvc/WQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7111F00893;
	Thu, 10 Sep 2026 23:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789082917;
	bh=artqFvkWKo5uErbk/ogd+8ev4ytKACPCNzpOwBF3XMA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ICxvc/WQbD9Q5UItnHwAZfw6coIU15iI4zVG6BKH3+AsGLKv12TphavLskJFwmJIC
	 ZiAgKDIXJr5DGcPOvy2tyhXdtgA1/3pG1TZVR/kt1Wjqb8APCSGdEJiXjrp+8mlDPB
	 iApgBjs12lZCSOHzUyA6z69JWDptdSvuDqXkDgEvgiqttar+1u2P7/U+sRWLQYr4Hx
	 MSIFMsnk+lMVBL4rnOpxw0m/OSrpXtozQl4NxRUTQ6aPGaY6XZBMOn7mz+Ze55NQt6
	 MsmuVLFRBOSzIakqVPKy5oXv0jsgTnqiYgjpoORemta9vSniReMnWr0P11KYBnPah0
	 MHCw5Z4JK7oLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/15] iommu/arm-smmu-v3: Allocate IOPF queue without
 FEAT_SVA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <7decce0b49f85da5df0f842862deb1af44093046.1789081084.git.nicolinc@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
 <7decce0b49f85da5df0f842862deb1af44093046.1789081084.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 23:28:37 +0000
Message-Id: <20260910232837.6A7111F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> arm_smmu_init_queues() allocates the IOPF queue only for FEAT_SVA together
> with FEAT_STALLS. This queue has no SVA dependency, and FEAT_STALLS alone
> can produce events that need IOPF.
>=20
> On HW with FEAT_STALLS but no FEAT_SVA, a master with the "dma-can-stall"
> device-tree property has master->stall_enabled set at probe. Then also wi=
th
> CONFIG_ARM_SMMU_V3_SVA=3Dy, arm_smmu_enable_iopf() sees stall_enabled, ca=
lls
> iopf_queue_add_device(NULL, ...) at fault-handling domain attach, which c=
an
> oops on mutex_lock(&queue->lock).
>=20
> Allocate the queue whenever FEAT_STALLS is present. Also select IOMMU_IOPF
> so iopf_queue_alloc() is always available without CONFIG_ARM_SMMU_V3_SVA.
> Since IOPF does not depend on SVA, drop the SVA guards from its enable and
> disable paths.
>=20
> Fixes: 395ad89d11fd9 ("iommu/arm-smmu-v3: Add stall support for platform =
devices")
> Cc: stable@vger.kernel.org # v5.14
> Assisted-by: Claude:claude-opus-4-8
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789081084.gi=
t.nicolinc@nvidia.com?part=3D6

