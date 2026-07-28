Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6824037F007;
	Tue, 28 Jul 2026 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785256675; cv=none; b=CmNTuZC1eMy6hQjzVYi4ana5wXlVNCVNpDbyw2f7WhG2UBnB7dunL2Blc9LANPfemoLFSC9LMw5PO1DVrOh8+acsKVB8FXIykO4qrJlOgxijufcYaTJJfsmOasPOkSxvGKDHCBk0cXHf6C/4jPrsC9+8XNd7ol4GrWk71F5NMMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785256675; c=relaxed/simple;
	bh=o2CyqqHeteFX7ZfU4lt6qqd4iQ7Yl2077KnKxTF2DQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Eflkr5HSO2Xgt+amuHrkk1NVWfWHPo/w5cFFMyY+mHGaYKmqe/lI6b1g7GSRjjPUi8FC1jiYkRoME+sr2/IpwURXChEWd6xy+5Yw1CqU2qlWhm5P/cWFkBLVy4eKpLf2dJKAlPAQ/W8C18oPo0f5+jE/qr9q1LxSka/XvZBeS+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwZw/ie+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwZw/ie+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702EC1F000E9;
	Tue, 28 Jul 2026 16:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785256673;
	bh=VaDP40JoGOSQxXmgmR3af5oPCK1LSZo99YVjzP4O+2E=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=MwZw/ie+VMuOaZJGGkyDSli4aTKGmcIXxhmj654dvcSKOlPloSaUaRxqJ6D7pWWd+
	 ZYBfw24z09CfaOyJhubrf65ZWc5pSDK4BzDeJ4lHkQLBzczrKdveNGRHk4+QxMvCq/
	 eAQ9jRhHaz85kZ6qSpaD3bUXFwc9/Ri3pIYipMvWCZbHJ9qws+2Yb76pLpQI3L480R
	 CThzCvCl2QzsgSIU7NQiF7x6knRnIXBu+uwFN+EW3wkzj/GA2mdXkJA/o6Bs6ocfZy
	 oDdBxtWAzEmOFaBTTc+MFa5XoGjTc1alEX5otaMoW7pCepT3G/gUGZPAuhuAxEytt7
	 N35zj92SU8zUw==
Date: Tue, 28 Jul 2026 11:37:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: hongxing.zhu@oss.nxp.com
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>,
	Leonardo Costa <leoreis.costa@gmail.com>,
	Leonardo Costa <leonardo.costa@toradex.com>
Subject: Re: [PATCH v5] PCI: imx6: Fix i.MX6Q/DL boot hang caused by improper
 PHY power sequencing
Message-ID: <20260728163752.GA1328281@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728035159.2702021-1-hongxing.zhu@oss.nxp.com>

On Tue, Jul 28, 2026 at 11:51:59AM +0800, hongxing.zhu@oss.nxp.com wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
> introduced a boot hang on i.MX6Q/DL variants by reordering
> imx_pcie_host_init() to call imx6q_pcie_enable_ref_clk() (which powered up
> the PHY) before imx6q_pcie_core_reset() (which powered it back down).
> 
> Before 610fa91d9863, the sequence was:
> 
>   1. imx_pcie_assert_core_reset() - power down PHY (set TEST_PD), set
>      REF_CLK_EN
>   2. imx_pcie_clk_enable() - power up PHY (clear TEST_PD), set REF_CLK_EN
>   3. Link training starts with PHY powered up (TEST_PD cleared)
>   4. Link training succeeds
> 
> After 610fa91d9863, the sequence became:
> 
>   1. imx_pcie_clk_enable() - power up PHY (clear TEST_PD), set REF_CLK_EN
>   2. imx_pcie_assert_core_reset() - power down PHY (set TEST_PD), set
>      REF_CLK_EN
>   3. imx_pcie_deassert_core_reset() - does nothing
>   4. Link training starts with PHY powered down (TEST_PD set)
>   5. Link training fails and boot hangs
> 
> To fix this:
> 
>   - Remove TEST_PD PHY power control from imx6q_pcie_enable_ref_clk()
>   - Remove REF_CLK_EN control from imx6q_pcie_core_reset()
>   - Add TEST_PD PHY power control to imx6qp_pcie_core_reset(), which
>     previously relied on imx6q_pcie_enable_ref_clk() to power up the PHY by
>     clearing TEST_PD
>   - Clear TEST_PD to power on PHY in imx_pcie_deassert_core_reset()
> 
> These changes together ensure the correct sequence:
> 
>   1. REF_CLK_EN set in clk_enable() (TEST_PD untouched)
>   2. TEST_PD set in assert_core_reset() (PHY power off)
>   3. TEST_PD cleared in deassert_core_reset() (PHY power on)
>   4. Link training starts with proper PHY state
> 
> The i.MX6Q/DL PCIe PHY requires approximately 120us between TEST_PD
> de-assertion and link training start. Add usleep_range(200, 500) in
> imx6q_pcie_core_reset() after clearing TEST_PD to satisfy this requirement.
> 
> Add explicit imx_pcie_assert_core_reset() calls in error paths and
> host_exit() to ensure no power leak.
> 
> Fixes: 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reported-by: Leonardo Costa <leoreis.costa@gmail.com>
> Closes: https://lore.kernel.org/lkml/20260629143439.361560-1-leoreis.costa@gmail.com/
> Tested-by: Leonardo Costa <leonardo.costa@toradex.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Applied to pci/for-linus for v7.2, thanks very much!

> ---
> Changes in v5:
> Update the commit log suggested by Bjorn.
> 
> Changes in v4:
> Refer to Sashiko' reivew of v3 patch.
> - Adjust imx_pcie_assert_core_reset() in imx_pcie_host_exit().
> - Add the delay explicitly after TEST_PD is cleared, since the PERST# GPIO
> might be optional.
> 
> Changes in v3:
> Update the commit descriptions to address the following items.
> - Clarify the root cause of this regresssion.
> - Describe why both changes are mandatory required to fix this
>   regression.
> - Justify the delay removal also.
> 
> Changes in v2:
> Per Sashiko's review, invoke imx_pcie_assert_core_reset() explicitly
> in error path of imx_pcie_host_init() and imx_pcie_host_exit().
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 41 ++++++++++++++-------------
>  1 file changed, 22 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index e25f938eefe23..c94b5e991aecd 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -681,21 +681,12 @@ static int imx_pcie_attach_pd(struct device *dev)
>  
>  static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
>  {
> -	if (enable) {
> -		/* power up core phy and enable ref clock */
> -		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
> -		/*
> -		 * The async reset input need ref clock to sync internally,
> -		 * when the ref clock comes after reset, internal synced
> -		 * reset time is too short, cannot meet the requirement.
> -		 * Add a ~10us delay here.
> -		 */
> -		usleep_range(10, 100);
> -		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
> -	} else {
> -		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
> -		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
> -	}
> +	if (enable)
> +		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				IMX6Q_GPR1_PCIE_REF_CLK_EN);
> +	else
> +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				  IMX6Q_GPR1_PCIE_REF_CLK_EN);
>  
>  	return 0;
>  }
> @@ -826,6 +817,12 @@ static int imx6sx_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
>  
>  static int imx6qp_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
>  {
> +	if (assert)
> +		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				IMX6Q_GPR1_PCIE_TEST_PD);
> +	else
> +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				  IMX6Q_GPR1_PCIE_TEST_PD);
>  	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_SW_RST,
>  			   assert ? IMX6Q_GPR1_PCIE_SW_RST : 0);
>  	if (!assert)
> @@ -836,11 +833,15 @@ static int imx6qp_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
>  
>  static int imx6q_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
>  {
> -	if (!assert)
> -		return 0;
> +	if (assert)
> +		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				IMX6Q_GPR1_PCIE_TEST_PD);
> +	else
> +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				  IMX6Q_GPR1_PCIE_TEST_PD);
>  
> -	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
> -	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
> +	if (!assert)
> +		usleep_range(200, 500);
>  
>  	return 0;
>  }
> @@ -1451,6 +1452,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  	return 0;
>  
>  err_phy_off:
> +	imx_pcie_assert_core_reset(imx_pcie);
>  	phy_power_off(imx_pcie->phy);
>  err_phy_exit:
>  	phy_exit(imx_pcie->phy);
> @@ -1470,6 +1472,7 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
>  
> +	imx_pcie_assert_core_reset(imx_pcie);
>  	if (imx_pcie->phy) {
>  		if (phy_power_off(imx_pcie->phy))
>  			dev_err(pci->dev, "unable to power off PHY\n");
> -- 
> 2.34.1
> 
