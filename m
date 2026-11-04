Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801642;
	b=Pg8yLGVt6vpAESektTX8C1N235msOrJAVt5YqSA3kTV39hZNbfKyhOK7xaKtU/oe1rSR
	 S6nyWTbgYouEgq3gNnfcEoHnlf4Iflgaup594mhYXfzgm1TeZDS4ZLIggcnOFhXYHZ6bn
	 Gn4gJDcK1vmWH45l7JbdOVemqAjRZXWDAHBS7q/XNCsxywuayjeIAZzLm4cd4AkmwP+BN
	 M/YxBo0yiUnMRWYEX2x+w9RMRrOrTdTfT3L/j21v5dv0p60+Rzkoh0gF64j+8V75nvVIe
	 hR/bv/TRcK+izPLVaNsfxXeoqhPrxPGkun69Kjre9XY5TmE+OJ+Of7t76UDEtNsZbaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801642;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=77P9EAq2PFwdEZ3tNpwVw/7rlfb0oA4Xaf3gPKeAj9M=;
	b=FGb17JInounQysvP/+QJ9Wh7NJEIxyJ2fcWbLKmrIamhdhx4wg5VaYR4PI+MghyLqBDj
	 f1N6Up3VG8obLYQ1eb2ctZJvi41puqfZKDiqPr4kSu4wmr2enhP6MUQEF2H7ukCWTn+rL
	 3tfforSTHrsVKac7qtBOE6bGLq94JH06Krci+yAVVvSYm/h4ofA1KJjA/I7XjSXnTd0HP
	 rN2GbIjyg3hwZfS155XC4qt+a4WA/DDx8uAxkO12cIsOh2T6NtI/H1iyXAC8KXTmLs75a
	 dTzPERtZPvIGK1N3XttPwvi/vFKkXpwXLuGe7JmTrqK+xtYMOX7n9ciBJy64VbIollg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eLVW82sr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBE7606A336
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 14:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eLVW82sr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEA61F000C1;
	Wed,  4 Nov 2026 14:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793801641;
	bh=77P9EAq2PFwdEZ3tNpwVw/7rlfb0oA4Xaf3gPKeAj9M=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=eLVW82srAdJ+zXE7KRQfsmwSjQz91dtefT18tVn3u+pPQ0zqHGgYrn1uTut/tIbho
	 zuh9tLnD6K+9wkrmm81wYhJGngfPo2nexN8FIMIf17ba9Dd6Q1/4Yk6AXQQdsf87v7
	 ww0ouaJyY0j8IzOnVE+kx/D3RcfxYKxRTnXn7A38xLsF5bXYQQbRmGFJ3F7ef7zWqp
	 02cyXasb3n6deW20mDeEqKHlFd1qki/c7ucD0U00IVTx5eP4FUj02N88EgXj1hKPia
	 C80YiukQjXH5gfCfCdqbZHjrbn47LQ1p8fnsTAFRRsKeluhmPasjHn561wPkWLyrYp
	 YeoFNNEjtcEPg==
Message-ID: <sashiko-outbox-197414@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: spacemit: Ignore PERST# bit for controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ali Tariq" <alitariq45892@gmail.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261104140750.761330-1-alitariq45892@gmail.com>
References: <20261104140750.761330-1-alitariq45892@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 14:13:59 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The k1_pcie_init() does not set PCIE_IGNORE_PERSTN bit of the
> control logic register, which causes controller to reset itself once
> PERST# signal is asserted even when acting as host.
> On Orange Pi RV2 (SpacemiT K1), this resets the controller and wipes
> the IDs. k1_pcie_deinit() leaves PERST# asserted, so when k1_pcie_init()
> runs again, its first DBI access hangs the CPU.
>=20
> Set PCIE_IGNORE_PERSTN bit of the control logic register of APMU
> in k1_pcie_init() before enabling resources so controllers
> dont end up resetting themselves when PERST# signal is asserted.
>=20
> Fixes: ff64e078e45f ("PCI: spacemit: Add SpacemiT PCIe host driver")
> Signed-off-by: Ali Tariq <alitariq45892@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104140750.7613=
30-1-alitariq45892@gmail.com?part=3D1

