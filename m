Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60F438BF68
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 11:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968178; cv=none; b=OPUraYAtkr20Hfu98DueOrPvB5HZygUHGFMuuZItZYamL8AN2bMbRa6GpyXXEJl8hT4XezorQAA9VU6sYxhiMwVTisgN7r2/HsPyH60VIlnryF2WAaPQnqqclvhtV8BTLTaYDptw5Cy6ZuLklm0H1fBlPw0mIxf/mPr6o8eg5o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968178; c=relaxed/simple;
	bh=fgp/cZIP+GEboqz6pWTP33z9ANVbef4g98TMvnC+XwE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tEjn9adU5jK/8vic1yxongw0xqt7QuI65YBuge3Tcm5eyAhIH5igoirnkFXFT1z6st1OblC4Tf4BiHXPfuocE6xEmgSyYzUliBfaEeHTiJ5G06GIgZWVhvZ87Vr4QeDzl6svp25JZKFUXf8iONQZJfLeKjA66FfG7urbrnh2rU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=na3rRINc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="na3rRINc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539F71F000E9;
	Thu, 28 May 2026 11:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779968177;
	bh=pIOLKILq4+z38VlXCod7M8BSOhhqnK8vh55jlFYhAjU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=na3rRINcWygGxT6dgEGwqSk2ntfiTFwOBk0phE1agKIv2qt1NdIa6QNcske7uFKxr
	 3HJK5teRDXxIOXnxj09xox2m3MNW/nw195vOoxZdutQcWrIeeFI6JgR4pzS/lyvHtt
	 poSHOLrItxF9hhhFYjmmsbF4nvGapMRU5+yILiCuY/c05xBanxGY9lGbMCGl7/DKAM
	 kpLWzJQBYj86UzWi/Yk+TD/16PpI1yKLdtAGz/f4rWp/T0mN6Be6yJ8z9uVKy6CP9p
	 vXPiKxwPnPpa9tNpjFGObxAU+Q7UUlQ73G30m3/sEynTEswmfssmiZs/qG0bYrzxpO
	 2n2gqf9mm40Rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/9] cxl/pci: Track memdevs affected by CXL reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260528083154.137979-7-smadhavan@nvidia.com>
References: <20260528083154.137979-7-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 11:36:16 +0000
Message-Id: <20260528113617.539F71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Inactive CXL memdevs are skipped during lock acquisition, allowing=
 concurrent driver binding and hardware access during PCI reset.
--

commit 89d0ec881cc974737d27ee49108cc6db271b06d5
Author: Srirangan Madhavan <smadhavan@nvidia.com>

cxl/pci: Track memdevs affected by CXL reset

This commit adds context tracking for memdevs affected by a CXL reset. It
collects memdevs associated with the target and sibling PCI functions,
identifies which ones are active, and provides helpers to lock them before
the reset proceeds.

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 1dd880f5a333f..c755c18c8d84a 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c

[ ... ]

> +static int __maybe_unused cxl_reset_lock_memdevs(struct cxl_reset_contex=
t *ctx)
> +{
> +	int i;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +
> +	for (i =3D 0; i < ctx->nr_memdevs; i++) {
> +		struct cxl_reset_memdev *rmd =3D &ctx->memdevs[i];
> +		struct cxl_memdev *cxlmd =3D rmd->cxlmd;
> +
> +		if (!rmd->active)
> +			continue;
> +

[Severity: High]
Does skipping the device lock for inactive memdevs allow concurrent driver
binding during the PCI reset?

The device lock on the cxl_memdev is used by the driver core to serialize
binding in device_driver_attach(). If a memdev is inactive, skipping this
lock might allow userspace to trigger a driver bind exactly when the
underlying PCI function is disabled and undergoing a physical reset.

Could the concurrent probe proceed to access CXL MMIO registers while the
device is resetting, potentially resulting in PCIe Completion Timeouts or
Unsupported Requests and triggering an AER panic? Should all associated
memdevs be unconditionally locked to block concurrent probe and remove
operations?

> +		if (!device_trylock(&cxlmd->dev))
> +			goto err;
> +
> +		rmd->locked =3D true;
> +		if (!cxl_reset_memdev_active(cxlmd)) {
> +			cxl_reset_unlock_memdevs(ctx);
> +			return -ENODEV;
> +		}
> +	}
> +
> +	return 0;
> +
> +err:
> +	cxl_reset_unlock_memdevs(ctx);
> +	return -EAGAIN;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528083154.1379=
79-1-smadhavan@nvidia.com?part=3D6
