Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296114;
	b=3VvgZQpt5vnVKpDs12lT8c3nClU2OYhxvo8U5s70GtdxX19J3V8aPjyT2SssorfaC11A
	 yNFxV4lkh1ffMPWVXQuL/esUPQLuQPi5m8HQKjjG6NzEu5RSxKwpv4jIdojDxz1PIaIR1
	 l7DltGmF55Rotu5xkVENs/SsJRkiqaCC0oXq5nnyM6EkPjjQuYpYwmMiXzMkGVl0cEOtz
	 BLSfuzeSsrOs6ghPMUxvSafaNwPM1VhxyItIi2DduTJii2vD2TrHY/TFcQJkNl4ASAbd0
	 uOTxVc5GjBJUSz8r4YEVhywPHElHfOiJl/rhl9gwg0rUkORNEge+1ywg7SFjQUkbtCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296114;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gzUz5dZW7OURo/NbKy54dPMncmSwPLDw8PnChmO1qIA=;
	b=nQTSZgWiNrENLDqPlHOHIeeba/oZdSX5v4GdfT2IXNew6WmxF1jb32y4ZxLFj3PTExWp
	 uhH9rtvB4NzK1l8xDbAUT4FGApVDYL4H312xJ1uLReYVURsjOU2g+/z6WVmhykoTHJ3C3
	 aBPBuSPR3lzD1h382V4fQg8OOhturqgmi7iR+0Y9pkLCOZQnLdu8n5bnCahCUo8PaswnJ
	 A4PhF3NiH8t3BG/V5kVD0V+gQqCnOKORNp6cQyqddyGkRCPFGHdY/GWL24w09VcEnpL8E
	 YG2H/gyVgghd3HngFCvlEA2d3+IKwcqOuhzaxHAwbof/2ehwFEclwJCRyME/mnLIu3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eF0L4L5O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E73606A32E;
	Tue, 10 Nov 2026 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eF0L4L5O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438A01F008A2;
	Tue, 10 Nov 2026 07:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794296113;
	bh=gzUz5dZW7OURo/NbKy54dPMncmSwPLDw8PnChmO1qIA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eF0L4L5OfynRZagXMqQnCSsx4X8SNqRdMMpsDrL0hPJdQO1Pmt6LUcJGInI6Hp++K
	 vGpEKoL+jPFgiIzJmtQ6a1Xr8nto73CeawwCz8FAd6lm7wU3RWczYoE0OB6ajqER4o
	 WeV4iBQ3vzenTALX/8uhZH5180xkIf6a5WZgokvIfwlrvW/eMQLaHVgaY+UIZjw0Rh
	 kBrRcAw8sxz4RsarvNNUSLpPrkCNITWGngU8XI3OrC4rf79C93xbqovMSCTeke4vzS
	 mBUQYGzn7GJmXV7Sp90dFXXGcmIKPY2bfqQLud3v7bgozoXHjyn5jQaPKJmKj85FO4
	 GMlUWXlB4XbVA==
Message-ID: <sashiko-outbox-206502@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/19] wifi: mac80211_hwsim: lock device for manual
 driver binding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261109-device-trust-core-v2-2-3b12d9a9f861@nvidia.com>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-2-3b12d9a9f861@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 07:35:12 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> The documented API contract for device_bind_driver() requires the device
> lock. mac80211_hwsim uses it for a newly created class device with no bus,
> so no automatic driver-core path can bind the device concurrently and the
> missing lock was safe.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-device-tru=
st-core-v2-0-3b12d9a9f861@nvidia.com?part=3D2

