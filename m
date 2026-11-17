Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906234;
	b=WAG9IQvRCLs4WY+uv4R0kJ2DLbYILZ8kGVaaQRrLw6z8yiQ1luqlQYjoBOOqykgR7juW
	 muQXm8k4qi3lWVwUnsl5DM4h1tBfGznjoPYYLgOyMyFd4bXh8Iej0MMYUxpJymaOeFi3+
	 clE2zLVz4FzgkrR3Ua5Sc4U0kdnu5BL8SPJ8B05IKFE7iD2SwjV9UygjrbPZB/+w7ih9Q
	 gQx4vXizDHQU0IPctl3tyDLToT81gt+lTqfSSvgvK/9xAmaNFzsg9JK7C77M6uDBap7sE
	 sPFFrDa2K9lot0TDUbuZyhXwUvXuj6GgW2/vIsiKPhXchuQvNnfM9oyXcLFaDVoDfow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906234;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=p5bdpr5dAjfPmwzq0UQYGOTEvHj1q+xWvnrMvmxhdH4=;
	b=Kqg4YYXZ+FibA15MW+rGnhy4pkardMkBPRQpynKJwLdHQJfH6pb18WsNSU/fNGfpEn60
	 FPznAs7p+pzyjrypL/ZHuY3m0gI4qT33OXNHz82KhN0OCpV6VN6IaA4Qdf6LfrqrTQgU/
	 wjrmcKg253JabFAHBDGVppKtvEViwWPzQ+H982CcqFh7s7GjGTzhbBAD5KSvYdgCPQAas
	 EfPZPE0j2tFh4FykUA32DAStrgNqIjhZrXLSuzEtdYLnVKfsNO5N+M0jm1uhyY1rjcNjT
	 8kEP4amteo2mJ6Mx/+AU1rBaQ3AC8ZtB0TXLNYsO52psMFRmzb5MnvOz5NAPnotB7Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RX2R9gPx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADF5606A333
	for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2026 09:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RX2R9gPx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831741F000C4;
	Tue, 17 Nov 2026 09:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794906233;
	bh=p5bdpr5dAjfPmwzq0UQYGOTEvHj1q+xWvnrMvmxhdH4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RX2R9gPxXzF8rMoDN9H15mP/UBN0uhqDkZ/JDfwEQQ/rYU5wS7sYHwmG3FHiHX70t
	 0R4pY4EWk/LlpZtt3MuXmGbarOrosJLNwrXG9GEEQ5QwdMuOvsupHytAMf2ldc3cK2
	 uEaXcamown8752Q3O/CMY2o4ogDigdo9e5lBURfxFvBS2d/QGPn8Gf8vvBgBrKHCdi
	 EZrXbL1Fn29j8rhwBZo/BRn+pkI2TSvM5GYHBpAlNKT18nsWANHqElMD0ICkv+mTlB
	 bXT1fjwm+jDQh69KslffNDX92Xz14etpxEwUtp+0j8/QQ2W99yCkdoZ/sopn5OY31H
	 wR/C88W/QtNPQ==
Message-ID: <sashiko-outbox-218445@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: spacemit-k1: Request the Gen2 speed change once
 the link is up
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RnLDqWTDqXJpYyBNYWjDqQ==?= <frederic.mahe@cirad.fr>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261117085508.83388-1-frederic.mahe@cirad.fr>
References: <20261117085508.83388-1-frederic.mahe@cirad.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 09:03:53 +0000
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
- [Low] PCI: spacemit-k1: missing Fixes trailer for Gen2 speed change
  fix
--

commit 842cad793224659cfdb7e69af083d16f7d380bad
Author: Fr=C3=A9d=C3=A9ric Mah=C3=A9 <frederic.mahe@cirad.fr>

> PCI: spacemit-k1: Request the Gen2 speed change once the link is up
>
> On a Banana Pi BPI-F3, an NVMe SSD in the M.2 slot (pcie1) always comes
> up at 2.5 GT/s, although the root port and the drive both support
> 5 GT/s. The Directed Speed Change that dw_pcie_setup_rc() requests
> before the LTSSM is enabled has no effect on K1. Setting Retrain Link
> in the root port's Link Control from userspace brings the link to
> 5 GT/s, so the link itself is fine.
>
> Once the link is up, request the speed change again, wait for the
> controller to clear SPEED_CHANGE (as pci-imx6 does), then briefly for
> Link Status to report the new speed. A port with nothing behind it is
> skipped after 100 ms.
>
> With an SK hynix BC511, the link now trains at 5 GT/s x2 and fio
> sequential read goes from 397 to 575-640 MB/s. Data verified with fio
> crc32c. The empty pcie2 port behaves as before.
>
> This change was developed with the help of Claude (Anthropic); I
> reviewed and tested it on hardware.
>
> Signed-off-by: Fr=C3=A9d=C3=A9ric Mah=C3=A9 <frederic.mahe@cirad.fr>

[Severity: Low]
This fixes Gen2 link training in the initial SpacemiT K1 PCIe driver.
Should the commit message include a Fixes tag?

  Fixes: ff64e078e45f ("PCI: spacemit: Add SpacemiT PCIe host driver")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117085508.8338=
8-1-frederic.mahe@cirad.fr?part=3D1
