Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC163488203;
	Mon,  7 Sep 2026 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781378; cv=none; b=bL9VMHV1wqWDvo+4RJtjS9x3iYcFVYelb8xG+cx+SD1fuG0AiEDhqzbcG2h0O9j9aGX2cagec9v5WoHSRvretdtA7uENIbEOmT9isWdeHuZdbiopoAV7OGJjB8hfWd4vGrUvZUiT5xrAV5aEDtnfSDB39zFTE4RTjtWtzqyC1Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781378; c=relaxed/simple;
	bh=reDJkJ7z06+YK/IQdl9LU4uF5c8tXC4hRMoq+qrkI1s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fUGphD4lVhrsObcVoKe85lAIOki/jCrXSqEGt7W8zMncT4uM2Aej3l3Wm1RkPOHg3dcsBS/DZbh3ovqSR3uL0gwscrNH/FkgugUxl0wM6dSTUHNz4EVaA7oGN25E91Qn/PEorLdJNxhMUGbTsZjk5SbeZgM4SyotGJtd27EDH7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSsOlENa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSsOlENa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3272E1F00A3A;
	Mon,  7 Sep 2026 11:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788781376;
	bh=UqnEq31sSNYoYSTUtusIoxJGMAgU1MoKX+UAJt6VELA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XSsOlENanPmFF5rx69ZI3f5TnvlCz55YY1l8M+h1Cew23PtNWf0SjJSCqYvgRevqG
	 uYHg01chFIsyxKfJkCKZrK1xsjQwyY8sDX+Ihar3z35QOdg7g/3OC9+jaBf92vFnjQ
	 iu6olk8pC+4u3Xqq/6jm+xFQvhxrpncn7xNjDR/QKLZZornM7mNJzJe643rARv6SgQ
	 kqwK/PDq6F4Gc168SrqX+AIiry3YEhYc1ts2Pg2jtRYqIduvkHAafzIXVxnKzNPJTH
	 BbJdoRSn4ep3wfQLCIQsbSdNUNHEKDYfHKglXK1pee5nSLJ/M8dm2nG07DC9MdPm02
	 qoTblEwedDalw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/6] PCI: spacemit-k1: Add Spacemit K3 PCIe host
 controller support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260907112606.465778-7-inochiama@gmail.com>
References: <20260907112606.465778-1-inochiama@gmail.com>
 <20260907112606.465778-7-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 11:42:55 +0000
Message-Id: <20260907114256.3272E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Incorrect PCIe Gen3 Equalization Preset Request Vector assignment.
- [High] The driver accesses link MMIO registers before peripheral clocks a=
re enabled, causing a bus fault.
- [Medium] The error path in k3_pcie_init incorrectly de-asserts PERST#, fa=
iling to safely reset the device.
- [Low] Use of undefined PHY bulk API functions causing build failure.
--

commit 63c719f7a87ffea307709340b4548f687247044d
Author: Inochi Amaoto <inochiama@gmail.com>
Subject: PCI: spacemit-k1: Add Spacemit K3 PCIe host controller support

This commit adds driver support for the PCIe controller on the Spacemit K3
SoC. The controller is similar to the Synopsys DesignWare PCIe IP but adds
support for an external MSI interrupt controller and multiple PHYs.

> diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/=
controller/dwc/pcie-spacemit-k1.c
> index c610b367412aa..5031b688fdab0 100644
> --- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
[ ... ]
> @@ -303,6 +316,116 @@ static int k1_pcie_parse_port(struct k1_pcie *k1)
>  	return ret;
>  }
> =20
> +static int k3_pcie_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> +	struct k1_pcie *k1 =3D to_k1_pcie(pci);
> +	u32 reset_ctrl =3D k1->pmu_off + PCIE_CLK_RESET_CONTROL;
> +	u32 val;
> +	int ret;
> +
> +	regmap_clear_bits(k1->pmu, reset_ctrl, LTSSM_EN);
> +
> +	k1_pcie_toggle_soft_reset(k1);
> +
> +	/* K3: Set IGNORE_PERSTN and drive PERSTN_OE high (assert reset) */
> +	regmap_update_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
> +			   PCIE_IGNORE_PERSTN | PCIE_PERSTN_OE | PCIE_PERSTN_OUT,
> +			   PCIE_IGNORE_PERSTN | PCIE_PERSTN_OE);
> +
> +	ret =3D k1_pcie_enable_resources(k1);
> +	if (ret)
> +		goto failed_resources;
> +
> +	regmap_set_bits(k1->pmu, reset_ctrl, PCIE_AUX_PWR_DET);
> +	regmap_clear_bits(k1->pmu, reset_ctrl, APP_HOLD_PHY_RST);
> +
> +	ret =3D phy_bulk_init(k1->phy_count, k1->phys);

[Severity: Low]
Does phy_bulk_init() exist in the mainline kernel? It seems this API might=
=20
be missing, which could cause a build failure here.

> +	if (ret)
> +		goto failed_phy;
> +
> +	msleep(PCIE_T_PVPERL_MS);
> +
> +	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
> +			PCIE_PERSTN_OUT | PCIE_PERSTN_OE);
> +
> +	val =3D dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
> +	val =3D u32_replace_bits(val, BIT(7),
> +			       GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);

[Severity: High]
Does this assignment set the correct equalization preset? BIT(7) evaluates=
=20
to 128 (0x80), which when inserted into the 16-bit preset request vector=20
field, assigns preset 8 to Lane 1 and 0 to all other lanes. Could this=20
cause PCIe Gen3 link training to fail or use incorrect presets?

> +	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, val);
> +
> +	k1_pcie_set_device_id(k1);
> +
> +	/* Finally, as a workaround, disable ASPM L1 */
> +	k1_pcie_disable_aspm_l1(k1);
> +
> +	return 0;
> +
> +failed_phy:
> +	k1_pcie_disable_resources(k1);
> +failed_resources:
> +	regmap_update_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
> +			   PCIE_PERSTN_OUT | PCIE_PERSTN_OE | PCIE_IGNORE_PERSTN,
> +			   PCIE_PERSTN_OUT | PCIE_PERSTN_OE);

[Severity: Medium]
In this error path, PCIE_PERSTN_OUT is set high, which appears to de-assert
PERST#. Should this be clearing PCIE_PERSTN_OUT instead, to ensure the=20
endpoint device is safely held in reset after initialization fails?

> +
> +	return ret;
> +}
[ ... ]
> +static int k3_pcie_parse_port(struct k1_pcie *k1)
> +{
> +	u32 status0, status1, status2;
> +
> +	/* This register require a RAW for cleanup */
> +	status0 =3D readl_relaxed(k1->link + K3_PHY_AHB_IRQSTATUS_INTX);

[Severity: High]
Can this unclocked read cause a bus hang or synchronous external abort?=20
k3_pcie_parse_port() is called unconditionally during k1_pcie_probe():

k1_pcie_probe()
  data->parse_port() -> k3_pcie_parse_port()
  ...
  dw_pcie_host_init()
    k3_pcie_init()
      k1_pcie_enable_resources()

It looks like the peripheral clocks are not enabled until=20
k1_pcie_enable_resources() is called later in the host initialization.=20
Reading the k1->link registers before the clocks are enabled might fault.

> +	status1 =3D readl_relaxed(k1->link + INTR_STATUS);
> +	status2 =3D readl_relaxed(k1->link + K3_ADDR_INTR_STATUS1);
> +
> +	writel_relaxed(status0, k1->link + K3_PHY_AHB_IRQSTATUS_INTX);
> +	writel_relaxed(status1, k1->link + INTR_STATUS);
> +	writel_relaxed(status2, k1->link + K3_ADDR_INTR_STATUS1);
> +
> +	return k1_pcie_parse_port(k1);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907112606.4657=
78-1-inochiama@gmail.com?part=3D6
