Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792483848;
	b=i7Sk8hcV6ehuSuqp+6nGRO9aUdadd/YSbgoVe9WnUM+TuNG8xOxowktL1ihXRKJBXWBO
	 au3u8YmOy5N2Qqj07XWZGoRSVNgk+apVGIs9h5jacMUNcdmw2fNdHEcWZZMgMkA/wckza
	 1hpTMlBeRdz3vYMalAkCgEJHgc7Qp2hAVD+CBu95EPajoVaiBM0OYPy161z3KHQtw6mbE
	 ybYGNrV7VgrIQY0D2+4tPqEueLT5Rda3Oxi7Ep4DGS5k1/cXtuFZWfX/Yv3Hdmmy0ZxET
	 3AIH43dEB7wOIaKlln4fyHWtGKMF0hRHHjsQKEbN9OMnzyfyAl7h/HxGkhPYr+wk0Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483848;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ALblVKsJz8bJc2vx7ZGDPCnmZWHcDpzcee9IhQmbjKA=;
	b=BM6rQlvbXxTOehbEy5q8VmV0+p21nTEVLQhSQHp4/eL+ehLO1/zxH9EBdUwPSUqf+eO2
	 opjZ4wyhgwpbO8eNLY69RWzd9b4bhytUtnOCAB/5nTFmudRX2z0htv3qYbIQ4H7TlADLD
	 nY9em6cVuSFMtmkprBPyv8nZN1kgJyZM8Kyi06TtkSfYIYzgDoWlgrXJ177fNUaUnQggW
	 fn9rWOxaF8x7o9X9JrE+el638BDotlJedssxJGBH6mg1SPlK7d/j9nVVhAq9GK0nqBDmZ
	 LWZxSuNFtQcYYAScsMqko/077BJwRCWabaRqn5sxkq8TBAFrODlGUajxzg8b39h1t7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lfJoXUR7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AE8606A31E
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 08:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lfJoXUR7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3141F000C4;
	Tue, 20 Oct 2026 08:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792483847;
	bh=ALblVKsJz8bJc2vx7ZGDPCnmZWHcDpzcee9IhQmbjKA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lfJoXUR7s0E0t0Xd5mWUF/xQKfymgpxf6HBjI86jW/PIBDGMFYirmvjiEcqpzMVx6
	 nbDuncE2nJ+M8QpWgNVmA5jSZQgdDzsMzB8OU54STo207fA/8WR7dEwnu+zaU/BV31
	 7t10xpJMSwpv7WUoYztxMxUrM7uygC5pmOUfKg6foZL3twKwHuMwMMvJ1ebNtzIGEv
	 uKHmiEECYCIbl4LUjZkwxbmGRnzVXsgDdLyj561vfTVbsiVKfp1faOPs0bmeE30bkd
	 XclpZbvBPdyNueBdkIDoLfG8pC0AA7pqYjUzNtrIDz8v14IrqXZ+Db2J4So23zsO9r
	 GuU85a3rLNYmg==
Message-ID: <sashiko-outbox-178490@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/17] PCI: dwc: Factor out the PORT_LINK_DEBUG1
 link-up check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261020031049.969895-3-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
 <20261020031049.969895-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:10:47 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> dw_pcie_link_up() reads PORT_LINK_DEBUG1 when the glue driver provides
> no .link_up() callback. A callback that needs a platform-specific check
> on top of that register would have to duplicate the register read.
>=20
> Factor the check out into dw_pcie_link_up_debug_check() and export it
> for modular glue drivers. pcie-rcar-gen4 will be the first user: its APP
> link-up events remain latched after the link goes down, so it has to
> combine them with the live PORT_LINK_DEBUG1 state.
>=20
> No functional change.
>=20
> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Reviewed-by: Shawn Lin <Shawn.lin@rock-chips.com>
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020031049.9698=
95-1-den@valinux.co.jp?part=3D2

