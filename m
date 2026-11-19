Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116570;
	b=Xn0QTPfa2VjHoqcQznfsoPxwDbAlpNdAKGvsPc0HpMjiaHWDJsB8d3h5I32YdH2L+LKQ
	 FOyg37/dQlhAMOTH9ZNvwhgWNJT0UbbuCDDDPDfNVgDUaoNDuWKCcZIouEMTtWDLiHWNF
	 qLlPVIHJgRYcDhnqCVUZx1kwK464Ha2sbC7mjB1EduglJeB9ZSxM4CUN0VFNL94Ltbtyz
	 r8ay7yiRxTlsg8wFStdtTisTq5j4CeNzopm3GPEbkVEuOW3QYj05xCj6w52PczP4aXAkQ
	 o2FvTRqbe3w0zQah2bRe8BogT4qMp+EK1s4wvFwyQ94D7idwoamfdvKOyLAtRh/cM6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116570;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RUryJ3QSQaM7TWyusvtzlaCqpGCuFBcs2ySD/SZ+74c=;
	b=4c88HFlI69YowSqXn9OyH1LxfG0Zjuh2rQ3AmAs6Ssi3DuRrBB8XSouoUx3C9g0p0EDF
	 JZwRcMPQ4XGPsp4JBoqUXqoUGnrmu+P1zNhBfx0vyW3HAdz6bhgV6m9+iWZ1kc5qzvrFn
	 wQqk/ORT40wRAtOLGdpeDXfOPr16uxWxgSYFhzMB6EceLdBRnlJWtumJKAs//5kp2I92o
	 KMYkFR3JMZUG9TMk3DQwKbcbR3x1+HlefApU9JlfUG0xUKe80XDZXi+A9AnvMnB2maoqY
	 1j7xVN7jOiLv7s/JkjIlcfNkVTbWTXa4800I71fHG4s3VYERFisNsYuDpnK5v9Kuc7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EwGwnbET;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F46760A3812;
	Thu, 19 Nov 2026 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EwGwnbET
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342D31F000CA;
	Thu, 19 Nov 2026 19:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116570;
	bh=RUryJ3QSQaM7TWyusvtzlaCqpGCuFBcs2ySD/SZ+74c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EwGwnbETDXGjtsmDSSM3zf12Hpb/G+UYcOndBZx4F3L5uCEEGkqWqti7rzA/6ev06
	 x+mFYhEHvgwSZ5q8ir0I0yIgBN81wQzjO0DppHRVozZDXbY4Dd8w5RwiLw+zD0vX87
	 +NuKLr0Sj58UDE2dfCR9L2Nr2F6TCzEV7eOQ+zefJ7rFR+rRn9uDDeUCi8FrAjv8dP
	 OK5q53E/03i1Wfdx6KNnBu3sjni5A0BhISncp1dvK1l5rCTlDF1gCTwkAldz92MTE7
	 GEReXqUo5ww5FxF+cbCgFM8vmRIQwiY5BIxHnzcFwTAFjBXJ9addfd7gQwG8RtwqZ1
	 HvF0/WMzuksyw==
Message-ID: <sashiko-outbox-223898@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/31] PNP: Attach card devices through the driver
 core
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118-device-trust-core-v3-12-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-12-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:29 +0000
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
> pnp_request_card_device() calls the PnP bus probe directly, bypassing
> the driver core's supplier checks and power management setup. If
> device_bind_driver() then fails to create the sysfs links, the device
> remains attached and may stay active, but the caller receives NULL and
> cannot release it.
>=20
> Use device_driver_attach() for synchronous probing with the driver
> core's setup and error handling. Preserve the card link until binding
> completes, so probe cleanup and CONFIG_DEBUG_TEST_DRIVER_REMOVE cannot
> clear or free a link still owned by the enclosing card probe.
>=20
> Fixes: bfc7ee207078 ("[PATCH] PNP: handle sysfs errors")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D12

