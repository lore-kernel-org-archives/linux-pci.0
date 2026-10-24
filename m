Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792861091;
	b=L9Z8KVjEqhgrIvPSCbwCiUgaS0CZwQ+XGAUzH1Rz2Xrs1+rWCW0vw3wjOVODj8OyOvTa
	 DZnGUB2hZvICI2ZUZg3tDsHMSbmg6eoWZBox0eKh3PVnOuIxcUzzyppSld9m4n5dP2HvE
	 TuzuzE3rLRDx5Wt+zl7mMpC8cQkXYKq/WToqraFOqUC0QwvbM9rTe9F3VJtsVWSTO2YBl
	 Utn4mdsiT4R548MNmAEeV4bC70n7h40FPDQtXmzADpX+rrKowT11kDWb9aDXqDIT3IWYp
	 B9KzkCjrP03rEpZ8LC5CO9HJXa56QBVfsx14xFEE4Lq7eQAIOdmDWMvRMoxZsExytqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792861091;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kkj0JxGqkifX7NYSGZ2s3QssiIwy39VQ4K/30eQQQZ8=;
	b=mUrchCKhZp4i/RaNmUOsMauaZuel3biq3aJHIKz0bZKV1qk/fD+AgfZIaBi9L5FYOM+P
	 OXFZEGgWUtY2u+SNeDefQtz983v0I6b5TRrju3rumHB3igKakmCc80pfdwrFEh3l+Kc0t
	 duh9U2fQMvVAZlNbMZZuWtjTCypmtAC2WvgrdoR5GbI0vpnUxiAff7+33zNb8dfsre2oo
	 O/ko261KvJO+/5Zuw8ef5R4pdJ2WC0uOSWpCUeZ9iTo6u2qjLjkKlNqMYk4keAs0A0mFH
	 40sgl1XyohNyPeIQOwc6fPFd5eS2TM+pt2W05iLpvGPbW3tySCpPJvK54HyDyq5OEtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SBpsqrlE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76781606A31A
	for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SBpsqrlE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350F81F01825;
	Sat, 24 Oct 2026 16:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792861091;
	bh=kkj0JxGqkifX7NYSGZ2s3QssiIwy39VQ4K/30eQQQZ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SBpsqrlETvUDQFAh3/KMAGAXD+MGbCOh667PYS48V1FS26MERAqClxtsSSbYfxwWw
	 B903te6Jyn8iRgh4Vo3cVIcFT7fOOxRILbcxeJ0rKlBfplerOzSu2rm1AfvFmjIq8q
	 1CXOvvK7EGhnMcAeHjzXSOVpvgRvM6nPprkuS5AJpIPfpPC+aZCLKYRPRbP09252Nj
	 D2A6o2/tXMPZfZhkQUEWlgjLsB3IZUEmlTUYbdVLzQ2liGgvjABiKIFDEZ7x7wHzFM
	 /NwQM2/FofH+HeAU7gf8yS0IG2Tf7xQHSXw2YEjpUMZin7rFD2dSFNVLV8aCRlqmie
	 Y+qPsiVD7n81w==
Message-ID: <sashiko-outbox-183808@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: apple: Avoid PERST# deassertion through gpiod
 initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janne Grunau" <j@jannau.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261024-pcie-apple-perst-gpiod-init-v1-1-f92f30f205ef@jannau.net>
References: <20261024-pcie-apple-perst-gpiod-init-v1-1-f92f30f205ef@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 16:58:10 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Commit 87620512681a ("PCI: apple: Fix PERST# polarity") switched the
> PERST# polarity by annotaing its GPIO as active low in the device tree
> via [1]. It missed to update gpiod_get()'s flags to GPIOD_OUT_HIGH
> resulting in deasserting PERST# through gpiod initialization.
> The Aquantia AQC113 10GB ethernet device used in some Apple silicon
> desktop does not finish link training with this additional PERST#
> deassert before the usual PERST# dance.
>=20
> Link: https://lore.kernel.org/linux-pci/20211123180636.80558-1-maz@kernel=
.org/ [1]
> Fixes: 87620512681a ("PCI: apple: Fix PERST# polarity")
> Cc: stable@vger.kernel.org
> Signed-off-by: Janne Grunau <j@jannau.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-pcie-apple=
-perst-gpiod-init-v1-1-f92f30f205ef@jannau.net?part=3D1

