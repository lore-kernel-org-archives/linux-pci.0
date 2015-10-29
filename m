Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:10118 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbbJ2JZf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2015 05:25:35 -0400
From: Zhou Wang <wangzhou1@hisilicon.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<pratyush.anand@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	<rmk+kernel@arm.linux.org.uk>,
	<thomas.petazzoni@free-electrons.com>,
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
Subject: [PATCH v13 6/6] PCI: hisi: Add PCIe host support for HiSilicon SoC Hip05
Date: Thu, 29 Oct 2015 17:40:38 +0800
Message-ID: <1446111638-197070-7-git-send-email-wangzhou1@hisilicon.com>
In-Reply-To: <1446111638-197070-1-git-send-email-wangzhou1@hisilicon.com>
References: <1446111638-197070-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds PCIe host support for HiSilicon SoC Hip05, related DT binding
document and maintainer update.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Signed-off-by: liudongdong <liudongdong3@huawei.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/arm/hisilicon/hisilicon.txt           |  17 ++
 .../devicetree/bindings/pci/hisilicon-pcie.txt     |  44 +++++
 MAINTAINERS                                        |   7 +
 drivers/pci/host/Kconfig                           |   8 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pcie-hisi.c                       | 198 +++++++++++++++++++++
 6 files changed, 275 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
 create mode 100644 drivers/pci/host/pcie-hisi.c

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
index 3504dca..6ac7c00 100644
--- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
@@ -171,6 +171,23 @@ Example:
 	};
 
 -----------------------------------------------------------------------
+Hisilicon HiP05 PCIe-SAS system controller
+
+Required properties:
+- compatible : "hisilicon,pcie-sas-subctrl", "syscon";
+- reg : Register address and size
+
+The HiP05 PCIe-SAS system controller is shared by PCIe and SAS controllers in
+HiP05 Soc to implement some basic configurations.
+
+Example:
+	/* for HiP05 PCIe-SAS system */
+	pcie_sas: system_controller@0xb0000000 {
+		compatible = "hisilicon,pcie-sas-subctrl", "syscon";
+		reg = <0xb0000000 0x10000>;
+	};
+
+-----------------------------------------------------------------------
 Hisilicon CPU controller
 
 Required properties:
diff --git a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
new file mode 100644
index 0000000..17c6ed9
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
@@ -0,0 +1,44 @@
+HiSilicon PCIe host bridge DT description
+
+HiSilicon PCIe host controller is based on Designware PCI core.
+It shares common functions with PCIe Designware core driver and inherits
+common properties defined in
+Documentation/devicetree/bindings/pci/designware-pci.txt.
+
+Additional properties are described here:
+
+Required properties:
+- compatible: Should contain "hisilicon,hip05-pcie".
+- reg: Should contain rc_dbi, config registers location and length.
+- reg-names: Must include the following entries:
+  "rc_dbi": controller configuration registers;
+  "config": PCIe configuration space registers.
+- msi-parent: Should be its_pcie which is an ITS receiving MSI interrupts.
+- port-id: Should be 0, 1, 2 or 3.
+
+Optional properties:
+- status: Either "ok" or "disabled".
+- dma-coherent: Present if DMA operations are coherent.
+
+Example:
+	pcie@0xb0080000 {
+		compatible = "hisilicon,hip05-pcie", "snps,dw-pcie";
+		reg = <0 0xb0080000 0 0x10000>, <0x220 0x00000000 0 0x2000>;
+		reg-names = "rc_dbi", "config";
+		bus-range = <0  15>;
+		msi-parent = <&its_pcie>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		dma-coherent;
+		ranges = <0x82000000 0 0x00000000 0x220 0x00000000 0 0x10000000>;
+		num-lanes = <8>;
+		port-id = <1>;
+		#interrupts-cells = <1>;
+		interrupts-map-mask = <0xf800 0 0 7>;
+		interrupts-map = <0x0 0 0 1 &mbigen_pcie 1 10
+				  0x0 0 0 2 &mbigen_pcie 2 11
+				  0x0 0 0 3 &mbigen_pcie 3 12
+				  0x0 0 0 4 &mbigen_pcie 4 13>;
+		status = "ok";
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 7ba7ab7..944a229 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8047,6 +8047,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
 F:	drivers/pci/host/pci-xgene-msi.c
 
+PCIE DRIVER FOR HISILICON
+M:	Zhou Wang <wangzhou1@hisilicon.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
+F:	drivers/pci/host/pcie-hisi.c
+
 PCMCIA SUBSYSTEM
 P:	Linux PCMCIA Team
 L:	linux-pcmcia@lists.infradead.org
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
index 0000000..545d4e7
--- /dev/null
+++ b/drivers/pci/host/pcie-hisi.c
@@ -0,0 +1,198 @@
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
+	dev_warn(pp->dev, "Hip05 PCIe host only supports 32-bit config access of host\n");
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

