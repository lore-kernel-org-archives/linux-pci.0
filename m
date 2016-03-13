Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35439 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbcCMX0e (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 13 Mar 2016 19:26:34 -0400
Received: by mail-wm0-f67.google.com with SMTP id n205so12382754wmf.2
        for <linux-pci@vger.kernel.org>; Sun, 13 Mar 2016 16:26:33 -0700 (PDT)
Message-ID: <1457911590.16725.37.camel@googlemail.com>
Subject: Re: [PATCH v3 2/2] PCI: imx6: add initial imx6sx support
From: Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lee Jones <lee.jones@linaro.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Date: Mon, 14 Mar 2016 00:26:30 +0100
In-Reply-To: <20160311175850.GA4725@localhost>
References: <1456411669-4699-1-git-send-email-chf.fritz@googlemail.com>
	 <1456411669-4699-3-git-send-email-chf.fritz@googlemail.com>
	 <20160311175850.GA4725@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

On Fri, 2016-03-11 at 11:58 -0600, Bjorn Helgaas wrote:
> Hi Christoph (and Lee; there's a question for you below, too),

Thanks for your review, please see my answers and comments below.

> On Thu, Feb 25, 2016 at 03:47:49PM +0100, Christoph Fritz wrote:
> > This patch adds initial PCIe support for the imx6 SoC derivate imx6sx.
> > PCI_MSI support is untested as its necessary suspend/resume quirk is
> > left out of this patch.
> > This patch is heavily based on patches by Richard Zhu.
> > 
> > Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> > ---
> >  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |   6 +-
> >  drivers/pci/host/pci-imx6.c                        | 130 ++++++++++++++-------
> >  2 files changed, 96 insertions(+), 40 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > index 6fbba53..c4323be 100644
> > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > @@ -4,7 +4,7 @@ This PCIe host controller is based on the Synopsis Designware PCIe IP
> >  and thus inherits all the common properties defined in designware-pcie.txt.
> >  
> >  Required properties:
> > -- compatible: "fsl,imx6q-pcie"
> > +- compatible: "fsl,imx6q-pcie", "fsl,imx6sx-pcie"
> >  - reg: base addresse and length of the pcie controller
> 
> I folded in a typo fix for "addresse".
> 
> >  - interrupts: A list of interrupt outputs of the controller. Must contain an
> >    entry for each entry in the interrupt-names property.
> > @@ -13,6 +13,10 @@ Required properties:
> >  - clock-names: Must include the following additional entries:
> >  	- "pcie_phy"
> >  
> > +Additional required properties for imx6sx-pcie:
> > +- clock names: Must include the following additional entries:
> > +	- "pcie_inbound_axi"
> > +
> >  Example:
> >  
> >  	pcie@0x01000000 {
> > diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> > index fe60096..7e634a6 100644
> > --- a/drivers/pci/host/pci-imx6.c
> > +++ b/drivers/pci/host/pci-imx6.c
> > @@ -35,9 +35,11 @@ struct imx6_pcie {
> >  	struct gpio_desc	*reset_gpio;
> >  	struct clk		*pcie_bus;
> >  	struct clk		*pcie_phy;
> > +	struct clk		*pcie_inbound_axi;
> >  	struct clk		*pcie;
> >  	struct pcie_port	pp;
> >  	struct regmap		*iomuxc_gpr;
> > +	bool			is_imx6sx;
> >  	void __iomem		*mem_base;
> >  };
> >  
> > @@ -214,35 +216,46 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
> >  	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
> >  	u32 val, gpr1, gpr12;
> >  
> > -	/*
> > -	 * If the bootloader already enabled the link we need some special
> > -	 * handling to get the core back into a state where it is safe to
> > -	 * touch it for configuration.  As there is no dedicated reset signal
> > -	 * wired up for MX6QDL, we need to manually force LTSSM into "detect"
> > -	 * state before completely disabling LTSSM, which is a prerequisite
> > -	 * for core configuration.

<snip>

> > +	} else {
> > +		/*
> > +		 * If the bootloader already enabled the link we need some
> > +		 * special handling to get the core back into a state where
> > +		 * it is safe to touch it for configuration.  As there is no
> > +		 * dedicated reset signal to manually force LTSSM into "detect"
> > +		 * state before completely disabling LTSSM, which is a
> > +		 * prerequisite for core configuration.
> 
> For example, you changed this comment, and now the last sentence is no
> longer a sentence.  I don't know if this was an editing mistake or if
> this comment really does need to change.  If it does need to change,
> it needs to stay a sentence.

I suppose Richard's intend was to get rid of the explicit mentioning of
"MX6QDL".
Since I don't touch this code I'll drop this change and leave this
comment as it is.

> 
> > +		 * If both LTSSM_ENABLE and REF_SSP_ENABLE are active we have
> > +		 * a strong indication that the bootloader activated the link.
> > +		 */
> > +		regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1, &gpr1);
> > +		regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, &gpr12);
> > +
> > +		if ((gpr1 & IMX6Q_GPR1_PCIE_REF_CLK_EN) &&
> > +				(gpr12 & IMX6Q_GPR12_PCIE_CTL_2)) {
> > +			val = readl(pp->dbi_base + PCIE_PL_PFLR);
> > +			val &= ~PCIE_PL_PFLR_LINK_STATE_MASK;
> > +			val |= PCIE_PL_PFLR_FORCE_LINK;
> > +			writel(val, pp->dbi_base + PCIE_PL_PFLR);
> > +
> > +			regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > +				IMX6Q_GPR12_PCIE_CTL_2, 0);
> > +		}
> >  
> > -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > -			IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
> > -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > -			IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
> > +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > +			IMX6Q_GPR1_PCIE_TEST_PD,
> > +			IMX6Q_GPR1_PCIE_TEST_PD);
> > +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > +			IMX6Q_GPR1_PCIE_REF_CLK_EN, 0);
> 
> And there are subtle changes here (changing "1 << 18" to
> IMX6Q_GPR1_PCIE_TEST_PD, etc.)  These are fine, but should be in a
> separate patch because (a) they're not related to imx6sx and (b) it
> makes them obvious and easy to review.  As it is, they just get snuck
> in under the radar.

OK

> 
> > +	}
> >  
> >  	return 0;
> >  }
> > @@ -270,18 +283,30 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
> >  		goto err_pcie;
> >  	}
> >  
> > -	/* power up core phy and enable ref clock */
> > -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > -			IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
> > -	/*
> > -	 * the async reset input need ref clock to sync internally,
> > -	 * when the ref clock comes after reset, internal synced
> > -	 * reset time is too short, cannot meet the requirement.
> > -	 * add one ~10us delay here.
> > -	 */
> > -	udelay(10);
> > -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > -			IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
> > +	if (imx6_pcie->is_imx6sx) {
> > +		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
> > +		if (ret) {
> > +			dev_err(pp->dev, "unable to enable pcie_axi clock\n");
> > +			goto err_inbound_axi;
> > +		}
> > +
> > +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > +			IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
> > +	} else {
> > +		/* power up core phy and enable ref clock */
> > +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > +				IMX6Q_GPR1_PCIE_TEST_PD, 0);
> > +		/*
> > +		 * the async reset input need ref clock to sync internally,
> > +		 * when the ref clock comes after reset, internal synced
> > +		 * reset time is too short , cannot meet the requirement.
> > +		 * add one ~10us delay here.
> > +		 */
> > +		udelay(10);
> > +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > +			IMX6Q_GPR1_PCIE_REF_CLK_EN,
> > +			IMX6Q_GPR1_PCIE_REF_CLK_EN);
> > +	}
> 
> Here again the diff is bigger than necessary because it re-indents the
> original code (and makes another unrelated "1 << 16" to
> IMX6Q_GPR1_PCIE_REF_CLK_EN change).  I'll show a different proposal in
> my patch below.

OK

> 
> >  	/* allow the clocks to stabilize */
> >  	usleep_range(200, 500);
> > @@ -292,8 +317,15 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
> >  		msleep(100);
> >  		gpiod_set_value_cansleep(imx6_pcie->reset_gpio, 1);
> >  	}
> > +
> > +	if (imx6_pcie->is_imx6sx)
> > +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
> > +			IMX6SX_GPR5_PCIE_BTNRST_RESET, 0);
> > +
> >  	return 0;
> >  
> > +err_inbound_axi:
> > +	clk_disable_unprepare(imx6_pcie->pcie);
> >  err_pcie:
> >  	clk_disable_unprepare(imx6_pcie->pcie_bus);
> >  err_pcie_bus:
> > @@ -307,6 +339,12 @@ static void imx6_pcie_init_phy(struct pcie_port *pp)
> >  {
> >  	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
> >  
> > +	if (imx6_pcie->is_imx6sx) {
> > +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > +			IMX6SX_GPR12_PCIE_RX_EQ_MASK,
> > +			IMX6SX_GPR12_PCIE_RX_EQ_2);
> 
> I see that you added definitions for IMX6SX_GPR12_PCIE_RX_EQ_MASK and
> IMX6SX_GPR12_PCIE_RX_EQ_2 in the first patch of this series, but doing
> that separately creates a merge problem.  I can't put this change in
> my tree by itself because it won't build.  If Lee applied the first
> patch to a git branch, I guess I could pull that into my tree.  But it
> would be far simpler to just include those new definitions in this
> patch.

Sorry, Lee Jones already applied this patch to his public git
repository:

git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git

Commit id:

 987480efd6d39447981e96b438cf5a781b756712

currently in branch for-mfd-next

Is it okay for you to pull this commit?

It's also already in linux-next.

<snip>

> The patches below are what I currently have in my tree, but they're
> not ready for v4.6 (yet).
> 
> Note that the second one is very clearly imx6sx-only.  It's obvious
> there are no tweaks to the existing imx6 code, which makes it easier
> to review, backport, bisect, revert, etc.
> 
> Obviously, I can't apply these directly.  First we have to:
> 
>   - Fix the LTSSM comment
>   - Figure out how to get the IMX6SX_GPR12_PCIE_RX_EQ_MASK definitions
> 
> 
> commit 78abf60b815a8f28207d029d61f7809647faa43a
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Fri Mar 11 11:15:36 2016 -0600
> 
>     PCI: imx6: Factor out ref clock enable
>     
>     Factor out ref clock enable to make it cleaner to add imx6sx support.  No
>     functional change intended.
>     
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 8c9b389..ecc8537 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -269,6 +269,23 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)

<snip>

> -	udelay(10);
> -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -			IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
> +	ret = imx6_pcie_enable_ref_clk(imx6_pcie);
> +	if (ret)

a '{ ' is missing

> +		dev_err(pp->dev, "unable to enable pcie ref clock\n");
> +		goto err_ref_clk;
> +	}
>  
>  	/* allow the clocks to stabilize */
>  	usleep_range(200, 500);
> @@ -316,6 +326,8 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
>  	}
>  	return 0;
>  
> +err_ref_clk:
> +	clk_disable_unprepare(imx6_pcie->pcie);
>  err_pcie:
>  	clk_disable_unprepare(imx6_pcie->pcie_bus);
>  err_pcie_bus:
> 
> commit d061033570b7fd22a3ed8c029d4793e5df7324e1
> Author: Christoph Fritz <chf.fritz@googlemail.com>
> Date:   Thu Mar 10 15:04:25 2016 -0600
> 
>     PCI: imx6: Add initial imx6sx support
>     
>     Add initial PCIe support for the imx6 SoC derivate imx6sx.  PCI MSI support
>     is untested as the necessary suspend/resume quirk is not included in this
>     patch.
>     
>     This patch is heavily based on patches by Richard Zhu.
>     
>     [bhelgaas: factor out refclk enable, fix adjacent typos in fsl,imx6q-pcie.txt]
>     Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
>     Acked-by: Richard Zhu <Richard.Zhu@freescale.com>
>     Acked-by: Lucas Stach <l.stach@pengutronix.de>
> 

<snip>

> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index ecc8537..4d6af21 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -35,9 +35,11 @@ struct imx6_pcie {
>  	struct gpio_desc	*reset_gpio;
>  	struct clk		*pcie_bus;
>  	struct clk		*pcie_phy;

<snip>

>  	/*
>  	 * If the bootloader already enabled the link we need some special
>  	 * handling to get the core back into a state where it is safe to
>  	 * touch it for configuration.  As there is no dedicated reset signal
> -	 * wired up for MX6QDL, we need to manually force LTSSM into "detect"
> -	 * state before completely disabling LTSSM, which is a prerequisite
> -	 * for core configuration.
> +	 * to manually force LTSSM into "detect" state before completely
> +	 * disabling LTSSM, which is a prerequisite for core configuration.
>  	 *
>  	 * If both LTSSM_ENABLE and REF_SSP_ENABLE are active we have a strong
>  	 * indication that the bootloader activated the link.
> @@ -271,6 +283,18 @@ static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
>  
>  static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  {

this is missing:

	struct pcie_port *pp = &imx6_pcie->pp;
	int ret;




> +	if (imx6_pcie->is_imx6sx) {
> +		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
> +		if (ret) {
> +			dev_err(pp->dev, "unable to enable pcie_axi clock\n");
> +			return ret;
> +		}
> +
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
> +		return 0;

then we can use

	return ret;

instead
> +	}
> +
>  	/* power up core phy and enable ref clock */
>  	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,

<snip>

I'll fix these two patches and send them as follow up to this mail.

 Thanks
  -- Christoph

