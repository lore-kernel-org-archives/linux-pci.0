Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795437973;
	b=01mdzk+Ln9a1WCpj5c1HrDcoJAkV7MaKePX4X0/Vmt8cM6xE9pkH6A5oSv3NMZIjquk/
	 GXaDovubEbBkWryahqBOdVhm0idO/ZTwqXgfXcmPRQEti/NuXee9ONp1HQFvHRSwh6pUE
	 9nrLkBcdjzfxQN7FPXL+ThEljPgE1bG/SYCHJapNiVmZXWhWmG4hv/GdLqgfvTzQe7v5a
	 XE29dmyZb/BKPGzJ3DDBtLpiAGGGG9C4ucXY9cc2G8+SVUl6G/xyTBNIf1ag+D5RnGAen
	 LKo6RkwQNyrw+m6PWX/tsTVOj7AcmRSaMFTZw+0IZiK2LC+MiIu3Gp+GMMs4fSCWXuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795437973;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=H3XY+R9/puuNgoo0oUNdFiZ9TsH6IAjKiA6LAaXoPpA=;
	b=ptSd7yOtbWN4OYRVILiA7sPs5DdxT9Aqot/JNtlUFiuSVI0o33AieNFoLOCOSIajZYD9
	 fwzLxa4iokc+mNgGc339C7B+gM0YTyKAYjclzJukjZIENplX0+9nVS9mUVj+cW3vJGNbL
	 jColi+0RFNTNMr0OPfO7cjHFtyz19W56ex/wWPuX7MVE1S+MnKgcL9o78UXXJx0U7CYtu
	 FSnJusXn7bbtufeiCZBYb8c/VBlXShrOA9J0SGhvXXwf6BdZPdUPDa7Fx7k4qa1tlW/y3
	 LbM6scW+K8XGGfql8lf9whL79a2Oaak4s/AoioQf82+pY2y8/d1rJL0eaVyEjeKja+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WTiILd68;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F4A606A31A
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WTiILd68
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388D91F000D3;
	Mon, 23 Nov 2026 12:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795437972;
	bh=H3XY+R9/puuNgoo0oUNdFiZ9TsH6IAjKiA6LAaXoPpA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WTiILd68lZ2qpBANMyFcAQTKjepveUE2ar8MUMQQRA8GKPm1ObnulC7MGWbiO3+iF
	 z9D9EmG4xtbr61NfHUv0AW93e4t6J6rnjXgBl6qkWoFBhAqA/HlTFX7Yl9KMLEZcpG
	 JN3XMCBsp1KGufQGq3U9AO092CF1PNMZU3DJc6ClX96JQ5xNlnztc4Co+XsXPeprMt
	 uIwXgRPzbXJbEJdleqBoZCJlmrF4ChkVdCwmuC+6mifZmr/LCGWGckdrz9tg53e3eH
	 erEwBHaMObt3VHo/X0EJ8UeDMJ7JU5ugyCB5S1RZ9W/Suf9+KceMYEZfIz3FaVGMpd
	 q2Z6Vo9HOY1IQ==
Message-ID: <sashiko-outbox-229246@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: imx6: Use dev_err_probe() when parsing Root Port
 nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Ghetu" <stefan.ghetu@nxp.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261123124110.563397-1-stefan.ghetu@nxp.com>
References: <20261123124110.563397-1-stefan.ghetu@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 12:46:11 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> pci_host_common_parse_ports() returns -EPROBE_DEFER when the PERST#
> GPIO of a Root Port node is provided by a GPIO controller that has not
> probed yet, e.g. an I2C GPIO expander. imx_pcie_host_init() logs this
> at error level on every probe attempt:
>=20
>   imx6q-pcie 4c300000.pcie: Failed to parse Root Port nodes: -517
>=20
> Probe deferral is expected and not an error, but these messages flood
> the kernel log during boot on boards like the i.MX95 19x19 EVK.
>=20
> Use dev_err_probe() so that deferral is only recorded as the deferred
> probe reason, while other errors are still reported.
>=20
> Signed-off-by: Stefan Ghetu <stefan.ghetu@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123124110.5633=
97-1-stefan.ghetu@nxp.com?part=3D1
