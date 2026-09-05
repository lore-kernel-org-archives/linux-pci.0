Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BFB165F1A;
	Sat,  5 Sep 2026 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788644418; cv=none; b=a7ok6rFPSrp3Yh0I3Vx/an17cU4cGpC8pU7STgXGnH0JLOo9yAn9VFu6/1wa4EI4yT8oX+djuadvDe2xpiB++Vha19Z9uGluicJi5eFYBiGA9FrwQfOkxExyw7uCNt6y7GH4VDk2EblSPzHtfP4sb1gAjA1D5rYn+6FYnOV+D7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788644418; c=relaxed/simple;
	bh=PQ8XCw+nMn6cgBaYM6+ME7fEQrdlwLcb3v+QU1aeOOg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EBDHU2gD1X0YLzySF5S8oXx7xpDDQ9x8c1xAAm0KEy4x1iYpG2BfAQx2P+TT5/rmPT7Wv5fkQ4Rb/idG7TSJmm9lOK6ENE4LpzBQZEOT3LeZJC6lPSNO5lrSTFKidaec7JzAen0wCmobiSC+zO3kjQDQwJ/7T/qrxw8J5xX5MXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIoM+ueC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIoM+ueC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BFB1F00A3A;
	Sat,  5 Sep 2026 21:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788644416;
	bh=NRNcumgUH1q6xDkKLI0xZmCci3vzXOnqUAzWemKFqWY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BIoM+ueCgBv7F3wUefXUQKRBFQyHCqmdHkidwQzZe3RkVRBe+PFUCC/QbTFl6joRd
	 WO0hdH/ABFZOYDGJU66RV5+jrMRfUm6UkJePMOmPcUy53mWiPnh1h5Qvmhbr8uB1uK
	 bRl7tbJ/j1xza0/Lq5hrWfxNEnOeUVqmFONTJmk+HYCEahlY9EQhByiFZrom455r11
	 76hu0vu9xuQZ74LzsOEIZjK7AhOd9gMcCtvbUcqJ6WqDAhEakZ7xAadCLIbT/SDcPk
	 AdymThw5sxoiOmJtJHyhCQGcT1ijDU/TAdKdaeKnoE2ZocDiM5FWtIomvYgEiupYF0
	 owAzhAZ59027Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/6] PCI: dwc: rcar-gen4: Add support for R-Car X5H
 PCIe4
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260905212649.360498-7-marek.vasut+renesas@mailbox.org>
References: <20260905212649.360498-1-marek.vasut+renesas@mailbox.org>
 <20260905212649.360498-7-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 21:40:16 +0000
Message-Id: <20260905214016.86BFB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Incorrect PHY power-on sequencing and unchecked return value in rc=
ar_gen5_pcie_ltssm_control().
- [High] The driver fails to configure the dw-edma core for HDMA on Gen5, b=
reaking the commit's claim of HDMA support.
- [Medium] Missing assertion of DW_PCIE_PWR_RST on the error path of rcar_g=
en5_pcie_init() leaks hardware reset state.
--

commit 33f1bd3dbda597464a41cce7e19a3d761ff8b7c8
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

PCI: dwc: rcar-gen4: Add support for R-Car X5H PCIe4

This patch adds support for the R8A78000 (R-Car X5H) PCIe4 controller,
differentiating it with the "renesas,rcar-gen5-pcie4" compatible string.
It implements Gen5-specific initialization, deinitialization, link speed,
and LTSSM control callbacks, and handles a separate PHY driver instance.

> The R-Car X5H PCIe4 controller embeds HDMA instead of EDMA embedded
> in the R-Car Gen4 PCIe controller, "dw-edma" driver supports both
> DMA variants.

[Severity: High]
Does the driver actually configure the dw-edma core for HDMA on Gen5 hardwa=
re?

Looking at rcar_gen4_pcie_alloc() elsewhere in the same file, the DMA mode
appears to be unconditionally hardcoded:

rcar_gen4_pcie_alloc() {
    ...
    rcar->dw.edma.mf =3D EDMA_MF_EDMA_UNROLL;
    ...
}

Since this mapping format is never updated for Gen5 controllers (e.g., to
EDMA_MF_HDMA_NATIVE or EDMA_MF_HDMA_COMPAT), will the dw-edma driver attempt
to program EDMA registers and descriptors instead of HDMA, causing DMA
operations to fail on Gen5?

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/co=
ntroller/dwc/pcie-rcar-gen4.c
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
[ ... ]
> @@ -285,6 +322,49 @@ static int rcar_gen4_v4h_v4m_pcie_init(struct rcar_g=
en4_pcie *rcar)
[ ... ]
> +static int rcar_gen5_pcie_init(struct rcar_gen4_pcie *rcar)
> +{
[ ... ]
> +	/* R-Car Gen4 and Gen5 common initialization. */
> +	ret =3D rcar_gen4_pcie_common_init(rcar);
> +	if (ret)
> +		return ret;
> +
> +	/* R-Car Gen5 specific additional initialization. */
> +	ret =3D phy_init(rcar->phy);
> +	if (ret)
> +		goto err_unprepare;
[ ... ]
> +err_unprepare:
> +	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
> +
> +	return ret;
> +}

[Severity: Medium]
Does this error path leak the hardware reset state?

rcar_gen4_pcie_common_init() successfully deasserts the DW_PCIE_PWR_RST
reset control before returning. If phy_init() subsequently fails, the
code jumps to err_unprepare, which disables the core clocks but leaves
the reset deasserted.

Should this error path also include a call to reset_control_assert() to
balance the state?

[ ... ]
> @@ -807,6 +897,28 @@ static int r8a779f0_pcie_ltssm_control(struct rcar_g=
en4_pcie *rcar, bool enable)
[ ... ]
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
Does this sequence start link training before the PHY is properly powered
on and stabilized?

By writing APP_LTSSM_ENABLE to PCIERSTCTRL1 before calling phy_power_on(),
the controller might attempt training with an unpowered PHY.

Also, is it safe to ignore the return value of phy_power_on() here? If the
PHY fails to power on, the function still returns 0, leaving the controller
in a broken state with an unpowered PHY.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905212649.3604=
98-1-marek.vasut+renesas@mailbox.org?part=3D6
