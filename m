Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39861 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752104AbcBYRBv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 25 Feb 2016 12:01:51 -0500
Date: Thu, 25 Feb 2016 11:01:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Vineet.Gupta1@synopsys.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	CARLOS.PALMINHA@synopsys.com, Alexey.Brodkin@synopsys.com,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org, arnd@arndb.de,
	Murali Karicheri <m-karicheri2@ti.com>
Subject: Re: [PATCH RESEND v9 2/2] pcie-designware platform driver
Message-ID: <20160225170145.GA31473@localhost>
References: <cover.1454952698.git.jpinto@synopsys.com>
 <9069117816a5cd9cc3314b6d584c26d457807b8e.1454952698.git.jpinto@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9069117816a5cd9cc3314b6d584c26d457807b8e.1454952698.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Murali]

On Wed, Feb 17, 2016 at 05:46:19PM +0000, Joao Pinto wrote:
> The "wait for link" routine was centralised and so all drivers using it
> (dra7xx, exynos, imx6 and spear13xx) were updated to include the new
> function. The keystone driver was not updated because it had some custom
> opreations in the link waiting loop. 

I'm dubious about the keystone code:

  ks_pcie_establish_link(...)
  {
    if (dw_pcie_link_up(...))
      return 0;

    ks_dw_pcie_initiate_link_train(...);
    for (retries = 0; retries < 200; retries++) {
      if (dw_pcie_link_up(...))
        return 0;
      usleep_range(100, 1000);
      ks_dw_pcie_initiate_link_train(...);
    }
  }

It doesn't seem reasonable to me to disable, then re-initiate link
training every time around the loop, after waiting only 100 to 1000
usec.  What if we did somethin like this:

  ks_pcie_establish_link(...)
  {
    if (dw_pcie_link_up(...))
      return 0;

    for (retries = 0; retries < 5; retries++) {
      ks_dw_pcie_initiate_link_train(...);
      if (!dw_pcie_wait_for_link(...))
        return 0;
    }

Murali, any thoughts on this?

Was there a reason you didn't update pcie-qcom.c?

> A simple module (pcie-designware-plat) was created to contain the 
> specific platform init code for pcie-designware.
> 
> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
> ---
> Change v8 -> v9 (Bjorn Helgaas and Arnd Bergmann):
> - wait for link routine was moved to pcie-designware, this implicated
>   an update in ra7xx, exynos, imx6 and spear13xx pcie drivers
> - the proposed synopsys pcie rc platform driver is now a simple module
>   that uses pcie-designware functions only and has no custom features
> - the designware-pcie.txt was updated with a DT example
> Change v7 -> v8 (Bjorn Helgaas and Arnd Bergmann):
> - driver name was changed from pcie-synopsys to pcie-dw-pltfm
> - mdelay() replaced for msleep() in the new driver
> - Devicetree bindings for the new driver was updated (config space removed
> from ranges)
> - Unnecessary synopsys_pcie_irq_handler() was removed
> - Driver compatibility strings updated
> Change v6 -> v7 (Bjorn Helgaas):
> - driver name was changed from pcie-snpsdev to pcie-synopsys
> - driver internals (functions and certain variables) also changed name
> accordingly
> - devicetree bindings documentation also changed accordingly
> - quirk function dw_pcie_link_retrain() was removed (tests were made
> successfully without it)
> - driver was changed to meet pci standards (link up confirmation routine,
> init rc functions, etc.)
> - EPROBE_DEFER were removed
> Change v5 -> v6:
> - Nothing changed (just to keep up with patch set version).
> Change v4 -> v5:
> - Nothing changed (just to keep up with patch set version).
> Changes v3 -> v4 (Bjorn Helgaas):
> - ARCH dependencies were added to the drivers/pci/host/kconfig for the
> PCIE_SNPSDEV.
> Changes v2 -> v3 (Bjorn Helgaas):
> - link init stuff was moved to a snpsdev_pcie_establish_link() function in
> pcie-snpsdev
> - pcie-snpsdev driver declaration was changed to be more 
> standard (Bjorn Helgaas)
> - pcie-designware' dw_pcie_link_retrain() now use standard registers from
> pci-regs.h (Bjorn Helgaas)
> - pcie-snpsdev.txt was complemented with more info (Mark Rutland)
> Changes v1 -> v2 (Bjorn Helgaas):
> - Fixups snpsdev_pcie_fixup_bridge() and snpsdev_pcie_fixup_res() were removed
> from the driver (these functions were for specific tests only and not usefull
> in mainline)
> - Driver' comments were reviewed (fix Typos and excessive comments removal)
> - Removed unnecessary definitions in the driver source (PCIE_PHY_CTRL and
> PCIE_PHY_STAT)
> 
>  .../devicetree/bindings/pci/designware-pcie.txt    |  17 +++
>  drivers/pci/host/Kconfig                           |  11 ++
>  drivers/pci/host/Makefile                          |   1 +
>  drivers/pci/host/pci-dra7xx.c                      |  11 +-
>  drivers/pci/host/pci-exynos.c                      |  11 +-
>  drivers/pci/host/pci-imx6.c                        |  11 +-
>  drivers/pci/host/pcie-designware-plat.c            | 143 +++++++++++++++++++++
>  drivers/pci/host/pcie-designware.c                 |  31 ++++-
>  drivers/pci/host/pcie-designware.h                 |   6 +
>  drivers/pci/host/pcie-spear13xx.c                  |  12 +-
>  10 files changed, 217 insertions(+), 37 deletions(-)
>  create mode 100644 drivers/pci/host/pcie-designware-plat.c
> 
> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> index 5b0853d..64f2fff 100644
> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> @@ -28,3 +28,20 @@ Optional properties:
>  - clock-names: Must include the following entries:
>  	- "pcie"
>  	- "pcie_bus"
> +
> +Example configuration:
> +
> +	pcie: pcie@0xdffff000 {
> +		compatible = "snps,dw-pcie";
> +		reg = <0xdffff000 0x1000>, /* Controller registers */
> +		      <0xd0000000 0x2000>; /* PCI config space */
> +		reg-names = "ctrlreg", "config";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		device_type = "pci";
> +		ranges = <0x81000000 0 0x00000000 0xde000000 0 0x00010000
> +			  0x82000000 0 0xd0400000 0xd0400000 0 0x0d000000>;
> +		interrupts = <25>, <24>;
> +		#interrupt-cells = <1>;
> +		num-lanes = <1>;
> +	};
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index f131ba9..b564f8a 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -15,6 +15,17 @@ config PCI_MVEBU
>  	depends on ARCH_MVEBU || ARCH_DOVE
>  	depends on OF
>  
> +config PCIE_DW_PLAT
> +	bool "Platform bus based DesignWare PCIe Controller"
> +	select PCIE_DW
> +	---help---
> +	 This selects the DesignWare PCIe controller support. Select this if
> +	 you have an PCIe controller on Platform bus.
> +
> +	 If you have a controller with this interface, say Y or M here.
> +
> +	 If unsure, say N.
> +
>  config PCIE_DW
>  	bool
>  
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index 9d4d3c6..d979121 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -1,4 +1,5 @@
>  obj-$(CONFIG_PCIE_DW) += pcie-designware.o
> +obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
>  obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
>  obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
>  obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
> index 8c36880..9b394bb 100644
> --- a/drivers/pci/host/pci-dra7xx.c
> +++ b/drivers/pci/host/pci-dra7xx.c
> @@ -10,7 +10,6 @@
>   * published by the Free Software Foundation.
>   */
>  
> -#include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> @@ -108,7 +107,6 @@ static int dra7xx_pcie_establish_link(struct pcie_port *pp)
>  {
>  	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
>  	u32 reg;
> -	unsigned int retries;
>  
>  	if (dw_pcie_link_up(pp)) {
>  		dev_err(pp->dev, "link is already up\n");
> @@ -119,13 +117,10 @@ static int dra7xx_pcie_establish_link(struct pcie_port *pp)
>  	reg |= LTSSM_EN;
>  	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
>  
> -	for (retries = 0; retries < 1000; retries++) {
> -		if (dw_pcie_link_up(pp))
> -			return 0;
> -		usleep_range(10, 20);
> -	}
> +	/* check if the link is up or not */
> +	if (!dw_pcie_wait_for_link(pp))
> +		return 0;
>  
> -	dev_err(pp->dev, "link is not up\n");
>  	return -EINVAL;
>  }
>  
> diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
> index 01095e1..bd26e15 100644
> --- a/drivers/pci/host/pci-exynos.c
> +++ b/drivers/pci/host/pci-exynos.c
> @@ -318,7 +318,6 @@ static int exynos_pcie_establish_link(struct pcie_port *pp)
>  {
>  	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
>  	u32 val;
> -	unsigned int retries;
>  
>  	if (dw_pcie_link_up(pp)) {
>  		dev_err(pp->dev, "Link already up\n");
> @@ -357,13 +356,8 @@ static int exynos_pcie_establish_link(struct pcie_port *pp)
>  			  PCIE_APP_LTSSM_ENABLE);
>  
>  	/* check if the link is up or not */
> -	for (retries = 0; retries < 10; retries++) {
> -		if (dw_pcie_link_up(pp)) {
> -			dev_info(pp->dev, "Link up\n");
> -			return 0;
> -		}
> -		mdelay(100);
> -	}
> +	if (!dw_pcie_wait_for_link(pp))
> +		return 0;
>  
>  	while (exynos_phy_readl(exynos_pcie, PCIE_PHY_PLL_LOCKED) == 0) {
>  		val = exynos_blk_readl(exynos_pcie, PCIE_PHY_PLL_LOCKED);
> @@ -372,7 +366,6 @@ static int exynos_pcie_establish_link(struct pcie_port *pp)
>  	/* power off phy */
>  	exynos_pcie_power_off_phy(pp);
>  
> -	dev_err(pp->dev, "PCIe Link Fail\n");
>  	return -EINVAL;
>  }
>  
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 22e8224..42c6930 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -330,15 +330,10 @@ static void imx6_pcie_init_phy(struct pcie_port *pp)
>  
>  static int imx6_pcie_wait_for_link(struct pcie_port *pp)
>  {
> -	unsigned int retries;
> -
> -	for (retries = 0; retries < 200; retries++) {
> -		if (dw_pcie_link_up(pp))
> -			return 0;
> -		usleep_range(100, 1000);
> -	}
> +	/* check if the link is up or not */
> +	if (!dw_pcie_wait_for_link(pp))
> +		return 0;
>  
> -	dev_err(pp->dev, "phy link never came up\n");
>  	dev_dbg(pp->dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
>  		readl(pp->dbi_base + PCIE_PHY_DEBUG_R0),
>  		readl(pp->dbi_base + PCIE_PHY_DEBUG_R1));
> diff --git a/drivers/pci/host/pcie-designware-plat.c b/drivers/pci/host/pcie-designware-plat.c
> new file mode 100644
> index 0000000..5f75aba
> --- /dev/null
> +++ b/drivers/pci/host/pcie-designware-plat.c
> @@ -0,0 +1,143 @@
> +/*
> + * PCIe RC driver for Synopsys Designware Core
> + *
> + * Copyright (C) 2015-2016 Synopsys, Inc. (www.synopsys.com)
> + *
> + * Authors: Joao Pinto <jpinto@synopsys.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_gpio.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/resource.h>
> +#include <linux/signal.h>
> +#include <linux/types.h>
> +
> +#include "pcie-designware.h"
> +
> +struct dw_plat_pcie {
> +	void __iomem		*mem_base;
> +	struct pcie_port	pp;
> +};
> +
> +static irqreturn_t dw_plat_pcie_msi_irq_handler(int irq, void *arg)
> +{
> +	struct pcie_port *pp = arg;
> +
> +	return dw_handle_msi_irq(pp);
> +}
> +
> +static void dw_plat_pcie_host_init(struct pcie_port *pp)
> +{
> +	dw_pcie_setup_rc(pp);
> +
> +	dw_pcie_wait_for_link(pp);
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		dw_pcie_msi_init(pp);
> +}
> +
> +static struct pcie_host_ops dw_plat_pcie_host_ops = {
> +	.host_init = dw_plat_pcie_host_init,
> +};
> +
> +static int dw_plat_add_pcie_port(struct pcie_port *pp,
> +				 struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	pp->irq = platform_get_irq(pdev, 1);
> +
> +	if (pp->irq < 0)
> +		return pp->irq;
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		pp->msi_irq = platform_get_irq(pdev, 0);
> +
> +		if (pp->msi_irq < 0)
> +			return pp->msi_irq;
> +
> +		ret = devm_request_irq(&pdev->dev, pp->msi_irq,
> +					dw_plat_pcie_msi_irq_handler,
> +					IRQF_SHARED, "dw-plat-pcie-msi", pp);
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to request msi irq\n");
> +			return ret;
> +		}
> +	}
> +
> +	pp->root_bus_nr = -1;
> +	pp->ops = &dw_plat_pcie_host_ops;
> +
> +	ret = dw_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to initialize host\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dw_plat_pcie_probe(struct platform_device *pdev)
> +{
> +	struct dw_plat_pcie *dw_plat_pcie;
> +	struct pcie_port *pp;
> +	struct resource *res;  /* Resource from DT */
> +	int ret;
> +
> +	dw_plat_pcie = devm_kzalloc(&pdev->dev, sizeof(*dw_plat_pcie),
> +					GFP_KERNEL);
> +	if (!dw_plat_pcie)
> +		return -ENOMEM;
> +
> +	pp = &dw_plat_pcie->pp;
> +	pp->dev = &pdev->dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	if (!res)
> +		return -ENODEV;
> +
> +	dw_plat_pcie->mem_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(dw_plat_pcie->mem_base))
> +		return PTR_ERR(dw_plat_pcie->mem_base);
> +
> +	pp->dbi_base = dw_plat_pcie->mem_base;
> +
> +	ret = dw_plat_add_pcie_port(pp, pdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, dw_plat_pcie);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id dw_plat_pcie_of_match[] = {
> +	{ .compatible = "snps,dw-pcie", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, dw_plat_pcie_of_match);
> +
> +static struct platform_driver dw_plat_pcie_driver = {
> +	.driver = {
> +		.name	= "dw-pcie",
> +		.of_match_table = dw_plat_pcie_of_match,
> +	},
> +	.probe = dw_plat_pcie_probe,
> +};
> +
> +module_platform_driver(dw_plat_pcie_driver);
> +
> +MODULE_AUTHOR("Joao Pinto <Joao.Pinto@synopsys.com>");
> +MODULE_DESCRIPTION("Synopsys PCIe host controller glue platform driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 540f077..68ca614 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -22,6 +22,7 @@
>  #include <linux/pci_regs.h>
>  #include <linux/platform_device.h>
>  #include <linux/types.h>
> +#include <linux/delay.h>
>  
>  #include "pcie-designware.h"
>  
> @@ -69,6 +70,11 @@
>  #define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
>  #define PCIE_ATU_UPPER_TARGET		0x91C
>  
> +/* PCIe Port Logic registers */
> +#define PCIE_PHY_DEBUG_R1_LINK_UP 0x00000010
> +#define PLR_OFFSET 0x700
> +#define PCIE_PHY_DEBUG_R1 (PLR_OFFSET + 0x2c)
> +
>  static struct pci_ops dw_pcie_ops;
>  
>  int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
> @@ -380,12 +386,33 @@ static struct msi_controller dw_pcie_msi_chip = {
>  	.teardown_irq = dw_msi_teardown_irq,
>  };
>  
> +int dw_pcie_wait_for_link(struct pcie_port *pp)
> +{
> +	int retries;
> +
> +	/* check if the link is up or not */
> +	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> +		if (dw_pcie_link_up(pp)) {
> +			dev_info(pp->dev, "link up\n");
> +			return 0;
> +		}
> +		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
> +	}
> +
> +	dev_err(pp->dev, "phy link never came up\n");
> +
> +	return 1;
> +}
> +
>  int dw_pcie_link_up(struct pcie_port *pp)
>  {
> +	u32 val;
> +
>  	if (pp->ops->link_up)
>  		return pp->ops->link_up(pp);
> -	else
> -		return 0;
> +
> +	val = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1);
> +	return val & PCIE_PHY_DEBUG_R1_LINK_UP;
>  }
>  
>  static int dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
> index 2356d29..8e42624 100644
> --- a/drivers/pci/host/pcie-designware.h
> +++ b/drivers/pci/host/pcie-designware.h
> @@ -22,6 +22,11 @@
>  #define MAX_MSI_IRQS			32
>  #define MAX_MSI_CTRLS			(MAX_MSI_IRQS / 32)
>  
> +/* Parameters for the Waiting for link up routine */
> +#define LINK_WAIT_MAX_RETRIES		10
> +#define LINK_WAIT_USLEEP_MIN		90000
> +#define LINK_WAIT_USLEEP_MAX		100000
> +
>  struct pcie_port {
>  	struct device		*dev;
>  	u8			root_bus_nr;
> @@ -76,6 +81,7 @@ int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val);
>  int dw_pcie_cfg_write(void __iomem *addr, int size, u32 val);
>  irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
>  void dw_pcie_msi_init(struct pcie_port *pp);
> +int dw_pcie_wait_for_link(struct pcie_port *pp);
>  int dw_pcie_link_up(struct pcie_port *pp);
>  void dw_pcie_setup_rc(struct pcie_port *pp);
>  int dw_pcie_host_init(struct pcie_port *pp);
> diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
> index b95b756..ffdff1d 100644
> --- a/drivers/pci/host/pcie-spear13xx.c
> +++ b/drivers/pci/host/pcie-spear13xx.c
> @@ -13,7 +13,6 @@
>   */
>  
>  #include <linux/clk.h>
> -#include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -149,7 +148,6 @@ static int spear13xx_pcie_establish_link(struct pcie_port *pp)
>  	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
>  	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
>  	u32 exp_cap_off = EXP_CAP_ID_OFFSET;
> -	unsigned int retries;
>  
>  	if (dw_pcie_link_up(pp)) {
>  		dev_err(pp->dev, "link already up\n");
> @@ -201,15 +199,9 @@ static int spear13xx_pcie_establish_link(struct pcie_port *pp)
>  			&app_reg->app_ctrl_0);
>  
>  	/* check if the link is up or not */
> -	for (retries = 0; retries < 10; retries++) {
> -		if (dw_pcie_link_up(pp)) {
> -			dev_info(pp->dev, "link up\n");
> -			return 0;
> -		}
> -		mdelay(100);
> -	}
> +	if (!dw_pcie_wait_for_link(pp))
> +		return 0;
>  
> -	dev_err(pp->dev, "link Fail\n");
>  	return -EINVAL;
>  }
>  
> -- 
> 1.8.1.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
