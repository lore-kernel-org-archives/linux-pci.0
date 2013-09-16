Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.g1.pair.com ([66.39.3.162]:35866 "EHLO mail1.g1.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752501Ab3IPGyi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 16 Sep 2013 02:54:38 -0400
Message-ID: <5236AB28.5060708@kosagi.com>
Date: Mon, 16 Sep 2013 14:54:32 +0800
From: Sean Cross <xobs@kosagi.com>
MIME-Version: 1.0
To: Shawn Guo <shawn.guo@linaro.org>
CC: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Zhu Richard-R65037 <r65037@freescale.com>
Subject: Re: [PATCH v4 3/3] PCI: imx6: Add support for i.MX6 PCIe controller
References: <1379065222-7275-1-git-send-email-xobs@kosagi.com> <1379065222-7275-4-git-send-email-xobs@kosagi.com> <20130916060631.GF31147@S2101-09.ap.freescale.net>
In-Reply-To: <20130916060631.GF31147@S2101-09.ap.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 16/9/13 2:06 PM, Shawn Guo wrote:
> On Fri, Sep 13, 2013 at 09:40:22AM +0000, Sean Cross wrote:
>> Add support for the PCIe port present on the i.MX6 family of controllers.
>> These use the Synopsis Designware core tied to their own PHY.
>>
>> Signed-off-by: Sean Cross <xobs@kosagi.com>
>> ---
>>   .../devicetree/bindings/pci/designware-pcie.txt    |    5 +
>>   arch/arm/boot/dts/imx6qdl.dtsi                     |   16 +
>>   arch/arm/mach-imx/Kconfig                          |    2 +
>>   arch/arm/mach-imx/clk-imx6q.c                      |   11 +
>>   drivers/pci/host/Kconfig                           |    6 +
>>   drivers/pci/host/Makefile                          |    1 +
>>   drivers/pci/host/pci-imx6.c                        |  482 ++++++++++++++++++++
>>   7 files changed, 523 insertions(+)
>>   create mode 100644 drivers/pci/host/pci-imx6.c
>>
>> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> index eabcb4b..41d8419 100644
>> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> @@ -21,6 +21,11 @@ Required properties:
>>   - num-lanes: number of lanes to use
>>   - reset-gpio: gpio pin number of power good signal
>>   
>> +Optional properties for fsl,imx6-pcie
>> +- power-on-gpio: gpio pin number of power-enable signal
>> +- wake-up-gpio: gpio pin number of incoming wakeup signal
>> +- disable-gpio: gpio pin number of outgoing rfkill/endpoint disable signal
>> +
>>   Example:
>>   
>>   SoC specific DT Entry:
>> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
>> index ccd55c2..ec72271 100644
>> --- a/arch/arm/boot/dts/imx6qdl.dtsi
>> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
>> @@ -116,6 +116,22 @@
>>   			arm,data-latency = <4 2 3>;
>>   		};
>>   
>> +		pcie: pcie@0x01000000 {
>> +			compatible = "fsl,imx6-pcie", "snps,dw-pcie";
> We generally use particular SoC name to specify the compatible string.
> So "fsl,imx6q-pcie" will be more appropriate.
Any reason to specify imx6q in particular?  It's also present on the 
imx6d, imx6dl, and imx6s (basically, everything but the imx6sl).
>
>>   	/* Set initial power mode */
>>   	imx6q_set_lpm(WAIT_CLOCKED);
>>   
>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>> index 3d95048..efa24d9 100644
>> --- a/drivers/pci/host/Kconfig
>> +++ b/drivers/pci/host/Kconfig
>> @@ -15,6 +15,12 @@ config PCI_EXYNOS
>>   	select PCIEPORTBUS
>>   	select PCIE_DW
>>   
>> +config PCI_IMX6
>> +	bool "Freescale i.MX6 PCIe controller"
>> +	depends on SOC_IMX6Q
>> +	select PCIEPORTBUS
>> +	select PCIE_DW
>> +
>>   config PCI_TEGRA
>>   	bool "NVIDIA Tegra PCIe controller"
>>   	depends on ARCH_TEGRA
>> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
>> index c9a997b..287d6a0 100644
>> --- a/drivers/pci/host/Makefile
>> +++ b/drivers/pci/host/Makefile
>> @@ -1,4 +1,5 @@
>>   obj-$(CONFIG_PCIE_DW) += pcie-designware.o
>>   obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
>> +obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
>>   obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
>>   obj-$(CONFIG_PCI_TEGRA) += pci-tegra.o
>> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
>> new file mode 100644
>> index 0000000..a3f9053
>> --- /dev/null
>> +++ b/drivers/pci/host/pci-imx6.c
>> @@ -0,0 +1,482 @@
>> +/*
>> + * PCIe host controller driver for Freescale i.MX6 SoCs
>> + *
>> + * Copyright (C) 2013 Kosagi
>> + *		http://www.kosagi.com
>> + *
>> + * Author: Sean Cross <xobs@kosagi.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/gpio.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of_gpio.h>
>> +#include <linux/pci.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/resource.h>
>> +#include <linux/signal.h>
>> +#include <linux/types.h>
>> +#include <linux/regmap.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
>> +
>> +#include "pcie-designware.h"
>> +
>> +#define to_imx6_pcie(x)	container_of(x, struct imx6_pcie, pp)
>> +
>> +struct imx6_pcie {
>> +	int			reset_gpio;
>> +	int			power_on_gpio;
>> +	int			wake_up_gpio;
>> +	int			disable_gpio;
>> +	struct pcie_port	pp;
>> +	struct regmap		*iomuxc_gpr;
>> +	void __iomem		*mem_base;
>> +};
>> +
>> +/* PCIe Port Logic registers (memory-mapped) */
>> +#define PL_OFFSET 0x700
>> +#define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
>> +#define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
>> +
>> +#define PCIE_PHY_CTRL (PL_OFFSET + 0x114)
>> +#define PCIE_PHY_CTRL_DATA_LOC 0
>> +#define PCIE_PHY_CTRL_CAP_ADR_LOC 16
>> +#define PCIE_PHY_CTRL_CAP_DAT_LOC 17
>> +#define PCIE_PHY_CTRL_WR_LOC 18
>> +#define PCIE_PHY_CTRL_RD_LOC 19
>> +
>> +#define PCIE_PHY_STAT (PL_OFFSET + 0x110)
>> +#define PCIE_PHY_STAT_DATA_LOC 0
>> +#define PCIE_PHY_STAT_ACK_LOC 16
>> +
>> +/* PHY registers (not memory-mapped) */
>> +#define PCIE_PHY_RX_ASIC_OUT 0x100D
>> +
>> +#define PHY_RX_OVRD_IN_LO 0x1005
>> +#define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1<<5)
> (1 << 5), please.
>
>> +#define PHY_RX_OVRD_IN_LO_RX_PLL_EN (1<<3)
> Ditto
>
>> +
>> +static int pcie_phy_poll_ack(void __iomem *dbi_base, int exp_val)
>> +{
>> +	u32 val;
>> +	u32 max_iterations = 10;
>> +	u32 wait_counter = 0;
>> +
>> +	do {
>> +		val = readl(dbi_base + PCIE_PHY_STAT);
>> +		val = (val >> PCIE_PHY_STAT_ACK_LOC) & 0x1;
>> +		wait_counter++;
>> +		udelay(1);
>> +	} while ((wait_counter < max_iterations) && (val != exp_val));
>> +
>> +	if (val != exp_val)
>> +		return -ETIMEDOUT;
>> +
>> +	return 0;
>> +}
>> +
>> +static int pcie_phy_wait_ack(void __iomem *dbi_base, int addr)
>> +{
>> +	u32 val;
>> +	int ret;
>> +
>> +	val = addr << PCIE_PHY_CTRL_DATA_LOC;
>> +	writel(val, dbi_base + PCIE_PHY_CTRL);
>> +
>> +	val |= (0x1 << PCIE_PHY_CTRL_CAP_ADR_LOC);
>> +	writel(val, dbi_base + PCIE_PHY_CTRL);
>> +
>> +	ret = pcie_phy_poll_ack(dbi_base, 1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	val = addr << PCIE_PHY_CTRL_DATA_LOC;
>> +	writel(val, dbi_base + PCIE_PHY_CTRL);
>> +
>> +	ret = pcie_phy_poll_ack(dbi_base, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +/* Read from the 16-bit PCIe PHY control registers (not memory-mapped) */
>> +static int pcie_phy_read(void __iomem *dbi_base, int addr , int *data)
>> +{
>> +	u32 val, phy_ctl;
>> +	int ret;
>> +
>> +	ret = pcie_phy_wait_ack(dbi_base, addr);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* assert Read signal */
>> +	phy_ctl = 0x1 << PCIE_PHY_CTRL_RD_LOC;
>> +	writel(phy_ctl, dbi_base + PCIE_PHY_CTRL);
>> +
>> +	ret = pcie_phy_poll_ack(dbi_base, 1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	val = readl(dbi_base + PCIE_PHY_STAT);
>> +	*data = (val & (0xffff << PCIE_PHY_STAT_DATA_LOC));
> One unnecessary parentheses.
>
>> +
>> +	/* deassert Read signal */
>> +	writel(0x00, dbi_base + PCIE_PHY_CTRL);
>> +
>> +	ret = pcie_phy_poll_ack(dbi_base, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +static int pcie_phy_write(void __iomem *dbi_base, int addr, int data)
>> +{
>> +	u32 var;
>> +	int ret;
>> +
>> +	/* write addr */
>> +	/* cap addr */
>> +	ret = pcie_phy_wait_ack(dbi_base, addr);
>> +	if (ret)
>> +		return ret;
>> +
>> +	var = data << PCIE_PHY_CTRL_DATA_LOC;
>> +	writel(var, dbi_base + PCIE_PHY_CTRL);
>> +
>> +	/* capture data */
>> +	var |= (0x1 << PCIE_PHY_CTRL_CAP_DAT_LOC);
>> +	writel(var, dbi_base + PCIE_PHY_CTRL);
>> +
>> +	ret = pcie_phy_poll_ack(dbi_base, 1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* deassert cap data */
>> +	var = data << PCIE_PHY_CTRL_DATA_LOC;
>> +	writel(var, dbi_base + PCIE_PHY_CTRL);
>> +
>> +	/* wait for ack de-assetion */
>> +	ret = pcie_phy_poll_ack(dbi_base, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* assert wr signal */
>> +	var = 0x1 << PCIE_PHY_CTRL_WR_LOC;
>> +	writel(var, dbi_base + PCIE_PHY_CTRL);
>> +
>> +	/* wait for ack */
>> +	ret = pcie_phy_poll_ack(dbi_base, 1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* deassert wr signal */
>> +	var = data << PCIE_PHY_CTRL_DATA_LOC;
>> +	writel(var, dbi_base + PCIE_PHY_CTRL);
>> +
>> +	/* wait for ack de-assetion */
>> +	ret = pcie_phy_poll_ack(dbi_base, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	writel(0x0, dbi_base + PCIE_PHY_CTRL);
>> +
>> +	return 0;
>> +}
>> +
>> +static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
>> +{
>> +	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
> Nit: have a blank line here.
>
>> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
>> +			IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
>> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>> +			IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
>> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
>> +			IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
>> +
>> +	gpio_set_value(imx6_pcie->reset_gpio, 0);
>> +	msleep(100);
>> +	gpio_set_value(imx6_pcie->reset_gpio, 1);
>> +
>> +	return 0;
>> +}
>> +
>> +static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
>> +{
>> +	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
>> +
>> +	if (gpio_is_valid(imx6_pcie->power_on_gpio))
>> +		gpio_set_value(imx6_pcie->power_on_gpio, 1);
>> +
>> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
>> +			IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
>> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
>> +			IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
>> +
>> +	/* allow the clocks to stabilize */
>> +	usleep_range(100, 200);
>> +
>> +	return 0;
>> +}
>> +
>> +static void imx6_pcie_init_phy(struct pcie_port *pp)
>> +{
>> +	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
>> +
>> +	/* FIXME the field name should be aligned to RM */
> Why cannot this be fixed right now?
The FIXME is left over from an earlier incarnation.  I don't think it's 
relevant anymore.  I'll drop it.
>> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>> +			IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
>> +
>> +	/* configure constant input signal to the pcie ctrl and phy */
>> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>> +			IMX6Q_GPR12_DEVICE_TYPE, PCI_EXP_TYPE_ROOT_PORT << 12);
>> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>> +			IMX6Q_GPR12_LOS_LEVEL, 9 << 4);
>> +
>> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
>> +			IMX6Q_GPR8_TX_DEEMPH_GEN1, 0 << 0);
>> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
>> +			IMX6Q_GPR8_TX_DEEMPH_GEN2_3P5DB, 0 << 6);
>> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
>> +			IMX6Q_GPR8_TX_DEEMPH_GEN2_6DB, 20 << 12);
>> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
>> +			IMX6Q_GPR8_TX_SWING_FULL, 127 << 18);
>> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
>> +			IMX6Q_GPR8_TX_SWING_LOW, 127 << 25);
>> +}
>> +
>> +static void imx6_pcie_host_init(struct pcie_port *pp)
>> +{
>> +	int count = 0;
>> +	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
>> +
>> +	imx6_pcie_assert_core_reset(pp);
>> +
>> +	imx6_pcie_init_phy(pp);
>> +
>> +	imx6_pcie_deassert_core_reset(pp);
>> +
>> +	dw_pcie_setup_rc(pp);
>> +
>> +	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>> +			IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
>> +
>> +	while (!dw_pcie_link_up(pp)) {
>> +		usleep_range(100, 1000);
>> +		count++;
>> +		if (count >= 10) {
>> +			dev_err(pp->dev, "phy link never came up\n");
>> +			dev_dbg(pp->dev,"DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
>> +				readl(pp->dbi_base + PCIE_PHY_DEBUG_R0),
>> +				readl(pp->dbi_base + PCIE_PHY_DEBUG_R1));
>> +			break;
>> +		}
>> +	}
>> +
>> +	return;
>> +}
>> +
>> +static int imx6_pcie_link_up(struct pcie_port *pp)
>> +{
>> +	u32 rc, ltssm, rx_valid, temp;
>> +
>> +	/* link is debug bit 36, debug register 1 starts at bit 32 */
>> +	rc = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1) & (0x1 << (36 - 32));
>> +	if (rc)
>> +		return -EAGAIN;
>> +
>> +	/* From L0, initiate MAC entry to gen2 if EP/RC supports gen2.
>> +	 * Wait 2ms (LTSSM timeout is 24ms, PHY lock is ~5us in gen2).
>> +	 * If (MAC/LTSSM.state == Recovery.RcvrLock)
>> +	 * && (PHY/rx_valid==0) then pulse PHY/rx_reset. Transition
>> +	 * to gen2 is stuck
>> +	 */
> 	/*
> 	 * Multiple lines comment
> 	 * ...
> 	 */
>
>> +	pcie_phy_read(pp->dbi_base, PCIE_PHY_RX_ASIC_OUT, &rx_valid);
>> +	ltssm = readl(pp->dbi_base + PCIE_PHY_DEBUG_R0) & 0x3F;
>> +
>> +	if (rx_valid & 0x01)
>> +		return 0;
>> +
>> +	if (ltssm != 0x0d)
>> +		return 0;
>> +
>> +	dev_err(pp->dev,
>> +		"transition to gen2 is stuck, reset PHY!\n");
>> +
>> +	pcie_phy_read(pp->dbi_base,
>> +		PHY_RX_OVRD_IN_LO, &temp);
>> +	temp |= (PHY_RX_OVRD_IN_LO_RX_DATA_EN
>> +		| PHY_RX_OVRD_IN_LO_RX_PLL_EN);
>> +	pcie_phy_write(pp->dbi_base,
>> +		PHY_RX_OVRD_IN_LO, temp);
>> +
>> +	usleep_range(2000, 3000);
>> +
>> +	pcie_phy_read(pp->dbi_base,
>> +		PHY_RX_OVRD_IN_LO, &temp);
>> +	temp &= ~(PHY_RX_OVRD_IN_LO_RX_DATA_EN
>> +		| PHY_RX_OVRD_IN_LO_RX_PLL_EN);
>> +	pcie_phy_write(pp->dbi_base,
>> +		PHY_RX_OVRD_IN_LO, temp);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct pcie_host_ops imx6_pcie_host_ops = {
>> +	.link_up = imx6_pcie_link_up,
>> +	.host_init = imx6_pcie_host_init,
>> +};
>> +
>> +static int add_pcie_port(struct pcie_port *pp, struct platform_device *pdev)
> imx6_pcie_add_port to have the proper namespace?
I thought this was the style for pci drivers, because
>> +{
>> +	int ret;
>> +
>> +	pp->irq = platform_get_irq(pdev, 0);
>> +	if (!pp->irq) {
>> +		dev_err(&pdev->dev, "failed to get irq\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	pp->root_bus_nr = -1;
>> +	pp->ops = &imx6_pcie_host_ops;
>> +
>> +	spin_lock_init(&pp->conf_lock);
>> +	ret = dw_pcie_host_init(pp);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "failed to initialize host\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int __init imx6_pcie_probe(struct platform_device *pdev)
>> +{
>> +	struct imx6_pcie *imx6_pcie;
>> +	struct pcie_port *pp;
>> +	struct device_node *np = pdev->dev.of_node;
>> +	struct resource *dbi_base;
>> +	int ret;
>> +
>> +	imx6_pcie = devm_kzalloc(&pdev->dev, sizeof(*imx6_pcie),
>> +				GFP_KERNEL);
>> +	if (!imx6_pcie)
>> +		return -ENOMEM;
>> +
>> +	pp = &imx6_pcie->pp;
>> +	pp->dev = &pdev->dev;
>> +
>> +	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!dbi_base) {
>> +		dev_err(&pdev->dev, "dbi_base memory resource not found\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	pp->dbi_base = devm_request_and_ioremap(&pdev->dev, dbi_base);
>> +	if (IS_ERR(pp->dbi_base)) {
>> +		dev_err(&pdev->dev, "unable to remap dbi_base\n");
>> +		ret = PTR_ERR(pp->dbi_base);
>> +		goto err;
>> +	}
> See kerneldoc of devm_request_and_ioremap().  I believe that the help
> already takes care of printing error messages.
This is a very good catch.  devm_request_and_ioremap() is deprecated and 
in the process of getting removed.  I'll replace the call and see what's 
best in terms of error messages.
>> +
>> +	/* Fetch GPIOs */
>> +	imx6_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
>> +	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
>> +		ret = devm_gpio_request_one(&pdev->dev,
>> +					imx6_pcie->reset_gpio,
>> +					GPIOF_OUT_INIT_LOW,
>> +					"PCIe reset");
>> +		if (ret) {
>> +			dev_err(&pdev->dev, "unable to get reset gpio\n");
>> +			goto err;
>> +		}
>> +	}
> The reset-gpio is not optional but required.  So if we do not have a
> valid reset-gpio, the probe should fail.  And that's why we can access
> reset_gpio in imx6_pcie_assert_core_reset() without checking if it's
> valid.
That is a very good call.  I'll make the reset-gpio actually required.
>> +
>> +	imx6_pcie->power_on_gpio = of_get_named_gpio(np, "power-on-gpio", 0);
>> +	if (gpio_is_valid(imx6_pcie->power_on_gpio)) {
>> +		ret = devm_gpio_request_one(&pdev->dev,
>> +					imx6_pcie->power_on_gpio,
>> +					GPIOF_OUT_INIT_LOW,
>> +					"PCIe power enable");
>> +		if (ret) {
>> +			dev_err(&pdev->dev, "unable to get power-on gpio\n");
>> +			goto err;
>> +		}
>> +	}
>> +
>> +	imx6_pcie->wake_up_gpio = of_get_named_gpio(np, "wake-up-gpio", 0);
>> +	if (gpio_is_valid(imx6_pcie->wake_up_gpio)) {
>> +		ret = devm_gpio_request_one(&pdev->dev,
>> +					imx6_pcie->wake_up_gpio,
>> +					GPIOF_IN,
>> +					"PCIe wake up");
>> +		if (ret) {
>> +			dev_err(&pdev->dev, "unable to get wake-up gpio\n");
>> +			goto err;
>> +		}
>> +	}
>> +
>> +	imx6_pcie->disable_gpio = of_get_named_gpio(np, "disable-gpio", 0);
>> +	if (gpio_is_valid(imx6_pcie->disable_gpio)) {
>> +		ret = devm_gpio_request_one(&pdev->dev,
>> +					imx6_pcie->disable_gpio,
>> +					GPIOF_OUT_INIT_HIGH,
>> +					"PCIe disable endpoint");
>> +		if (ret) {
>> +			dev_err(&pdev->dev, "unable to get disable-ep gpio\n");
>> +			goto err;
>> +		}
>> +	}
>> +
>> +	/* Grab GPR config register range */
>> +	imx6_pcie->iomuxc_gpr =
>> +		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
>> +	if (IS_ERR(imx6_pcie->iomuxc_gpr)) {
>> +		dev_err(&pdev->dev, "unable to find iomuxc registers\n");
>> +		ret = PTR_ERR(imx6_pcie->iomuxc_gpr);
>> +		goto err;
>> +	}
>> +
>> +	ret = add_pcie_port(pp, pdev);
>> +	if (ret < 0)
>> +		goto err;
>> +
>> +	platform_set_drvdata(pdev, imx6_pcie);
>> +	return 0;
>> +
>> +err:
>> +	return ret;
>> +}
>> +
>> +static const struct of_device_id imx6_pcie_of_match[] = {
>> +	{ .compatible = "fsl,imx6-pcie", },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, imx6_pcie_of_match);
>> +
>> +static struct platform_driver imx6_pcie_driver = {
>> +	.driver = {
>> +		.name	= "imx6-pcie",
>> +		.owner	= THIS_MODULE,
>> +		.of_match_table = of_match_ptr(imx6_pcie_of_match),
>> +	},
>> +};
>> +
>> +/* Freescale PCIe driver does not allow module unload */
>> +
>> +static int __init pcie_init(void)
>> +{
>> +	return platform_driver_probe(&imx6_pcie_driver, imx6_pcie_probe);
>> +}
>> +subsys_initcall(pcie_init);
> Any reason why it cannot be module_init()?
>
No reason whatsoever.  I'll rename pcie_init to module_init.
