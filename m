Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578431;
	b=Jik5/sHAgbHU2BgZLk9Vzi5zRsAgjBuNnrkXOyAK3my6BSMouf7DAriZVHRZWl0+4XdZ
	 eZSPLvNEJ5xEJuhRcJxhF+nt3RTtycu1dyxlfO5Sw4ENr1ntaDMToHnwLGJsG39SyHeRK
	 YXQm9zI4IZFhS85YEl6Ta2kC21j1ySmg0aD1pPtkrUNTIkiOjDkR7y0pfuXx1puVvC+gm
	 HfL47JPpfrgL3J/hRoLAoR9dpCZvMnMmgAqTNRYmoo6yv8NhqplJ/DEP4lJ3EsAhzx3/E
	 UUoH77FlMWL2fpQOga3lu7NVF0l54mC01Tvtu/kpzgD48kPy7fFKng8zNA0JgNYdyiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578431;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/8c1fTcxUx309d6lNsioFI28hznPcne6U2gkParSE1Q=;
	b=c1psIddwtNMg18rbRKpv5BpxlFo/Pm7klMb3qh5Rc3LPI/c8kyfdvQUmRpUlhooarcVc
	 uL8rZkps+lebHRPxiAX9WMAK0lfqVFiCzU/3p1xUmw1iNQcLVwEeLpJjCPGXcRYFGfO1O
	 4+nuHnWv0OlOtWcUWkMjHKJ7TIxFMZRg/rNJsiQlDJBvOPtGq7fL3HE2LeQVh4DHzB5f1
	 UFJU6h0oLbAAuDA4ter/dYneHIY/orNWCg31aUzi7415Idw5bqC2IW2Ba7azC1pEqHA9L
	 Tqrxj0iNAjEGxNBRhPsG2LcBQ5LabZcNaZYKKE58IgbSh9oDxbd5Dggg9PVGJcYdk0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Br8weBF+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76343606A33E
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Br8weBF+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F420B1F000C4;
	Fri, 13 Nov 2026 14:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794578431;
	bh=/8c1fTcxUx309d6lNsioFI28hznPcne6U2gkParSE1Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Br8weBF+zgWFCDPsAf7wDXFTn6+LvvlJlfsaq2HObJWs6eodhT1VvzonJu5ion84d
	 cfwkoff4FwUKMtAadINd9lDARMLScbcba+cMPQWxqi1iuMlewsocUA8MUp1zLMNS8g
	 fO9TmO95hB8FGzNXhnOXGEaNM01LePV0WdBoWx+gutENlxxabUefmkbzIU8222vbBS
	 OBo8VCdzBHgreWcjozHtIur7sTBStECUmjTS0ZSLb+shXZJrDKb2Aj80odsECtC8tM
	 v6qvg6dxY8UUNxstNuJo4Ku12PSlKVEzfveVbgcYmeo+atQlHjWBnFqqWQDUnnq9DH
	 rXoXtcNxekJMg==
Message-ID: <sashiko-outbox-212944@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 05/10] PCI: endpoint: pci-epf-vntb: Export endpoint
 DMA channels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261113132935.4152566-6-den@valinux.co.jp>
References: <20261113132935.4152566-1-den@valinux.co.jp>
 <20261113132935.4152566-6-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 14:00:30 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> An RC may use endpoint-local DMA read channels to transfer data directly
> to an endpoint DMA address once both sides agree to use them. Quiescing
> an unrolled eDMA channel disables its whole direction, so reserve the
> complete read direction and route its interrupts to the RC when dma_bar
> is configured.
>=20
> Describe the controller and per-channel descriptor memory in a private
> control-region extension.
>=20
> Add a dma_bar configfs attribute. An explicit BAR selection enables DMA
> export. Leaving it unassigned keeps the feature disabled.
>=20
> Keep resources already assigned to a BAR in place, and map the rest
> through the selected dma_bar.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113132935.4152=
566-1-den@valinux.co.jp?part=3D5

