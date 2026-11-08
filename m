Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794148061;
	b=2H7FpD09Z5UGfWd8hhfnKHgLuacaUTD38nw45OaRJIdFpN7z9mwbPr8G0M7dh2k05Z2J
	 qVvsjRshhUEMg59uEngramkULrI94qWlfj0BPyLO8R9IRzVGBWAcEMuI22KFBsqEq3bp3
	 fAG5inWKixkG392hni4BooZYrfxUAM1ezFTrsNlXb7VnxaTUvRJeWFI+Fe6eIULFzFFbh
	 9MT0gR9c9Rc5lnljKDzSLcRS0GBo6Cr+r9reIBw9ijbEB7dVJp9TLr89KRo/9FaCNfOAI
	 VSseQTFedGf0E7m+QznH5sWxMn58vnVqVwpXP1yD9KaaxvMMUh5aKVWXjK7N+YJ5C3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794148061;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yqpXKI8YOVxitYRoRe0ql1Uh2AxWeZLFjXTUEspLiwg=;
	b=zuXrZhHI5kYEyGkhGxdlpkV7wtOSHP0ZhF/9vN0re0RxOGk+6mNCfy+ZdqZ1yc4B8N2v
	 vIXtBx5mdhLG/td1b5f4HP6zrP0aa/hLUP0vC/CWs+CB3RdTVwYl4yvE1C2c7u2BO3pr8
	 LEt1rwq1T504D8o4sa4POD0yY+kQoGX998hwyuiACP8h1F/T2eaeZ6tvjVWn56KxUuDh3
	 X62DygD5hEn0P2lJdzWK1iM3Sf9zxyFvWJVHBnnjQwTQV+1WYnJRlrbdo6is9zRIL+iKI
	 bSGShq40to7CoOlhcyGRiBMXCUqPndGOuhwuSYstco0qvGNhVAktNASa6Hwc49JnUMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TYq91gJz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80464606D805
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TYq91gJz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FA11F0089F;
	Sun,  8 Nov 2026 14:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794148061;
	bh=yqpXKI8YOVxitYRoRe0ql1Uh2AxWeZLFjXTUEspLiwg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TYq91gJzSzs9+z/JljU+HE/x3uuYDzXNrsc05M2tcthtpMB8PTODe72STNS0lATJr
	 wjgvTAfcSOCq+Ouwd4REcLXepxWmVH34RI9LVN+kSGWYaPyEZVJltxNvs94859eIZc
	 kJ118bUkPLaJt/CXCcarwsUB7NrKhoqKc5yZjXjzKrOnZ6Sl5QUqa/LzQwX8vRmpJQ
	 diSzHfdULc131hMWnDxMIZOTTA3RskS42pj36iQ3Wmb8Avr2NQctAiJLiYTZXYdNMK
	 opvvo/vBgyB/qFs3iOmMjdPyjvNXHx/VlIftOH58aDRJNTjdpv4SUqjGBRLZqV9LGC
	 e7D7rQVA0Yaew==
Message-ID: <sashiko-outbox-203799@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/7] arm64: dts: apple: t6031: Add PCIe nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janne Grunau" <j@jannau.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261108-apple-m3-pcie-v2-4-0e5ffec71da4@jannau.net>
References: <20261108-apple-m3-pcie-v2-0-0e5ffec71da4@jannau.net>
 <20261108-apple-m3-pcie-v2-4-0e5ffec71da4@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 14:27:40 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Yureka Lilian <yureka@cyberchaos.dev>
>=20
> Add the PCIe controller, its ports, IOMMUs and clock request pins to the
> die0 M3 Max/Ultra .dtsi file.
> All M3 Max and Ultra devices use port 0 and 1 so enable them and their
> IOMMU.
>=20
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> Co-developed-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Janne Grunau <j@jannau.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-apple-m3-p=
cie-v2-0-0e5ffec71da4@jannau.net?part=3D4

