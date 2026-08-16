Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6672D0614
	for <linux-pci@vger.kernel.org>; Sun, 16 Aug 2026 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786900944; cv=none; b=ZmXgrWokoEl7LONoMajp5kKaxGuz6+QfrAGX3BIZ5HYx/abaDy8OckePv0vizu+BRSSlqBELxDHLYg1Zo3Awa0kZAv7U0n9jWlGV/S9UX1lZNnvW5loJEK07qSLkc7xVTP4hT/6aaZPLhBPoYST41oG+EBEh+vYAiciEgcr4Nt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786900944; c=relaxed/simple;
	bh=AeEYdSsGBv3DBx3zRuPWm1AOuJnAM/pzoAMDx3PXmMI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=srxnRkRgF+dQilqF9Z6jPcQnnumnM9X8JZoBkeTm/45kX7i1/0L4fXtpQk0T/kGm5UJ+XaHyd1Dp2yimshQco5HE15KMJuBDOaw6I9ShRDRTupw0kq9j4q8yengNSXPVZOmy7nVc5vwAkYzcRSTPwsoWuxtRDOcuUqR/J1yCIdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wrlm+ER0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wrlm+ER0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2201F000E9;
	Sun, 16 Aug 2026 17:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786900942;
	bh=UU5W+RHGZPPVIf7LTmaZhX0X6gYsIif/IcdHrPxaW3c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wrlm+ER0MmddvZJ6nGXMm30Mx+pXfWlAoQgbWLQF0NfId9v/Jn0MgsSXLTHzCCzKM
	 nkxIw83LEShQzYsX0y9oHbD6zfBPyDyW/h43zkEXNB1iQBa2MS+3kH6ZGBRcHaibqR
	 oCK2eofYeqhNY069NGCFvO5/RtVLlTVg3mu30Kix9trrfVYi+xjIOgpSIbVFUPFOki
	 jpAuyGsnubYYlF16hHiMlcfAXUcrhdS4SGoF0PBBfh2DBFDuKDdipyKWPlsvAn/k4T
	 L3w4DZTl8LgBp8ow5lXJWfqudlNdxh9/WcmIHgOLN6L2zsBPVBSjbVFGuUUX8/Oi57
	 cL0MHJbyR+xZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: aspeed: fix clk and phy leak in
 aspeed_pcie_port_init error paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liu Zhenlong" <dragonliu2018@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260816171633.15025-1-dragonliu2018@gmail.com>
References: <20260816171633.15025-1-dragonliu2018@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 17:22:22 +0000
Message-Id: <20260816172222.8D2201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> aspeed_pcie_port_init() calls clk_prepare_enable() to enable the port
> clock, but if phy_init() or phy_set_mode_ext() fails afterwards, the
> function returns without calling clk_disable_unprepare(), leaking the
> clock reference on every probe failure.  Additionally, when
> phy_set_mode_ext() fails, phy_init() has already succeeded, so
> phy_exit() is also missing, leaking the phy reference.
>=20
> Add the matching clk_disable_unprepare() to both error paths, and
> phy_exit() to the phy_set_mode_ext() failure path, mirroring the
> cleanup pattern in pci-aardvark.
>=20
> Compile-tested with gcc on arm64 defconfig using COMPILE_TEST; no
> hardware available for runtime testing.
>=20
> Fixes: 9aa0cb68fcc1 ("PCI: aspeed: Add ASPEED PCIe RC driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Liu Zhenlong <dragonliu2018@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260816171633.1502=
5-1-dragonliu2018@gmail.com?part=3D1

