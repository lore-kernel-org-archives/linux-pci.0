Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878819;
	b=P7OnvkDwxWKHOYAMWN+i2/gdhS5obw1FqPnDk4NO0uHtNjGDDpnyFINwbHANgQ485nVq
	 m98J3TwWo5Na6uYmuogLYm2hvLHUNYmVNlnh04S6ZnjsCAnVkLXkE0xPpjwrootFZdJox
	 GMJowwAl6UrPx8KXJVahm8NQf16vDGm1yRxMvtEiNFOuFH4TjVQE3umuLGofXG4AS54E8
	 siLbRHKryL0jVoYFrA6mYx4+Vd4nyY565i2nqI6ocw9sPqbpwsh04z5BiTfPeRADgJd/W
	 PgDECWk6mbDDhqcMKnI/3GWNN3pgejNx3bkB8W0FIgkqJ5W3UgGF59Fa7gC5GFCQlXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878819;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WzueLFxT1nKvjG3yBT6rMMXMk+clNtTs+yZH/n98ULg=;
	b=1/R/5/l0vHo4N8qvPBxN7V7R/xD9rTVD23IvBzu4BN2swsIxwYW32rGfhiIDZzJY1c0u
	 GsjjfB4XL1VTr3IpyEs2eXmRjRbn/S8SaGyH5gkSCM2tmZj0dmxyOt736GGT0oB+qznmN
	 W84dsa8aXmjbFPcySM7VOE+1gs5eX3TTjCFaD0c8s+WP3hOGcKvrHmGbYaLgZ6mkiwF4W
	 xTE1OoFSPXZtNs4iY1MNSsGhl+hvScumKbSAuqbVOjqmKwqTSpb3oQlPKPozU0iMqfE4d
	 sYMUa/5C4b9UbDEK120d7mwAxekr1ldirfp+NFCiZkb5an3sgVQbTloat6gP8ckRc9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bSnF+G5v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03D6606A31B
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bSnF+G5v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF1C1F00919;
	Thu,  5 Nov 2026 11:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793878818;
	bh=WzueLFxT1nKvjG3yBT6rMMXMk+clNtTs+yZH/n98ULg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bSnF+G5v46YVLLiaPmjcFiPUhh8RYPnr1Rz8XXbP/9HwnrZknpPmJQ65n2x3lj9/C
	 CpUY0MZ3kwPrUR+vsZOlb1LkEpArpedrJEJU9JeD2IWQZGg8afEA5k/e6hV8QclPzj
	 oEhXNnghGgTgnpn+WZzsKqQLIzKFn92/rlY6aFerVQHgKQ/A/jrFHmOC/o9xeJeOuR
	 ICPVbXDpqh0Jt3+zaeb+i3MT/gSIl9m/DA9dYFdj7Vk+WP2abbNG8vaFw7Jy09gBty
	 D1FTGXXdIaKBBy800ga+JaoCayVbu0fgJ7Xe8oXobAamge/1jkst0Mdx5mriMju2ge
	 C4KkhJ6vbwhjw==
Message-ID: <sashiko-outbox-198965@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] arm64: dts: apple: t6030: Add PCIe nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janne Grunau" <j@jannau.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105-apple-m3-pcie-v1-3-e00a72a604f8@jannau.net>
References: <20261105-apple-m3-pcie-v1-0-e00a72a604f8@jannau.net>
 <20261105-apple-m3-pcie-v1-3-e00a72a604f8@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 11:40:17 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Add the PCIe controller, its ports, IOMMUs and clock request pins to the
> base M3 Pro .dtsi file.
> M3 Pro is only used in 14 and 16-inch Macbook Pro which connect PCIe
> devices to the port 0 and 1.
>=20
> Signed-off-by: Janne Grunau <j@jannau.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-apple-m3-p=
cie-v1-0-e00a72a604f8@jannau.net?part=3D3

