Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906608;
	b=5RNYHHMLuMtqRvFBbUxunhamABfdh9lhNqtXVhUAyaq8cnRdhVKQ1YCxitPIdfR2ZsF4
	 YLv9w+rA3e3RZPwk91JOCC14QyujKIDjzvdT2PT9AmHCEwRNxo3GwutxER9ylvszlrT5E
	 K04rVVXrXv/PMIBc3hbzpyusmgLdnmOyI2jp5da87AnRhe0YSA8GhPZLLowxPVRuLsV9k
	 I1BvUK8gJjiFpBVt5WDF0njWfW8gocAKpn9y8ROBX8jPQje4YOPBs6yUgEM1elNdm0q5h
	 WGSE3o/PyThtge/wGpkZDB82rndjH+dE+82Q2nuw9Xdhdh/wkFp1/6TxpS18NSnEp6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906608;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=c6logFtXvkjKajdate51tTXcoOZfAOhW4TsINn6/coM=;
	b=KL0JX2LjuCteNkoerX594nsmwAil8OdxTbK3Bmk7JBwe3t8QFiym+KwZQ5K3QtQ3SNIP
	 He2JDT/ywRADRxePbzaIuveCNb0XVMFllenpBvKGbZLFSlvyPTZ9HbAcTBKJ53yu8p5ow
	 XRdno+mDTbVpadRH6yDRRAwDGtEjT5RNds/K27KlNOZcU0A/1SqMLd6HRS6dasakGdkX6
	 14LgNVgcD4Wqpc/BtphIBfGVl4UNSA9E+e7EbU/Z0tDyFCu/KYNdXAGA+AnmzO39AA43n
	 FqabG4uBMTqTtq7tcHppc1LLqf9ViemWs4qO8bIyThAiaQkDVEsHupk6lQbljieUjSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ooDu48kl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C841E606A330
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 19:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ooDu48kl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC0B1F00A17;
	Thu,  5 Nov 2026 19:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793906607;
	bh=c6logFtXvkjKajdate51tTXcoOZfAOhW4TsINn6/coM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ooDu48kl8XwUGYzRsc64dLaXW+/TUD8ZY7XVEOALthQqcpbyFJi5PTFdXzNKUc5CY
	 IsaC/IkcUhF5PhKx2/K4j4tcrcMpTrlEMHarJiWcwjMgb2WGqblxMYqctL1LCdhUU2
	 4TY1FM6Xxx9pF+rnycmPUiMMbk6XZuTPN7dhlDltHiQn78d7Rz7wIfAXC+IjZRp0o0
	 pZEN3Ij1B038/sj53GNwmd5o+iU+6o+KMcRwiikMq/49oA2m/z9s0sAlTQ49rME/Hb
	 x2dxmzBDvub2D/5j6gmUx+hUYdSNM1D7Bay09pyPt0FeG/qNOJoTtTYmco3cOVtVKZ
	 BoBymyPIxWC2w==
Message-ID: <sashiko-outbox-199847@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 10/19] cxl: Build register block helpers into the
 kernel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261105185917.2667656-11-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-11-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:23:27 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Build register discovery with the built-in HDM helpers so PCI enumeration
> can use it even when cxl_core is modular. Export the interfaces used by
> cxl_core and preserve the BAR and offset in the register map.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105185917.2667=
656-1-smadhavan@nvidia.com?part=3D10

