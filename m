Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 28 Aug 2018 11:07:58 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [RESEND] PCI: imx: Initial imx7d pm support
Message-ID: <20180828100758.GA27217@e107981-ln.cambridge.arm.com>
References: <d577303de61fb060aa428898f5df1d0bc9be89b8.1535369231.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
In-Reply-To: <d577303de61fb060aa428898f5df1d0bc9be89b8.1535369231.git.leonard.crestez@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, kernel@pengutronix.de,
 Anson Huang <Anson.Huang@nxp.com>, Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 27, 2018 at 02:28:37PM +0300, Leonard Crestez wrote:
> On imx7d the pcie-phy power domain is turned off in suspend and this can
> make the system hang after resume when attempting any read from PCI.
> 
> Fix this by adding minimal suspend/resume code from the nxp internal
> tree. This will prepare for powering down on suspend and reset the block
> on resume.
> 
> Code is only for imx7d but a very similar sequence can be used for
> other socs.
> 
> The original author is mostly Richard Zhu <hongxing.zhu@nxp.com>, this
> patch adjusts the code to the upstream imx7d implemention using reset
> controls and power domains.

I will add a Suggested-by: replacing this paragraph, it is always better
to add proper tags rather than credit hidden in commit logs messages.

> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 97 +++++++++++++++++++++++++--
>  1 file changed, 92 insertions(+), 5 deletions(-)
> 
> Resending after RC1 as suggested here: https://lkml.org/lkml/2018/8/8/496
> 
> This was initially sent together with a dts fix, that was already
> accepted by Shawn: https://lkml.org/lkml/2018/8/21/529
> 
> Some dependencies in this area are complicated but as far as I know
> including this patch without others should not break anything that was
> not already broken. Since this is a patch for something that has never
> worked before it should be treated as a feature not a bugfix.

Ok, so I consider this v4.20 material, please shout if it has to be
sent as a fix, I do not think so given what we discussed above.

Lorenzo

> I have a few other patches for imx pci but it's better to deal with them
> separately. This initial patch adding suspend support is useful by
> itself.
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 4a9a673b4777..65b6d1015723 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -540,10 +540,28 @@ static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
>  
>  	dev_err(dev, "Speed change timeout\n");
>  	return -EINVAL;
>  }
>  
> +static void imx6_pcie_ltssm_enable(struct device *dev)
> +{
> +	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> +
> +	switch (imx6_pcie->variant) {
> +	case IMX6Q:
> +	case IMX6SX:
> +	case IMX6QP:
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				   IMX6Q_GPR12_PCIE_CTL_2,
> +				   IMX6Q_GPR12_PCIE_CTL_2);
> +		break;
> +	case IMX7D:
> +		reset_control_deassert(imx6_pcie->apps_reset);
> +		break;
> +	}
> +}
> +
>  static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
>  {
>  	struct dw_pcie *pci = imx6_pcie->pci;
>  	struct device *dev = pci->dev;
>  	u32 tmp;
> @@ -558,15 +576,11 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
>  	tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
>  	tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1;
>  	dw_pcie_writel_dbi(pci, PCIE_RC_LCR, tmp);
>  
>  	/* Start LTSSM. */
> -	if (imx6_pcie->variant == IMX7D)
> -		reset_control_deassert(imx6_pcie->apps_reset);
> -	else
> -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				   IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
> +	imx6_pcie_ltssm_enable(dev);
>  
>  	ret = imx6_pcie_wait_for_link(imx6_pcie);
>  	if (ret)
>  		goto err_reset_phy;
>  
> @@ -680,10 +694,82 @@ static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
>  
>  static const struct dw_pcie_ops dw_pcie_ops = {
>  	.link_up = imx6_pcie_link_up,
>  };
>  
> +#ifdef CONFIG_PM_SLEEP
> +static void imx6_pcie_ltssm_disable(struct device *dev)
> +{
> +	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> +
> +	switch (imx6_pcie->variant) {
> +	case IMX6SX:
> +	case IMX6QP:
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				   IMX6Q_GPR12_PCIE_CTL_2, 0);
> +		break;
> +	case IMX7D:
> +		reset_control_assert(imx6_pcie->apps_reset);
> +		break;
> +	default:
> +		dev_err(dev, "ltssm_disable not supported\n");
> +	}
> +}
> +
> +static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
> +{
> +	clk_disable_unprepare(imx6_pcie->pcie);
> +	clk_disable_unprepare(imx6_pcie->pcie_phy);
> +	clk_disable_unprepare(imx6_pcie->pcie_bus);
> +
> +	if (imx6_pcie->variant == IMX7D) {
> +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> +				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> +	}
> +}
> +
> +static int imx6_pcie_suspend_noirq(struct device *dev)
> +{
> +	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> +
> +	if (imx6_pcie->variant != IMX7D)
> +		return 0;
> +
> +	imx6_pcie_clk_disable(imx6_pcie);
> +	imx6_pcie_ltssm_disable(dev);
> +
> +	return 0;
> +}
> +
> +static int imx6_pcie_resume_noirq(struct device *dev)
> +{
> +	int ret;
> +	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> +	struct pcie_port *pp = &imx6_pcie->pci->pp;
> +
> +	if (imx6_pcie->variant != IMX7D)
> +		return 0;
> +
> +	imx6_pcie_assert_core_reset(imx6_pcie);
> +	imx6_pcie_init_phy(imx6_pcie);
> +	imx6_pcie_deassert_core_reset(imx6_pcie);
> +	dw_pcie_setup_rc(pp);
> +
> +	ret = imx6_pcie_establish_link(imx6_pcie);
> +	if (ret < 0)
> +		dev_info(dev, "pcie link is down after resume.\n");
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops imx6_pcie_pm_ops = {
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(imx6_pcie_suspend_noirq,
> +				      imx6_pcie_resume_noirq)
> +};
> +
>  static int imx6_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct dw_pcie *pci;
>  	struct imx6_pcie *imx6_pcie;
> @@ -846,10 +932,11 @@ static const struct of_device_id imx6_pcie_of_match[] = {
>  static struct platform_driver imx6_pcie_driver = {
>  	.driver = {
>  		.name	= "imx6q-pcie",
>  		.of_match_table = imx6_pcie_of_match,
>  		.suppress_bind_attrs = true,
> +		.pm = &imx6_pcie_pm_ops,
>  	},
>  	.probe    = imx6_pcie_probe,
>  	.shutdown = imx6_pcie_shutdown,
>  };
>  
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
