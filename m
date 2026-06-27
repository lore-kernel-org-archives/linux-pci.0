Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ED4288D0;
	Sat, 27 Jun 2026 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782563437; cv=none; b=hsrNRCmy+KQ3P1cTS095Ex+fvaRLMVb/MFAcYH1ONfOxfXijI/d7suQKl3ogZEUU45hpmL35ImFIcneQ3GRLF4E8kCWxLjTAjLB+XTzCyXERDaM3oiyilC2ZcFSyat1TMDYpxv/CzgL4fKef2IIM05T/DWjauvl1kWahpgQ+U6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782563437; c=relaxed/simple;
	bh=hGap/kpCPZMvIo40ktmWy1wFYpPyhAZMbmUJ3ZYEmmk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JU//pxj88evc0p8scNSBAQxNfROmI2kPVl4e7ucHXGCerL8hQV8iJ81HZr36Nsq8YgxGJr+03hxLj5cAud9fs8dR6OnvO4Cg7whDFircFWh0bOl5MY0Dwa6AxplhaspgrBL5n9kdPLN2oddXnTo4ruarqXqzetHgtB5XjfXFc5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUkHy3wh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUkHy3wh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EE61F000E9;
	Sat, 27 Jun 2026 12:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782563435;
	bh=/DS6B2lidGFFhUdzPhiRiwXH58GSMkLpkOHs0LP3wM0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CUkHy3whUtLlY1Ii9Opd2fWqyQYEztFmDwF25A+znb7cECrO3yUOPF5pLM37bDwEZ
	 EDf6F2+rUVyM8qM8rtZCQDWotJdchkT8FjfTj9h3lqr8YxFIbJQSmv6cfnz4Eqd7Ok
	 Xdue9kuHSdz4TC6sv0n6c6VYSEYHEQImZt+2DRbJHnMldwHWfMKW0505UFuMfP7mvg
	 GS60UCDkWcmH5/QA+5nl92LKEOv/OpBTpGDyM+u4T0LtLf9UobJI6q3x7eWBV1wjfa
	 /Sty5dgQpnzj00iupQ2eHSQPWMqkKQJuk2oiPLg2gNCgzp3CPplJ1CuP3pFeHgUA7J
	 rwAmyUhj0b1oQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] PCI: mediatek-gen3: Add 2-lanes mode support for
 Airoha AN7581
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Marangi" <ansuelsmth@gmail.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260627121450.3529133-5-ansuelsmth@gmail.com>
References: <20260627121450.3529133-1-ansuelsmth@gmail.com>
 <20260627121450.3529133-5-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 12:30:34 +0000
Message-Id: <20260627123035.40EE61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] Modifying the `SCU_PCIC` register via syscon regmap replaces u=
nrelated bits (unintentionally asserting device resets) and races with the =
clock driver's raw memory accesses.
- [High] The dedicated PERSTOUT resets (perstout_resets) are never asserted=
 during device teardown, leaving PCIe endpoints out of reset.

Pre-existing issues:
- [High] The return value of `pm_runtime_get_sync()` is ignored, potentiall=
y leading to hardware access on a suspended device.
- [High] Early returns in `mtk_pcie_en7581_power_up()` leak the `phy_resets=
` deassert count, permanently breaking hardware initialization on probe ret=
ry.
--

commit 13851a15e592cd94ee574eb5716be89f2a065bba
Author: Christian Marangi <ansuelsmth@gmail.com>
Subject: PCI: mediatek-gen3: Add 2-lanes mode support for Airoha AN7581

The Airoha AN7581 SoC supports configuring the first PCIe0 lane to 2-lanes
mode by bonding it with the second PCIe lane. This change configures the
PCIe MUX in the SCU register and adds logic to assert and deassert the
PERSTOUT resets.

> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/co=
ntroller/pcie-mediatek-gen3.c
> index b0accd8285892..ba28d95e5d44b 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c

[ ... ]

> @@ -949,18 +965,38 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie=
 *pcie)
>  			pcie->num_lanes =3D num_lanes;
>  	}
> =20
> +	/* Map secondary PCIe for 2-lanes mode for EN7581 */
> +	if (pcie->num_lanes =3D=3D 2 && device_is_compatible(dev, "airoha,en758=
1-pcie")) {
> +		regs =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "sec-pcie-=
mac");
> +		if (!regs)
> +			return -EINVAL;
> +		pcie->sec_base =3D devm_ioremap_resource(dev, regs);
> +		if (IS_ERR(pcie->sec_base))
> +			return dev_err_probe(dev, PTR_ERR(pcie->sec_base), "failed to map sec=
ondary register base\n");
> +	}
> +
>  	return 0;
>  }
> =20
>  static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
>  {
>  	struct pci_host_bridge *host =3D pci_host_bridge_from_priv(pcie);
> +	unsigned int num_lanes =3D max(1, pcie->num_lanes);
> +	struct regmap *pbus_regmap, *scu;
>  	struct device *dev =3D pcie->dev;
>  	struct resource_entry *entry;
> -	struct regmap *pbus_regmap;
>  	u32 val, args[2], size;
>  	resource_size_t addr;
> -	int err;
> +	int i, err;
> +
> +	if (num_lanes > 2)
> +		return dev_err_probe(dev, -EINVAL, "unsupported num-lanes, maximum 2 l=
anes supported\n");
> +
> +	if (num_lanes =3D=3D 2) {
> +		scu =3D syscon_regmap_lookup_by_phandle(dev->of_node, "airoha,scu");
> +		if (IS_ERR(scu))
> +			return dev_err_probe(dev, PTR_ERR(scu), "failed to map SCU regmap\n");
> +	}

[Severity: High]
This is a pre-existing issue, but do these early returns leak the
phy_resets deassert count?

If syscon_regmap_lookup_by_phandle() returns -EPROBE_DEFER, or if num_lanes
is greater than 2, this function returns directly to mtk_pcie_setup().

mtk_pcie_setup() does an initial deassert before calling power_up:

mtk_pcie_setup() {
    reset_control_bulk_deassert(pcie->soc->phy_resets.num_resets, pcie->phy=
_resets);
    ...
    err =3D pcie->soc->power_up(pcie);
    if (err)
        return err;
}

Since the error path in mtk_pcie_setup() returns without asserting the rese=
ts
again, does this leaked reset deassert count on shared resets prevent the
reset controller from physically asserting the line on subsequent probe
attempts, permanently breaking hardware initialization on probe retry?

> =20
>  	/*
>  	 * The controller may have been left out of reset by the bootloader
> @@ -992,6 +1028,19 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3=
_pcie *pcie)
>  	size =3D lower_32_bits(resource_size(entry->res));
>  	regmap_write(pbus_regmap, args[1], GENMASK(31, __fls(size)));
> =20
> +	/* Assert PERSTOUT for all relevant lines */
> +	err =3D reset_control_bulk_assert(MAX_NUM_PERSTOUT_RESETS,
> +					pcie->perstout_resets);
> +	if (err) {
> +		dev_err(dev, "failed to assert PERSTOUTs\n");
> +		return err;
> +	}
> +
> +	/* Configure SCU MUX to disable PCIE1 for 2 lines mode */
> +	if (num_lanes =3D=3D 2)
> +		regmap_update_bits(scu, SCU_PCIC, SCU_PCIC_PCIE_CTRL,
> +				   FIELD_PREP(SCU_PCIC_PCIE_CTRL, BIT(1)));

[Severity: Critical]
Does this regmap_update_bits() call on SCU_PCIC clear unrelated bits and
unintentionally assert device resets?

By using SCU_PCIC_PCIE_CTRL (GENMASK(7, 0)) as the mask to write BIT(1),
this forces bits 0 and 2-7 to 0. Since the clock/reset driver for this SoC
uses this same register to control device resets with inverted logic
(0 =3D assert, 1 =3D deassert), does this unintentionally assert the reset =
for
the PCIE0 controller itself and other peripherals?

Also, since the clock driver uses raw readl()/writel() without a shared
lock, does this introduce a data race that could corrupt the register state?

> +
>  	/*
>  	 * Unlike the other MediaTek Gen3 controllers, the Airoha EN7581
>  	 * requires PHY initialization and power-on before PHY reset deassert.
> @@ -1024,18 +1073,6 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen=
3_pcie *pcie)
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_sync(dev);

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to ignore the
return value of pm_runtime_get_sync() here?

If runtime PM fails to resume the device and returns a negative error code,
this unconditionally proceeds to enable clocks and access hardware register=
s.
Can accessing registers of a suspended device cause synchronous external
aborts or bus faults resulting in a kernel panic?

> =20
> -	val =3D FIELD_PREP(PCIE_VAL_LN0_DOWNSTREAM, 0x47) |
> -	      FIELD_PREP(PCIE_VAL_LN1_DOWNSTREAM, 0x47) |
> -	      FIELD_PREP(PCIE_VAL_LN0_UPSTREAM, 0x41) |
> -	      FIELD_PREP(PCIE_VAL_LN1_UPSTREAM, 0x41);
> -	writel_relaxed(val, pcie->base + PCIE_EQ_PRESET_01_REG);
> -
> -	val =3D PCIE_K_PHYPARAM_QUERY | PCIE_K_QUERY_TIMEOUT |
> -	      FIELD_PREP(PCIE_K_PRESET_TO_USE_16G, 0x80) |
> -	      FIELD_PREP(PCIE_K_PRESET_TO_USE, 0x2) |
> -	      FIELD_PREP(PCIE_K_FINETUNE_MAX, 0xf);
> -	writel_relaxed(val, pcie->base + PCIE_PIPE4_PIE8_REG);
> -
>  	err =3D clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
>  	if (err) {
>  		dev_err(dev, "failed to prepare clock\n");
> @@ -1043,14 +1080,47 @@ static int mtk_pcie_en7581_power_up(struct mtk_ge=
n3_pcie *pcie)
>  	}
> =20
>  	/*
> -	 * Airoha EN7581 performs PCIe reset via clk callbacks since it has a
> -	 * hw issue with PCIE_PE_RSTB signal. Add wait for the time needed to
> -	 * complete the PCIe reset.
> +	 * Old Airoha EN7581 clock driver performed PCIe reset via
> +	 * clk callbacks since it has a hw issue with PCIE_PE_RSTB signal.
> +	 * This is now handled by dedicated PERSTOUT resets with clk
> +	 * driver only enabling the refclk.
> +	 *
> +	 * Wait is still needed for refclk to stabilize
>  	 */
>  	msleep(PCIE_T_PVPERL_MS);
> =20
> +	/* Configure all the lines to the same EQ config */
> +	for (i =3D 0; i < num_lanes; i++) {
> +		void __iomem *base =3D pcie->base;
> +
> +		if (i =3D=3D 1)
> +			base =3D pcie->sec_base;
> +
> +		val =3D FIELD_PREP(PCIE_VAL_LN0_DOWNSTREAM, 0x47) |
> +			FIELD_PREP(PCIE_VAL_LN1_DOWNSTREAM, 0x47) |
> +			FIELD_PREP(PCIE_VAL_LN0_UPSTREAM, 0x41) |
> +			FIELD_PREP(PCIE_VAL_LN1_UPSTREAM, 0x41);
> +		writel_relaxed(val, base + PCIE_EQ_PRESET_01_REG);
> +
> +		val =3D PCIE_K_PHYPARAM_QUERY | PCIE_K_QUERY_TIMEOUT |
> +			FIELD_PREP(PCIE_K_PRESET_TO_USE_16G, 0x80) |
> +			FIELD_PREP(PCIE_K_PRESET_TO_USE, 0x2) |
> +			FIELD_PREP(PCIE_K_FINETUNE_MAX, 0xf);
> +		writel_relaxed(val, base + PCIE_PIPE4_PIE8_REG);
> +	}
> +
> +	/* Deassert PERSTOUT for all relevant lines */
> +	err =3D reset_control_bulk_deassert(MAX_NUM_PERSTOUT_RESETS,
> +					  pcie->perstout_resets);

[Severity: High]
Are the perstout_resets missing from the teardown path?

Since they are asserted and deasserted during power up, does the endpoint
remain fully powered on and out of reset while the host controller's PHYs
and clocks are disabled during mtk_pcie_power_down()?

mtk_pcie_power_down() {
    clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
    pm_runtime_put_sync(pcie->dev);
    ...
    phy_power_off(pcie->phy);
    phy_exit(pcie->phy);
    ...
}

This might violate the PCIe specification and leave endpoints active, which
could lead to spurious DMA, fatal bus errors, and system lockups when
unbinding the driver or suspending.

> +	if (err) {
> +		dev_err(dev, "failed to deassert PERSTOUTs\n");
> +		goto err_perstout_deassert;
> +	}
> +
>  	return 0;
> =20

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627121450.3529=
133-1-ansuelsmth@gmail.com?part=3D4
