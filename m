Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:24082 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbbETGPb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2015 02:15:31 -0400
From: Zhou Wang <wangzhou1@hisilicon.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Liviu Dudau <Liviu.Dudau@arm.com>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <gabriele.paoloni@huawei.com>,
	<yuanzhichang@hisilicon.com>, <zhudacai@hisilicon.com>,
	<zhangjukuo@huawei.com>, <qiuzhenfa@hisilicon.com>,
	<liguozhu@hisilicon.com>, Zhou Wang <wangzhou1@hisilicon.com>
Subject: [RFC PATCH v1 2/3] PCI: hisi: Add PCIe host support for Hisilicon Soc Hip05
Date: Wed, 20 May 2015 14:21:40 +0800
Message-ID: <1432102901-186201-3-git-send-email-wangzhou1@hisilicon.com>
In-Reply-To: <1432102901-186201-1-git-send-email-wangzhou1@hisilicon.com>
References: <1432102901-186201-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds PCIe host support for Hisilicon Soc Hip05.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/pci/host/Kconfig     |   5 +
 drivers/pci/host/Makefile    |   1 +
 drivers/pci/host/pcie-hisi.c | 252 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 258 insertions(+)
 create mode 100644 drivers/pci/host/pcie-hisi.c

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 1dfb567..486d822 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -125,4 +125,9 @@ config PCIE_IPROC_PLATFORM
 	  Say Y here if you want to use the Broadcom iProc PCIe controller
 	  through the generic platform bus interface
 
+config PCI_HISI
+	depends on OF && ARM64
+	bool "Hisilicon Soc HIP05 PCIe controller"
+	select PCIE_DW
+
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index f733b4e..562142e 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
 obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
 obj-$(CONFIG_PCIE_IPROC) += pcie-iproc.o
 obj-$(CONFIG_PCIE_IPROC_PLATFORM) += pcie-iproc-platform.o
+obj-$(CONFIG_PCI_HISI) += pcie-hisi.o
diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
new file mode 100644
index 0000000..3f8cb9a
--- /dev/null
+++ b/drivers/pci/host/pcie-hisi.c
@@ -0,0 +1,252 @@
+/*
+ * PCIe host controller driver for Hisilicon Hip05 SoCs
+ *
+ * Copyright (C) 2014 Hisilicon Co., Ltd. http://www.hisilicon.com
+ *
+ * Author: Zhou Wang <wangzhou1@hisilicon.com>
+ *         Dacai Zhu <zhudacai@hisilicon.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_pci.h>
+#include <linux/platform_device.h>
+
+#include "pcie-designware.h"
+
+#define PCIE_SUBCTRL_MODE_REG                           (0x2800)
+#define PCIE_SUBCTRL_SYS_STATE4_REG                     (0x6818)
+#define PCIE_SLV_DBI_MODE                               (0x0)
+#define PCIE_SLV_SYSCTRL_MODE                           (0x1)
+#define PCIE_SLV_CONTENT_MODE                           (0x2)
+#define PCIE_LTSSM_LINKUP_STATE                         (0x11)
+#define PCIE_LTSSM_STATE_MASK                           (0x3F)
+#define PCIE_MSI_CONTEXT_VALUE                          (0x1011000)
+#define PCIE_MSI_TRANS_ENABLE                           (0x1ff0)
+#define PCIE_MSI_LOW_ADDRESS                            (0x1b4)
+#define PCIE_MSI_HIGH_ADDRESS                           (0x1c4)
+
+#define to_hisi_pcie(x)	container_of(x, struct hisi_pcie, pp)
+
+struct hisi_pcie {
+	void __iomem *subctrl_base;
+	void __iomem *reg_base;
+	struct msi_controller *msi;
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
+
+	hisi_pcie_change_apb_mode(pcie, PCIE_SLV_CONTENT_MODE);
+
+	for (i = 0; i < 0x400; i++)
+		hisi_pcie_apb_writel(pcie, 0x0, i * 4);
+
+	for (i = 0x400; i < 0x800; i++)
+		hisi_pcie_apb_writel(pcie, 0x0, i * 4);
+
+	hisi_pcie_change_apb_mode(pcie, PCIE_SLV_SYSCTRL_MODE);
+
+	hisi_pcie_apb_writel(pcie, 0xb7010040, PCIE_MSI_LOW_ADDRESS);
+	hisi_pcie_apb_writel(pcie, 0x0, PCIE_MSI_HIGH_ADDRESS);
+	hisi_pcie_apb_writel(pcie, PCIE_MSI_CONTEXT_VALUE, 0x10);
+	hisi_pcie_apb_writel(pcie, PCIE_MSI_TRANS_ENABLE, 0x1c8);
+
+	hisi_pcie_change_apb_mode(pcie, PCIE_SLV_DBI_MODE);
+}
+
+static int hisi_pcie_link_up(struct pcie_port *pp)
+{
+	u32 val;
+
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
+	struct device_node *msi_node;
+	struct msi_controller *msi;
+	struct device_node *np = pp->dev->of_node;
+	struct hisi_pcie *hisi_pcie = to_hisi_pcie(pp);
+
+	msi_node = of_parse_phandle(np, "msi-parent", 0);
+	if (!msi_node) {
+		pr_err("failed to find msi-parent\n");
+		return -ENODEV;
+	}
+
+	msi = of_pci_find_msi_chip_by_node(msi_node);
+	hisi_pcie->msi = msi;
+
+	pp->irq_domain = msi->domain;
+
+	return 0;
+}
+
+static struct pcie_host_ops hisi_pcie_host_ops = {
+	.link_up = hisi_pcie_link_up,
+	.msi_host_init = hisi_pcie_msi_host_init,
+};
+
+static int __init hisi_add_pcie_port(struct pcie_port *pp,
+				     struct platform_device *pdev)
+{
+	int ret;
+	u32 port_id;
+	struct resource busn;
+
+	struct hisi_pcie *hisi_pcie = to_hisi_pcie(pp);
+
+	if (of_property_read_u32(pdev->dev.of_node, "port-id", &port_id)) {
+		dev_err(&pdev->dev, "failed to read port-id\n");
+		return -EINVAL;
+	}
+	if (port_id > 3) {
+		dev_err(&pdev->dev, "Invalid port-id\n");
+		return -EINVAL;
+	}
+
+	hisi_pcie->port_id = port_id;
+
+	if (of_pci_parse_bus_range(pdev->dev.of_node, &busn)) {
+		dev_err(&pdev->dev, "failed to parse bus-ranges\n");
+		return -EINVAL;
+	}
+
+	pp->root_bus_nr = busn.start;
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
+		dev_err(pp->dev, "cannot get reg base\n");
+		return PTR_ERR(hisi_pcie->reg_base);
+	}
+
+	hisi_pcie->pp.dbi_base = hisi_pcie->reg_base;
+
+	ret = hisi_add_pcie_port(pp, pdev);
+	if (ret < 0)
+		return ret;
+
+	platform_set_drvdata(pdev, hisi_pcie);
+
+	return ret;
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
+	.probe  = hisi_pcie_probe,
+	.driver = {
+		   .name = "hisi-pcie",
+		   .owner = THIS_MODULE,
+		   .of_match_table = hisi_pcie_of_match,
+	},
+};
+
+module_platform_driver(hisi_pcie_driver);
+
+MODULE_AUTHOR("Zhou Wang <wangzhou1@huawei.com>");
+MODULE_AUTHOR("Dacai Zhu <zhudacai@huawei.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

