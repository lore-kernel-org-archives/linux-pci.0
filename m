Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0B33AAF59
	for <linux-pci@vger.kernel.org>; Sun, 30 Aug 2026 11:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788089011; cv=none; b=G383QZzfI7eeiVh8iCYyRa20QCNGyd2z6XAWsi42qrNY91i02Tk8wAMKKhtxVokgDB2DvMNghmyvCHWeo7GlwLqrW7xBL+7UL1jo5/gEoF6k1AZ/2BnmzPF5DPrcTiAEmhaWgS1ROyKpOoGuy2yobLEHglB9dSy26y39FY5OocM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788089011; c=relaxed/simple;
	bh=pwBX+BKSJlg0v5ro5/vc9TDDDmGzE9ujx71UZKSX38w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HIpg5R8MH2MWWuDyHOr8cAzDVtegIw4b+og05qQD6juYGAhWshmVViTA3SsCY75NsUTLd/4g+xOf+pEfARGv0CQE8Pc9hpc8rRJHTdWVFDxdH/0VT8Xj3EXvYsNoFzodufBy0zoNhLKszelkzgUXXGI69I5BujSMOchtHruBstg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIKy27RV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIKy27RV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1411F000E9;
	Sun, 30 Aug 2026 11:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788089009;
	bh=pwBX+BKSJlg0v5ro5/vc9TDDDmGzE9ujx71UZKSX38w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fIKy27RVtRcKT0lqpaXJAWvUhKqErj3s7hYbjY93QN6ARC582FfKUPR9J+S9uGTm0
	 369UAUkED47LcYlxAqhiowE9G07ez5rrQ6bgvgu0BAX6vbLoBoKuzQvbhotA1dpeje
	 gpzzprqzPylH/O0tVptscNL0dMpRAlJKlOl2sV5S8zsg2Fpk+xQCKLhZycd3i/5mGw
	 SDmFapi2vpET5v8bAO8MY+QsvPC34dOir3D3RzFrTcbwXu7LoFe5Nti+wSHNJsDzmf
	 2yGY7CCmaaF2xS7ZuuG5XkqD6pjMHCIMvUJHmnwTxC3cqTdN572d/pJMPOnNP2Itbe
	 GIBmiHDfcBTiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] PCI/P2PDMA: Wait for RCU readers before freeing
 state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260830-batch-p2p-fixes-v1-2-5044e8dfbe2e@nvidia.com>
References: <20260830-batch-p2p-fixes-v1-0-5044e8dfbe2e@nvidia.com>
 <20260830-batch-p2p-fixes-v1-2-5044e8dfbe2e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 11:23:28 +0000
Message-Id: <20260830112329.5E1411F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> pci_p2pmem_find_many() scans all PCI devices without locking or
> protection against driver unbind, including devices with poolless
> P2PDMA state. pci_has_p2pmem() may observe pdev->p2pdma just before
> driver unbind clears it, while pci_p2pdma_release() skips the grace
> period when no pool is present. This allows devres to free the object
> while it is still in use.
>=20
> Clear the pointer with RCU_INIT_POINTER() and always wait for pre-existing
> RCU readers before returning. The same grace period continues to protect
> gen_pool users for pool-backed providers.
>=20
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: Matt Evans <matt@ozlabs.org>
> Fixes: 372d6d1b8ae3 ("PCI/P2PDMA: Refactor to separate core P2P functiona=
lity from memory allocation")
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830-batch-p2p-=
fixes-v1-0-5044e8dfbe2e@nvidia.com?part=3D2

