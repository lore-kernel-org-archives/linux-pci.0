Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.g1.pair.com ([66.39.3.162]:43214 "EHLO mail1.g1.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753458Ab3ILGoH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 12 Sep 2013 02:44:07 -0400
Date: Thu, 12 Sep 2013 14:44:01 +0800
From: Sean Cross <xobs@kosagi.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Shawn Guo <shawn.guo@linaro.org>
Message-ID: <6FF3113C3FCC43A4A0D711C8656A4C03@kosagi.com>
In-Reply-To: <20130912062859.GM30088@pengutronix.de>
References: <1378958611-4274-1-git-send-email-xobs@kosagi.com>
 <1378958611-4274-4-git-send-email-xobs@kosagi.com>
 <20130912062859.GM30088@pengutronix.de>
Subject: Re: [PATCH v3 3/3] PCI: imx6: Add support for i.MX6 PCIe
 controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Sean,
> 
> Several more comments.
> 
> Shawn,
> 
> A question about a clk_set_parent inside.
> 
> On Thu, Sep 12, 2013 at 04:03:31AM +0000, Sean Cross wrote:
> > +
> > +#define IMX6_ENTER_RESET 0
> > +#define IMX6_EXIT_RESET 1
> 
> 
> 
> These are unused
> 
> > +
> > +#define IMX6_POWER_OFF 0
> > +#define IMX6_POWER_ON 1
> 
> 
> 
> unused aswell
> 
Thanks.  These leaked out from an earlier revision of the code.  I'll remove them. 
> 
> > +static int pcie_phy_poll_ack(void __iomem *dbi_base, int max_iterations,
> > + int exp_val)
> > +{
> > + u32 val;
> > + u32 wait_counter = 0;
> > +
> > + do {
> > + val = readl(dbi_base + PCIE_PHY_STAT);
> > + val = (val >> PCIE_PHY_STAT_ACK_LOC) & 0x1;
> > + wait_counter++;
> > + } while ((wait_counter < max_iterations) && (val != exp_val));
> 
> 
> 
> may_iterations is never something else than 100 so you should drop the
> argument.
> Also I would prefer a real timeout here rather than a counter.

Is there a construct to have a real timer?  Would a completion work here instead? 
> > +
> > + if (val != exp_val)
> > + return -1;
> 
> 
> 
> By saying "A negative error value" I actually meant one of
> include/uapi/asm-generic/errno*

Of course.  How silly of me.  I'll fix that correctly. 
> > +static int pcie_phy_write(void __iomem *dbi_base, int addr, int data)
> > +{
> > + u32 var;
> > +
> > + /* write addr */
> > + /* cap addr */
> > + if (pcie_phy_wait_ack(dbi_base, addr))
> > + return -1;
> > +
> > + var = data << PCIE_PHY_CTRL_DATA_LOC;
> > + writel(var, dbi_base + PCIE_PHY_CTRL);
> > +
> > + /* capture data */
> > + var |= (0x1 << PCIE_PHY_CTRL_CAP_DAT_LOC);
> > + writel(var, dbi_base + PCIE_PHY_CTRL);
> > +
> > + /* wait for ack */
> 
> 
> 
> Drop this comment.
> 
> > + if (pcie_phy_poll_ack(dbi_base, 100, 1))
> > + return -1;
> > +
> 
> 
> 
> ...
> 
> > +static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
> > +{
> > + int ret;
> > + struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
> > +
> > + if (imx6_pcie->power_on_gpio >= 0)
> > + gpio_set_value(imx6_pcie->power_on_gpio, IMX6_POWER_ON);
> 
> 
> 
> in probe you used gpio_is_valid(). Why not here?
Again, leftover from when that used to be exynos_pcie_assert_reset().  I'll change it to use gpio_is_valid(). 
> > +
> > + regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > + IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
> > + regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > + IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
> > +
> > + ret = clk_set_parent(imx6_pcie->lvds1_sel, imx6_pcie->sata_ref);
> > + if (ret) {
> > + dev_err(pp->dev, "unable to set lvds1_gate parent\n");
> > + goto err_set_parent;
> > + }
> 
> 
> 
> I'm unsure this should be done here. Shawn, should we do this in SoC
> code?

A different board could easily use lvds2 to drive the PCIe clock.  I think that I should change the variable names to simply "lvds_sel". 
> > +
> > + ret = clk_prepare_enable(imx6_pcie->pcie_ref_125m);
> > + if (ret) {
> > + dev_err(pp->dev, "unable to enable pcie_ref_125m\n");
> > + goto err_pcie_ref;
> > + }
> > +
> > + ret = clk_prepare_enable(imx6_pcie->lvds1_gate);
> > + if (ret) {
> > + dev_err(pp->dev, "unable to enable lvds1_gate\n");
> > + goto err_lvds1_gate;
> > + }
> > +
> > + ret = clk_prepare_enable(imx6_pcie->pcie_axi);
> > + if (ret) {
> > + dev_err(pp->dev, "unable to enable pcie_axi\n");
> > + goto err_pcie_axi;
> > + }
> > +
> > + /* allow the clocks to stabilize */
> > + usleep_range(100, 200);
> > +
> > + return 0;
> > +
> > +err_pcie_axi:
> > + clk_disable(imx6_pcie->lvds1_gate);
> 
> 
> 
> The counterpart of clk_prepare_enable is clk_disable_unprepare.
I'll fix this, too. 
> > + return;
> > + }
> > + }
> > +
> > + return;
> 
> 
> 
> unnecessary return
I'll turn it into a "break" then. 
> > +
> > + imx6_pcie->power_on_gpio = of_get_named_gpio(np, "power-on-gpio", 0);
> > + if (gpio_is_valid(imx6_pcie->power_on_gpio))
> > + devm_gpio_request_one(&pdev->dev, imx6_pcie->power_on_gpio,
> > + GPIOF_OUT_INIT_LOW,
> > + "PCIe power enable");
> 
> 
> 
> devm_gpio_request_one can still fail.
It can fail, but it's only critical for the power switch.  However, arguably it's a critical error even if these GPIOs can't be allocated, so I'll go ahead and add the same consistency check and error return code to the other three switches. 
> > +
> > + imx6_pcie->wake_up_gpio = of_get_named_gpio(np, "wake-up-gpio", 0);
> > + if (gpio_is_valid(imx6_pcie->wake_up_gpio))
> > + devm_gpio_request_one(&pdev->dev, imx6_pcie->wake_up_gpio,
> > + GPIOF_IN,
> > + "PCIe wake up");
> > +
> > + imx6_pcie->disable_gpio = of_get_named_gpio(np, "disable-gpio", 0);
> > + if (gpio_is_valid(imx6_pcie->disable_gpio))
> > + devm_gpio_request_one(&pdev->dev, imx6_pcie->disable_gpio,
> > + GPIOF_OUT_INIT_HIGH,
> > + "PCIe disable endpoint");
> > +
> > + /* Fetch clocks */
> > + imx6_pcie->lvds1_sel = clk_get(&pdev->dev, "lvds1_sel");
> > + if (IS_ERR(imx6_pcie->lvds1_sel)) {
> > + dev_err(&pdev->dev,
> > + "lvds1_sel clock missing or invalid\n");
> > + ret = PTR_ERR(imx6_pcie->lvds1_sel);
> > + goto err;
> > + }
> > +
> > + imx6_pcie->lvds1_gate = clk_get(&pdev->dev, "lvds1_gate");
> > + if (IS_ERR(imx6_pcie->lvds1_gate)) {
> > + dev_err(&pdev->dev,
> > + "lvds1_gate clock select missing or invalid\n");
> > + ret = PTR_ERR(imx6_pcie->lvds1_gate);
> > + goto err;
> > + }
> 
> 
> 
> devm_clk_get(). Otherwise you need to release the clock un
> unregister/probe failure.

Good point. 
> > +static int __exit imx6_pcie_remove(struct platform_device *pdev)
> > +{
> > + struct imx6_pcie *imx6_pcie = platform_get_drvdata(pdev);
> > +
> > + clk_disable_unprepare(imx6_pcie->pcie_axi);
> > + clk_disable_unprepare(imx6_pcie->lvds1_gate);
> > + clk_disable_unprepare(imx6_pcie->pcie_ref_125m);
> 
> 
> 
> Still no unregister for the pcie controller?
The Designware core doesn't support unregistering (or even module unloading).  I'm not sure how to handle that case.  For that matter, when is remove() even called on a module that can't be unloaded?

