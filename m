Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793185249;
	b=URpDT8D426Qnj80IIiZ0LmOlJBWemj/XLO0oiPWSbB3fzGQNoGWy6sQNQ835FMYXBdWH
	 wmF6rK2UpqZ3RRZwsthTl7tLGZv6ft8XwqJetIIHFGYFPUVqjjA6V4GKPnaFAjHpOdXT3
	 hK4CTzvYJ7v+MxcO4SrdgdPy6SMIrmMtJK0vvd1Gmvar3Maiq4gsVd0BfNiJ12ZLylm3i
	 SicNOIqNxnccuBdcGgsOeZEcbowZ88xY6DhzvXzNlpbwy4+NM03ViQY6O5qR5dvOP4QsV
	 M/W66WCsau1QKIntuQh/zZT7/A0PbD3mKCqbwi9OdBgnvcsTmBkAOOaLPhUHauirVwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793185249;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Khyj6gSp/OMmf4FbwhvvaTJboiiEjILEqGSHH4dItOI=;
	b=jaN+voEEKSTFDr7sLIsbhnMAQbDifUUCk0UMFDFIZaDjq+apakOf3srzMaMUOpakrDX2
	 GXsuKli+mqt1FMuCFV7t2AsQ4O+Y7K/HaM83AFBh0HpVKSkZLzzPlhmqiQsgwQHzi4VVN
	 gHCBFxczS555ig4qnECbVo61CAT2yYNveVYeOgviYKklR2plkk1CPwi2fSNz75zALr5fp
	 J5M35fW8Eu6OGr7sndM5++4gbIOHL+pYDFyhnPidfVjbGonok3kmHptAyQnr7wm29mb3w
	 wlTQ+TRHpmGth0Bll1TqD7QrOhQuf2kjEMHSi73oCVmaOeu9g/gnP5jBQiwREy9IOzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GImnXA9N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4176606A31C
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 11:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GImnXA9N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63BD1F01825;
	Wed, 28 Oct 2026 11:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793185248;
	bh=Khyj6gSp/OMmf4FbwhvvaTJboiiEjILEqGSHH4dItOI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GImnXA9NHja7jHdcPvlL+cMIX62TUbZPlk9SUB+NaH8TBxA6Ua5jAn7n1ZPAgU5Ei
	 gbvNcaYh6Dr3FhjZgL2Os14/Qo9yzEbeRHN8qA5J3D1K3rGxg0lnUYqBczg+uvhRUP
	 XAcWY6yBpro4qV89cxK7GFVfkZOE7duHkHZ5He5RB7igCByQMnxOoTgO4XwP5JzCwq
	 VV8734ft0OAeAvKe8gTq1XojlcyGFTAfyK7Rw3Gjhqc6FbsqRmRf8mT8m9cU8XB/x6
	 tx/9X2QGWHi7Cw3IYeUPgRZr5UtszAeP//Ey43yun8Z+VeOAzhQaNBVQckozn/B4LC
	 UWIqkuvE1nnoQ==
Message-ID: <sashiko-outbox-187784@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] PCI: mediatek: Fix integer truncation and handle
 oversized resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261028105211.2773-1-sreekuttan2156239@gmail.com>
References: <kfnxuro5xf4mhokabg773zcyp7otcjxwpzcn3dlo6y3kpv4uv4@bne4qf3vcif5>
 <20261028105211.2773-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 11:00:48 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] PCI: mediatek: oversized resource check after unmasking IRQs and=
 link-up
--

commit 1000c85227f12ca140c68660a5dc51d66a32f949
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

PCI: mediatek: Fix integer truncation and handle oversized resources

This commit uses fls64() instead of fls() when calculating the AHB-to-PCIe
translation window size order to avoid truncating 64-bit resource_size_t
values. It also rejects memory resources whose size order exceeds 31 with
-EINVAL so that the 5-bit AHB2PCIE_SIZE() field does not silently truncate
the window size.

> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/control=
ler/pcie-mediatek.c
> index 3a3e91cd0c211..6821452a82b68 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c

[ ... ]

> @@ -686,6 +687,8 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_p=
ort *port)
>  	const struct mtk_pcie_soc *soc =3D port->pcie->soc;
>  	u32 val;
>  	int err;
> +	resource_size_t size;
> +	int size_order;
> =20
>  	entry =3D resource_list_first_type(&host->windows, IORESOURCE_MEM);
>  	if (entry)
> @@ -753,8 +756,15 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_=
port *port)
>  		mtk_pcie_enable_msi(port);
> =20
>  	/* Set AHB to PCIe translation windows */
> +	size =3D resource_size(mem);
> +	size_order =3D fls64(size);
> +	if (size_order > 31) {
> +		dev_err(pcie->dev, "Memory resource size too large: %pa\n", &size);
> +		return -EINVAL;
> +	}
> +
>  	val =3D lower_32_bits(mem->start) |
> -	      AHB2PCIE_SIZE(fls(resource_size(mem)));
> +	      AHB2PCIE_SIZE(size_order);
>  	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
> =20
>  	val =3D upper_32_bits(mem->start);
> @@ -775,6 +785,8 @@ static int mtk_pcie_startup_port_en7528(struct mtk_pc=
ie_port *port)
>  	struct resource_entry *entry;
>  	u32 val, link_mask;
>  	int err;
> +	resource_size_t size;
> +	int size_order;
> =20
>  	entry =3D resource_list_first_type(&host->windows, IORESOURCE_MEM);
>  	if (entry)
> @@ -829,8 +841,15 @@ static int mtk_pcie_startup_port_en7528(struct mtk_p=
cie_port *port)
>  		mtk_pcie_enable_msi(port);
> =20
>  	/* Set AHB to PCIe translation windows */
> +	size =3D resource_size(mem);
> +	size_order =3D fls64(size);
> +	if (size_order > 31) {
> +		dev_err(pcie->dev, "Memory resource size too large: %pa\n", &size);
> +		return -EINVAL;
> +	}

[Severity: Medium]
In both mtk_pcie_startup_port_v2() and mtk_pcie_startup_port_en7528(), mem =
is
retrieved at the very start of the function, but the size_order > 31 check =
is
performed after enabling LTSSM, de-asserting port resets, waiting for the
PCIe link to come up, and unmasking INTx and MSI interrupts in PCIE_INT_MAS=
K.

During mtk_pcie_probe() -> mtk_pcie_setup(), mtk_pcie_parse_port() ->
mtk_pcie_setup_irq() registers the chained interrupt handler
mtk_pcie_intr_handler() before mtk_pcie_enable_port() is called. When
soc->startup() returns -EINVAL here, mtk_pcie_enable_port() jumps to
err_soc_startup:

drivers/pci/controller/pcie-mediatek.c:mtk_pcie_enable_port() {
	...
	err =3D pcie->soc->startup(port);
	if (err) {
		dev_info(dev, "Port%d link down\n", port->slot);
		goto err_soc_startup;
	}

	return 0;

err_soc_startup:
	phy_power_off(port->phy);
err_phy_on:
	phy_exit(port->phy);
err_phy_init:
	clk_disable_unprepare(port->pipe_ck);
	...
	clk_disable_unprepare(port->ahb_ck);
err_ahb_clk:
	clk_disable_unprepare(port->sys_ck);
}

This powers off the PHY and disables the port clocks (including ahb_ck and
sys_ck) while the port resets remain de-asserted and hardware interrupts
remain unmasked in PCIE_INT_MASK with the chained IRQ handler still active.
If an endpoint asserts an interrupt before mtk_pcie_setup() tears down the
IRQ, mtk_pcie_intr_handler() will read PCIE_INT_STATUS with the port clocks
disabled.

Could the size_order > 31 check be moved to the top of
mtk_pcie_startup_port_v2() and mtk_pcie_startup_port_en7528() right after
validating !mem, before touching the hardware state and unmasking interrupt=
s?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028105211.2773=
-1-sreekuttan2156239@gmail.com?part=3D1
