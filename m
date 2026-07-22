Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E54376A13;
	Wed, 22 Jul 2026 03:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784690421; cv=none; b=nH+t6KvvzHS4w7aPUlCDuY+OLoZDf2vfcGe4zUnuL60Dz9MVjlcg140/wxV2SzptNJ5grCDX7bzCX9h9T/MuQ8lU9SxP2TPaP0T5JpyjA8h0VsUFf5npUnxpFMNKbsgBzaJa4cWqK13HwtAkUFFtgrlZLg42OIPUfrtWv64A09M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784690421; c=relaxed/simple;
	bh=YYsk06+SC2GGgso4AXbY4/Xlse3qgK6z9B097IGwelI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ORCXPQmugF10CpvMUtT+wcgB090u3a1eUrZ4Zix/j0fTP7/BtLdsgUnTh3shoitxxQQAwArUHkvxrXyRd1fIPykn0xYdE3KPpmtqYMYGqeyXOlnSkT9LuJpD23DLom2QDup4PYd7lLLqQhJYmj2iINXOavnrwVUTG/w0ZCXFckg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTSyvELP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTSyvELP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70091F000E9;
	Wed, 22 Jul 2026 03:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784690420;
	bh=f5vlXSHvUu6X9bMg56VRITG7Px3L4OM4EGYWMiE44wY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eTSyvELPzq+B/jRPpsetOX6aGDjSVzUt6IHR7dH8QgcvxfZm4Qr30SRqupAxbnN03
	 lUVlTleMMrg59yBPKZvD4/R/xT2XhtRKpP+yMsASUmsJYYouPHFz4r1F0DGpP1ANZ4
	 z3g6Jr3p3lZQM3G7DccW/GSo7jSXMvOYAmVgxA2Z+M9u4I2jGMfVUrTrbB7skj/+Mm
	 lPvWsTkTu5sU0BGnubLRQxKC47Pg0TF/TrsW5IDdoVT9z8XisArRYhpsp3pnoKK6Wb
	 kMX5JzVN4jyaDTGwlwASX5E9e8qqtlu4tdHAKckRzhpZ5itGV+aMSkiZwA3kBculcA
	 cNR7WGuCRv1IA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: imx6: Fix i.MX6Q/DL boot hang caused by
 improper PHY power sequencing
Reply-To: sashiko-reviews@lists.linux.dev
To: hongxing.zhu@oss.nxp.com
Cc: imx@lists.linux.dev, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260722030935.2328278-1-hongxing.zhu@oss.nxp.com>
References: <20260722030935.2328278-1-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 03:20:19 +0000
Message-Id: <20260722032019.E70091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The removal of explicit PHY power-up delays causes a boot regressi=
on on boards without a PERST# GPIO or explicit Root Port nodes in the devic=
e tree.
- [Medium] Incorrect teardown ordering in `imx_pcie_host_exit()` violates L=
IFO symmetry by asserting the core reset after the PHY is powered off and e=
xited.
--

--- Patch [1]: [PATCH v3] PCI: imx6: Fix i.MX6Q/DL boot hang caused by impr=
oper PHY power sequencing ---
commit 00ce7804e098bc0e8573a15a850f6250a9cb1245
Author: Richard Zhu <hongxing.zhu@nxp.com>
PCI: imx6: Fix i.MX6Q/DL boot hang caused by improper PHY power sequencing

This commit fixes a boot hang on i.MX6Q/DL variants by correcting the PHY p=
ower
sequencing and TEST_PD control logic. It removes an explicit delay during c=
lock
enable, assuming the PERST# toggling sequence provides sufficient stabiliza=
tion
time. It also adds explicit core reset assertions in the error paths.

Link: https://lore.kernel.org/lkml/20260629143439.361560-1-leoreis.costa@gm=
ail.com/

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index e25f938eefe23..45ab21c9769a4 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -681,21 +681,12 @@ static int imx_pcie_attach_pd(struct device *dev)
> =20
>  static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool ena=
ble)
>  {
> -	if (enable) {
> -		/* power up core phy and enable ref clock */
> -		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_T=
EST_PD);
> -		/*
> -		 * The async reset input need ref clock to sync internally,
> -		 * when the ref clock comes after reset, internal synced
> -		 * reset time is too short, cannot meet the requirement.
> -		 * Add a ~10us delay here.
> -		 */
> -		usleep_range(10, 100);

[Severity: High]
The commit message states that the ~120us delay needed between TEST_PD
de-assertion and link training is satisfied by the PERST# toggling sequence.
Does this break boards that don't define a reset GPIO (like
imx6qdl-sabrelite.dtsi)?

If the device tree lacks a PERST# GPIO or explicit Root Port nodes,
imx_pcie_assert_perst() returns immediately:

static void imx_pcie_assert_perst(struct imx_pcie *imx_pcie, bool assert)
{
        [ ... ]
        if (!bridge || list_empty(&bridge->ports))
                return;
        [ ... ]
}

Because of this early return, there will be no delay before link training
begins in imx_pcie_host_init(). Could this lead to a boot hang on these
boards due to the missing PHY stabilization delay?

[ ... ]

> @@ -1475,6 +1467,7 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *p=
p)
>  		if (phy_power_off(imx_pcie->phy))
>  			dev_err(pci->dev, "unable to power off PHY\n");
>  		phy_exit(imx_pcie->phy);
>  	}
> +	imx_pcie_assert_core_reset(imx_pcie);

[Severity: Medium]
Is the teardown ordering correct here?

During initialization, the core reset is asserted before powering on the PH=
Y.
The error path err_phy_off in imx_pcie_host_init() correctly mirrors this
by asserting the core reset before powering off the PHY.

However, this sequence in imx_pcie_host_exit() asserts the core reset
after the PHY has already been powered off and exited. Should
imx_pcie_assert_core_reset() be called before phy_power_off() to maintain
proper LIFO teardown symmetry?

>  	imx_pcie_clk_disable(imx_pcie);
> =20
>  	if (!pci->pp.skip_pwrctrl_off)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722030935.2328=
278-1-hongxing.zhu@oss.nxp.com?part=3D1
