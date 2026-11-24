Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526545;
	b=XE9myaubHgiEM9vUWh3AuTzLdKgXmZssAjHMJf4TXoYwUc6XUcA7YdJb3Ejr9iefGr7O
	 cIi/GGwG3DL/qAqCzUqT3xNdLQ8hrMpwLZx6S54EdU8waZsyl3X+/STvH3PqFUTX4lVtI
	 ujFb56j3IF56krviPdGK4TbLb1yyxiLAWX7Sg5OOStVKoMWmv0Gic+L05mPcDVQFZvbmu
	 PEVlm8HlFNcIbMEZ+2RwYzq0fPGjUGOtQUPaT3qk19XcT6eBbZkAn9xMlrQwT7Qnr2TLU
	 lMiYfBKSej213FEOHNfZ11GtQw+yDD863IP/A/g7NynzqE1JHRFqGKc5vFQCaxgEyuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526545;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Mi41Y69yBGbwp1V63Btz/r6QFAO9ZUQSmDh31BrE6tQ=;
	b=ccIZdWssBVEEtHBLURbveOgzgf2VxBRF9vkVw6SvRI66XR9Qx+BnvNTBpul4Nhs4w1ph
	 btZiTT69xkYkhTflcBrFIs1HwSp2zs1dm9MPRDv12ClfFFkqJvE2nr485sXiDApj6s2e4
	 HySb3Q/k2cioiVvd8kkw/mQnDrBsdhup1XfPMKGIEZK6SWpAOzp91DKiy8eR6YXvaVNOn
	 zQfAbmtJ8QQ+pu7CaHHSSkbiIMlxgdNaXRn8+57C+Goa1UY3p1ZvlrRNa+GNPQHLPIsmt
	 Kges6ceYvJbzJxt0y9I4/xhGDoiRiLjsnciKsIb4KY2j5dJljVc5FGVhXpslCIxO3XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eGpK2DNH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AFB606A31E
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eGpK2DNH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B9D1F000C4;
	Tue, 24 Nov 2026 13:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795526544;
	bh=Mi41Y69yBGbwp1V63Btz/r6QFAO9ZUQSmDh31BrE6tQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=eGpK2DNHLM6vhxOID7C7fUbOzmUaKuaB28gVp0/ZXPK+m37+8yJ0NYx5QpEZwSs2O
	 Q+uv0HhH3Cl3my+CYidP8+IbMMucDVJUux/dmjxF9O4pQ09201oUaGrFvcHz6VZOq/
	 8VCvcIrLyWgM06QQ1H4CnQAGrBYrf0kwcpQDnslBLa4aKokjUHHl55ffZNmk1eAN49
	 Hmp6k7RNj7yygk6LS1m1f4MY1xmUrMnrgJolcMHtY4JNcnJcOVNks9/oEYGOZspJFl
	 YzFPHs+W6pX493axbndCG+Snyt1OzA6IqgjVs/gZ94I1cIbHex3pkLb2J7Vyy15XJZ
	 IJMEOwPU1e5VA==
Message-ID: <sashiko-outbox-231197@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: imx6: Fix kernel oops on user-mode external aborts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Ghetu" <stefan.ghetu@nxp.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261124131432.695946-1-stefan.ghetu@nxp.com>
References: <20261124131432.695946-1-stefan.ghetu@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 13:22:24 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Richard Zhu <hongxing.zhu@nxp.com>
>=20
> When a user-space process (e.g., memtool) accesses an OP-TEE protected
> memory region, the SoC raises an external abort (FSR code 8). The
> imx6q_pcie_abort_handler() registered for this fault code attempts to
> decode the faulting instruction by directly dereferencing the saved PC:
>=20
>     unsigned long instr =3D *(unsigned long *)pc;
>=20
> However, for user-mode aborts, the PC points to user-space memory. This
> unchecked dereference from kernel mode triggers a secondary domain fault,
> which is not hooked by any handler. The fault then escalates to an
> "Internal error: Oops" and crashes the kernel:
>=20
>     Unhandled fault: page domain fault (0x01b) at 0x006e3316
> [ ... ]
>=20
> Fixes: 415b6185c541 ("PCI: imx6: Fix config read timeout handling")
> Signed-off-by: Sahil Malhotra <sahil.malhotra@nxp.com>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Stefan Ghetu <stefan.ghetu@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124131432.6959=
46-1-stefan.ghetu@nxp.com?part=3D1
