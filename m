Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C627EB672
	for <linux-pci@vger.kernel.org>; Sun,  5 Jul 2026 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783272027; cv=none; b=geJ1tjdg6lxRm0Jpa88c+Ej5rZegDj9Sq/oBi0yPd2iMPnDiEzbkGyihCSYqcYNV/vYB/xXjpGWVD3VNlp8NstAVbtZTsFaDcV9YOgbl8ksvJ49Td/6306cjLVtCaaZw6IhHEhW61N9tQJnu9p7lmtaO8um9lz5Uifz/CYzYVbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783272027; c=relaxed/simple;
	bh=253nWMAPh9c58lN9mxxXV5c7m0+dIVOUjCQxX6I/Rp4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=piL6XU2Lc3czM1+Kp1EKsFBuzEbAmFN+9W1ZeTNJgjo6NqL5SdiBtrf/TunU8X3QeGUXtjgHLhXkD1eY4TdJu7j70ZFZAMuhbLWzLz8WH1/JXIiHhsHzh1v95C9QPXcB6BeQEaQBL2jcMWmwBuL7JAvJI4EaKBWvFzv9cHDuSHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYqqPikm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYqqPikm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543B51F000E9;
	Sun,  5 Jul 2026 17:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783272026;
	bh=253nWMAPh9c58lN9mxxXV5c7m0+dIVOUjCQxX6I/Rp4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HYqqPikmQaxx6vt16HIix017KVT1bHSc3Z1MkEu9Hu85Lc9XjUoP2gW7xv9Cwm2mW
	 9ib/2f6fMMDyfQdMIG2QfrWMMTaMUU2GVdTDdACnQBphplc+HgJzGb179QbPnYIL24
	 8BTTXqWwOw9Z76/jPHhjrNKGTNIn0z73shXFkpI0NtUQ7/GCVlZRUZYjw3Y2jvCUsR
	 RpLbeTMif5NDggxx4vomcnAeILWqHPgNVm69rXfBC33lstvCmZPG2kNgXaHnRLGnAZ
	 Dia5q3lm0112Nj9BrKP7oKQOM8/x/m0p3RTLvxcrB4NAautme6mRCkdFBRpr7uyHkn
	 tGgdGpb1Ojvpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Fix BAR resize for devices on a root bus
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liz Fong-Jones" <lizf@honeycomb.io>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260705-pci-rebar-root-bus-v1-1-55df70cbdd88@honeycomb.io>
References: <20260705-pci-rebar-root-bus-v1-1-55df70cbdd88@honeycomb.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 17:20:25 +0000
Message-Id: <20260705172026.543B51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Liz Fong-Jones <lizf@honeycomb.io>
>=20
> pci_do_resource_release_and_resize() releases the device BARs that
> share a bridge window with the BAR being resized, but when the device
> sits directly on a root bus (pdev->bus->self =3D=3D NULL) it then skips
> resource assignment entirely and returns success, leaving the BARs it
> just released unassigned (IORESOURCE_UNSET).
>=20
> Skipping pbus_reassign_bridge_resources() is correct in that case --
> there is no bridge window to adjust -- but the device BARs still have
> to be reassigned. Before the BAR release was consolidated into the PCI
> core, this case worked for amdgpu because the driver released the BARs
> itself and then called pci_assign_unassigned_bus_resources()
> unconditionally after the resize, which assigns unassigned device BARs
> also on a root bus. Commit db92e3fef53e ("drm/amdgpu: Remove driver
> [ ... ]
> it exactly once.
>=20
> Fixes: 337b1b566db0 ("PCI: Fix restoring BARs on BAR resize rollback path=
")
> Cc: stable@vger.kernel.org # v6.19+
> Signed-off-by: Liz Fong-Jones <lizf@honeycomb.io>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705-pci-rebar-=
root-bus-v1-1-55df70cbdd88@honeycomb.io?part=3D1

