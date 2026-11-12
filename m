Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794473811;
	b=jyKMlheYgef0kt4bPa5zMNYJeTgI1N8DAgu+24UqYWI/cjeyL/WjWdz+kYh4MJQXn9O4
	 uwSO3y7SPqMC9WI+195whZ6rXqSUvjRQMip3o0ArhcMmreN0tINQVjkeikCkyESqm69h/
	 LrnAHwTYQM5Fr/0gek2fWri6okRicxI6nJHjgn2fyH/OpdbyFwsJLpQMOyyI0EA+3JOG1
	 56nNsFofUGlbOwNTqk1mAtXft4BbV3pH0nLkxiXIm58XguLb2eLmEBDOg3tQMialkxpmw
	 hQtWjFpWzvH6/1UL2UpriRXCRcOQ5Vvzme+CaQNQjmGx2JUfyJGixcLIECDP6tXcuNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473811;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HiqPTSJX8vSg95r19b9jVhOijtEwmP0NTam1qD3/+eE=;
	b=eUMbkZfl3spP86H8Cmlr6xKiPRQ+Dug+1CTzjgePDzTZU1L5xvQPiZSuBTuNrv02ocmA
	 xNINW5sC/7OdMBzr4UQ+vMdIYrkIpJXvxPkYxjO6NnCC4F6BlfUlN7gxIQsFV4iehb1wU
	 er4psQ1gY845qxex6sM8U22VlpEmviGiJugGkJLslC2jC2USMdEn7mt1hl4wFoSIscWBd
	 f15YGN1ehSzj6EyD6ltmQJ2jC2PUVw8f+3pNQIIvwzpsK3KQn02rUO9MSZ/Itpq/TJJLa
	 ZwYVL2C07R1sXqBvMtAxYqFPk8kS93wKpC+3mrN8Yce5KKRxerxBHOZvBNaesFV3b6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eKd1wpNC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794E8606A8A1;
	Thu, 12 Nov 2026 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eKd1wpNC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F291F00A09;
	Thu, 12 Nov 2026 08:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794473811;
	bh=HiqPTSJX8vSg95r19b9jVhOijtEwmP0NTam1qD3/+eE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eKd1wpNCsW3U9I3ucKkq09fAidN+HqlZZv/w+TLKlPP8fgAPo3dU6OHxvnx0Qr0Nl
	 rSALCD4QchWu7NN1rzs6enaFRNPdBG6jw26LWWAgdkIZUA4GyaEUncUWDtfb9yB4kr
	 GmwCyimvjESH7sNzlM+O6Kd2y10z54TnHiA9k04yzV5WnrQFSFIS0vdl+P6egn+4N2
	 0Top1WFBHUzquncmoRrgF9dfxSOgYNPwCuxulZqjNlo4i+V3GSIo6/vX95S7/BX/Ru
	 R/zr97s6nlGE/fBckabQkgUJnOEcYKXOA850WFA/w4wE2iJTN7vJy3XBBY5fH5of2J
	 8Vd3/24Zs7tQQ==
Message-ID: <sashiko-outbox-210804@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/4] arm64: dts: qcom: shikra: add PCIe PHY and
 controller nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linghui Wu" <linghui.wu@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261112083355.3884737-4-linghui.wu@oss.qualcomm.com>
References: <20261112083355.3884737-1-linghui.wu@oss.qualcomm.com>
 <20261112083355.3884737-4-linghui.wu@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 08:56:50 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] arm64: dts: qcom: shikra: missing 4th GIC cell in pcie
  interrupt-map
- [High] arm64: dts: qcom: shikra: wrong slave and ICC tags in pcie
  interconnects
- [High] arm64: dts: qcom: shikra: missing pcie_phy clock phandle in gcc
  node
- [Medium] arm64: dts: qcom: shikra: 1-cell iommu-map entries for 2-cell
  apps_smmu
--

commit 5f4c78a483eb233ec45c85fdfcd5ba4cf541044d
Author: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>

arm64: dts: qcom: shikra: add PCIe PHY and controller nodes

This commit adds the PCIe controller and QMP Gen2x1 PHY device tree nodes
for the Qualcomm Shikra SoC.

> diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/q=
com/shikra.dtsi
> index 0a95ad5a5582c..fa9b0d41a576c 100644
> --- a/arch/arm64/boot/dts/qcom/shikra.dtsi
> +++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
> @@ -1285,6 +1285,164 @@ rng: rng@4454000 {
>  			reg =3D <0x0 0x04454000 0x0 0x1000>;
>  		};
> =20
> +		pcie: pcie@45e8000 {

[ ... ]

> +			interrupt-map =3D <0 0 0 1 &intc 0 0 0 499 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &intc 0 0 0 500 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc 0 0 0 501 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc 0 0 0 502 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-map-mask =3D <0 0 0 0x7>;
> +			#interrupt-cells =3D <1>;

[Severity: High]
Are these interrupt-map entries missing the fourth GICv3 interrupt cell?

In shikra.dtsi, &intc declares #address-cells =3D <2> and
#interrupt-cells =3D <4> (as used in the interrupts property above).  Each
entry here only provides 5 cells after &intc instead of 6, so
of_irq_parse_imap_parent() consumes the first cell of the next entry and
shifts INTB, INTC, and INTD out of alignment, causing legacy INTx mapping
for those pins to fail with -EINVAL.

[ ... ]

> +			interconnects =3D <&system_noc MASTER_PCIE2_0 QCOM_ICC_TAG_ALWAYS
> +					&mc_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ALWAYS>,
> +					<&mem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ACTIVE_ONLY
> +					&config_noc SLAVE_PCIE2_0 QCOM_ICC_TAG_ACTIVE_ONLY>;
> +
> +			interconnect-names =3D "pcie-mem",
> +					     "cpu-pcie";

[Severity: High]
Does the cpu-pcie interconnect path point to the wrong slave node and use
RPMh tags on an SMD-RPM platform?

SLAVE_PCIE2_0 (29) is a slave on &system_noc (shikra_sys_noc_nodes),
whereas index 29 in shikra_config_noc_nodes (&config_noc) is
SLAVE_PKA_WRAPPER_CFG, so cpu-pcie votes on qhs_pka_wrapper instead of
PCIe (&system_noc SLAVE_PCIE2_0 or &config_noc SLAVE_PCIE_CFG).  In
addition, Shikra uses the SMD-RPM interconnect driver (icc-rpm.c), where
RPM_ALWAYS_TAG and RPM_ACTIVE_TAG should be used instead of RPMh's
QCOM_ICC_TAG_ALWAYS and QCOM_ICC_TAG_ACTIVE_ONLY (0x3), which sets BIT(1)
and keeps active-only bandwidth voted during system sleep.

> +
> +			iommu-map =3D <0x0 &apps_smmu 0x800 0x1>,
> +				    <0x100 &apps_smmu 0x801 0x1>;

[Severity: Medium]
Should each iommu-map entry include a second IOMMU specifier cell (such as
<0x0 &apps_smmu 0x800 0x0 0x1>)?

&apps_smmu declares #iommu-cells =3D <2>, so 4-cell iommu-map entries trigg=
er
runtime warnings in qcom_pcie_config_sid_1_9_0() and of_map_id() as well as
dtbs_check schema errors.

[ ... ]

> +		pcie_phy: phy@45ee000 {

[ ... ]

> +			#clock-cells =3D <0>;
> +			clock-output-names =3D "pcie_pipe_clk";
> +
> +			#phy-cells =3D <0>;
> +
> +			status =3D "disabled";
> +		};

[Severity: High]
Should the gcc node's clocks property also be updated to reference
<&pcie_phy> at index 6 (DT_PCIE_PIPE_CLK)?

In drivers/clk/qcom/gcc-shikra.c, gcc_pcie_pipe_clk_src resolves its parent
solely through DT index DT_PCIE_PIPE_CLK (6) on &gcc:

drivers/clk/qcom/gcc-shikra.c:
static struct clk_regmap_phy_mux gcc_pcie_pipe_clk_src =3D {
	.reg =3D 0xaf058,
	.clkr =3D {
		.hw.init =3D &(const struct clk_init_data) {
			.name =3D "gcc_pcie_pipe_clk_src",
			.parent_data =3D &(const struct clk_parent_data) {
				.index =3D DT_PCIE_PIPE_CLK,
			},
			.num_parents =3D 1,
			.ops =3D &clk_regmap_phy_mux_ops,
		},
	},
};

Because index 6 of &gcc's clocks property in shikra.dtsi is still <0>,
gcc_pcie_pipe_clk_src and gcc_pcie_pipe_clk remain orphaned and never
parent to pcie_phy's clock provider.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112083355.3884=
737-1-linghui.wu@oss.qualcomm.com?part=3D3
