Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084514B44C0;
	Mon, 21 Sep 2026 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006610; cv=none; b=CKUA1aEVbf4+6EsEMbKrvsIvM6l90LD9BOv6EmXraY5bID3ipLHn8YuOSoHmtlt83e+C6uaeafLoGAvqBlx5UdjKgocx7P4iwYhC2DTR4Z4islnaa709FB5gBk+aTk+vMlr4RM0Hdalu3enALE7BiyLh6yqZFvYdUu2Kwj2fvUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006610; c=relaxed/simple;
	bh=GcQVIx0ZHlSgiMpABZs9hzeajAke/Pcr222mEOJyldw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o91dKc9d6E2DAuKPzR1OWBetMNsMtwoloiE8wX6quEONfKgeYMOhRhfzdCepZuCz/k4nSZdr4tXGwGRyQZxDVrqOUMzHhBM7PdNJPl9/SJI6zTAkjEX7CttoTQhVuAKR3qZPfprgSY4Cw4zXsVlPc/EkokSim6eXwCzd/pBYJpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfT0Auj5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfT0Auj5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710321F000FF;
	Mon, 21 Sep 2026 16:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790006608;
	bh=S+nMtydxu60gnpE5YP5lmUy7iVTsov6d1dYlPJMyWS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mfT0Auj5snoKFG1xn3/9wL5oGWbpP0gJKVay/fBgkh+vPMCLBBeyB9hSKeb5yxgW7
	 zG3VAe0XvtqoJdUxoimZ1lX/3/UfvbPpYbtkxPWw9pLtcgqfcJPTfM17U9mfzj/GhS
	 muGfKTc68RCMRkhxAz6bfOpK7ZrgewkX/9/JsDAn8cMQqoslvIceLybmhWkmVwJNhf
	 KMfjKWG3SMSA8k7r23HH1NG9PrcaJ/kGD6AAJgBEs4z4nUWoJBgUrolJh1gtcbyuHT
	 /hCi4shZbAhhWlz+zzS1YWayY8MtCjXGRzGzhRuh73wBlXawNyLDiEhFbDxZq5maNd
	 4En6yh89p5r1A==
Date: Mon, 21 Sep 2026 18:03:20 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 6/6] PCI: dwc: rcar-gen4: Add support for R-Car X5H
 PCIe4
Message-ID: <ygec5dvolsujxmaxxjqnmusfj6shzszkiprlckbwqkdf6u6hc6@5sm6ayrfzkkm>
References: <20260905212649.360498-1-marek.vasut+renesas@mailbox.org>
 <20260905212649.360498-7-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260905212649.360498-7-marek.vasut+renesas@mailbox.org>

On Sat, Sep 05, 2026 at 11:26:27PM +0200, Marek Vasut wrote:
> Add support for R8A78000 (R-Car X5H) PCIe4.
> 
> This driver previously supported R-Car Gen4 S4/V4H/V4M. PCIe features
> of R-Car X5H PCIe4 are almost all the same.
> 
> The controller initialization sequence is slightly different and is
> factored out into controller specific callbacks, in a manner similar
> to previous R-Car Gen4 handling.
> 
> The controller does have a PHY attached to it, but the PHY is operated
> by a separate PHY driver, the PHY driver instance binding is handled
> in rcar_gen4_pcie_get_resources() and controlled in the aforementioned
> controller specific callbacks.
> 
> The controller driver is deliberately using "renesas,rcar-gen5-pcie4"
> DT compatible string to discern R-Car X5H PCIe4 controller supported
> by this driver, from R-Car X5H PCIe6 controller which will most likely
> use a separate driver.
> 
> The R-Car X5H PCIe4 controller embeds HDMA instead of EDMA embedded
> in the R-Car Gen4 PCIe controller, "dw-edma" driver supports both
> DMA variants.
> 
> Endpoint mode is currently not implemented for R-Car Gen5 PCIe4.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V2: No change
> V3: - Disable clock in case of PHY init failure in rcar_gen5_pcie_init()
>     - Add .deinit callback and tear down Gen5 PHY in it
>     - Use 16bit accessors on LNKCTL register
> V4: Rebase on next-20260904
> ---
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 128 +++++++++++++++++++-
>  1 file changed, 126 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index 89472a4becc46..5c0d5fd686cb5 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -19,6 +19,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/pci.h>
> +#include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
> @@ -36,6 +37,7 @@
>  
>  /* MSI Capability */
>  #define MSICAP0			0x0050
> +#define MSICAP0_MMESCAP_MASK	GENMASK(19, 17)
>  #define MSICAP0_MSIE		BIT(16)
>  
>  /* PCIe Interrupt Status 0 */
> @@ -74,6 +76,11 @@
>  #define PCIEPWRMNGCTRL		0x0070
>  #define APP_CLK_REQ_N		BIT(11)
>  #define APP_CLK_PM_EN		BIT(10)
> +#define APP_READY_ENTR_L23	BIT(6)
> +#define APP_REQ_ENTR_L1		BIT(5)
> +
> +/* PCI Express capability */
> +#define EXPCAP(x)		(0x0070 + (x))
>  
>  #define RCAR_NUM_SPEED_CHANGE_RETRIES	10
>  #define RCAR_MAX_LINK_SPEED		4
> @@ -98,6 +105,7 @@ struct rcar_gen4_pcie {
>  	struct dw_pcie dw;
>  	void __iomem *base;
>  	void __iomem *phy_base;
> +	struct phy *phy;
>  	struct platform_device *pdev;
>  	struct reset_control *perst;
>  	const struct rcar_gen4_pcie_drvdata *drvdata;
> @@ -170,6 +178,35 @@ static int rcar_gen4_pcie_speed_control(struct rcar_gen4_pcie *rcar)
>  	return 0;
>  }
>  
> +static int rcar_gen5_pcie_speed_control(struct rcar_gen4_pcie *rcar)
> +{
> +	struct dw_pcie *dw = &rcar->dw;
> +	u32 lnkcap = dw_pcie_readl_dbi(dw, EXPCAP(PCI_EXP_LNKCAP));
> +	u32 lnksta = dw_pcie_readw_dbi(dw, EXPCAP(PCI_EXP_LNKSTA));
> +	u32 val, retries;
> +
> +	if ((lnksta & PCI_EXP_LNKSTA_CLS) == (lnkcap & PCI_EXP_LNKCAP_SLS))
> +		return 0;
> +
> +	/* Retrain link */
> +	val = dw_pcie_readw_dbi(dw, EXPCAP(PCI_EXP_LNKCTL));
> +	val |= PCI_EXP_LNKCTL_RL;
> +	dw_pcie_writew_dbi(dw, EXPCAP(PCI_EXP_LNKCTL), val);
> +
> +	/* Wait for link retrain */
> +	for (retries = 0; retries <= 10; retries++) {

So this loop executes 11 times. Is that intented?

> +		lnksta = dw_pcie_readw_dbi(dw, EXPCAP(PCI_EXP_LNKSTA));
> +
> +		/* Check retrain flag */
> +		if (!(lnksta & PCI_EXP_LNKSTA_LT))
> +			break;
> +
> +		usleep_range(1000, 1100);

What is the expected behavior if the Link retrain is not successfull? If it is
safe to continue, shouldn't the users be warned atleast?

> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * Enable LTSSM of this controller and manually initiate the speed change.
>   * Always return 0.
> @@ -285,6 +322,49 @@ static int rcar_gen4_v4h_v4m_pcie_init(struct rcar_gen4_pcie *rcar)
>  	return 0;
>  }
>  
> +static int rcar_gen5_pcie_init(struct rcar_gen4_pcie *rcar)
> +{
> +	struct dw_pcie *dw = &rcar->dw;
> +	int ret;
> +	u32 val;
> +
> +	/* R-Car Gen4 and Gen5 common initialization. */
> +	ret = rcar_gen4_pcie_common_init(rcar);
> +	if (ret)
> +		return ret;
> +
> +	/* R-Car Gen5 specific additional initialization. */
> +	ret = phy_init(rcar->phy);
> +	if (ret)
> +		goto err_unprepare;
> +
> +	dw_pcie_dbi_ro_wr_en(dw);
> +
> +	val = dw_pcie_readl_dbi(dw, PCIE_PORT_LANE_SKEW);
> +	val &= ~PORT_LANE_SKEW_INSERT_MASK;
> +	if (dw->num_lanes < 8)
> +		val |= BIT(6);
> +	dw_pcie_writel_dbi(dw, PCIE_PORT_LANE_SKEW, val);
> +
> +	val = dw_pcie_readl_dbi(dw, MSICAP0);
> +	FIELD_MODIFY(MSICAP0_MMESCAP_MASK, &val, 4);
> +	dw_pcie_writel_dbi(dw, MSICAP0, val);
> +
> +	dw_pcie_dbi_ro_wr_dis(dw);
> +
> +	val = readl(rcar->base + PCIEPWRMNGCTRL);
> +	val |= APP_CLK_REQ_N | APP_CLK_PM_EN |
> +	       APP_READY_ENTR_L23 | APP_REQ_ENTR_L1;
> +	writel(val, rcar->base + PCIEPWRMNGCTRL);
> +
> +	return 0;
> +
> +err_unprepare:
> +	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
> +
> +	return ret;
> +}
> +
>  static void rcar_gen4_pcie_common_deinit(struct rcar_gen4_pcie *rcar)
>  {
>  	struct dw_pcie *dw = &rcar->dw;
> @@ -293,6 +373,12 @@ static void rcar_gen4_pcie_common_deinit(struct rcar_gen4_pcie *rcar)
>  	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
>  }
>  
> +static void rcar_gen5_pcie_deinit(struct rcar_gen4_pcie *rcar)
> +{
> +	phy_exit(rcar->phy);
> +	rcar_gen4_pcie_common_deinit(rcar);
> +}
> +
>  static int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *rcar)
>  {
>  	struct device *dev = rcar->dw.dev;
> @@ -322,8 +408,12 @@ static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
>  	struct device_node *root_port;
>  
>  	rcar->phy_base = devm_platform_ioremap_resource_byname(rcar->pdev, "phy");
> -	if (IS_ERR(rcar->phy_base))
> -		return PTR_ERR(rcar->phy_base);
> +	if (IS_ERR(rcar->phy_base)) {
> +		rcar->phy_base = NULL;
> +		rcar->phy = devm_phy_get(dev, NULL);
> +		if (IS_ERR(rcar->phy))
> +			return PTR_ERR(rcar->phy);
> +	}
>  
>  	root_port = of_get_next_available_child(dev->of_node, NULL);
>  	if (root_port) {
> @@ -807,6 +897,28 @@ static int r8a779f0_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable)
>  	return 0;
>  }
>  
> +static int rcar_gen5_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable)
> +{
> +	u32 val;
> +
> +	val = readl(rcar->base + PCIERSTCTRL1);
> +	if (enable) {
> +		val |= APP_LTSSM_ENABLE;
> +		val &= ~APP_HOLD_PHY_RST;
> +	} else {
> +		val &= ~APP_LTSSM_ENABLE;
> +		val |= APP_HOLD_PHY_RST;
> +	}
> +	writel(val, rcar->base + PCIERSTCTRL1);
> +
> +	if (enable)
> +		phy_power_on(rcar->phy);
> +	else
> +		phy_power_off(rcar->phy);

It is quite unusual to handle PHY power on/off in the start_link() callback.
Should this be moved to init/deinit callbacks?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
