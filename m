Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795682576;
	b=jVtGGxGAAKgDyND4CTFZGxpwJcc5LPAkPli9lG3JmO6nYKCP3+XnbyQrDYKuugs/+kU8
	 KxjK77e11cbiJdgfzs5cIz0Zn8wpeAoLRw0xCcjZZ7PL6gLoMqJ5NwSkFePvm9daUjZtg
	 3NVqXNHaX89VMYv8ixhOT1l1Cx12Iv188r9ZfkAC+X3eAiDDiM1FyPwD5Y9Eb/opbc7Qq
	 Gq/eqHEflEPPVLTrMu/fSTVflmj5ZH+Kw5+yXCLih3PqoRx/mEme+XbfYU0L76deYcWYi
	 hszlnkJYqFkZlYDvxYBWS+SWa60o5pi3PSeWo+DFYCHMzL8hKVqvlAG+uLD/z90NiRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795682576;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SoHmeTtq8FTznN3/QpWzQejfsA/YXZN2aEmckWsCZ8Y=;
	b=E9OuPGAVTer7QLW3NFx/oDBX5nLZG7NMIVm4w0SOCKRe/9QNtELwonfJ7t2xcKEnyX+i
	 UcZsGMTVVoGuhFoJ6uSrWc4ywy8RVYFjv5BCgmLy+mQiCVFWUFR4MOh86dBTFyUrOzLXi
	 QYyyiZj1JfjX269n8ue8BG0pV0p4/QTX8YP52/5rNnV8m/W7Cf7RNJacEcVD/ehyCwMeu
	 +6UJvFojzpOaWwGfiwuWIh0/V64d65oPHSPEt1BVUhhk4F1Q8i+lVYBHgDadVgNAS0gfJ
	 80G3IqVQMf8E1EODSQj34za1Lt5Noc/TuoJwY3UtC1z0qN75pGQylAfrwa+cdlWfEIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XvYTJuK7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFD2606A329
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XvYTJuK7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0CF1F000F0;
	Thu, 26 Nov 2026 08:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795682576;
	bh=SoHmeTtq8FTznN3/QpWzQejfsA/YXZN2aEmckWsCZ8Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XvYTJuK7PFQbOyxDWDeom5f+5Va7NkxOYZDGDERjb8WKypYd5gP8QOf2f1Ehiuzaf
	 77SpHtOWRTySQE7G+qf4E4j5d4zwmsr8/f9DBsQLwM4MAIi/s8nU5VVsIeQ6ld7zpm
	 lpD+a9Nj89vpmzFE/4ZVYuXzBRps9ijlIAf6zVUe3XjO6nLfvJaYkLsCISt8Nv2sC/
	 JSaXpeAp10MoXiTMwasHSaiSGpoNTG2ftH/MvL/8d1hJUEV/69mVyDuPy/L8ZRdlRD
	 sgpKw9PhoISn4Ieyip2+Sb4opNxHCvhv13qnk+ldJr7oKHKl6S95FBSAdqLDv57Soz
	 JpYicGbFoUnRg==
Message-ID: <sashiko-outbox-235048@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: apple: Release port IRQs and domains on driver
 detach
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <liguangshuo@mail.sdu.edu.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261126-a35bb25eb5-u39-0@mail.sdu.edu.cn>
References: <20261126-a35bb25eb5-u39-0@mail.sdu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 08:42:55 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] PCI: apple: missing IS_ERR() check for port->phy in
  apple_pcie_setup_port() [1]
--

commit 102d3679b8d5966284cf3435e5c387deb0e77c02
Author: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>

PCI: apple: Release port IRQs and domains on driver detach

This commit registers device-managed cleanup actions for the per-port
interrupt domains, link IRQs, and the MSI parent domain, and wires up
pci_host_common_remove() on driver detach.

> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller=
/pcie-apple.c
> index dfd0e345bc567..79dac3fb9a05c 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
[ ... ]
> @@ -582,6 +602,7 @@ static int apple_pcie_setup_port(struct apple_pcie *p=
cie,
>  	port->idx =3D idx >> 11;
>  	port->pcie =3D pcie;
>  	port->np =3D np;
> +	INIT_LIST_HEAD(&port->entry);
> =20
>  	raw_spin_lock_init(&port->lock);

[Severity: High]
This problem wasn't introduced by this patch, but can
apple_pcie_setup_port() [1] dereference an error pointer in
port->phy when devm_ioremap_resource() fails?

Later in apple_pcie_setup_port(), port->phy is mapped without an IS_ERR()
check and then passed to apple_pcie_setup_refclk() for MMIO access:

drivers/pci/controller/pcie-apple.c:apple_pcie_setup_port() {
	...
	snprintf(name, sizeof(name), "phy%d", port->idx);
	res =3D platform_get_resource_byname(platform, IORESOURCE_MEM, name);
	if (res)
		port->phy =3D devm_ioremap_resource(&platform->dev, res);
	else
		port->phy =3D pcie->base + CORE_PHY_DEFAULT_BASE(port->idx);

	rmw_set(PORT_APPCLK_EN, port->base + PORT_APPCLK);

	/* Assert PERST# before setting up the clock */
	gpiod_set_value_cansleep(reset, 1);

	ret =3D apple_pcie_setup_refclk(pcie, port);
	...
}

If mapping the named PHY resource fails, rmw_set() in
apple_pcie_setup_refclk() will dereference the ERR_PTR() value in
port->phy and crash during probe.

[1] https://sashiko.dev/#/bug/linux-7340dc46-b98f-4a1f-909a-9ae73ed0ddc9

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-a35bb25eb5=
-u39-0@mail.sdu.edu.cn?part=3D1
