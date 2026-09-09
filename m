Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042C35237A4;
	Wed,  9 Sep 2026 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955650; cv=none; b=JsdoGY/K7Z0gfkIet9HhpPlLtwu/TUZ0ufE9di8NI+Gs3MWE1D5MHYJiW2zNgPRooP/lfUof8kzQMt20YsTRhszIlIsLbBuPQzNDzYgSVmQ+C3+H5PpoiPc/PYdg3MebqEx82PJK2HpTTipU97LnHAjLMn4E4a7lfHugPL3GNIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955650; c=relaxed/simple;
	bh=2h8XIstbQQAAwItgV1Dpxh958hOmAz/lfHtGxpdZuOc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LJ4xeUUwzLcUf6Y4XODUxDHPJT97+Y8LDj5KUbVhuDjChvtjKUOyh0LnXOtvc3qXmD3yXaftAYwRYaC96ukPKmprw4lZBISGr2mlKy4wp1nYAFbCdWkPLSV0RuXUVZENvvqy050hvEu6SUzihfZcN3NMOF0Rz6M6y9RIMM4i+dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrQSlYjs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrQSlYjs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2FC1F00A3D;
	Wed,  9 Sep 2026 12:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788955648;
	bh=eWdprPw1IAwyZg2T0oKk+X/h6rbzr2IN/8PYX7S7qQU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hrQSlYjsg7LIQ485IzaZ/UX4LsV1qN6Q8wEFsitUnwfek7GRn6yQNByh5hNkBoC0i
	 i2e0ezG7Z0oo9IcV6OvGcqIHGdqbmWdXSEDO+za6P/jPcav4mBE/AlOEo6xMET4ij3
	 uLSSVGyYZwP8Endj9LlTRN7WcAB4n1CY0lnwHMtQrjkfPcft52E/k5/9K99Mopztg4
	 rXdGg6DD+fYoQzPYkR+G+JCjYt/39/RmAdCbhEEg4SNKKbJKo0AhByzvyk/zn7AmfP
	 tulSgVpJvFgNeAXwBtW+qrnTPUqes+7hLiV3bBOSPKWLivkvtL3fbFhuA4FD/bc/DJ
	 baodBaYGJimjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] phy: qcom: qmp-pcie: Add Nord Gen5x16 PCIe
 multi-PHY support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, vkoul@kernel.org, olteanv@gmail.com, conor+dt@kernel.org, robh@kernel.org, neil.armstrong@linaro.org, linux-phy@lists.infradead.org, linux-pci@vger.kernel.org
In-Reply-To: <20260909-nord-v3-5-b0a82721c547@oss.qualcomm.com>
References: <20260909-nord-v3-0-b0a82721c547@oss.qualcomm.com>
 <20260909-nord-v3-5-b0a82721c547@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 12:07:27 +0000
Message-Id: <20260909120728.3D2FC1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] The `skip_init` logic is flawed for the existing Glymur PHY pl=
atform, leading to a guaranteed NULL pointer dereference and unintended reg=
ister corruption during initialization.
- [High] Accessing PHY PCS registers in `qmp_pcie_init()` before explicitly=
 enabling the required AHB clocks leads to a synchronous external abort.
--

commit e58c7fedd872d7c03646f577c8b3832e397473b6
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

phy: qcom: qmp-pcie: Add Nord Gen5x16 PCIe multi-PHY support

This commit adds support for the Nord Gen5x16 bifurcated QMP PCIe PHY.
It implements the PHY initialization sequencing including PLL, TXRXZ,
and PCS tables, handling PHY power domains against their own device.

> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c b/drivers/=
phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
[ ... ]
> +static void qmp_pcie_init_port_registers(struct qmp_pcie *qmp)
> +{
> +	const struct qmp_phy_cfg *cfg =3D qmp->cfg;
> +	const struct qmp_pcie_offsets *offs =3D cfg->offsets;
> +	const struct qmp_phy_cfg_tbls *tbls =3D &cfg->tbls;
> +	int i;
> +
> +	for (i =3D 0; i < cfg->num_regs; i++) {
> +		void __iomem *port =3D qmp->base[i];
[ ... ]
> +		qmp_configure(qmp->dev, port + offs->pll,
> +			      tbls->pll_common, tbls->pll_common_num);
> +		qmp_configure(qmp->dev, port + offs->pll,
> +			      cfg->pll_tbls[i], cfg->pll_nums[i]);

[Severity: Critical]
If the existing Glymur platform calls qmp_pcie_init_port_registers(), could
this dereference a null pointer? Looking at glymur_qmp_gen5x8_pciephy_cfg,
cfg->pll_tbls is not initialized and remains null.

[ ... ]
> @@ -953,6 +953,30 @@ static int qmp_pcie_init(struct phy *phy)
>  {
>  	struct qmp_pcie *qmp =3D phy_get_drvdata(phy);
>  	const struct qmp_phy_cfg *cfg =3D qmp->cfg;
> +	const struct qmp_pcie_offsets *offs =3D cfg->offsets;
> +	int i, ret;
> =20
>  	ret =3D qmp_pcie_pd_power_on(qmp);
>  	if (ret)
>  		return ret;
> =20
> +	/*
> +	 * We can skip PHY initialization if all of the following conditions
> +	 * are met:
> +	 *  1. The PHY supports the nocsr_reset that preserves the PHY config.
> +	 *  2. The PHY was started (and not powered down again) by the
> +	 *     bootloader, with all of the expected bits set correctly.
> +	 * In this case, we can continue without having the init sequence
> +	 * defined in the driver.
> +	 */
> +	qmp->skip_init =3D cfg->pll_tbls && qmp->nocsr_resets;

[Severity: Critical]
Because cfg->pll_tbls is null for the Glymur platform, qmp->skip_init will
always evaluate to false. Does this unintentionally force the Glymur
platform to attempt the port register initialization in qmp_pcie_power_on()?

> +	for (i =3D 0; qmp->skip_init && i < cfg->num_regs; i++) {
> +		void __iomem *port =3D qmp->base[i];
> +
> +		if (!qphy_checkbits(port + offs->pcs, cfg->regs[QPHY_PCS_START_CONTROL=
],
> +				     SERDES_START | PCS_START) ||
> +		    !qphy_checkbits(port + offs->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CO=
NTROL],
> +				     SW_PWRDN | REFCLK_DRV_DSBL))
> +			qmp->skip_init =3D false;
> +	}

[Severity: High]
Does reading QPHY_PCS_START_CONTROL here happen before the required AHB/APB
clocks are enabled? The call to clk_bulk_prepare_enable() occurs further
down in qmp_pcie_init().

If the clocks are currently disabled, such as during boot or after a suspen=
d=20
cycle, will accessing these memory-mapped registers trigger a synchronous=20
external abort?

[ ... ]
> @@ -1067,6 +1067,20 @@ static int qmp_pcie_power_on(struct phy *phy)
>  		goto err_disable_pipe_clk;
>  	}
> =20
> +	if (!qmp->skip_init) {
> +		qmp_pcie_init_port_registers(qmp);
> +
> +		for (i =3D 0; i < cfg->num_regs; i++) {
> +			qphy_clrbits(qmp->base[i] + offs->pcs,
> +				     cfg->regs[QPHY_PCS_SW_RESET], SW_RESET);

[Severity: Critical]
If Glymur falls into this block due to skip_init being false, it reads
from cfg->regs[QPHY_PCS_SW_RESET]. The Glymur register layout
(pciephy_v8_50_regs_layout) does not define QPHY_PCS_SW_RESET.

Can this result in reading index 0 (which maps to QPHY_PCS_STATUS) and
writing to an undefined offset, thereby corrupting the PHY register at
offset 0x0?

> +			qphy_setbits(qmp->base[i] + offs->pcs,
> +				     cfg->regs[QPHY_PCS_START_CONTROL],
> +				     SERDES_START | PCS_START);
> +		}
> +
> +		usleep_range(2000, 2500);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-nord-v3-0-=
b0a82721c547@oss.qualcomm.com?part=3D5
