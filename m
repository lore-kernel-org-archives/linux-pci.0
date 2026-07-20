Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9524420C029;
	Mon, 20 Jul 2026 02:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784513890; cv=none; b=FjTalQphETdl0JN3hY4kjLQ/0qpTzqKbriwM0JPpX1i5kRPoxBOz4HJr268DXXDtGprj4nqHznU+362cNRQMWbwaLDWJUoU5xIOHpc7zj5e8FwCC1mGMDcPqH6npYE4hScBKDSz9BLE0xHydx+s9RjWRDsodWeFYyhuKhXFJLv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784513890; c=relaxed/simple;
	bh=Q8R6voTVEs2i0t0tq9FOBHYciobkHo6MLg3YH6ZLdf4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ts1S7k6H2HpmeS0t9ohNYO/RAkzbe++cY6/Pchl9SkjEpPguKTDHd3IbaYWWXjm77PoUi/tv8HhORTm+POpCI5/kCmTxzg6bqO9rmd9X+F6hOesSt3XM6UWEJFESfDM6Xw02K2eSAVW644a5Yiqj7QONecus1YAQ/GPTSwNhra8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIYobOzT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIYobOzT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26921F000E9;
	Mon, 20 Jul 2026 02:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784513889;
	bh=zNnH5MFGFZPr3emnyh8izYMrHBKBiTOTAV9kPXNgNpw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JIYobOzT7KYyJZd5vrHrFdrrPGN6ksXWxabfhOFYDo2z8BQ6DSB9PVhNiE+tCFURg
	 ihBhvolGmM795mjKajDpPy394df91kRN9MZLqENFg0pEeEZDzVLJAMTgWA581bPjGi
	 OdFIemvywk3qsJeuwKVs63s9+X7IdQr6VXf2o/qnT3s9G7leY13T1g70OFeOacEb3u
	 6fCmlq18AIDY41Qfd7EIJhyNXIi0ch9josDb0K66l210D1claxqGuQeJi1f4yYR84w
	 3GbXnMzHCwT3L5BoQVg4mKCMxa6HyTdiYXUkcdz0F6yD9shcpYTknEsVreNQ1sSxFe
	 ao8cdNjYrnrxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] PCI: dwc: rcar-gen4: Add support for R-Car X5H
 PCIe4
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org
In-Reply-To: <20260720020505.315335-6-marek.vasut+renesas@mailbox.org>
References: <20260720020505.315335-1-marek.vasut+renesas@mailbox.org>
 <20260720020505.315335-6-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 02:18:07 +0000
Message-Id: <20260720021808.C26921F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Missing `phy_exit()` call on error paths and driver teardown cause=
s a leak of PHY resources.
- [High] Missing cleanup of core clocks and reset states when `phy_init()` =
fails in `rcar_gen5_pcie_init()`.
- [High] Incorrect initialization sequence in `rcar_gen5_pcie_ltssm_control=
()` and ignored error check for `phy_power_on()`.
- [High] A 32-bit read-modify-write of `PCI_EXP_LNKCTL` inadvertently clear=
s Write-1-to-Clear (W1C) bits in the adjacent `PCI_EXP_LNKSTA` register.
- [High] Dereference of `ERR_PTR` in `rcar->phy_base` on Gen4 code paths if=
 a malformed Device Tree is provided.
--

--- Patch [5]: [PATCH v2 5/5] PCI: dwc: rcar-gen4: Add support for R-Car X5=
H PCIe4 ---
commit cab5ad82173a65768d51a17315ea45161e805bdf
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

PCI: dwc: rcar-gen4: Add support for R-Car X5H PCIe4

Add support for R8A78000 (R-Car X5H) PCIe4. The controller initialization
sequence is factored out into controller-specific callbacks. Endpoint mode
is currently not implemented for R-Car Gen5 PCIe4.

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/co=
ntroller/dwc/pcie-rcar-gen4.c
> index f88168f2df195..794c42c53380d 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c

[ ... ]

> @@ -169,6 +177,35 @@ static int rcar_gen4_pcie_speed_control(struct rcar_=
gen4_pcie *rcar)
> +static int rcar_gen5_pcie_speed_control(struct rcar_gen4_pcie *rcar)
> +{
> +	struct dw_pcie *dw =3D &rcar->dw;
> +	u32 lnkcap =3D dw_pcie_readl_dbi(dw, EXPCAP(PCI_EXP_LNKCAP));
> +	u32 lnksta =3D dw_pcie_readw_dbi(dw, EXPCAP(PCI_EXP_LNKSTA));
> +	u32 val, retries;
> +
> +	if ((lnksta & PCI_EXP_LNKSTA_CLS) =3D=3D (lnkcap & PCI_EXP_LNKCAP_SLS))
> +		return 0;
> +
> +	/* Retrain link */
> +	val =3D dw_pcie_readl_dbi(dw, EXPCAP(PCI_EXP_LNKCTL));
> +	val |=3D PCI_EXP_LNKCTL_RL;
> +	dw_pcie_writel_dbi(dw, EXPCAP(PCI_EXP_LNKCTL), val);

[Severity: High]
Will this 32-bit read-modify-write access unintentionally clear Write-1-to-=
Clear
(W1C) bits in the adjacent PCI_EXP_LNKSTA register?

Since PCI_EXP_LNKCTL (offset 0x10) and PCI_EXP_LNKSTA (offset 0x12) share t=
he
same 32-bit Dword, any W1C bits set in the Link Status register will be rea=
d as
1 and written back as 1, clearing them. Could a 16-bit accessor be used ins=
tead?

> +
> +	/* Wait for link retrain */

[ ... ]

> @@ -284,6 +321,44 @@ static int rcar_gen4_v4h_v4m_pcie_init(struct rcar_g=
en4_pcie *rcar)
> +static int rcar_gen5_pcie_init(struct rcar_gen4_pcie *rcar)
> +{
> +	struct dw_pcie *dw =3D &rcar->dw;
> +	int ret;
> +	u32 val;
> +
> +	/* R-Car Gen4 and Gen5 common initialization. */
> +	ret =3D rcar_gen4_pcie_common_init(rcar);
> +	if (ret)
> +		return ret;
> +
> +	/* R-Car Gen5 specific additional initialization. */
> +	ret =3D phy_init(rcar->phy);
> +	if (ret)
> +		return ret;

[Severity: High]
If this fails, do we need to clean up the resources just initialized by
rcar_gen4_pcie_common_init()? It looks like returning the error directly le=
aves
core clocks enabled and resets unhandled.

[Severity: High]
Since phy_init() is called on the successful initialization path, shouldn't
there be a matching phy_exit() in the deinitialization paths (such as
rcar_gen4_pcie_common_deinit) to prevent leaking PHY resources when the dev=
ice
is unbound?

> +
> +	dw_pcie_dbi_ro_wr_en(dw);

[ ... ]

> @@ -321,8 +396,11 @@ static int rcar_gen4_pcie_get_resources(struct rcar_=
gen4_pcie *rcar)
>  	struct device_node *root_port;
> =20
>  	rcar->phy_base =3D devm_platform_ioremap_resource_byname(rcar->pdev, "p=
hy");
> -	if (IS_ERR(rcar->phy_base))
> -		return PTR_ERR(rcar->phy_base);
> +	if (IS_ERR(rcar->phy_base)) {
> +		rcar->phy =3D devm_phy_get(dev, NULL);
> +		if (IS_ERR(rcar->phy))
> +			return PTR_ERR(rcar->phy);
> +	}

[Severity: High]
If the device tree lacks the phy memory region but provides a phys node,
the fallback devm_phy_get() succeeds, leaving rcar->phy_base containing an
error pointer.

Later on, if Gen4 code paths like rcar_gen4_pcie_ltssm_control() execute,
they unconditionally call rcar_gen4_pcie_phy_reg_update_bits():

rcar_gen4_pcie_phy_reg_update_bits()
	tmp =3D readl(rcar->phy_base + offset);

Can this dereference the error pointer and crash? Should rcar->phy_base be =
set
to NULL after falling back to devm_phy_get()?

> =20
>  	root_port =3D of_get_next_available_child(dev->of_node, NULL);

[ ... ]

> @@ -743,6 +821,28 @@ static int r8a779f0_pcie_ltssm_control(struct rcar_g=
en4_pcie *rcar, bool enable)
> +static int rcar_gen5_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, boo=
l enable)
> +{
> +	u32 val;
> +
> +	val =3D readl(rcar->base + PCIERSTCTRL1);
> +	if (enable) {
> +		val |=3D APP_LTSSM_ENABLE;
> +		val &=3D ~APP_HOLD_PHY_RST;
> +	} else {
> +		val &=3D ~APP_LTSSM_ENABLE;
> +		val |=3D APP_HOLD_PHY_RST;
> +	}
> +	writel(val, rcar->base + PCIERSTCTRL1);
> +
> +	if (enable)
> +		phy_power_on(rcar->phy);
> +	else
> +		phy_power_off(rcar->phy);
> +
> +	return 0;
> +}

[Severity: High]
Is it expected to enable the LTSSM and drop the PHY reset before calling
phy_power_on()?  Normally, wouldn't the PHY need to be powered and stabiliz=
ed
before activating the MAC's LTSSM?

Also, if phy_power_on() fails, shouldn't we handle the error instead of
unconditionally returning 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720020505.3153=
35-1-marek.vasut+renesas@mailbox.org?part=3D5
