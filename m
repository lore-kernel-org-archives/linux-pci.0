Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794016419;
	b=VTatv4jlFcbgqFI1FlFaitEzEF1pmlLAalpnrNLvgDRqpE2pxEzpZLMMcIUfA3uDQ3Yf
	 g8cry/STEti16iVSYLzmnjZBqfdJMM+SmAduwXinj6SGxTvuUFMoNypMDZrOyK5GNaiP5
	 qftakwurO83o9dGVf01+HlPWYcvXLyuT92DMSbHvuuvXg/nwzGZzqQEiEXsA5NVn1bEGp
	 eOye/51nHaaA8yQG9evVK5npZ6/yT+zah7MGkcO0QgVHZwzCLv/I1MFO0aYURQ5tGnGH1
	 FcxYxOdFDlkVC2ltuIiw8GJ2ZWPD0VvQC30CC8Oo0sNhKisMxN+Tdh7PpSFC5LI8fDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794016419;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zoyDK1L5EKmYwDR/gsFd2qbNRhkuJa9gBrovFxjQxOQ=;
	b=tb599Zjk63KBrY1+zEHIL3nzRF+/wy/122Rksp5UDH+jdcF3op/N6Alkl/y6Pt8tdgPv
	 LMrMKx1Mh+gsR82aadJW6VIKyHowYnPLrDVTlpNrQ7t/87wH6ccr/lWvGCz/DgmwKf0JA
	 v0U8+k4xPy2rnOxVMAsYi+vLrx7nJOwmkChgfW5YAMSzjuQT2JO25XOOI2ykdsBzyIAec
	 6PRrxV+07tuQOhx0HC2hv79nFCcoDV/uJOO7TypLDFsF8/efHmeP3Epgq/IDyNLi95jCU
	 HOnAq98NdbcGIIUJJwRKwYrRYqlC5zvlemkNnY/4VGmGs1p6PpHyw9kW6+5nkPunNXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZyNF1ges;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F7D606A326
	for <linux-pci@vger.kernel.org>; Sat,  7 Nov 2026 01:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZyNF1ges
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E201F008A2;
	Sat,  7 Nov 2026 01:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794016418;
	bh=zoyDK1L5EKmYwDR/gsFd2qbNRhkuJa9gBrovFxjQxOQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZyNF1ges76Yo+ck/3nNx8H1kzndr2a98aswasoW33pOL8+n7GlH61EjEamzqwDCY/
	 0EeziBrHu5lHGE7WlVMM+9qy1iIjwl/EUfZ2bSCaUxR2518DhHAvGFQk30L9gc/1Mi
	 O7i6xUWkDwIqrxbqSMVWf4me0CwNPZd4gNAeYugbPWYM34OcnpXtX704NxbOGeSg+8
	 AO6xWMvavfU2dhLnymQ0+OsM9mEDYekKwEoO1GCxibaFMFuku5uawJ5sIrnUy96GXS
	 vG4aacUiUvh/7IxX9CS29YGFYlGf3w+DdHHkOk6PdLnO4OAwhmVKVmuytGnoYzVZJq
	 OMH6MWvruV0Cw==
Message-ID: <sashiko-outbox-202467@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/4] PCI: host-common: Fix early bus-walk exit in
 d3cold_possible()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261107-shutdown-v8-1-bf607c6429b0@oss.qualcomm.com>
References: <20261107-shutdown-v8-0-bf607c6429b0@oss.qualcomm.com>
 <20261107-shutdown-v8-1-bf607c6429b0@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 01:53:37 +0000
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
- [Low] PCI: host-common: missing Fixes trailer for
  __pci_host_common_d3cold_possible()
--

commit 846cf26aeb81e6f1edca4dcbd23133cd3972fd62
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

> PCI: host-common: Fix early bus-walk exit in d3cold_possible()
>
> __pci_host_common_d3cold_possible() returns -EOPNOTSUPP for the first
> downstream device it finds outside PCI_D3hot, and pci_walk_bus() aborts
> the walk as soon as its callback returns nonzero. Any device enumerated
> after the disqualifying one -- including a wakeup-enabled, PME-from-D3cold
> capable endpoint -- is then never visited, so pme_capable can come back
> false even though such a device exists on the bus.
>
> Since pci_host_common_d3cold_possible() already returns false whenever
> any device disqualifies D3cold, aborting the walk buys nothing for the
> plain suspend path: the overall bool result is unaffected. But it
> silently drops pme_capable detection for any device ordered after the
> disqualifying one.
>
> This matters for the upcoming shutdown path in particular: unlike plain
> suspend, shutdown forces the link into L2/D3cold regardless of whether
> pci_host_common_d3cold_possible() itself allows it (see the following
> "force_d3cold" changes), so at shutdown time it's common for an
> endpoint to still be in D0 and disqualify D3cold while a later,
> PME-capable device is never visited. dw_pcie_suspend_noirq() still
> uses "pme_capable" to set pci->pp.skip_pwrctrl_off, so an inaccurate
> result here can cause Vaux/wakeup support to be dropped for a device
> that actually supports PME from D3cold.
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

[Severity: Low]
This fixes the early-exit bug in __pci_host_common_d3cold_possible().
Should this include:

  Fixes: 1d2a29ccd3a1 ("PCI: host-common: Add pci_host_common_d3cold_possib=
le() helper")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107-shutdown-v=
8-0-bf607c6429b0@oss.qualcomm.com?part=3D1
