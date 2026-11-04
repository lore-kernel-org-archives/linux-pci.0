Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819761;
	b=0WhpbHn4pN3PNFMRXYnAC41XzgreObm4KOm0TYOkhPO+ptitx0jOFNRdtoDo+lemLesy
	 VtIKGL80ucCNUskiSC6+B4n0HPLf73KjIoRe+HWWsZoSDlwM8unEzJEFdvnK7gxNAx0o8
	 Bg33lLQg4pgSvn5klmaAdKnireL8V0emgerftQTtJyMieetGYT6hWfWfRPd6ohLZIgREi
	 FGNhBw6J1VgAemRK9m5cs4wPN6ypZDYyZqKfaPiJcexZ1NfOj3i6s7JIA1YRJc1H0VIDv
	 BBO2843irGZY6Vv8Y1WOx7poDUITaoFEMy7MOqx4rt+IZ6i4r+kkQoVR/Obo4fUewmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819761;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Kq7syqG37YQTMG0ysI0F9BhUwDyMbuaLI8gSn9XJ8V8=;
	b=KBPC1T2oyfISC/5SthzdCu7ySP51dyB+p3GOO0Gjuqtm1SmooY8w12wYWXu6vaEkSkDX
	 fzecLch8K1DBxBuAcOTTOEoQCXJ1d94srGIbUMaiCcI0XH3Myx/azyRhfyQKc4AgfbqIZ
	 RAzDVFs0IxFQYXwM+ZHyqdoeXy6H+9KiEWI+cRiBSFTiU9v7BVFthVyVI3IWHRNkZKcxA
	 cLJDN6KGTtq7NJqauq8hbKN1x04yvowm6J7NeaBALV7yUZlBvLyx5jSuQMnBQuSHSUT0x
	 CmZHmqVYCuGeSIX9JZZb32hv6HJNy1QsTErC+UCcbPJn7VXKIrfsIWs0/dKC8cp40KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZlTJ2Lkh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD80606A326
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 19:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZlTJ2Lkh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7C81F00919;
	Wed,  4 Nov 2026 19:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793819760;
	bh=Kq7syqG37YQTMG0ysI0F9BhUwDyMbuaLI8gSn9XJ8V8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZlTJ2LkhT0AHooHt7heooBVgr866DGbin4Gd/y9RPa/RGYLnTc+eAwXn5AiLj3UCa
	 PmM3ZzEQxY4+tSbOCY3iDqkChB9zwGfo+1hA+QJV7b9mpc+j/3w/RvuXG51lEuOsDJ
	 KTfKVpbYcCEJhGjekCn367p/DhvFI2ald+K82KF8J9l6lL1HjUmA7v7yc6+2VGyqz8
	 KTFgaRZqFLAG/B82SEiu8fSGmbkwY0q2e831jRsnjZkS7Bo7REuHJao7qTTURQyXIS
	 UyHORYYoP6GkcGKKvhDfns1e1CRKBWEp4bUw2vukcnzM1QbOx+ddH2RJ+dSXfLZHUr
	 zAFYnPETdC62Q==
Message-ID: <sashiko-outbox-197931@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/10] PCI: dw-rockchip: Move devm_phy_get out of
 phy_init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104-rockchip-pcie-system-suspend-v7-3-6ae6875939a2@collabora.com>
References: <20261104-rockchip-pcie-system-suspend-v7-0-6ae6875939a2@collabora.com>
 <20261104-rockchip-pcie-system-suspend-v7-3-6ae6875939a2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 19:15:59 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> By moving devm_phy_get() to the probe routine, rockchip_pcie_phy_init()
> can be used to re-initialize the PCIe PHY, which is for example needed
> after a system suspend/resume cycle.
>=20
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-rockchip-p=
cie-system-suspend-v7-0-6ae6875939a2@collabora.com?part=3D3

