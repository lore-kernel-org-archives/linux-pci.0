Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E98D27FD51
	for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 23:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781567898; cv=none; b=g3Pp2Dz9iuVjZQNBYXik3YjgoWZojMdCXjFSukA4RrIeAZZp+ZPbpp1bjOqIlpmc4V9Gb5/xvLD6aWJbTlgvvGk0nWKt90nLciAzVM+41tN6EpS7g0YsXrKxPGi36MNss68pXRfwZbhlTde/AIVAr4q7/NsrNyoeDwfQzdXkMG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781567898; c=relaxed/simple;
	bh=SZYpvW4IZ83QbrSAXEcA8mUl/ou4Vh355HTChjfLnjQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TpxN689TKWg1OZOUaJMJGm2xxr/l4w7cG+fLUo8JtE8VI6GO/wpoWDObRmEp9B1g4ZMdcBZSinmF96hU7itERVU2uIvUrsV9eDPvSy7kK3wGmjY19GkXISczRDAIPiPV92hKbxW7qWzyO+7C5fuoXy+zJqZFJQ+YNme6nmL9bsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcleZ/BN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcleZ/BN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788EB1F000E9;
	Mon, 15 Jun 2026 23:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781567896;
	bh=SZYpvW4IZ83QbrSAXEcA8mUl/ou4Vh355HTChjfLnjQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XcleZ/BNB/BHIFa2gJWeoFYhB0OrPNt9RXdCTJE17mcOm7gDkoL8Yq5iiZEtvIw/1
	 h8oFDF5CbM2ujsTb1FqpiIea0Y7zmenin4vunYm+inQE9Mo+NOSz14xczg8CAc1R9+
	 /ULhCv+dri0UBmvTHjX/9R1/yaZGnK7RutJIB/13xOUrtUBNeZzN/SSfTvgTFwskeo
	 rPRhrgN9xiEbbPPTLdC5itX3m2piuNPv8WJcD0a8TQ0MjMeFFo5zs4gHu2bSs4/t82
	 nYxCvuU5oK5+a4dGr1oOsxuvF7Il4DLnN+vPu7/PTM9Ox6kLAXDLsxY5ljbmQJpOJV
	 c2/H5mj5emHNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/4] iommu/arm-smmu-v3: Standardize ATS enablement
 failure reporting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260615235037.259909-4-praan@google.com>
References: <20260615235037.259909-4-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 23:58:15 +0000
Message-Id: <20260615235816.788EB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Update arm_smmu_enable_ats() to wrap the pci_enable_ats() call in a
> WARN(). Since probe-time checks now preclude configuration errors
> any failure during hardware enablement is considered a kernel bug.
>=20
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615235037.2599=
09-1-praan@google.com?part=3D3

