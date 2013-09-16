Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:57368 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947Ab3IPGWj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2013 02:22:39 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Sean Cross' <xobs@kosagi.com>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	'Sascha Hauer' <s.hauer@pengutronix.de>,
	'Zhu Richard-R65037' <r65037@freescale.com>,
	'Shawn Guo' <shawn.guo@linaro.org>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1379065222-7275-1-git-send-email-xobs@kosagi.com>
 <1379065222-7275-4-git-send-email-xobs@kosagi.com>
In-reply-to: <1379065222-7275-4-git-send-email-xobs@kosagi.com>
Subject: Re: [PATCH v4 3/3] PCI: imx6: Add support for i.MX6 PCIe controller
Date: Mon, 16 Sep 2013 15:22:37 +0900
Message-id: <000501ceb2a5$2373c260$6a5b4720$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, September 13, 2013 6:40 PM, Sean Cross wrote:
> 
> Add support for the PCIe port present on the i.MX6 family of controllers.
> These use the Synopsis Designware core tied to their own PHY.
> 
> Signed-off-by: Sean Cross <xobs@kosagi.com>

It looks good. :-)
But, I added some minor comments.

> ---
>  .../devicetree/bindings/pci/designware-pcie.txt    |    5 +
>  arch/arm/boot/dts/imx6qdl.dtsi                     |   16 +
>  arch/arm/mach-imx/Kconfig                          |    2 +
>  arch/arm/mach-imx/clk-imx6q.c                      |   11 +
>  drivers/pci/host/Kconfig                           |    6 +
>  drivers/pci/host/Makefile                          |    1 +
>  drivers/pci/host/pci-imx6.c                        |  482 ++++++++++++++++++++
>  7 files changed, 523 insertions(+)
>  create mode 100644 drivers/pci/host/pci-imx6.c

[.....]

> diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> index 679d49a..0a2093c 100644
> --- a/arch/arm/mach-imx/clk-imx6q.c
> +++ b/arch/arm/mach-imx/clk-imx6q.c
> @@ -622,6 +622,17 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
>  	if (ret)
>  		pr_warn("failed to set up CLKO: %d\n", ret);
> 
> +	/*
> +	 * All existing boards with PCIe run them off LVDS1
> +	 */
> +	if (IS_ENABLED(CONFIG_PCI_IMX6)) {
> +		clk_set_parent(clk[lvds1_sel], clk[sata_ref]);
> +		clk_prepare_enable(clk[lvds1_gate]);
> +		clk_prepare_enable(clk[pcie_ref_125m]);
> +		clk_prepare_enable(clk[pcie_axi]);
> +        }

Please use tab instead of spaces.

> +
> +

Please remove a duplicated line.

[.....]

> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_gpio.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/resource.h>
> +#include <linux/signal.h>
> +#include <linux/types.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>

If possible, please re-order in alphabetical order.

[.....]

> +static void imx6_pcie_host_init(struct pcie_port *pp)
> +{
> +	int count = 0;
> +	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
> +
> +	imx6_pcie_assert_core_reset(pp);
> +
> +	imx6_pcie_init_phy(pp);
> +
> +	imx6_pcie_deassert_core_reset(pp);
> +
> +	dw_pcie_setup_rc(pp);
> +
> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +			IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
> +
> +	while (!dw_pcie_link_up(pp)) {
> +		usleep_range(100, 1000);
> +		count++;
> +		if (count >= 10) {
> +			dev_err(pp->dev, "phy link never came up\n");
> +			dev_dbg(pp->dev,"DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",

Please insert space between pp->dev, and "DEBUG_R0 in order to fix the following
checkpatch error.

ERROR: space required after that ',' (ctx:VxV)
#407: FILE: drivers/pci/host/pci-imx6.c:276:
+                       dev_dbg(pp->dev,"DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",

Best regards,
Jingoo Han

