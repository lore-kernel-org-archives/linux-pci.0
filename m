Return-Path: <linux-kernel-owner@vger.kernel.org>
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
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhangjukuo@huawei.com>, <qiuzhenfa@hisilicon.com>,
	<liudongdong3@huawei.com>, <qiujiang@huawei.com>,
	<xuwei5@hisilicon.com>, <liguozhu@hisilicon.com>,
	Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH v11 4/6] PCI: hisi: Add PCIe host support for HiSilicon SoC Hip05
Date: Fri, 16 Oct 2015 18:23:39 +0800
Message-ID: <1444991021-109306-5-git-send-email-wangzhou1@hisilicon.com>
In-Reply-To: <1444991021-109306-1-git-send-email-wangzhou1@hisilicon.com>
References: <1444991021-109306-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds PCIe host support for HiSilicon SoC Hip05.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Signed-off-by: liudongdong <liudongdong3@huawei.com>
---
 drivers/pci/host/Kconfig     |   8 ++
 drivers/pci/host/Makefile    |   1 +
 drivers/pci/host/pcie-hisi.c | 196 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 205 insertions(+)
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
index 0000000..a342a48
--- /dev/null
+++ b/drivers/pci/host/pcie-hisi.c
@@ -0,0 +1,196 @@
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
+#include <linux/module.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include "pcie-designware.h"
+
+#define PCIE_SUBCTRL_SYS_STATE4_REG                     0x6818
+#define PCIE_LTSSM_LINKUP_STATE                         0x11
+#define PCIE_LTSSM_STATE_MASK                           0x3F
+
+#define to_hisi_pcie(x)	container_of(x, struct hisi_pcie, pp)
+
+struct hisi_pcie {
+	struct regmap *subctrl;
+	void __iomem *reg_base;
+	u32 port_id;
+	struct pcie_port pp;
+};
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
+/* Hip05 PCIe host only supports 32-bit config access */
+static int hisi_pcie_cfg_read(struct pcie_port *pp, int where, int size,
+			      u32 *val)
+{
+	u32 reg;
+	u32 reg_val;
+	struct hisi_pcie *pcie = to_hisi_pcie(pp);
+	void *walker = &reg_val;
+
+	walker += (where & 0x3);
+	reg = where & ~0x3;
+	reg_val = hisi_pcie_apb_readl(pcie, reg);
+
+	if (size == 1)
+		*val = *(u8 __force *) walker;
+	else if (size == 2)
+		*val = *(u16 __force *) walker;
+	else if (size != 4)
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+/* Hip05 PCIe host only supports 32-bit config access */
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
+static int hisi_pcie_link_up(struct pcie_port *pp)
+{
+	u32 val;
+	struct hisi_pcie *hisi_pcie = to_hisi_pcie(pp);
+
+	regmap_read(hisi_pcie->subctrl, PCIE_SUBCTRL_SYS_STATE4_REG +
+		    0x100 * hisi_pcie->port_id, &val);
+
+	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
+}
+
+static struct pcie_host_ops hisi_pcie_host_ops = {
+	.rd_own_conf = hisi_pcie_cfg_read,
+	.wr_own_conf = hisi_pcie_cfg_write,
+	.link_up = hisi_pcie_link_up,
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
+	int ret;
+
+	hisi_pcie = devm_kzalloc(&pdev->dev, sizeof(*hisi_pcie), GFP_KERNEL);
+	if (!hisi_pcie)
+		return -ENOMEM;
+
+	pp = &hisi_pcie->pp;
+	pp->dev = &pdev->dev;
+
+	hisi_pcie->subctrl =
+	syscon_regmap_lookup_by_compatible("hisilicon,pcie-sas-subctrl");
+	if (IS_ERR(hisi_pcie->subctrl)) {
+		dev_err(pp->dev, "cannot get subctrl base\n");
+		return PTR_ERR(hisi_pcie->subctrl);
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
+	.probe  = hisi_pcie_probe,
+	.driver = {
+		   .name = "hisi-pcie",
+		   .of_match_table = hisi_pcie_of_match,
+	},
+};
+
+module_platform_driver(hisi_pcie_driver);
-- 
1.9.1

