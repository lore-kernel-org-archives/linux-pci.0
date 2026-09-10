Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77B849EC57
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051210; cv=none; b=DYXoC/KXJpsmzNLmF5Cr3/VPbR0Q8zjSIXfa2UBKMg2xLP7V/OjNOHigP1OQX2LgolBxhgcEjar6xz+XY2VnBKa7CLzrcqfBeOPc1bVNZvmN75yO8NxIoCUpHUH6BiUmYBjGYiNIaxZigFbCUkeVTzWreXA+jB0ZOPdcehcsmcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051210; c=relaxed/simple;
	bh=0VREbFUB3TCle1ezWYpBbmUDIMfispfasTreQiMNzoI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=riw5I3HuBJ5s+I+efuVK1RsqEnZfup6gDDhn+HBe+ceU19yJUkhYy3dYun6qltsVMnXrlxZ2X65osuSuccv+0eXGYEf/z4mwux3NfGVfC9UK0DTFO8ahMqi0iQM/4LHBWlg+PjG7hs2K4JyzNk6wVbM+AhPeOYwuFWqtjS1IrNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2n1qLZ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2n1qLZ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FDC1F000FF;
	Thu, 10 Sep 2026 14:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789051208;
	bh=t66SvFitvf2Sat5B28UxBllrmS46kiSkEJQTC1crge0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a2n1qLZ2jzwcyeJD8dBht75DiA5TFkKn07ugRNgXQKdRRduSc8R5qCbn9X3Ar08TT
	 v8Db7JrpZW7ULYLNDJjekTuxMAhO65niZdqud+b+PhTQpDIPr8l1QrhOw+DHcP5vOV
	 RwuZBvnQBKsln4oQyyuUongr6Hoed9GdvcN7YUXv0DyiCNA9r8OpWgP0mYsStfbh9c
	 vvOAxOadEsQcKiRJlQRzDFUHjUB6q7g3xpArdEe0dAg4t1biY0ZgMaQBjWT3gaX7XB
	 RcRZDOTmTYVIRnyGQ1njVZp7xsDRIlcWbQ6ayW14g1vQ2LrUyyIRkeJPCXep301RIi
	 qJ3DoXa+pRYzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] iommu/amd: Remove iommu_ignore_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260910142655.3281464-3-praan@google.com>
References: <20260910142655.3281464-1-praan@google.com>
 <20260910142655.3281464-3-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 14:40:07 +0000
Message-Id: <20260910144008.69FDC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The iommu_ignore_device() helper was historically called on device
> initialization failure to clear the primary Device Table Entry (DTE) via
> memset() and nullify the rlookup_table entry.
>=20
> However, clearing the DTE on probe failure is problematic:
> 1. During normal boot, DTEs start out unconfigured (blocking DMA), making
>    clearing redundant.
> 2. During kdump boot, pre-existing translations should be kept running
>    until deferred attach rather than abruptly clearing them, which risks
>    breaking in-flight transfers.
> 3. Writing to the DTE table via memset without flushing the hardware DTE
>    cache risks aliasing & torn writes.
> 4. Clearing the rlookup_table entry breaks interrupt remapping for
>    devices that fail probe or operate in translation-less modes.
>=20
> Remove iommu_ignore_device() entirely and simplify the error return
> paths in amd_iommu_probe_device().
>=20
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Suggested-by: Vasant Hegde <vasant.hegde@amd.com>
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kern=
el.org/
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910142655.3281=
464-1-praan@google.com?part=3D2

