Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:47770 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbbIOMoY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 08:44:24 -0400
From: Zhou Wang <wangzhou1@hisilicon.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<pratyush.anand@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	<linux@arm.linux.org.uk>, <thomas.petazzoni@free-electrons.com>,
	<gabriele.paoloni@huawei.com>, <lorenzo.pieralisi@arm.com>,
	<james.morse@arm.com>, <Liviu.Dudau@arm.com>,
	<jason@lakedaemon.net>, <robh@kernel.org>,
	<gabriel.fernandez@linaro.org>, <Minghuan.Lian@freescale.com>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <zhangjukuo@huawei.com>,
	<qiuzhenfa@hisilicon.com>, <liudongdong3@huawei.com>,
	<qiujiang@huawei.com>, <xuwei5@hisilicon.com>,
	<liguozhu@hisilicon.com>, Zhou Wang <wangzhou1@hisilicon.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v9 4/6] PCI: hisi: Add PCIe host support for HiSilicon SoC Hip05
Date: Tue, 15 Sep 2015 20:49:19 +0800
Message-ID: <1442321361-174300-5-git-send-email-wangzhou1@hisilicon.com>
In-Reply-To: <1442321361-174300-1-git-send-email-wangzhou1@hisilicon.com>
References: <1442321361-174300-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds PCIe host support for HiSilicon SoC Hip05.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Signed-off-by: liudongdong <liudongdong3@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: qiuzhenfa <qiuzhenfa@hisilicon.com>
---
 drivers/pci/host/Kconfig     |   8 ++
 drivers/pci/host/Makefile    |   1 +
 drivers/pci/host/pcie-hisi.c | 310 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 319 insertions(+)
 create mode 100644 drivers/pci/host/pcie-hisi.c

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index d5e58ba..ae873be 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -145,4 +145,12 @@ config PCIE_IPROC_BCMA
 	  Say Y here if you want to use the Broadcom iProc PCIe controller
 	  through the BCMA bus interface
 
+config PCI_HISI
+	depends on OF && ARM64
+	bool "HiSilicon SoC HIP05 PCIe controller"
+	select PCIEPORTBUS
+	select PCIE_DW
+	help
+	  Say Y here if you want PCIe controller support on HiSilicon HIP05 SoC
+
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 140d66f..ea1dbf2 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
 obj-$(CONFIG_PCIE_IPROC) += pcie-iproc.o
 obj-$(CONFIG_PCIE_IPROC_PLATFORM) += pcie-iproc-platform.o
 obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
+obj-$(CONFIG_PCI_HISI) += pcie-hisi.o
diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
new file mode 100644
index 0000000..b77c103
--- /dev/null
+++ b/drivers/pci/host/pcie-hisi.c
@@ -0,0 +1,310 @@
+/*
+ * PCIe host controller driver for HiSilicon Hip05 SoC
+ *
+ * Copyright (C) 2015 HiSilicon Co., Ltd. http://www.hisilicon.com
+ *
+ * Author: Zhou Wang <wangzhou1@hisilicon.com>
+ *         Dacai Zhu <zhudacai@hisilicon.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/platform_device.h>
+
+#include "pcie-designware.h"
+
+#define PCIE_SUBCTRL_MODE_REG                           0x2800
+#define PCIE_SUBCTRL_SYS_STATE4_REG                     0x6818
+#define PCIE_SLV_DBI_MODE                               0x0
+#define PCIE_SLV_SYSCTRL_MODE                           0x1
+#define PCIE_SLV_CONTENT_MODE                           0x2
+#define PCIE_SLV_MSI_ASID                               0x10
+#define PCIE_LTSSM_LINKUP_STATE                         0x11
+#define PCIE_LTSSM_STATE_MASK                           0x3F
+#define PCIE_MSI_ASID_ENABLE                            (0x1 << 12)
+#define PCIE_MSI_ASID_VALUE                             (0x1 << 16)
+#define PCIE_MSI_TRANS_ENABLE                           (0x1 << 12)
+#define PCIE_MSI_TRANS_REG                              0x1c8
+#define PCIE_MSI_LOW_ADDRESS                            0x1b4
+#define PCIE_MSI_HIGH_ADDRESS                           0x1c4
+#define PCIE_GITS_TRANSLATER                            0x10040
+
+#define PCIE_SYS_CTRL20_REG                             0x20
+#define PCIE_RD_TAB_SEL                                 BIT(31)
+#define PCIE_RD_TAB_EN                                  BIT(30)
+
+#define to_hisi_pcie(x)	container_of(x, struct hisi_pcie, pp)
+
+struct hisi_pcie {
+	void __iomem *subctrl_base;
+	void __iomem *reg_base;
+	u32 port_id;
+	struct pcie_port pp;
+};
+
+static inline void hisi_pcie_subctrl_writel(struct hisi_pcie *pcie,
+					    u32 val, u32 reg)
+{
+	writel(val, pcie->subctrl_base + reg);
+}
+
+static inline u32 hisi_pcie_subctrl_readl(struct hisi_pcie *pcie, u32 reg)
+{
+	return readl(pcie->subctrl_base + reg);
+}
+
+static inline void hisi_pcie_apb_writel(struct hisi_pcie *pcie,
+					u32 val, u32 reg)
+{
+	writel(val, pcie->reg_base + reg);
+}
+
+static inline u32 hisi_pcie_apb_readl(struct hisi_pcie *pcie, u32 reg)
+{
+	return readl(pcie->reg_base + reg);
+}
+
+/*
+ * Change mode to indicate the same reg_base to base of PCIe host configure
+ * registers, base of RC configure space or base of vmid/asid context table
+ */
+static void hisi_pcie_change_apb_mode(struct hisi_pcie *pcie, u32 mode)
+{
+	u32 val;
+	u32 bit_mask;
+	u32 bit_shift;
+	u32 port_id = pcie->port_id;
+	u32 reg = PCIE_SUBCTRL_MODE_REG + 0x100 * port_id;
+
+	if ((port_id == 1) || (port_id == 2)) {
+		bit_mask = 0xc;
+		bit_shift = 0x2;
+	} else {
+		bit_mask = 0x6;
+		bit_shift = 0x1;
+	}
+
+	val = hisi_pcie_subctrl_readl(pcie, reg);
+	val = (val & (~bit_mask)) | (mode << bit_shift);
+	hisi_pcie_subctrl_writel(pcie, val, reg);
+}
+
+/* Configure vmid/asid table in PCIe host */
+static void hisi_pcie_config_context(struct hisi_pcie *pcie)
+{
+	int i;
+	u32 val;
+
+	/* enable to clean vmid and asid tables though apb bus */
+	hisi_pcie_change_apb_mode(pcie, PCIE_SLV_SYSCTRL_MODE);
+
+	val = hisi_pcie_apb_readl(pcie, PCIE_SYS_CTRL20_REG);
+	/* enable ar channel */
+	val |= PCIE_RD_TAB_SEL | PCIE_RD_TAB_EN;
+	hisi_pcie_apb_writel(pcie, val, PCIE_SYS_CTRL20_REG);
+
+	hisi_pcie_change_apb_mode(pcie, PCIE_SLV_CONTENT_MODE);
+
+	/*
+	 * init vmid and asid tables for all PCIe devices as 0
+	 * vmid table: 0 ~ 0x3ff, asid table: 0x400 ~ 0x7ff
+	 */
+	for (i = 0; i < 0x800; i++)
+		hisi_pcie_apb_writel(pcie, 0x0, i * 4);
+
+	hisi_pcie_change_apb_mode(pcie, PCIE_SLV_SYSCTRL_MODE);
+
+	/* enable aw channel */
+	val &= (~PCIE_RD_TAB_SEL);
+	val |= PCIE_RD_TAB_EN;
+	hisi_pcie_apb_writel(pcie, val, PCIE_SYS_CTRL20_REG);
+
+	hisi_pcie_change_apb_mode(pcie, PCIE_SLV_CONTENT_MODE);
+
+	for (i = 0; i < 0x800; i++)
+		hisi_pcie_apb_writel(pcie, 0x0, i * 4);
+
+	hisi_pcie_change_apb_mode(pcie, PCIE_SLV_SYSCTRL_MODE);
+
+	val = hisi_pcie_apb_readl(pcie, PCIE_SYS_CTRL20_REG);
+	/* disable ar channel */
+	val |= PCIE_RD_TAB_SEL;
+	val &= (~PCIE_RD_TAB_EN);
+	hisi_pcie_apb_writel(pcie, val, PCIE_SYS_CTRL20_REG);
+	/* disable aw channel */
+	val &= ((~PCIE_RD_TAB_SEL) & (~PCIE_RD_TAB_EN));
+	hisi_pcie_apb_writel(pcie, val, PCIE_SYS_CTRL20_REG);
+
+	hisi_pcie_change_apb_mode(pcie, PCIE_SLV_DBI_MODE);
+}
+
+static int hisi_pcie_link_up(struct pcie_port *pp)
+{
+	u32 val;
+	struct hisi_pcie *hisi_pcie = to_hisi_pcie(pp);
+
+	val = hisi_pcie_subctrl_readl(hisi_pcie, PCIE_SUBCTRL_SYS_STATE4_REG +
+				      0x100 * hisi_pcie->port_id);
+
+	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
+}
+
+static
+int hisi_pcie_msi_host_init(struct pcie_port *pp, struct msi_controller *chip)
+{
+	u64 addr;
+	struct device_node *msi_node;
+	struct resource res;
+	struct device_node *np = pp->dev->of_node;
+	struct hisi_pcie *pcie = to_hisi_pcie(pp);
+
+	msi_node = of_parse_phandle(np, "msi-parent", 0);
+	if (!msi_node) {
+		dev_err(pp->dev, "failed to find msi-parent\n");
+		return -EINVAL;
+	}
+	of_address_to_resource(msi_node, 0, &res);
+	addr = res.start + PCIE_GITS_TRANSLATER;
+
+	hisi_pcie_change_apb_mode(pcie, PCIE_SLV_SYSCTRL_MODE);
+
+	hisi_pcie_apb_writel(pcie, addr & 0xffffffff, PCIE_MSI_LOW_ADDRESS);
+	hisi_pcie_apb_writel(pcie, addr >> 32, PCIE_MSI_HIGH_ADDRESS);
+	hisi_pcie_apb_writel(pcie, PCIE_MSI_ASID_ENABLE | PCIE_MSI_ASID_VALUE,
+			     PCIE_SLV_MSI_ASID);
+	hisi_pcie_apb_writel(pcie, PCIE_MSI_TRANS_ENABLE, PCIE_MSI_TRANS_REG);
+
+	hisi_pcie_change_apb_mode(pcie, PCIE_SLV_DBI_MODE);
+
+	return 0;
+}
+
+static int hisi_pcie_cfg_write(struct pcie_port *pp, int where, int  size,
+				u32 val)
+{
+	u32 reg_val;
+	u32 reg;
+	struct hisi_pcie *pcie = to_hisi_pcie(pp);
+	void *walker = &reg_val;
+
+	walker += (where & 0x3);
+	reg = where & ~0x3;
+	if (size == 4)
+		hisi_pcie_apb_writel(pcie, val, reg);
+	else if (size == 2) {
+		reg_val = hisi_pcie_apb_readl(pcie, reg);
+		*(u16 __force *) walker = val;
+		hisi_pcie_apb_writel(pcie, reg_val, reg);
+	} else if (size == 1) {
+		reg_val = hisi_pcie_apb_readl(pcie, reg);
+		*(u8 __force *) walker = val;
+		hisi_pcie_apb_writel(pcie, reg_val, reg);
+	} else
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pcie_host_ops hisi_pcie_host_ops = {
+	.link_up = hisi_pcie_link_up,
+	.msi_host_init = hisi_pcie_msi_host_init,
+	.wr_own_conf = hisi_pcie_cfg_write,
+};
+
+static int __init hisi_add_pcie_port(struct pcie_port *pp,
+				     struct platform_device *pdev)
+{
+	int ret;
+	u32 port_id;
+	struct hisi_pcie *hisi_pcie = to_hisi_pcie(pp);
+
+	if (of_property_read_u32(pdev->dev.of_node, "port-id", &port_id)) {
+		dev_err(&pdev->dev, "failed to read port-id\n");
+		return -EINVAL;
+	}
+	if (port_id > 3) {
+		dev_err(&pdev->dev, "Invalid port-id: %d\n", port_id);
+		return -EINVAL;
+	}
+	hisi_pcie->port_id = port_id;
+
+	pp->ops = &hisi_pcie_host_ops;
+
+	hisi_pcie_config_context(hisi_pcie);
+
+	ret = dw_pcie_host_init(pp);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to initialize host\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __init hisi_pcie_probe(struct platform_device *pdev)
+{
+	struct hisi_pcie *hisi_pcie;
+	struct pcie_port *pp;
+	struct resource *reg;
+	struct resource *subctrl;
+	int ret;
+
+	hisi_pcie = devm_kzalloc(&pdev->dev, sizeof(*hisi_pcie), GFP_KERNEL);
+	if (!hisi_pcie)
+		return -ENOMEM;
+
+	pp = &hisi_pcie->pp;
+	pp->dev = &pdev->dev;
+
+	subctrl = platform_get_resource_byname(pdev, IORESOURCE_MEM, "subctrl");
+	hisi_pcie->subctrl_base = devm_ioremap_nocache(&pdev->dev,
+					subctrl->start, resource_size(subctrl));
+	if (IS_ERR(hisi_pcie->subctrl_base)) {
+		dev_err(pp->dev, "cannot get subctrl base\n");
+		return PTR_ERR(hisi_pcie->subctrl_base);
+	}
+
+	reg = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbi");
+	hisi_pcie->reg_base = devm_ioremap_resource(&pdev->dev, reg);
+	if (IS_ERR(hisi_pcie->reg_base)) {
+		dev_err(pp->dev, "cannot get rc_dbi base\n");
+		return PTR_ERR(hisi_pcie->reg_base);
+	}
+
+	hisi_pcie->pp.dbi_base = hisi_pcie->reg_base;
+
+	ret = hisi_add_pcie_port(pp, pdev);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, hisi_pcie);
+
+	return 0;
+}
+
+static const struct of_device_id hisi_pcie_of_match[] = {
+	{.compatible = "hisilicon,hip05-pcie",},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, hisi_pcie_of_match);
+
+static struct platform_driver hisi_pcie_driver = {
+	.driver = {
+		   .name = "hisi-pcie",
+		   .of_match_table = hisi_pcie_of_match,
+	},
+};
+
+static int __init hisi_pcie_init(void)
+{
+	return platform_driver_probe(&hisi_pcie_driver, hisi_pcie_probe);
+}
+subsys_initcall(hisi_pcie_init);
-- 
1.9.1

