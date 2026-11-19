Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116563;
	b=BMXA/Yyakqd5O10nYGyMJ20foxbGqDBUOKgKVH5/0JEpq/v61LPYCMwscaanoQCQWTOd
	 W+6AfAyYRo5dn25wkrrCUCe0HBVowoX+rKfoMeNdsJtaOMoVSgbac46BdcKr6Ks963JQt
	 DAK5c6s+hmDTaQJw+c1m9NG7oDWQ3RALFGFeIbZb2Mz7dng5E70Qm1jZIV3IRA0s1EYEa
	 FhVrxMtz/QVuUCPbvnzpW0pwKXK23iBkARQAhPCYYDMfBkJbzKq+3fG2EN7Cc5Z5ficrv
	 7o1aiAYpU8Sl0XLMOMIlp9To/5mkPOr8cT1Iwz47Kf+IcroKpIoWtGoYqfolji+Vpkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116563;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=h36NijIFiLpyNcA+ZUwhHWRIm6TVs6UUJLhgbu0YExI=;
	b=qUynpWHHBkJQ0qCM4FX59OjLsmUuq3jcC5yNNA6nbyOPk+4FOTgQ6i7BFS+DqQpyD6Y6
	 GqCK7WQphALw2bzGwkkCf9YvlfZj34vCGamA8X8wgpkiAcg9hpt0YiVZBZ9JSTPAV4Djh
	 MMr0JnFNR/231BPK09tfydoQO/UIishV6pOs4yYYtoHalwuroikEnv4WgqWvM5BmPtY4c
	 P9aXIEb9IgLgeZ4gtNCS1vb4WJMTrkBxKWu2EYs91t3QddOwGvYtL5AdiCudBz87Xv1y3
	 VnYyvSNtJdUenR7sIY9Y2osHnW/82y2ISKYT5QY7W3FNB+hHiG2CNmo32rY6rsK7Tnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQ2z3c5a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38E0606A332;
	Thu, 19 Nov 2026 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQ2z3c5a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F0D1F000C5;
	Thu, 19 Nov 2026 19:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116563;
	bh=h36NijIFiLpyNcA+ZUwhHWRIm6TVs6UUJLhgbu0YExI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EQ2z3c5aAY0rUgMYJhADfnv8AchMIAFgnnLJ1hMb3poRlU7hy4R3Fm3uGDPhVf5S+
	 PU7fR0aIaGeRreQg/EYCJwKrIdDU+MA71sE/oPA1JWTMzGFXffDyDPCaXtWctD/trh
	 EBWNVPNYfNb+LX13AnwZwMONyo2yZbcFg+zwDE25o/wwJ1XfNOdk4PjSolybYnG84a
	 rmtFD1s8wGQqfQNPTJlROrl3KDiALFJcH59QhSganFj26JKEDFA4oBY5lYI5ZjLN6p
	 4RbkYkL8m3KsVg88t5uQRzYLNqR3HOj/+CpT7rgkZEgUjWaXm4f8551AOVhlWiQwFr
	 kSosB7TdlP2vw==
Message-ID: <sashiko-outbox-223889@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/31] USB: Lock interfaces during manual driver
 binding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118-device-trust-core-v3-3-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-3-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:23 +0000
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
> Driver core requires the claimed interface's device lock during binding.
> The parent USB device lock alone does not satisfy this requirement.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D3

