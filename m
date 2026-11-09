Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258697;
	b=kEjeg87/GWIXR5S0CsqoxwJXI5ssynEQzyXPi94wjt3eQYYpvbHUUJe3S+NHXFZGLWGB
	 kmUU2cKlvLHNOMf9Q4x12oAjrDsk2pOap4TjKDFMpVbf8mX8NUSH89rtZAbv5zghVK14T
	 v25Ba4DypQwEjCQViOmP/hb5ztmn4CdhrI/Askg3qzUsJHGn7bju/gRCerjtjeTfibhrE
	 vADBKrnidXvI1v+Y9EuoBzj6YeV6t8EWFOszMqRtU9JKFj23w6aEePs7Z7qX/UNkqO4rz
	 UiDg8mNEq/OGGcM+MOTWcwM8t7fGZENsFp+6VlzJvVD/PP1vpnzjMKL1KdcTCzD3lrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258697;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LkEeprvfsD7+YwEceixtlz02e16Be6K1p8AumR9Je/w=;
	b=GBbb2StEwQM5Fm7bl1mT1XO7/9KpD81/+LAvidvdtPSqd1tgVNutw+W700v1WEQFc5DD
	 ipFzb35jNzqYS1V5HTZ4HmGAFWA9RssfZbt5bG4MgRr1Fn3sDfvU8TCBsa6CEANYdKq8Z
	 BlTzv3fOJ5ceHU80TjjBBX+3rLiKUTxGHiW4ZcMtrACTHzcGVRvgbuc9sx4+MOIHtZeoK
	 Co2LPO2uKRSDzBhOPCJonTf1UFWbLwUGI6jVvEG3wOqcTiXJ9NpPNs37xMvaH1QIBQS8n
	 RCqXUsN7h5P21ThKO3MJEOjl64qwqCFYD24BLuZ3XF2rUgIlwI4lGxa32YDNyP7/I4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gP9/4fjY";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227C5606A321
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 21:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gP9/4fjY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F52F1F0089F;
	Mon,  9 Nov 2026 21:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794258696;
	bh=LkEeprvfsD7+YwEceixtlz02e16Be6K1p8AumR9Je/w=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=gP9/4fjYMFwzqPIlv7OLVGJuRMU5eqekZdFzJq3mjgru1hWVaAWDVMp9OofqXxrLA
	 z2Nx8tufN2AAXA5M3IJksuQzomKPo0K/cbwrsYOzTCp8/rJ5avqwmJmHgbH6hCz4WO
	 bTKsLRoiVzxFEY36vUZ31TvXfSy3XgWMhVDK6Hq2dTogGpctIhNh2UB7GZYxscFlyO
	 C5uXl/tV/U2T9G/aTzuJ08UzSnfEDssKA/wuEW+UtMzfKHoXVaWI0vpaeTM6OQcCs0
	 ERli9IKfeUU+w2+uc0FeXCm+18kaI1++1LptnWKmokDMkIcn85I/ShOpdR7K3Z7Yap
	 lKalvYI4U/WHQ==
Message-ID: <sashiko-outbox-205638@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/11] mmc: sdricoh_cs: Depend on CARDBUS
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261109210714.3862-7-ilpo.jarvinen@linux.intel.com>
References: <20261109210714.3862-1-ilpo.jarvinen@linux.intel.com>
 <20261109210714.3862-7-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 21:11:36 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> sdricoh_cs accesses the SD controller through the PCI device of the
> Ricoh RL5C476 CardBus bridge. An upcoming change makes the PCI core
> ignore CardBus bridges when CONFIG_CARDBUS is not set, so the driver
> would no longer find the controller.
>=20
> Make MMC_SDRICOH_CS depend on CARDBUS.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109210714.3862=
-1-ilpo.jarvinen@linux.intel.com?part=3D6

