Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:59886 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750922AbdELIIa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 May 2017 04:08:30 -0400
Subject: Re: [PATCH 1/2] PCI: dwc: kirin: add PCIe Driver for HiSilicon Kirin
 SoC
To: Song Xiaowei <songxiaowei@hisilicon.com>, <bhelgaas@google.com>,
        <kishon@ti.com>, <jingoohan1@gmail.com>, <arnd@arndb.de>,
        <tn@semihalf.com>, <keith.busch@intel.com>, <dhdang@apm.com>,
        <liudongdong3@huawei.com>
CC: <puck.chen@hisilicon.com>, <guodong.xu@linaro.org>,
        <wangbinghui@hisilicon.com>, <suzhuangluan@hisilicon.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20170512015105.32653-1-songxiaowei@hisilicon.com>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <39a62f81-b021-2ffc-eb1d-6f4dfdd91dd8@axis.com>
Date: Fri, 12 May 2017 10:08:26 +0200
MIME-Version: 1.0
In-Reply-To: <20170512015105.32653-1-songxiaowei@hisilicon.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Song

On 05/12/2017 03:51 AM, Song Xiaowei wrote:
> From: songxiaowei <songxiaowei@hisilicon.com>
> 
> Hisilicon PCIe Driver shares the common functions fo PCIe dw-host
> 
> The poweron functions is developed on hi3660 SoC, while Others Functions
> are common for Kirin series SoCs.
> 
> Lowpower(L1ss and SR), hotplug and MSI feature are not supported
> currently.
> 
> Cc: Guodong Xu <guodong.xu@linaro.org>
> Signed-off-by: Song Xiaowei <songxiaowei@hisilicon.com>
> ---
>  drivers/pci/dwc/Kconfig      |  11 ++
>  drivers/pci/dwc/Makefile     |   1 +
>  drivers/pci/dwc/pcie-kirin.c | 443 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/dwc/pcie-kirin.h |  79 ++++++++
>  4 files changed, 534 insertions(+)
>  create mode 100644 drivers/pci/dwc/pcie-kirin.c
>  create mode 100644 drivers/pci/dwc/pcie-kirin.h
> 
> diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
> index d2d2ba5b8a68..25f5ec33ce0c 100644
> --- a/drivers/pci/dwc/Kconfig
> +++ b/drivers/pci/dwc/Kconfig
> @@ -130,4 +130,15 @@ config PCIE_ARTPEC6
>  	  Say Y here to enable PCIe controller support on Axis ARTPEC-6
>  	  SoCs.  This PCIe controller uses the DesignWare core.
>  
> +config PCIE_KIRIN
> +	depends on OF && ARM64
> +	bool "HiSilicon Kirin series SoCs PCIe controllers"
> +	depends on PCI
> +	depends on PCI_MSI_IRQ_DOMAIN

do you need to depend on PCI_MSI_IRQ_DOMAIN if your driver
does not support MSI?

> +	select PCIEPORTBUS
> +	select PCIE_DW_HOST
> +	help
> +	  Say Y here if you want PCIe controller support on HiSilicon Kirin series SoCs
> +	  kirin960 SoCs
> +
>  endmenu
> diff --git a/drivers/pci/dwc/Makefile b/drivers/pci/dwc/Makefile
> index a2df13c28798..4bd69bacd4ab 100644
> --- a/drivers/pci/dwc/Makefile
> +++ b/drivers/pci/dwc/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
>  obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
>  obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
>  obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
> +obj-$(CONFIG_PCIE_KIRIN) += pcie-kirin.o
>  
>  # The following drivers are for devices that use the generic ACPI
>  # pci_root.c driver but don't support standard ECAM config access.
> diff --git a/drivers/pci/dwc/pcie-kirin.c b/drivers/pci/dwc/pcie-kirin.c
> new file mode 100644
> index 000000000000..5298407cf10a
> --- /dev/null
> +++ b/drivers/pci/dwc/pcie-kirin.c
> @@ -0,0 +1,443 @@
> +/*
> + * PCIe host controller driver for Kirin Phone SoCs
> + *
> + * Copyright (C) 2015 Hilisicon Electronics Co., Ltd.
> + *		http://www.huawei.com
> + *
> + * Author: Xiaowei Song <songxiaowei@huawei.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include "pcie-kirin.h"
> +
> +static inline void kirin_apb_ctrl_writel(struct kirin_pcie *kirin_pcie,
> +						u32 val, u32 reg)
> +{
> +	writel(val, kirin_pcie->apb_base + reg);
> +}
> +
> +static inline u32 kirin_apb_ctrl_readl(struct kirin_pcie *kirin_pcie,
> +						u32 reg)
> +{
> +	return readl(kirin_pcie->apb_base + reg);
> +}
> +
> +/*Registers in PCIePHY*/
> +static inline void kirin_apb_phy_writel(struct kirin_pcie *kirin_pcie,
> +						u32 val, u32 reg)
> +{
> +	writel(val, kirin_pcie->phy_base + reg);
> +}
> +
> +static inline u32 kirin_apb_phy_readl(struct kirin_pcie *kirin_pcie,
> +						u32 reg)
> +{
> +	return readl(kirin_pcie->phy_base + reg);
> +}
> +
> +static int32_t kirin_pcie_get_clk(struct kirin_pcie *kirin_pcie,
> +				  struct platform_device *pdev)
> +{
> +	kirin_pcie->phy_ref_clk = devm_clk_get(&pdev->dev, "pcie_phy_ref");
> +	if (IS_ERR(kirin_pcie->phy_ref_clk))
> +		return PTR_ERR(kirin_pcie->phy_ref_clk);
> +
> +	kirin_pcie->pcie_aux_clk = devm_clk_get(&pdev->dev, "pcie_aux");
> +	if (IS_ERR(kirin_pcie->pcie_aux_clk))
> +		return PTR_ERR(kirin_pcie->pcie_aux_clk);
> +
> +	kirin_pcie->apb_phy_clk = devm_clk_get(&pdev->dev, "pcie_apb_phy");
> +	if (IS_ERR(kirin_pcie->apb_phy_clk))
> +		return PTR_ERR(kirin_pcie->apb_phy_clk);
> +
> +	kirin_pcie->apb_sys_clk = devm_clk_get(&pdev->dev, "pcie_apb_sys");
> +	if (IS_ERR(kirin_pcie->apb_sys_clk))
> +		return PTR_ERR(kirin_pcie->apb_sys_clk);
> +
> +	kirin_pcie->pcie_aclk = devm_clk_get(&pdev->dev, "pcie_aclk");
> +	if (IS_ERR(kirin_pcie->pcie_aclk))
> +		return PTR_ERR(kirin_pcie->pcie_aclk);
> +
> +	return 0;
> +}
> +
> +static int32_t kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
> +				       struct platform_device *pdev)
> +{
> +	struct resource *apb;
> +	struct resource *phy;
> +	struct resource *dbi;
> +
> +	apb = platform_get_resource_byname(pdev, IORESOURCE_MEM, "apb");
> +	kirin_pcie->apb_base = devm_ioremap_resource(&pdev->dev, apb);
> +	if (IS_ERR(kirin_pcie->apb_base))
> +		return PTR_ERR(kirin_pcie->apb_base);
> +
> +	phy = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
> +	kirin_pcie->phy_base = devm_ioremap_resource(&pdev->dev, phy);
> +	if (IS_ERR(kirin_pcie->phy_base))
> +		return PTR_ERR(kirin_pcie->phy_base);
> +
> +	dbi = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> +	kirin_pcie->pci->dbi_base = devm_ioremap_resource(&pdev->dev, dbi);
> +	if (IS_ERR(kirin_pcie->pci->dbi_base))
> +		return PTR_ERR(kirin_pcie->pci->dbi_base);
> +
> +	kirin_pcie->crgctrl =
> +		syscon_regmap_lookup_by_compatible("hisilicon,hi3660-crgctrl");
> +	if (IS_ERR(kirin_pcie->crgctrl))
> +		return PTR_ERR(kirin_pcie->crgctrl);
> +
> +	kirin_pcie->sysctrl =
> +		syscon_regmap_lookup_by_compatible("hisilicon,hi3660-sctrl");
> +	if (IS_ERR(kirin_pcie->sysctrl))
> +		return PTR_ERR(kirin_pcie->sysctrl);
> +
> +	return 0;
> +}
> +
> +static int kirin_pcie_phy_init(struct kirin_pcie *kirin_pcie)
> +{
> +	u32 reg_val;
> +	u32 pipe_clk_stable = 0x1 << 19;
> +	u32 time = 10;
> +
> +	reg_val = kirin_apb_phy_readl(kirin_pcie, 0x4);
> +	reg_val &= ~(0x1 << 8);
> +	kirin_apb_phy_writel(kirin_pcie, reg_val, 0x4);
> +
> +	reg_val = kirin_apb_phy_readl(kirin_pcie, 0x0);
> +	reg_val &= ~(0x1 << 22);
> +	kirin_apb_phy_writel(kirin_pcie, reg_val, 0x0);
> +	udelay(10);
> +
> +	reg_val = kirin_apb_phy_readl(kirin_pcie, 0x4);
> +	reg_val &= ~(0x1 << 16);
> +	kirin_apb_phy_writel(kirin_pcie, reg_val, 0x4);
> +
> +	reg_val = kirin_apb_phy_readl(kirin_pcie, 0x400);
> +	while (reg_val & pipe_clk_stable) {
> +		udelay(100);
> +		if (time == 0) {
> +			dev_err(kirin_pcie->pci->dev, "PIPE clk is not stable\n");
> +			return -EINVAL;
> +		}
> +		time--;
> +		reg_val = kirin_apb_phy_readl(kirin_pcie, 0x400);
> +	}

magic numbers here, replace with #defines with describing names.

> +
> +	return 0;
> +}
> +
> +static void kirin_pcie_oe_enable(struct kirin_pcie *kirin_pcie)
> +{
> +	u32 val;
> +
> +	regmap_read(kirin_pcie->sysctrl, 0x1a4, &val);
> +	val |= 0xF0F400;
> +	val &= ~(0x3 << 28);
> +	regmap_write(kirin_pcie->sysctrl, 0x1a4, val);

magic numbers here, replace with #defines with describing names.

> +}
> +
> +static int kirin_pcie_clk_ctrl(struct kirin_pcie *kirin_pcie, bool enable)
> +{
> +	int ret = 0;
> +
> +	if (!enable)
> +		goto close_clk;
> +
> +	ret = clk_set_rate(kirin_pcie->phy_ref_clk, REF_CLK_FREQ);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(kirin_pcie->phy_ref_clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(kirin_pcie->apb_sys_clk);
> +	if (ret)
> +		goto apb_sys_fail;
> +
> +	ret = clk_prepare_enable(kirin_pcie->apb_phy_clk);
> +	if (ret)
> +		goto apb_phy_fail;
> +
> +	ret = clk_prepare_enable(kirin_pcie->pcie_aclk);
> +	if (ret)
> +		goto aclk_fail;
> +
> +	ret = clk_prepare_enable(kirin_pcie->pcie_aux_clk);
> +	if (ret)
> +		goto aux_clk_fail;
> +
> +	return 0;
> +close_clk:
> +	clk_disable_unprepare(kirin_pcie->pcie_aux_clk);
> +aux_clk_fail:
> +	clk_disable_unprepare(kirin_pcie->pcie_aclk);
> +aclk_fail:
> +	clk_disable_unprepare(kirin_pcie->apb_phy_clk);
> +apb_phy_fail:
> +	clk_disable_unprepare(kirin_pcie->apb_sys_clk);
> +apb_sys_fail:
> +	clk_disable_unprepare(kirin_pcie->phy_ref_clk);
> +	return ret;
> +}
> +
> +static int kirin_pcie_power_on(struct kirin_pcie *kirin_pcie)
> +{
> +	int ret;
> +
> +	/*Power supply for Host*/
> +	regmap_write(kirin_pcie->sysctrl, 0x60, 0x10);
> +	udelay(100);
> +	kirin_pcie_oe_enable(kirin_pcie);
> +
> +	ret = kirin_pcie_clk_ctrl(kirin_pcie, true);
> +	if (ret)
> +		return ret;
> +
> +	/*deasset PCIeCtrl&PCIePHY*/
> +	regmap_write(kirin_pcie->sysctrl, 0x44, 0x30);
> +	regmap_write(kirin_pcie->crgctrl, 0x88, 0x8c000000);
> +	regmap_write(kirin_pcie->sysctrl, 0x190, 0x184000);

magic numbers here, replace with #defines with describing names.

> +
> +	ret = kirin_pcie_phy_init(kirin_pcie);
> +	if (ret)
> +		goto close_clk;
> +
> +	/*perst assert Endpoint*/
> +	if (!gpio_request(kirin_pcie->gpio_id_reset, "pcie_perst")) {
> +		usleep_range(REF_2_PERST_MIN, REF_2_PERST_MAX);
> +		ret = gpio_direction_output(kirin_pcie->gpio_id_reset, 1);
> +		if (ret)
> +			goto close_clk;
> +		usleep_range(PERST_2_ACCESS_MIN, PERST_2_ACCESS_MAX);
> +
> +		return 0;
> +	}
> +
> +close_clk:
> +	kirin_pcie_clk_ctrl(kirin_pcie, false);
> +	return -1;

return a proper error code.

> +}
> +
> +static void kirin_pcie_sideband_dbi_w_mode(struct kirin_pcie *kirin_pcie,
> +					bool on)
> +{
> +	u32 val;
> +
> +	val = kirin_apb_ctrl_readl(kirin_pcie, SOC_PCIECTRL_CTRL0_ADDR);
> +	if (on)
> +		val = val | PCIE_ELBI_SLV_DBI_ENABLE;
> +	else
> +		val = val & ~PCIE_ELBI_SLV_DBI_ENABLE;
> +
> +	kirin_apb_ctrl_writel(kirin_pcie, val, SOC_PCIECTRL_CTRL0_ADDR);
> +}
> +
> +static void kirin_pcie_sideband_dbi_r_mode(struct kirin_pcie *kirin_pcie,
> +					bool on)
> +{
> +	u32 val;
> +
> +	val = kirin_apb_ctrl_readl(kirin_pcie, SOC_PCIECTRL_CTRL1_ADDR);
> +	if (on)
> +		val = val | PCIE_ELBI_SLV_DBI_ENABLE;
> +	else
> +		val = val & ~PCIE_ELBI_SLV_DBI_ENABLE;
> +
> +	kirin_apb_ctrl_writel(kirin_pcie, val, SOC_PCIECTRL_CTRL1_ADDR);
> +}
> +
> +static int kirin_pcie_rd_own_conf(struct pcie_port *pp,
> +				  int where, int size, u32 *val)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct kirin_pcie *kirin_pcie = to_kirin_pcie(pci);
> +	int ret;
> +
> +	kirin_pcie_sideband_dbi_r_mode(kirin_pcie, true);
> +	ret = dw_pcie_read(pci->dbi_base + where, size, val);
> +	kirin_pcie_sideband_dbi_r_mode(kirin_pcie, false);
> +
> +	return ret;
> +}
> +
> +static int kirin_pcie_wr_own_conf(struct pcie_port *pp,
> +				  int where, int size, u32 val)
> +{
> +	int ret;
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct kirin_pcie *kirin_pcie = to_kirin_pcie(pci);
> +
> +	kirin_pcie_sideband_dbi_w_mode(kirin_pcie, true);
> +	ret = dw_pcie_write(pci->dbi_base + where, size, val);
> +	kirin_pcie_sideband_dbi_w_mode(kirin_pcie, false);
> +
> +	return ret;
> +}
> +
> +static u32 kirin_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
> +				u32 reg, size_t size)
> +{
> +	u32 ret;
> +	struct kirin_pcie *kirin_pcie = to_kirin_pcie(pci);
> +
> +	kirin_pcie_sideband_dbi_r_mode(kirin_pcie, true);
> +	dw_pcie_read(base + reg, size, &ret);
> +	kirin_pcie_sideband_dbi_r_mode(kirin_pcie, false);
> +
> +	return ret;
> +}
> +
> +static void kirin_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
> +				u32 reg, size_t size, u32 val)
> +{
> +	struct kirin_pcie *kirin_pcie = to_kirin_pcie(pci);
> +
> +	kirin_pcie_sideband_dbi_w_mode(kirin_pcie, true);
> +	dw_pcie_write(base + reg, size, val);
> +	kirin_pcie_sideband_dbi_w_mode(kirin_pcie, false);
> +}
> +
> +static int kirin_pcie_link_up(struct dw_pcie *pci)
> +{
> +	struct kirin_pcie *kirin_pcie = to_kirin_pcie(pci);
> +	u32 val = kirin_apb_ctrl_readl(kirin_pcie, PCIE_ELBI_RDLH_LINKUP);
> +
> +	if ((val & PCIE_LINKUP_ENABLE) == PCIE_LINKUP_ENABLE)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int kirin_pcie_establish_link(struct pcie_port *pp)
> +{
> +	int count = 0;
> +
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct kirin_pcie *kirin_pcie = to_kirin_pcie(pci);
> +
> +	if (kirin_pcie_link_up(pci))
> +		return 0;
> +
> +	dw_pcie_setup_rc(pp);
> +
> +	/* assert LTSSM enable */
> +	kirin_apb_ctrl_writel(kirin_pcie, PCIE_LTSSM_ENABLE_BIT,
> +			 PCIE_APP_LTSSM_ENABLE);
> +
> +	/* check if the link is up or not */
> +	while (!kirin_pcie_link_up(pci)) {
> +		usleep_range(LINK_WAIT_MIN, LINK_WAIT_MAX);
> +		count++;
> +		if (count == 1000) {
> +			dev_err(pci->dev, "Link Fail\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void kirin_pcie_host_init(struct pcie_port *pp)
> +{
> +	kirin_pcie_establish_link(pp);
> +}
> +
> +static struct dw_pcie_ops kirin_dw_pcie_ops = {
> +	.read_dbi = kirin_pcie_read_dbi,
> +	.write_dbi = kirin_pcie_write_dbi,
> +	.link_up = kirin_pcie_link_up,
> +};
> +
> +static struct dw_pcie_host_ops kirin_pcie_host_ops = {
> +	.rd_own_conf = kirin_pcie_rd_own_conf,
> +	.wr_own_conf = kirin_pcie_wr_own_conf,
> +	.host_init = kirin_pcie_host_init,
> +};
> +
> +static int __init kirin_add_pcie_port(struct dw_pcie *pci,
> +				      struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	pci->pp.ops = &kirin_pcie_host_ops;
> +
> +	ret = dw_pcie_host_init(&pci->pp);
> +
> +	return ret;
> +}
> +
> +static int kirin_pcie_probe(struct platform_device *pdev)
> +{
> +	struct kirin_pcie *kirin_pcie;
> +	struct dw_pcie *pci;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	if (!pdev->dev.of_node) {
> +		dev_err(&pdev->dev, "NULL node\n");
> +		return -EINVAL;
> +	}
> +
> +	kirin_pcie = devm_kzalloc(&pdev->dev,
> +					sizeof(struct kirin_pcie), GFP_KERNEL);
> +	if (!kirin_pcie)
> +		return -ENOMEM;
> +
> +	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
> +	if (!pci)
> +		return -ENOMEM;
> +
> +	pci->dev = dev;
> +	pci->ops = &kirin_dw_pcie_ops;
> +	kirin_pcie->pci = pci;
> +
> +	ret = kirin_pcie_get_clk(kirin_pcie, pdev);
> +	if (ret != 0)
> +		return -ENODEV;
> +
> +	ret = kirin_pcie_get_resource(kirin_pcie, pdev);
> +	if (ret != 0)
> +		return -ENODEV;

if (ret != 0) can be replaced with if (ret)

> +
> +	kirin_pcie->gpio_id_reset = of_get_named_gpio(pdev->dev.of_node,
> +			"reset-gpio", 0);
> +	if (kirin_pcie->gpio_id_reset < 0)
> +		return -ENODEV;
> +
> +	ret = kirin_pcie_power_on(kirin_pcie);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, kirin_pcie);
> +
> +	ret = kirin_add_pcie_port(pci, pdev);
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(&pdev->dev, "probe Done\n");

this is your only dev_dbg.
is it really needed?
booting with kernel command line options debug initcall_debug=1
will show you if your drivers was probed or not.

> +	return 0;
> +}
> +
> +static const struct of_device_id kirin_pcie_match[] = {
> +	{ .compatible = "hisilicon,kirin-pcie" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, kirin_pcie_match);
> +
> +struct platform_driver kirin_pcie_driver = {
> +	.probe			= kirin_pcie_probe,
> +	.driver			= {
> +		.name			= "Kirin-pcie",
> +		.owner			= THIS_MODULE,

owner shouldn't be needed since it populated by the core.

> +		.of_match_table = kirin_pcie_match,

since your module can only be built as built-in
(bool rather than tristate in Kconfig)
and since you don't provide a .remove callback,
you should probably add

.suppress_bind_attrs = true,

> +	},
> +};
> +
> +module_platform_driver(kirin_pcie_driver);

since your module can only be built as built-in
(bool rather than tristate in Kconfig)
this should probably be replaced with
builtin_platform_driver

> diff --git a/drivers/pci/dwc/pcie-kirin.h b/drivers/pci/dwc/pcie-kirin.h
> new file mode 100644
> index 000000000000..ad9a3b427298
> --- /dev/null
> +++ b/drivers/pci/dwc/pcie-kirin.h
> @@ -0,0 +1,79 @@
> +/*
> + * PCIe host controller driver for Kirin 960 SoCs
> + *
> + * Copyright (C) 2015 Huawei Electronics Co., Ltd.
> + *		http://www.huawei.com
> + *
> + * Author: Xiaowei Song <songxiaowei@huawei.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef _PCIE_KIRIN_H
> +#define _PCIE_KIRIN_H
> +
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +#include <asm/compiler.h>
> +#include <linux/compiler.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqdomain.h>
> +#include <linux/module.h>

since your module can only be built as built-in
(bool rather than tristate in Kconfig)
you should probably not include module.h

> +#include <linux/of_gpio.h>
> +#include <linux/pci.h>
> +#include <linux/of_pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/resource.h>
> +#include <linux/types.h>
> +#include <linux/msi.h>

is this header needed if you don't support msi?

> +#include <linux/of_address.h>
> +#include <linux/pci_regs.h>
> +
> +#include "pcie-designware.h"
> +
> +#define to_kirin_pcie(x) dev_get_drvdata((x)->dev)
> +
> +#define REF_CLK_FREQ 100000000
> +
> +/* PCIe ELBI registers */
> +#define SOC_PCIECTRL_CTRL0_ADDR 0x000
> +#define SOC_PCIECTRL_CTRL1_ADDR 0x004
> +#define SOC_PCIEPHY_CTRL2_ADDR 0x008
> +#define SOC_PCIEPHY_CTRL3_ADDR 0x00c
> +#define PCIE_ELBI_SLV_DBI_ENABLE	(0x1 << 21)
> +
> +#define PCIE_APP_LTSSM_ENABLE		0x01c
> +#define PCIE_ELBI_RDLH_LINKUP		0x400
> +#define PCIE_LINKUP_ENABLE		(0x8020)
> +#define PCIE_LTSSM_ENABLE_BIT	  (0x1 << 11)
> +
> +#define REF_2_PERST_MIN		(20000)
> +#define REF_2_PERST_MAX		(25000)
> +#define PERST_2_ACCESS_MIN	(10000)
> +#define PERST_2_ACCESS_MAX	(12000)
> +#define LINK_WAIT_MIN	(900)
> +#define LINK_WAIT_MAX		(1000)
> +
> +
> +struct kirin_pcie {
> +	void __iomem		*apb_base;
> +	void __iomem		*phy_base;
> +	struct regmap *crgctrl;
> +	struct regmap *sysctrl;
> +	struct clk			*apb_sys_clk;
> +	struct clk			*apb_phy_clk;
> +	struct clk			*phy_ref_clk;
> +	struct clk			*pcie_aclk;
> +	struct clk			*pcie_aux_clk;
> +	int                 gpio_id_reset;
> +	struct dw_pcie		*pci;
> +};
> +
> +#endif
> +
> 

since this .h file is really small, it might be better to just
remove it and move the code to the .c file.



Best regards,
Niklas
