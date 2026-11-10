Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271201;
	b=DPlEMc6wuPq2bkL6lpVnekcnKa1O+6VUTcMRphL0I7EL6EBpFjA9zMNksBPgItPwBnj9
	 i1PTymT5zClsSxkZf156nlGM5r2i4va+lp9hEOkinyKuPMB53fLHpuu7i/4csLcCvjqSf
	 0fYhWCHAx9aMxlahKL5PKLorWGbUbVlOWGxVE/valHCXJKdKpQHSyY8W5/g7x1YWrcWB0
	 ynQF3wvD5J29wmpNCUXR+GAI4E+H7VyqCcG6X4a+wXWukTTxVPFoJ5Rfk7Yy8x+TdybkS
	 rr9r3W2kTRiUKcfo3u1L6VyWNZ+87KBR0jAwdUqC7mj4JR0y6ZbTAQVRFrou64J1ybg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271201;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WtYy2XtUBnRJ7Md5jqmtXe1XcQj+8h05kQPusTV+RsY=;
	b=nHwWCo93Umo3QaYP6E989Tz3mcg/sd2kF+bPFklNEJ8WE1P/eWLHhwycYpyLx8JtY2TT
	 WnZbi9y1E59awzaCL/qRpyyS6JMyIHAphcY9Fqgo+i0MNuo4AIMYwyhO+PkOOu87qddNx
	 SaBRuWINzYceykhv46yP55/O6YYe5b8AUu3cio34CLI+h8FlIBTDqFLGvNLW8P0ER8jT9
	 Zv/1xsBlvS8P/QO4V+wH6yiXLFIo6ZYV/ELEdf98SwVI3WsX8D0X5VLpew85fFX5sH7a0
	 Trr+ff2VqDKYR9KcqaFFMe+U7bx3MDHsCgihaSajmso7VMkGP09lgSpOI2HEpdilVzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="b9t/yMZw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12878606A31C
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 00:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b9t/yMZw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FB61F0089F;
	Tue, 10 Nov 2026 00:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794271200;
	bh=WtYy2XtUBnRJ7Md5jqmtXe1XcQj+8h05kQPusTV+RsY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=b9t/yMZw65MfGdc4umSMUJJuj7hQxPJ3FvPvpw0rssaU7ucGEpkQeLdEJjNzB2NFn
	 JRcVG33bW7eNGgCByUGRLEv0cJjdqPEZOHFv/LjzrEc6NktNCbnSrfHLppGp67no3v
	 geI8E8y4GofqxVhUdYqmvzVJK983V6WWwtSK0xpBd6nYEBL2rVtUefeagGTFjGtYnd
	 E/1hb9n3TLkO1qX2qI1vehdkacO5ejmW2M4o19UKJA1sOojQlq1K3FrXdwqFz7ASbt
	 +tauvf7jUXoGtvwdsltMeADorqxSjoplyWrdWJNv/vGN+p7mTvKR8q/8++dbWPJk9K
	 mqNW3wsj1AhXw==
Message-ID: <sashiko-outbox-205881@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] PCI: Ensure ATS disabled via quirk before notifying
 IOMMU drivers
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261110003353.1824793-1-dmatlack@google.com>
References: <20261110003353.1824793-1-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 00:40:00 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Apply the quirks that disable ATS before IOMMU drivers are notified
> about the device. Convert the quirks from final to header fixups and
> have them set a new no_ats bit in struct pci_dev, which keeps
> pci_ats_init() from setting pci_dev.ats_cap.
>=20
> Header fixups run in pci_device_add() before pci_init_capabilities()
> initializes ATS and before device_add() notifies IOMMU drivers. Final
> fixups run later, in pci_bus_add_device(). Use header fixups instead of
> early fixups because quirk_amd_harvest_no_ats() needs subsystem_vendor
> and subsystem_device, which are not yet set during early fixups.
>=20
> This ensures that pci_ats_supported() returns the same value in
> iommu_ops.probe_device() and iommu_ops.release_device(). Since commit
> 89436f4f5412 ("iommu/vt-d: Fix WARN_ON in iommu probe path"), the Intel
> IOMMU driver relies on this to decide whether to add a device to, and
> remove it from, iommu->device_rbtree. With final fixups,
> pci_ats_supported() returns true at probe but false at release, so the
> device is never removed from the rbtree, leading to a later
> use-after-free.
>=20
> This only affects PCI devices added after IOMMU bus notifiers are set
> up, e.g. hot-plugged devices and VFs.
>=20
> Fixes: a18615b1cfc0 ("PCI: Disable ATS for specific Intel IPU E2000 devic=
es")
> Fixes: 9b44b0b09dec ("PCI: Mark AMD Stoney GPU ATS as broken")
> Fixes: 3f1271b54edc ("PCI: Mark all AMD Navi10 and Navi14 GPU ATS as brok=
en")
> Closes: https://lore.kernel.org/linux-iommu/aYUQ_HkDJU9kjsUl@google.com/
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110003353.1824=
793-1-dmatlack@google.com?part=3D1

