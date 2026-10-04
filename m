Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51471440A1F
	for <linux-pci@vger.kernel.org>; Sun,  4 Oct 2026 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116262; cv=none; b=fYUy345Rdvkt2N4KK9oJQrXW0PEvnPRrI0sxRwGEzV1/5DdCPiEUU1SBOQQj+APAzplI1HsXshRZzGUMrGnrrkfuQStnvoVXuqAWaKkIUpIo83cd5f5gzma/l7a3PEURmtgpg7bW77QDf9C6AWMHexxXSkIiWoSaAN+Qulp7Xyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116262; c=relaxed/simple;
	bh=+d5DZlryAtcEcH7lq1lbVPR+jHvecMQnBc6tmQLym4k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PG53xH14iyDbVTc/ziRBB5FpP3xkTSk2m0BosQhEoNvu8yN6Ug0/ippNRS0zwhqAc4gEXP3dANliZanTb9Q1L1/COJV3vZ0Yq5AHw+BxKPppFFEYMwDpQEI8/iNJq4/Pe13b0VgNiX6njGh/F0FBshxugTnbt9fs8pcmlxPJsmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDCbH2xR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDCbH2xR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2151F000FF;
	Sun,  4 Oct 2026 12:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791116255;
	bh=+d5DZlryAtcEcH7lq1lbVPR+jHvecMQnBc6tmQLym4k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QDCbH2xRZ1AS6Gjb3UZJt5JpEMbvB5uWRnFksyP7EwudaxUUlnFnQQ3lmfA9YLGza
	 TLzY9NrSRc8b3AgWIaEY0Uh6q3976Hs50XVC7XoZ4jUkQQJmRJF5Bxilyy3ZTspYeF
	 lS+nUrJR3DUY5YzVIMsp9wPOYdreaS3hs4aPMkcJUHy+mlN/PVMUlL2h1PYtiaZ7eX
	 S1SkOHXPQoVzLJPNNugs0iqB3idSAV84UqUOyFJ+i6fQkuCiTstKW8rKriyoHbQIUu
	 NSFlMHIKGVqhy+9iUsyzbaMMLhBYFLMCSV5oYc05v2yf1ic9yBjlzqEcb8aXoM47tN
	 EeTnLvbXAnNEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 9/9] samples: rust: add Rust SR-IOV PF and VF driver
 samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: ojeda@kernel.org, gary@garyguo.net, linux-pci@vger.kernel.org
In-Reply-To: <20261004120732.1045629-10-zhiw@nvidia.com>
References: <20261004120732.1045629-1-zhiw@nvidia.com>
 <20261004120732.1045629-10-zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 12:17:35 +0000
Message-Id: <20261004121735.7D2151F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Peter Colberg <peter@colberg.org>
>=20
> Add separate PF and VF driver modules that demonstrate SR-IOV using
> QEMU's 82576 (igb) emulation.
>=20
> The PF publishes a pinned API object in its private data and exposes a
> submit_request() helper. The VF calls this helper with its Bound device
> borrow. The helper performs the typed registration lookup in the PF
> crate, keeping the API object and its lifetime encoding private. The PF
> also reads the same object through its pinned registration borrow.
>=20
> Adapt the nova-core/nova-drm rules in drivers/gpu/Makefile, preserving
> their metadata, export-selection and MODVERSIONS recipes with the sample
> object names and paths. Set the PF crate name explicitly because its Rust
> root file has a _main suffix.
>=20
> Keep the helper out of line so the VF module has a real symbol dependency
> on the PF module. The module loader therefore holds the PF module while
> the VF module is loaded, and modprobe loads the dependency automatically.
>=20
> Each driver has its own module registration. The VF module can be unloaded
> and reloaded while the PF remains bound. Unbinding the PF disables SR-IOV
> and removes its VFs before releasing the registered data. The shared
> Kconfig option builds both drivers as modules or both into the kernel.
>=20
> Link: https://www.qemu.org/docs/master/system/devices/igb.html
> Signed-off-by: Peter Colberg <peter@colberg.org>
> Co-developed-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004120732.1045=
629-1-zhiw@nvidia.com?part=3D9

