Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54945 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751185AbcCKR7A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Mar 2016 12:59:00 -0500
Date: Fri, 11 Mar 2016 11:58:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lee Jones <lee.jones@linaro.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/2] PCI: imx6: add initial imx6sx support
Message-ID: <20160311175850.GA4725@localhost>
References: <1456411669-4699-1-git-send-email-chf.fritz@googlemail.com>
 <1456411669-4699-3-git-send-email-chf.fritz@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456411669-4699-3-git-send-email-chf.fritz@googlemail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Christoph (and Lee; there's a question for you below, too),

On Thu, Feb 25, 2016 at 03:47:49PM +0100, Christoph Fritz wrote:
> This patch adds initial PCIe support for the imx6 SoC derivate imx6sx.
> PCI_MSI support is untested as its necessary suspend/resume quirk is
> left out of this patch.
> This patch is heavily based on patches by Richard Zhu.
> 
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> ---
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |   6 +-
>  drivers/pci/host/pci-imx6.c                        | 130 ++++++++++++++-------
>  2 files changed, 96 insertions(+), 40 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index 6fbba53..c4323be 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -4,7 +4,7 @@ This PCIe host controller is based on the Synopsis Designware PCIe IP
>  and thus inherits all the common properties defined in designware-pcie.txt.
>  
>  Required properties:
> -- compatible: "fsl,imx6q-pcie"
> +- compatible: "fsl,imx6q-pcie", "fsl,imx6sx-pcie"
>  - reg: base addresse and length of the pcie controller

I folded in a typo fix for "addresse".

>  - interrupts: A list of interrupt outputs of the controller. Must contain an
>    entry for each entry in the interrupt-names property.
> @@ -13,6 +13,10 @@ Required properties:
>  - clock-names: Must include the following additional entries:
>  	- "pcie_phy"
>  
> +Additional required properties for imx6sx-pcie:
> +- clock names: Must include the following additional entries:
> +	- "pcie_inbound_axi"
> +
>  Example:
>  
>  	pcie@0x01000000 {
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index fe60096..7e634a6 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -35,9 +35,11 @@ struct imx6_pcie {
>  	struct gpio_desc	*reset_gpio;
>  	struct clk		*pcie_bus;
>  	struct clk		*pcie_phy;
> +	struct clk		*pcie_inbound_axi;
>  	struct clk		*pcie;
>  	struct pcie_port	pp;
>  	struct regmap		*iomuxc_gpr;
> +	bool			is_imx6sx;
>  	void __iomem		*mem_base;
>  };
>  
> @@ -214,35 +216,46 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
>  	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
>  	u32 val, gpr1, gpr12;
>  
> -	/*
> -	 * If the bootloader already enabled the link we need some special
> -	 * handling to get the core back into a state where it is safe to
> -	 * touch it for configuration.  As there is no dedicated reset signal
> -	 * wired up for MX6QDL, we need to manually force LTSSM into "detect"
> -	 * state before completely disabling LTSSM, which is a prerequisite
> -	 * for core configuration.
> -	 *
> -	 * If both LTSSM_ENABLE and REF_SSP_ENABLE are active we have a strong
> -	 * indication that the bootloader activated the link.
> -	 */
> -	regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1, &gpr1);
> -	regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, &gpr12);
> -
> -	if ((gpr1 & IMX6Q_GPR1_PCIE_REF_CLK_EN) &&
> -	    (gpr12 & IMX6Q_GPR12_PCIE_CTL_2)) {
> -		val = readl(pp->dbi_base + PCIE_PL_PFLR);
> -		val &= ~PCIE_PL_PFLR_LINK_STATE_MASK;
> -		val |= PCIE_PL_PFLR_FORCE_LINK;
> -		writel(val, pp->dbi_base + PCIE_PL_PFLR);
> -
> +	if (imx6_pcie->is_imx6sx) {
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
> -	}
> +				IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
> +				IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
> +		/* Force PCIe PHY reset */
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
> +					IMX6SX_GPR5_PCIE_BTNRST_RESET,
> +					IMX6SX_GPR5_PCIE_BTNRST_RESET);

Since there's nothing after the "else" clause, I think it's better to
return immediately here.  Then we don't have extra diffs that merely
indent the original function.  I did make this change (I'll attach my
resulting patch), and that made some other changes to the indented
code more visible.

> +	} else {
> +		/*
> +		 * If the bootloader already enabled the link we need some
> +		 * special handling to get the core back into a state where
> +		 * it is safe to touch it for configuration.  As there is no
> +		 * dedicated reset signal to manually force LTSSM into "detect"
> +		 * state before completely disabling LTSSM, which is a
> +		 * prerequisite for core configuration.

For example, you changed this comment, and now the last sentence is no
longer a sentence.  I don't know if this was an editing mistake or if
this comment really does need to change.  If it does need to change,
it needs to stay a sentence.

> +		 * If both LTSSM_ENABLE and REF_SSP_ENABLE are active we have
> +		 * a strong indication that the bootloader activated the link.
> +		 */
> +		regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1, &gpr1);
> +		regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, &gpr12);
> +
> +		if ((gpr1 & IMX6Q_GPR1_PCIE_REF_CLK_EN) &&
> +				(gpr12 & IMX6Q_GPR12_PCIE_CTL_2)) {
> +			val = readl(pp->dbi_base + PCIE_PL_PFLR);
> +			val &= ~PCIE_PL_PFLR_LINK_STATE_MASK;
> +			val |= PCIE_PL_PFLR_FORCE_LINK;
> +			writel(val, pp->dbi_base + PCIE_PL_PFLR);
> +
> +			regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				IMX6Q_GPR12_PCIE_CTL_2, 0);
> +		}
>  
> -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -			IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
> -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -			IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +			IMX6Q_GPR1_PCIE_TEST_PD,
> +			IMX6Q_GPR1_PCIE_TEST_PD);
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +			IMX6Q_GPR1_PCIE_REF_CLK_EN, 0);

And there are subtle changes here (changing "1 << 18" to
IMX6Q_GPR1_PCIE_TEST_PD, etc.)  These are fine, but should be in a
separate patch because (a) they're not related to imx6sx and (b) it
makes them obvious and easy to review.  As it is, they just get snuck
in under the radar.

> +	}
>  
>  	return 0;
>  }
> @@ -270,18 +283,30 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
>  		goto err_pcie;
>  	}
>  
> -	/* power up core phy and enable ref clock */
> -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -			IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
> -	/*
> -	 * the async reset input need ref clock to sync internally,
> -	 * when the ref clock comes after reset, internal synced
> -	 * reset time is too short, cannot meet the requirement.
> -	 * add one ~10us delay here.
> -	 */
> -	udelay(10);
> -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -			IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
> +	if (imx6_pcie->is_imx6sx) {
> +		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
> +		if (ret) {
> +			dev_err(pp->dev, "unable to enable pcie_axi clock\n");
> +			goto err_inbound_axi;
> +		}
> +
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +			IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
> +	} else {
> +		/* power up core phy and enable ref clock */
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				IMX6Q_GPR1_PCIE_TEST_PD, 0);
> +		/*
> +		 * the async reset input need ref clock to sync internally,
> +		 * when the ref clock comes after reset, internal synced
> +		 * reset time is too short , cannot meet the requirement.
> +		 * add one ~10us delay here.
> +		 */
> +		udelay(10);
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +			IMX6Q_GPR1_PCIE_REF_CLK_EN,
> +			IMX6Q_GPR1_PCIE_REF_CLK_EN);
> +	}

Here again the diff is bigger than necessary because it re-indents the
original code (and makes another unrelated "1 << 16" to
IMX6Q_GPR1_PCIE_REF_CLK_EN change).  I'll show a different proposal in
my patch below.

>  	/* allow the clocks to stabilize */
>  	usleep_range(200, 500);
> @@ -292,8 +317,15 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
>  		msleep(100);
>  		gpiod_set_value_cansleep(imx6_pcie->reset_gpio, 1);
>  	}
> +
> +	if (imx6_pcie->is_imx6sx)
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
> +			IMX6SX_GPR5_PCIE_BTNRST_RESET, 0);
> +
>  	return 0;
>  
> +err_inbound_axi:
> +	clk_disable_unprepare(imx6_pcie->pcie);
>  err_pcie:
>  	clk_disable_unprepare(imx6_pcie->pcie_bus);
>  err_pcie_bus:
> @@ -307,6 +339,12 @@ static void imx6_pcie_init_phy(struct pcie_port *pp)
>  {
>  	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
>  
> +	if (imx6_pcie->is_imx6sx) {
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +			IMX6SX_GPR12_PCIE_RX_EQ_MASK,
> +			IMX6SX_GPR12_PCIE_RX_EQ_2);

I see that you added definitions for IMX6SX_GPR12_PCIE_RX_EQ_MASK and
IMX6SX_GPR12_PCIE_RX_EQ_2 in the first patch of this series, but doing
that separately creates a merge problem.  I can't put this change in
my tree by itself because it won't build.  If Lee applied the first
patch to a git branch, I guess I could pull that into my tree.  But it
would be far simpler to just include those new definitions in this
patch.

> +	}
> +
>  	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  			IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
>  
> @@ -571,6 +609,9 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  	pp = &imx6_pcie->pp;
>  	pp->dev = &pdev->dev;
>  
> +	imx6_pcie->is_imx6sx = of_device_is_compatible(pp->dev->of_node,
> +					"fsl,imx6sx-pcie");
> +
>  	/* Added for PCI abort handling */
>  	hook_fault_code(16 + 6, imx6q_pcie_abort_handler, SIGBUS, 0,
>  		"imprecise external abort");
> @@ -606,6 +647,16 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>  		return PTR_ERR(imx6_pcie->pcie);
>  	}
>  
> +	if (imx6_pcie->is_imx6sx) {
> +		imx6_pcie->pcie_inbound_axi = devm_clk_get(&pdev->dev,
> +			"pcie_inbound_axi");
> +		if (IS_ERR(imx6_pcie->pcie_inbound_axi)) {
> +			dev_err(&pdev->dev,
> +				"pcie_incbound_axi clock missing or invalid\n");
> +			return PTR_ERR(imx6_pcie->pcie_inbound_axi);
> +		}
> +	}
> +
>  	/* Grab GPR config register range */
>  	imx6_pcie->iomuxc_gpr =
>  		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
> @@ -632,6 +683,7 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
>  
>  static const struct of_device_id imx6_pcie_of_match[] = {
>  	{ .compatible = "fsl,imx6q-pcie", },
> +	{ .compatible = "fsl,imx6sx-pcie", },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, imx6_pcie_of_match);

The patches below are what I currently have in my tree, but they're
not ready for v4.6 (yet).

Note that the second one is very clearly imx6sx-only.  It's obvious
there are no tweaks to the existing imx6 code, which makes it easier
to review, backport, bisect, revert, etc.

Obviously, I can't apply these directly.  First we have to:

  - Fix the LTSSM comment
  - Figure out how to get the IMX6SX_GPR12_PCIE_RX_EQ_MASK definitions


commit 78abf60b815a8f28207d029d61f7809647faa43a
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri Mar 11 11:15:36 2016 -0600

    PCI: imx6: Factor out ref clock enable
    
    Factor out ref clock enable to make it cleaner to add imx6sx support.  No
    functional change intended.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 8c9b389..ecc8537 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -269,6 +269,23 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
 	return 0;
 }
 
+static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
+{
+	/* power up core phy and enable ref clock */
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+			IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
+	/*
+	 * the async reset input need ref clock to sync internally,
+	 * when the ref clock comes after reset, internal synced
+	 * reset time is too short, cannot meet the requirement.
+	 * add one ~10us delay here.
+	 */
+	udelay(10);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+			IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
+	return 0;
+}
+
 static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 {
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
@@ -292,18 +309,11 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 		goto err_pcie;
 	}
 
-	/* power up core phy and enable ref clock */
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-			IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
-	/*
-	 * the async reset input need ref clock to sync internally,
-	 * when the ref clock comes after reset, internal synced
-	 * reset time is too short, cannot meet the requirement.
-	 * add one ~10us delay here.
-	 */
-	udelay(10);
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
-			IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
+	ret = imx6_pcie_enable_ref_clk(imx6_pcie);
+	if (ret)
+		dev_err(pp->dev, "unable to enable pcie ref clock\n");
+		goto err_ref_clk;
+	}
 
 	/* allow the clocks to stabilize */
 	usleep_range(200, 500);
@@ -316,6 +326,8 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 	}
 	return 0;
 
+err_ref_clk:
+	clk_disable_unprepare(imx6_pcie->pcie);
 err_pcie:
 	clk_disable_unprepare(imx6_pcie->pcie_bus);
 err_pcie_bus:

commit d061033570b7fd22a3ed8c029d4793e5df7324e1
Author: Christoph Fritz <chf.fritz@googlemail.com>
Date:   Thu Mar 10 15:04:25 2016 -0600

    PCI: imx6: Add initial imx6sx support
    
    Add initial PCIe support for the imx6 SoC derivate imx6sx.  PCI MSI support
    is untested as the necessary suspend/resume quirk is not included in this
    patch.
    
    This patch is heavily based on patches by Richard Zhu.
    
    [bhelgaas: factor out refclk enable, fix adjacent typos in fsl,imx6q-pcie.txt]
    Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
    Acked-by: Richard Zhu <Richard.Zhu@freescale.com>
    Acked-by: Lucas Stach <l.stach@pengutronix.de>

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index 3be80c6..0561e88 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -4,8 +4,8 @@ This PCIe host controller is based on the Synopsis Designware PCIe IP
 and thus inherits all the common properties defined in designware-pcie.txt.
 
 Required properties:
-- compatible: "fsl,imx6q-pcie"
-- reg: base addresse and length of the pcie controller
+- compatible: "fsl,imx6q-pcie", "fsl,imx6sx-pcie"
+- reg: base address and length of the PCIe controller
 - interrupts: A list of interrupt outputs of the controller. Must contain an
   entry for each entry in the interrupt-names property.
 - interrupt-names: Must include the following entries:
@@ -20,6 +20,10 @@ Optional properties:
 - fsl,tx-swing-full: Gen2 TX SWING FULL value. Default: 127
 - fsl,tx-swing-low: TX launch amplitude swing_low value. Default: 127
 
+Additional required properties for imx6sx-pcie:
+- clock names: Must include the following additional entries:
+	- "pcie_inbound_axi"
+
 Example:
 
 	pcie@0x01000000 {
diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index ecc8537..4d6af21 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -35,9 +35,11 @@ struct imx6_pcie {
 	struct gpio_desc	*reset_gpio;
 	struct clk		*pcie_bus;
 	struct clk		*pcie_phy;
+	struct clk		*pcie_inbound_axi;
 	struct clk		*pcie;
 	struct pcie_port	pp;
 	struct regmap		*iomuxc_gpr;
+	bool			is_imx6sx;
 	void __iomem		*mem_base;
 	u32			tx_deemph_gen1;
 	u32			tx_deemph_gen2_3p5db;
@@ -236,13 +238,23 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
 	u32 val, gpr1, gpr12;
 
+	if (imx6_pcie->is_imx6sx) {
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
+				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
+		/* Force PCIe PHY reset */
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
+				   IMX6SX_GPR5_PCIE_BTNRST_RESET,
+				   IMX6SX_GPR5_PCIE_BTNRST_RESET);
+		return 0;
+	}
+
 	/*
 	 * If the bootloader already enabled the link we need some special
 	 * handling to get the core back into a state where it is safe to
 	 * touch it for configuration.  As there is no dedicated reset signal
-	 * wired up for MX6QDL, we need to manually force LTSSM into "detect"
-	 * state before completely disabling LTSSM, which is a prerequisite
-	 * for core configuration.
+	 * to manually force LTSSM into "detect" state before completely
+	 * disabling LTSSM, which is a prerequisite for core configuration.
 	 *
 	 * If both LTSSM_ENABLE and REF_SSP_ENABLE are active we have a strong
 	 * indication that the bootloader activated the link.
@@ -271,6 +283,18 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
 
 static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 {
+	if (imx6_pcie->is_imx6sx) {
+		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
+		if (ret) {
+			dev_err(pp->dev, "unable to enable pcie_axi clock\n");
+			return ret;
+		}
+
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
+		return 0;
+	}
+
 	/* power up core phy and enable ref clock */
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
 			IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
@@ -324,6 +348,11 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 		msleep(100);
 		gpiod_set_value_cansleep(imx6_pcie->reset_gpio, 1);
 	}
+
+	if (imx6_pcie->is_imx6sx)
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
+				   IMX6SX_GPR5_PCIE_BTNRST_RESET, 0);
+
 	return 0;
 
 err_ref_clk:
@@ -341,6 +370,12 @@ static void imx6_pcie_init_phy(struct pcie_port *pp)
 {
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
 
+	if (imx6_pcie->is_imx6sx) {
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				   IMX6SX_GPR12_PCIE_RX_EQ_MASK,
+				   IMX6SX_GPR12_PCIE_RX_EQ_2);
+	}
+
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 			IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
 
@@ -565,6 +600,9 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 	pp = &imx6_pcie->pp;
 	pp->dev = &pdev->dev;
 
+	imx6_pcie->is_imx6sx = of_device_is_compatible(pp->dev->of_node,
+						       "fsl,imx6sx-pcie");
+
 	/* Added for PCI abort handling */
 	hook_fault_code(16 + 6, imx6q_pcie_abort_handler, SIGBUS, 0,
 		"imprecise external abort");
@@ -600,6 +638,16 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(imx6_pcie->pcie);
 	}
 
+	if (imx6_pcie->is_imx6sx) {
+		imx6_pcie->pcie_inbound_axi = devm_clk_get(&pdev->dev,
+							   "pcie_inbound_axi");
+		if (IS_ERR(imx6_pcie->pcie_inbound_axi)) {
+			dev_err(&pdev->dev,
+				"pcie_incbound_axi clock missing or invalid\n");
+			return PTR_ERR(imx6_pcie->pcie_inbound_axi);
+		}
+	}
+
 	/* Grab GPR config register range */
 	imx6_pcie->iomuxc_gpr =
 		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
@@ -647,6 +695,7 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 
 static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx6q-pcie", },
+	{ .compatible = "fsl,imx6sx-pcie", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, imx6_pcie_of_match);
