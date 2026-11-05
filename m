Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793894333;
	b=eupjeeb6lx3mFIRdhlbF38xZL9xmS6PKnrXfJFQseBuLwKjNWhiSUUHsQNutMw1pS9dd
	 MTsKHA7phoeo1x4evpLsC+s5pVVXLqFKGJv7GaiaI0cM/2Jw7IUkCbn1rJjgFz70FwSfH
	 mJHT1iNHtnSYT1bnCHz5sBjhJCVuaKwd2Q0McSDlSff+ANSSpFlzDIyqa0O4Xc5iPz+aA
	 tyMJZur81xewHN0oZD1WX6+iwrVHU4tGhn+CAJVrZ7TkERh6jh9fCyjAk+zmZ0IDfJkgH
	 pbRUVjTfHfAHd1D9drRmIlnXOMuwBC8lYPFUzYvRnqHMsRo2PZw7VQDBdo+nH3azaxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894333;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5tjnXd5miiAneuEH8BPoZReeVbxwEsi+MDeKDUIY9OI=;
	b=ykem0Vok2YYfqplTcJxKrYhCbRrmWEIM3uZ6WjYSE1vYsC9gYcFqbOOsrQ5JM+J0DQSF
	 JWkBdSv1IzDozxqSyy6Z1VbwJOjH91RGkfz9sBVyWvZGCiBrw3fgsNh8P7ThBH6+njog+
	 CqJLGbmlruOkkgohYw072dg8ZSFX56UocUss8DSjhKe80AlDvrCFey64PI9wrzEVkjEz8
	 sfa/NhSyR1DeT6XwtPQWLuXMAu1GUpLRM0OF15kQ5FFziF02sGzPxLXYZO5mgJzi76A+l
	 D04Tbwd4t0OfueiXWe0KgB6L4o340Yt6PYLB1xrZ3RKmrS1fSwsirrkNcnoud5VQfOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EScvWxTZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8922A606A61A
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EScvWxTZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF081F00919;
	Thu,  5 Nov 2026 15:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793894333;
	bh=5tjnXd5miiAneuEH8BPoZReeVbxwEsi+MDeKDUIY9OI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EScvWxTZUbINkNcADXmiSOCjEkw8WeUnT/UO3Eq/BaM5sWdb8wbzwrrnVrQwxxQfV
	 ywqgYZCSXQn/h7ZcwMVNn+k5jHuWFp8OMjHwct60QcSKfW7QeT/HI/S4wlFUosri7s
	 +6HSx5bFNlnzKwef74mNpYkNV2qkRrc9Fa8WVmj9hYfmbr2kfUBSYziNPHg2A99NbZ
	 k4jMVo5v4v+jY4RmPWOf4l181gH88QuxUP1ccX4/2XDPIPDMYJVtVRtArFbCQf8CuP
	 Tha8CryoMu+dzv4dOl2u7+jDVaQaxl9mGcPQuF0JFJXEm+ZsCjukZdvn+vg5+MI+GE
	 wrc06EjeV2vNg==
Message-ID: <sashiko-outbox-199391@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 05/10] cxl/test: Use fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103155540.365294-6-herve.codina@bootlin.com>
References: <20261103155540.365294-1-herve.codina@bootlin.com>
 <20261103155540.365294-6-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 15:58:52 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The code set directly fwnode.dev field.
>=20
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103155540.3652=
94-1-herve.codina@bootlin.com?part=3D5

