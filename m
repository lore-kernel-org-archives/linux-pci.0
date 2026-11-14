Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616715;
	b=SJ5/5MpduGA43q56ETzbFDwT3dJ/ydz9DFooEuo2cw/+ZVdCLNu7+kbz/t33WhRFInBB
	 8jDa6icohOIdTCueUxJSrYFbsfSG/acAPpz6YIZxzMyuXplHHHG66vsLQ+vea2TAE2F8A
	 wOLRDccmSGWLb9/0+OGaPxS22GGiCI3U4PAHWrUpMGeynvouimazzfQ/MdKfaHJr1Y5bm
	 05YMNlY8LkkTdR2wwNy8NvW8xEVv4QmK/VdfvKZLvzgyeBZXJM9WOPH+RecdDD1voE3EP
	 MpWFM2bysJrQZeOwEaIBnume+Ve1J658guDqnPzbSkN/fc9+82YTR32lAQePKD8A1JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616715;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3g9Or2pvdND0fwulul6KAtmCgzFp1/RY2watCz3HyA8=;
	b=l9ahrQGqXmq9tZxCzul4zm/KNnXNSTcGJpiz0fNQ2o3b1M0hBJjLQrkdseUoIK8wP0Ws
	 m2/fAiflsfcix0GApKQNfhxAilUMyoxavuHzoDi6NaZzUFFwGTUh5/QoBBQykpVZPtgWD
	 PBAcU554PWGyTxVoBmJwINXVMgBhKdriM+U2iOKGSKUidv4VWHFunBBgn9Ex58hG/MhMx
	 FOaz77j9JouiK4TPwpjy/o0TaF5usFv6iypyCAfDnlCLYShxwS3+TiIHeO1IVOIeoRphc
	 Ke6WCGOKuajVFacB6i8Bcr81zs78eHwIPwn3SkpCqzM0CnXsxbh9xN33Xzurp9sOniQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NLQB4rq4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AE3606A32D
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 00:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NLQB4rq4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DEDB1F000C4;
	Sat, 14 Nov 2026 00:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794616714;
	bh=3g9Or2pvdND0fwulul6KAtmCgzFp1/RY2watCz3HyA8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NLQB4rq4saPXkgMmOLdBPqBFSxJP3RM6riw01h/AmMY0B2SZ0IntOE7cSgikLpxEB
	 0Ul1a1ariIgAupiDFS/WLtN5hC05dJ4BEdQhsa7w1uWtgRs4pR0ocJfTXCEcyuphZ6
	 zhu4DxQgP/3m42bZB3B7TL+tDS+KqhHPV4MI6tH5VuHGrV6AZCE5z7q8wgkt9fzEoR
	 mP/rVvjffBbmcslANZ0JY1MafNGH7uNtSwFR1bqMraN9sRG+F8o5yh5bBJKyRj4+Ur
	 3XQhK9pREy3T/AN/SyCXaRtncN2DxxSLV+8Ww29MZJmWO4gFqWY9Ae/BiD/qQiTB01
	 Snz4WWbSkjSSA==
Message-ID: <sashiko-outbox-213939@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/3] PCI: rockchip-host: Skip downstream config
 access while link is down
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Thompson" <matt@boondocker.io>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261113-rfc-b4-v1-1-b91dcb502250@boondocker.io>
References: <20261113-rfc-b4-v1-0-b91dcb502250@boondocker.io>
 <20261113-rfc-b4-v1-1-b91dcb502250@boondocker.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 00:38:34 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] PCI: rockchip-host: missing Fixes trailer for link-down config
  access fix
--

commit d2a13e40a12b2c5046df485daa4e6e09d60bef0c
Author: Matt Thompson <matt@boondocker.io>

> PCI: rockchip-host: Skip downstream config access while link is down
>
> On a RockPro64, a PCI bus rescan with the downstream FPGA unavailable
> faulted in rockchip_pcie_rd_conf() during a vendor ID read. The rescan
> task exited with interrupts disabled and the watchdog reported a lockup.
>
> Check the controller's link-up and link-training status before issuing
> downstream config requests. Return PCIBIOS_DEVICE_NOT_FOUND while the
> link is unavailable. Root port config access still uses the local
> controller registers.
>
> This check cannot prevent the link from dropping during the transaction.
>
> Signed-off-by: Matt Thompson <matt@boondocker.io>

[Severity: Low]
Since this fixes a fault and lockup when rockchip_pcie_rd_other_conf() or
rockchip_pcie_wr_other_conf() accesses config space while the PCIe link is
down, should it include a Fixes: tag?

  Fixes: e77f847df54c ("PCI: rockchip: Add Rockchip PCIe controller support=
")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-rfc-b4-v1-=
0-b91dcb502250@boondocker.io?part=3D1
