Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:34202 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbbGUWha (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2015 18:37:30 -0400
Received: by iebmu5 with SMTP id mu5so153646272ieb.1
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2015 15:37:29 -0700 (PDT)
Date: Tue, 21 Jul 2015 17:37:24 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, gabriele.paoloni@huawei.com,
	lorenzo.pieralisi@arm.com, James Morse <james.morse@arm.com>,
	Liviu.Dudau@arm.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	yuanzhichang@hisilicon.com, zhudacai@hisilicon.com,
	zhangjukuo@huawei.com, qiuzhenfa@hisilicon.com,
	liudongdong3@huawei.com, qiujiang@huawei.com,
	kangfenglong@huawei.com, liguozhu@hisilicon.com
Subject: Re: [PATCH v4 3/5] PCI: hisi: Add PCIe host support for Hisilicon
 Soc Hip05
Message-ID: <20150721223724.GL21967@google.com>
References: <1437461323-3531-1-git-send-email-wangzhou1@hisilicon.com>
 <1437461323-3531-4-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437461323-3531-4-git-send-email-wangzhou1@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Zhou,

On Tue, Jul 21, 2015 at 02:48:41PM +0800, Zhou Wang wrote:
> This patch adds PCIe host support for Hisilicon Soc Hip05.
> 
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> ---
>  drivers/pci/host/Kconfig     |   5 +
>  drivers/pci/host/Makefile    |   1 +
>  drivers/pci/host/pcie-hisi.c | 257 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 263 insertions(+)
>  create mode 100644 drivers/pci/host/pcie-hisi.c
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index c132bdd..37f2075 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -145,4 +145,9 @@ config PCIE_IPROC_BCMA
>  	  Say Y here if you want to use the Broadcom iProc PCIe controller
>  	  through the BCMA bus interface
>  
> +config PCI_HISI
> +	depends on OF && ARM64
> +	bool "Hisilicon Soc HIP05 PCIe controller"
> +	select PCIE_DW

Almost all the other DesignWare-based drivers select PCIEPORTBUS in
addition to PCIE_DW.  I'm not sure that's the best Kconfiggery (maybe we
should leave this up to the user), but it'd be nice if all the drivers at
least did this consistently.  So do you have a reason for doing it
differently?

>  endmenu
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index 140d66f..ea1dbf2 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -17,3 +17,4 @@ obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
>  obj-$(CONFIG_PCIE_IPROC) += pcie-iproc.o
>  obj-$(CONFIG_PCIE_IPROC_PLATFORM) += pcie-iproc-platform.o
>  obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
> +obj-$(CONFIG_PCI_HISI) += pcie-hisi.o
> diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
> new file mode 100644
> index 0000000..9f2fac1
> --- /dev/null
> +++ b/drivers/pci/host/pcie-hisi.c
> @@ -0,0 +1,257 @@
> +/*
> + * PCIe host controller driver for Hisilicon Hip05 SoCs
> + *
> + * Copyright (C) 2015 Hisilicon Co., Ltd. http://www.hisilicon.com
> + *
> + * Author: Zhou Wang <wangzhou1@hisilicon.com>
> + *         Dacai Zhu <zhudacai@hisilicon.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/interrupt.h>
> +#include <linux/irqdomain.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_pci.h>
> +#include <linux/platform_device.h>
> +
> +#include "pcie-designware.h"
> +
> +#define PCIE_SUBCTRL_MODE_REG                           0x2800
> +#define PCIE_SUBCTRL_SYS_STATE4_REG                     0x6818
> +#define PCIE_SLV_DBI_MODE                               0x0
> +#define PCIE_SLV_SYSCTRL_MODE                           0x1
> +#define PCIE_SLV_CONTENT_MODE                           0x2
> +#define PCIE_SLV_MSI_ASID                               0x10
> +#define PCIE_LTSSM_LINKUP_STATE                         0x11
> +#define PCIE_LTSSM_STATE_MASK                           0x3F
> +#define PCIE_MSI_ASID_ENABLE                            (0x1 << 12)
> +#define PCIE_MSI_ASID_VALUE                             (0x1 << 16)
> +#define PCIE_MSI_TRANS_ENABLE                           (0x1 << 12)
> +#define PCIE_MSI_TRANS_REG                              0x1c8
> +#define PCIE_MSI_LOW_ADDRESS                            0x1b4
> +#define PCIE_MSI_HIGH_ADDRESS                           0x1c4
> +#define PCIE_MSI_ADDRESS_VAL                            0xb7010040
> +
> +#define to_hisi_pcie(x)	container_of(x, struct hisi_pcie, pp)
> +
> +struct hisi_pcie {
> +	void __iomem *subctrl_base;
> +	void __iomem *reg_base;
> +	struct msi_controller *msi;
> +	u32 port_id;
> +	struct pcie_port pp;
> +};
> +
> +static inline void hisi_pcie_subctrl_writel(struct hisi_pcie *pcie,
> +					    u32 val, u32 reg)
> +{
> +	writel(val, pcie->subctrl_base + reg);
> +}
> +
> +static inline u32 hisi_pcie_subctrl_readl(struct hisi_pcie *pcie, u32 reg)
> +{
> +	return readl(pcie->subctrl_base + reg);
> +}
> +
> +static inline void hisi_pcie_apb_writel(struct hisi_pcie *pcie,
> +					u32 val, u32 reg)
> +{
> +	writel(val, pcie->reg_base + reg);
> +}
> +
> +static inline u32 hisi_pcie_apb_readl(struct hisi_pcie *pcie, u32 reg)
> +{
> +	return readl(pcie->reg_base + reg);
> +}
> +
> +/*
> + * Change mode to indicate the same reg_base to base of PCIe host configure
> + * registers, base of RC configure space or base of vmid/asid context table
> + */
> +static void hisi_pcie_change_apb_mode(struct hisi_pcie *pcie, u32 mode)
> +{
> +	u32 val;
> +	u32 bit_mask;
> +	u32 bit_shift;
> +	u32 port_id = pcie->port_id;
> +	u32 reg = PCIE_SUBCTRL_MODE_REG + 0x100 * port_id;
> +
> +	if ((port_id == 1) || (port_id == 2)) {
> +		bit_mask = 0xc;
> +		bit_shift = 0x2;
> +	} else {
> +		bit_mask = 0x6;
> +		bit_shift = 0x1;
> +	}
> +
> +	val = hisi_pcie_subctrl_readl(pcie, reg);
> +	val = (val & (~bit_mask)) | (mode << bit_shift);
> +	hisi_pcie_subctrl_writel(pcie, val, reg);
> +}
> +
> +/* Configure vmid/asid table in PCIe host */
> +static void hisi_pcie_config_context(struct hisi_pcie *pcie)
> +{
> +	int i;
> +
> +	hisi_pcie_change_apb_mode(pcie, PCIE_SLV_CONTENT_MODE);
> +
> +	/*
> +	 * init vmid and asid tables for all PCIes device as 0

s/PCIes device as/PCIe devices to/ ?

> +	 * vmid table: 0 ~ 0x3ff, asid table: 0x400 ~ 0x7ff
> +	 */
> +	for (i = 0; i < 0x800; i++)
> +		hisi_pcie_apb_writel(pcie, 0x0, i * 4);
> +
> +	hisi_pcie_change_apb_mode(pcie, PCIE_SLV_SYSCTRL_MODE);
> +
> +	hisi_pcie_apb_writel(pcie, PCIE_MSI_ADDRESS_VAL, PCIE_MSI_LOW_ADDRESS);
> +	hisi_pcie_apb_writel(pcie, 0x0, PCIE_MSI_HIGH_ADDRESS);
> +	hisi_pcie_apb_writel(pcie, PCIE_MSI_ASID_ENABLE | PCIE_MSI_ASID_VALUE,
> +			     PCIE_SLV_MSI_ASID);
> +	hisi_pcie_apb_writel(pcie, PCIE_MSI_TRANS_ENABLE, PCIE_MSI_TRANS_REG);
> +
> +	hisi_pcie_change_apb_mode(pcie, PCIE_SLV_DBI_MODE);
> +}
> +
> +static int hisi_pcie_link_up(struct pcie_port *pp)
> +{
> +	u32 val;
> +

Remove this extra blank line.

> +	struct hisi_pcie *hisi_pcie = to_hisi_pcie(pp);
> +
> +	val = hisi_pcie_subctrl_readl(hisi_pcie, PCIE_SUBCTRL_SYS_STATE4_REG +
> +				      0x100 * hisi_pcie->port_id);
> +
> +	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
> +}
> +
> +static
> +int hisi_pcie_msi_host_init(struct pcie_port *pp, struct msi_controller *chip)
> +{
> +	struct device_node *msi_node;
> +	struct irq_domain *irq_domain;
> +	struct device_node *np = pp->dev->of_node;
> +
> +	msi_node = of_parse_phandle(np, "msi-parent", 0);
> +	if (!msi_node) {
> +		pr_err("failed to find msi-parent\n");

Can you use dev_err() here (and below)?  A message like this that doesn't
have a hint about what device it's related to is not as useful as it could
be.

> +		return -ENODEV;
> +	}
> +
> +	irq_domain = irq_find_host(msi_node);
> +	if (!irq_domain) {
> +		pr_err("failed to find irq domain\n");
> +		return -ENODEV;
> +	}
> +
> +	pp->irq_domain = irq_domain;
> +
> +	return 0;
> +}
> +
> +static struct pcie_host_ops hisi_pcie_host_ops = {
> +	.link_up = hisi_pcie_link_up,
> +	.msi_host_init = hisi_pcie_msi_host_init,
> +};
> +
> +static int __init hisi_add_pcie_port(struct pcie_port *pp,
> +				     struct platform_device *pdev)
> +{
> +	int ret;
> +	u32 port_id;
> +	struct resource busn;
> +

Remove this extra blank line.

> +	struct hisi_pcie *hisi_pcie = to_hisi_pcie(pp);
> +
> +	if (of_property_read_u32(pdev->dev.of_node, "port-id", &port_id)) {
> +		dev_err(&pdev->dev, "failed to read port-id\n");
> +		return -EINVAL;
> +	}
> +	if (port_id > 3) {
> +		dev_err(&pdev->dev, "Invalid port-id\n");

Since you have the invalid port_id here, maybe you could include the
invalid value in the output?

> +		return -EINVAL;
> +	}
> +
> +	hisi_pcie->port_id = port_id;
> +
> +	if (of_pci_parse_bus_range(pdev->dev.of_node, &busn)) {
> +		dev_err(&pdev->dev, "failed to parse bus-ranges\n");
> +		return -EINVAL;
> +	}
> +
> +	pp->root_bus_nr = busn.start;
> +	pp->ops = &hisi_pcie_host_ops;
> +
> +	hisi_pcie_config_context(hisi_pcie);
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
> +static int __init hisi_pcie_probe(struct platform_device *pdev)
> +{
> +	struct hisi_pcie *hisi_pcie;
> +	struct pcie_port *pp;
> +	struct resource *reg;
> +	struct resource *subctrl;
> +	int ret;
> +
> +	hisi_pcie = devm_kzalloc(&pdev->dev, sizeof(*hisi_pcie), GFP_KERNEL);
> +	if (!hisi_pcie)
> +		return -ENOMEM;
> +
> +	pp = &hisi_pcie->pp;
> +	pp->dev = &pdev->dev;
> +
> +	subctrl = platform_get_resource_byname(pdev, IORESOURCE_MEM, "subctrl");
> +	hisi_pcie->subctrl_base = devm_ioremap_nocache(&pdev->dev,
> +					subctrl->start, resource_size(subctrl));
> +	if (IS_ERR(hisi_pcie->subctrl_base)) {
> +		dev_err(pp->dev, "cannot get subctrl base\n");
> +		return PTR_ERR(hisi_pcie->subctrl_base);
> +	}
> +
> +	reg = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbi");
> +	hisi_pcie->reg_base = devm_ioremap_resource(&pdev->dev, reg);
> +	if (IS_ERR(hisi_pcie->reg_base)) {
> +		dev_err(pp->dev, "cannot get reg base\n");

Maybe this could include the actual resource name ("rc_dbi") as the message
above does?

> +		return PTR_ERR(hisi_pcie->reg_base);
> +	}
> +
> +	hisi_pcie->pp.dbi_base = hisi_pcie->reg_base;
> +
> +	ret = hisi_add_pcie_port(pp, pdev);
> +	if (ret < 0)

Seems like this return value check should be the same as the one above in 
hisi_add_pcie_port().  In both cases, the only possible returns are zero
(success) or a negative error number.  Using "if (ret)" here has the
advantage that below you could "return 0" and it would be crystal clear
that you're always returning success if you get that far.

> +		return ret;
> +
> +	platform_set_drvdata(pdev, hisi_pcie);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id hisi_pcie_of_match[] = {
> +	{.compatible = "hisilicon,hip05-pcie",},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, hisi_pcie_of_match);
> +
> +static struct platform_driver hisi_pcie_driver = {
> +	.probe  = hisi_pcie_probe,
> +	.driver = {
> +		   .name = "hisi-pcie",
> +		   .owner = THIS_MODULE,

You can drop this ".owner =" initialization.  platform_driver_register()
supplies that automatically.

> +		   .of_match_table = hisi_pcie_of_match,
> +	},
> +};
> +
> +module_platform_driver(hisi_pcie_driver);
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
