Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45D33A9002;
	Mon,  6 Jul 2026 03:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783307940; cv=none; b=J7LqJl5IKcR7WXuMin+nDg9EcExX2oaJsvVWgPX3vQHmDbRVTMW8UCxgOsIbIEynBxNXD2jAOp/kiUIJklyQx0y9hnkrZtjIl6pAJkTI5g+/hHFaJkBNnZwEHVJFc70sfSJReua69Rm/kasn1zZMHgtHgSRFFKcwoxb5b6Moh08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783307940; c=relaxed/simple;
	bh=Bwwr62XBODVEUb4pQqYoypX4oYuGOg2sMv6PRXOchcI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RKQ9aYfIkE2RESXUcXBgkLr0IZX2Etg8anhODzryLWzELqRixIhd/LNfvNmgwPzdj9UvZyEXsOkoXQ4pYunXqSawHpu36edzPssMlDoCfezNvSz9u716XLClpclJSlb1MxxIImS+Vw40vcwg1zMCjuzb048LuUuF9p8C8ApVgYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5ETpcKH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5ETpcKH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB1F1F000E9;
	Mon,  6 Jul 2026 03:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783307938;
	bh=JuD2/SyQOuNz2feW5xsKAXTZOopq5bas2xY2T6msgZ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m5ETpcKHAYSWzchZl6yWsk9ycqinapxvRrUf2EaQWlTRDaqg+gPR8lYF+rnR/6b85
	 KT8i/4x+0G9zC3PtMGmt28EuInF0dZ9PwhV4rkD9q4hfJiDUPJl9lF1sG5kdd83s4H
	 7afzmbpSofGYBgkN7uli2CeXDpo+kzWIp2GGwnTYVWbTLa00ZxV+fSbhQ5O6HjtN41
	 qNK1rFz5o2FFgi0QZGAmdt3RgShgCVx1q0p3KS6MX01TERnLHpcVIaEd5LTOM0r/ow
	 5N0inHoR89m5LOpC51Q7wDBpufW85R1mzGzFpgvJvMEMxzpRONMk1x88fsMHW8wt28
	 s5phee+Jg1K1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] PCI: imx6: Fix i.MX6Q/DL boot hang by separating PHY
 power and reference clock control
Reply-To: sashiko-reviews@lists.linux.dev
To: hongxing.zhu@oss.nxp.com
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260706030629.3264320-1-hongxing.zhu@oss.nxp.com>
References: <20260706030629.3264320-1-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 03:18:57 +0000
Message-Id: <20260706031858.3BB1F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] PCIe PHY remains powered up on probe error paths
--

commit a734b2214ed3f695bc7968ca2438d6c116ff54b7
Author: Richard Zhu <hongxing.zhu@nxp.com>

PCI: imx6: Fix i.MX6Q/DL boot hang by separating PHY power and reference cl=
ock control

Commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
introduced a boot hang on i.MX6Q/DL variants by changing the initialization
sequence.

The issue stems from coupling PHY power (TEST_PD) and reference clock
(REF_CLK_EN) control in imx6q_pcie_enable_ref_clk(). When these are
managed together, the timing between PHY power-up and reference clock
enablement cannot be properly controlled, leading to initialization
failures.

[ ... ]

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 98e1db751132a..ab74f03f70bc8 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -680,21 +680,12 @@ static int imx_pcie_attach_pd(struct device *dev)
> =20
>  static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool ena=
ble)
>  {
> -	if (enable) {
> -		/* power up core phy and enable ref clock */
> -		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_T=
EST_PD);

[ ... ]

> -	} else {
> -		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_R=
EF_CLK_EN);
> -		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TES=
T_PD);
> -	}
> +	if (enable)
> +		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				IMX6Q_GPR1_PCIE_REF_CLK_EN);
> +	else
> +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				  IMX6Q_GPR1_PCIE_REF_CLK_EN);
> =20
>  	return 0;
>  }

[Severity: Medium]
When TEST_PD is no longer asserted here, does this cause a power leak
during probe failure or driver removal?

Because imx_pcie_clk_disable() indirectly calls this function with
enable=3Dfalse, it used to power down the PHY by asserting TEST_PD. After
this change, error paths only disable the clock but leave the PHY powered u=
p:

drivers/pci/controller/dwc/pci-imx6.c:imx_pcie_host_init() {
    ...
    imx_pcie_deassert_core_reset(imx_pcie);
    ...
    if (imx_pcie->drvdata->wait_pll_lock) {
        ret =3D imx_pcie->drvdata->wait_pll_lock(imx_pcie);
        if (ret < 0)
            goto err_phy_off;
    }
    ...
err_clk_disable:
    imx_pcie_clk_disable(imx_pcie);
    ...
}

The same applies to imx_pcie_host_exit() which calls imx_pcie_clk_disable()
during teardown.

Should imx_pcie_assert_core_reset() be explicitly called in
imx_pcie_host_init()'s error path (and in imx_pcie_host_exit()) to ensure
the PHY is properly powered down and reset?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706030629.3264=
320-1-hongxing.zhu@oss.nxp.com?part=3D1
