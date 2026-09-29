Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E5251357E
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 11:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790680668; cv=none; b=HWiqy80AgKW5Dilzeg17KbMebGGSti8dizJQXGwguvl5Jem6ru1nDwINU4ejsHUtRNW8sLixPcY7SJNefhg2RSgRZAUX3EYQYSQRlJMMz0YFiN3sZSW5JFYDv72uIQfB8dXoqNv4//b2qxi/7zILYvHReAtp4erOC33lWhH6ijo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790680668; c=relaxed/simple;
	bh=N9MHeoQmJVqdZ6M36Oq9HZWcNH/6VLoKo7aocfUtako=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I1X0Ux4n0a8Q/auz/XA5SY5raAVuDF/i8X7R+7BUOguLusLhMNiHh1+PzOxvhfhX7e+fTUIgSdNa2PN3jLD3fqR+TXwRRO5ijoC6nScbsHMz2nm/WvvbS+6RDYP92isPweiuOWSbcvg33RT5kWO+BNq3r/dXh7HInroKbQBuh24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLVXLhCR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLVXLhCR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868D81F00893;
	Tue, 29 Sep 2026 11:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790680661;
	bh=zpY9eKpwfSChBCkMWjGiIOFGgZl/ymnyz9MRcYIL3wM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aLVXLhCRdlFYbGGf0nV6VpD0+XoKSJxeJV/6Ra/A2jrqY9qpx4lU4wq3TIZROCEPC
	 H6oy1ErpRnE5GFBxpr2Vr1aniqD0pQMmVLAPmmarwXj2x2zA0UU4J+Yz9QIf8ija8t
	 xl3DlGFNbj4y13lA53T4nzgiSaPlGmsBZRHM5fE4OcpoplJEFjPuCPJCjI8vYG3fri
	 UIVZUiWVKAoe/whPhHd8nBaSbXhNeBQUf3hoOVnBxGTAItR6iE6/ZUP+Z3fDMA2PNt
	 6ugVVSSzwvdN+QtsUzzQunyk1violcDoigfP505PfOXriUv2c/5P/G1Sn+b7aHSvtJ
	 YjFHUEmmqJPHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/MSI: Clear msi_desc::irq in the legacy teardown
 path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stian Halseth" <stian@itx.no>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260929111003.3707239-1-stian@itx.no>
References: <20260929111003.3707239-1-stian@itx.no>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 11:17:41 +0000
Message-Id: <20260929111741.868D81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pci_msi_teardown_msi_irqs() runs the legacy teardown and then calls
> msi_free_msi_descs(), which refuses to free a descriptor that is still
> associated with an interrupt:
>=20
> 	/* Leak the descriptor when it is still referenced */
> 	if (WARN_ON_ONCE(msi_desc_match(desc, MSI_DESC_ASSOCIATED)))
> 		continue;
>=20
> MSI_DESC_ASSOCIATED is msi_desc::irq being non-zero, and nothing in the
> legacy path clears it - neither the generic arch_teardown_msi_irqs() nor
> the arch_teardown_msi_irq() implementations on sparc and mips/octeon.
> Every teardown therefore leaks one descriptor per vector. The check is
> WARN_ON_ONCE, so only the first teardown after boot is visible and the
> warning understates how often this happens.
>=20
> Before commit 9fb9eb4b59ac ("PCI/MSI: Let core code free MSI descriptors")
> free_msi_irqs() freed the descriptors unconditionally, so a stale
> msi_desc::irq was harmless. That commit moved the freeing into the core
> and added the precondition without satisfying it here.
>=20
> powerpc overrides arch_teardown_msi_irqs() and clears msi_desc::irq
> itself, so it is unaffected; do the same in the generic implementation.
>=20
> Reproduced on an UltraSPARC T7-1 (ixgbe, "ethtool -L <if> combined 4")
> and on an UltraSPARC T4-1 (igb, unbinding the PCI function). Verified
> fixed on the T7-1: repeated MSI-X teardown and setup is clean.
>=20
> Fixes: 9fb9eb4b59ac ("PCI/MSI: Let core code free MSI descriptors")
> Closes: https://github.com/sparclinux/issues/issues/104
> Signed-off-by: Stian Halseth <stian@itx.no>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929111003.3707=
239-1-stian@itx.no?part=3D1

