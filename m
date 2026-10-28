Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157082;
	b=E1KvfgnH7nyUUm7SBUFpjVFa4X0a/ammflOe058pMTXmkKZZHISFxS/wXV2FrhSzDo2/
	 yo7QaPCdZ8vKwvbkpnBM0ijL7c/HbZRWuYwUXN9pSsJ9B7Navv63jEVjCKOxpH5nnc5Eb
	 mMdSSdQ+9o0YbmcVdfQ/mbVZ8Xf0S9wQu5fHcAvW2U1MJZOiQtMQ8sD/VsbJL+UpGygAU
	 9ZbhbDI0AXE9Y2UhTabrwHgou1ixAx8rx2FCu+nrzsQyajuHsqeyds3jRbWdYlFdVx3GN
	 u1c6fK96o7HKIuYNma1G0QZdonuNNmhYbEdTmXICm9itlJZy00X9lAztxSWZSFVY+Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157082;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hUNeRVCEnO0JTksqOdjf7g4pijUrwdIVAArsIbB+j5E=;
	b=BwT0JB+pbuJLIKGmsV3j9b4+y/IXz4WUgyFBxiJbk5JwTtooaH5sk8fENxkbisDe9/iD
	 X/Zs9sxnpqLB2VSPXzcfUIJ4arZ1uxAHcQdibu+3SDqkXS7fZ7r2BlVWQlPuOQrl6jEv1
	 +fxh7izda/X9ORXF+3rMQrvZkjxqkxLGQ9JBo6aXeRbXnhsBd0/xMnmg7B9sEpyIseRTD
	 0T2KS5/3vuwZLpqEV98sgATbT3nJMqYc5c6Nhb2pKv3gY2U+xtqAdk+xrzvr6VdmDteoB
	 nH114JKKJs/CzlTWvxNbXcnpe2G4K3tIXjuYZmhH1yhYNE7mGcI2DlZzL4KQJXuT4Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MUe3m0Xs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360C3606A31A
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 03:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MUe3m0Xs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3DD1F01828;
	Wed, 28 Oct 2026 03:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793157081;
	bh=hUNeRVCEnO0JTksqOdjf7g4pijUrwdIVAArsIbB+j5E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MUe3m0XsJy144ILKVyF+jIrs/evlOb9bxzxU8dMEecNvP9WFOKdkH2tUXWm19uzHr
	 YTxX968o8Zj7GWqI9VVhl52R0tnKWk5Ex+wxfo1Z9hS/WFEPaHNR+74K0vnKnYM1NC
	 qQlWtm3AY8ZP+z0UJ1KccjZPw4NwTh1B+Xfm2p555lPMD+Tm0Wsqu4OFt7//kAzEs1
	 0LmssviESTRAX/aayNMnAI6PBCvRMbNxuhMwOIxX2Iy2PNZwmg9c6C4Mhcce0W7JK4
	 QmqceoZdtt9Vr51CXBhzjwwe81PH6NCleVSPnlFdT2oMqrevNo7i4NU7FQr1GDaVXh
	 R48PRY5/7w+8g==
Message-ID: <sashiko-outbox-187393@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/16] PCI: dwc: imx6: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261028030652.2917756-4-18255117159@163.com>
References: <20261028030652.2917756-1-18255117159@163.com>
 <20261028030652.2917756-4-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:11:21 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Replace the two dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) calls in
> imx_pcie_ltssm_enable() and imx_pcie_start_link() with
> dw_pcie_get_pcie_cap().
>=20
> Both functions run with the controller powered and clocked: they are
> reached either from the host .start_link callback or, in Endpoint mode,
> after the PERST# deassert path has enabled the resources. The helper
> therefore performs the DBI read at the same point as the replaced call
> and caches the result for later invocations, which is useful for
> suspend/resume where the link is started again.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028030652.2917=
756-1-18255117159@163.com?part=3D3

