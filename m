Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:13154 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755151AbbKRJlM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 Nov 2015 04:41:12 -0500
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <wangzhou1@hisilicon.com>, <linux-pci@vger.kernel.org>
CC: <gabriele.paoloni@huawei.com>, <xuwei5@hisilicon.com>,
	<zhangjukuo@huawei.com>, <qiuzhenfa@hisilicon.com>,
	<qiujiang@huawei.com>, <liudongdong3@huawei.com>,
	<liguozhu@hisilicon.com>, <linux-kernel@vger.kernel.org>,
	<lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>
Subject: [PATCH] PCI: hisi: Add support for HiSilicon Hip06 PCIe host bridge controllers
Date: Wed, 18 Nov 2015 17:51:09 +0800
Message-ID: <1447840269-25001-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: gabriele paoloni <gabriele.paoloni@huawei.com>

This patch adds support for HiSilicon Hip06 SoC that implements
v2 HW IP of the PCIe Host Bridge controller.
Hip05 SoC references have been replaced with v1-Hip05
and references to v2-Hip06 have been added.
Documentation has been updated to include Hip06 and the DT
example also has been updated accordingly.
Finally Gabriele Paoloni has been added as maintainer of the
driver

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
This patch is based on top of Arnd Bergmann patch
[PATCH] PCI: hisi: fix deferred probing
---
 .../devicetree/bindings/pci/hisilicon-pcie.txt     | 16 ++--
 MAINTAINERS                                        |  1 +
 drivers/pci/host/Kconfig                           |  5 +-
 drivers/pci/host/pcie-hisi.c                       | 91 ++++++++++++++++++----
 4 files changed, 90 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
index 17c6ed9..3eee49a 100644
--- a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
@@ -1,4 +1,4 @@
-HiSilicon PCIe host bridge DT description
+HiSilicon Hip05 and Hip06 PCIe host bridge DT description
 
 HiSilicon PCIe host controller is based on Designware PCI core.
 It shares common functions with PCIe Designware core driver and inherits
@@ -7,8 +7,8 @@ Documentation/devicetree/bindings/pci/designware-pci.txt.
 
 Additional properties are described here:
 
-Required properties:
-- compatible: Should contain "hisilicon,hip05-pcie".
+Required properties
+- compatible: Should contain "hisilicon,v1-pcie-hip05" or "hisilicon,v2-pcie-hip06".
 - reg: Should contain rc_dbi, config registers location and length.
 - reg-names: Must include the following entries:
   "rc_dbi": controller configuration registers;
@@ -20,10 +20,14 @@ Optional properties:
 - status: Either "ok" or "disabled".
 - dma-coherent: Present if DMA operations are coherent.
 
-Example:
+Hip05/Hip06 Example:
 	pcie@0xb0080000 {
-		compatible = "hisilicon,hip05-pcie", "snps,dw-pcie";
+		compatible = "hisilicon,v1-pcie-hip05", "snps,dw-pcie";
 		reg = <0 0xb0080000 0 0x10000>, <0x220 0x00000000 0 0x2000>;
+/* for v2 HW IP use
+ *		compatible = "hisilicon,v2-pcie-hip06", "snps,dw-pcie";
+ *		reg = <0 0xa0090000 0 0x10000>, <0 0xa8000000 0 0x2000>;
+ */
 		reg-names = "rc_dbi", "config";
 		bus-range = <0  15>;
 		msi-parent = <&its_pcie>;
@@ -41,4 +45,4 @@ Example:
 				  0x0 0 0 3 &mbigen_pcie 3 12
 				  0x0 0 0 4 &mbigen_pcie 4 13>;
 		status = "ok";
-	};
+	};
\ No newline at end of file
diff --git a/MAINTAINERS b/MAINTAINERS
index 7af7f4a..3f97cf1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8195,6 +8195,7 @@ F:	drivers/pci/host/pci-xgene-msi.c
 
 PCIE DRIVER FOR HISILICON
 M:	Zhou Wang <wangzhou1@hisilicon.com>
+M:	Gabriele Paoloni <gabriele.paoloni@huawei.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index f131ba9..f5c58cf 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -166,10 +166,11 @@ config PCIE_ALTERA_MSI
 
 config PCI_HISI
 	depends on OF && ARM64
-	bool "HiSilicon SoC HIP05 PCIe controller"
+	bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
 	select PCIEPORTBUS
 	select PCIE_DW
 	help
-	  Say Y here if you want PCIe controller support on HiSilicon HIP05 SoC
+	  Say Y here if you want PCIe controller support on SoCs supporting
+	  HiSilicon Hip05 and Hip06 SoCs
 
 endmenu
diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index 163671a..1210685 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -1,10 +1,11 @@
 /*
- * PCIe host controller driver for HiSilicon Hip05 SoC
+ * PCIe host bridge controller driver for HiSilicon SoCs
  *
  * Copyright (C) 2015 HiSilicon Co., Ltd. http://www.hisilicon.com
  *
- * Author: Zhou Wang <wangzhou1@hisilicon.com>
- *         Dacai Zhu <zhudacai@hisilicon.com>
+ * Authors: Zhou Wang <wangzhou1@hisilicon.com>
+ *          Dacai Zhu <zhudacai@hisilicon.com>
+ *          Gabriele Paoloni <gabriele.paoloni@huawei.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -16,21 +17,35 @@
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/platform_device.h>
+#include <linux/of_device.h>
 #include <linux/regmap.h>
 
 #include "pcie-designware.h"
 
-#define PCIE_SUBCTRL_SYS_STATE4_REG                     0x6818
-#define PCIE_LTSSM_LINKUP_STATE                         0x11
-#define PCIE_LTSSM_STATE_MASK                           0x3F
+#define PCIE_HOST_V1                                 0x1
+#define PCIE_HOST_V2                                 0x2
+
+#define PCIE_LTSSM_LINKUP_STATE                      0x11
+#define PCIE_LTSSM_STATE_MASK                        0x3F
+#define PCIE_SUBCTRL_SYS_STATE4_REG                  0x6818
+#define PCIE_SYS_STATE4                              0x31c
+#define PCIE_V2_CTRL_OFF                             0x1000
 
 #define to_hisi_pcie(x)	container_of(x, struct hisi_pcie, pp)
 
+struct hisi_pcie;
+
+struct pcie_soc_ops {
+	int (*hisi_pcie_link_up)(struct hisi_pcie *pcie);
+	u32 soc_type;
+};
+
 struct hisi_pcie {
 	struct regmap *subctrl;
 	void __iomem *reg_base;
 	u32 port_id;
 	struct pcie_port pp;
+	struct pcie_soc_ops *soc_ops;
 };
 
 static inline void hisi_pcie_apb_writel(struct hisi_pcie *pcie,
@@ -44,7 +59,7 @@ static inline u32 hisi_pcie_apb_readl(struct hisi_pcie *pcie, u32 reg)
 	return readl(pcie->reg_base + reg);
 }
 
-/* Hip05 PCIe host only supports 32-bit config access */
+/* HipXX PCIe host only supports 32-bit config access */
 static int hisi_pcie_cfg_read(struct pcie_port *pp, int where, int size,
 			      u32 *val)
 {
@@ -67,7 +82,7 @@ static int hisi_pcie_cfg_read(struct pcie_port *pp, int where, int size,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-/* Hip05 PCIe host only supports 32-bit config access */
+/* HipXX PCIe host only supports 32-bit config access */
 static int hisi_pcie_cfg_write(struct pcie_port *pp, int where, int  size,
 				u32 val)
 {
@@ -96,13 +111,8 @@ static int hisi_pcie_cfg_write(struct pcie_port *pp, int where, int  size,
 
 static int hisi_pcie_link_up(struct pcie_port *pp)
 {
-	u32 val;
 	struct hisi_pcie *hisi_pcie = to_hisi_pcie(pp);
-
-	regmap_read(hisi_pcie->subctrl, PCIE_SUBCTRL_SYS_STATE4_REG +
-		    0x100 * hisi_pcie->port_id, &val);
-
-	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
+	return hisi_pcie->soc_ops->hisi_pcie_link_up(hisi_pcie);
 }
 
 static struct pcie_host_ops hisi_pcie_host_ops = {
@@ -143,7 +153,9 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 {
 	struct hisi_pcie *hisi_pcie;
 	struct pcie_port *pp;
+	const struct of_device_id *match;
 	struct resource *reg;
+	struct device_driver *driver;
 	int ret;
 
 	hisi_pcie = devm_kzalloc(&pdev->dev, sizeof(*hisi_pcie), GFP_KERNEL);
@@ -152,6 +164,10 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 
 	pp = &hisi_pcie->pp;
 	pp->dev = &pdev->dev;
+	driver = (pdev->dev).driver;
+
+	match = of_match_device(driver->of_match_table, &pdev->dev);
+	hisi_pcie->soc_ops = (struct pcie_soc_ops *) match->data;
 
 	hisi_pcie->subctrl =
 	syscon_regmap_lookup_by_compatible("hisilicon,pcie-sas-subctrl");
@@ -180,11 +196,51 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 	return 0;
 }
 
+/* Check if the link is up for V1 PCIe HW IP*/
+static int hisi_pcie_link_up_v1(struct hisi_pcie *hisi_pcie)
+{
+	u32 val;
+
+	regmap_read(hisi_pcie->subctrl, PCIE_SUBCTRL_SYS_STATE4_REG +
+		    0x100 * hisi_pcie->port_id, &val);
+
+	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
+}
+
+/* Check if the link is up for V2 PCIe HW IP */
+static int hisi_pcie_link_up_v2(struct hisi_pcie *hisi_pcie)
+{
+	u32 val;
+
+	val = hisi_pcie_apb_readl(hisi_pcie, PCIE_V2_CTRL_OFF +
+			PCIE_SYS_STATE4);
+
+	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
+}
+
+static struct pcie_soc_ops v2_ops = {
+		&hisi_pcie_link_up_v2,
+		PCIE_HOST_V2
+};
+
+static struct pcie_soc_ops v1_ops = {
+		&hisi_pcie_link_up_v1,
+		PCIE_HOST_V1
+};
+
 static const struct of_device_id hisi_pcie_of_match[] = {
-	{.compatible = "hisilicon,hip05-pcie",},
+	{
+			.compatible = "hisilicon,v1-pcie-hip05",
+			.data	    = (void *) &v1_ops,
+	},
+	{
+			.compatible = "hisilicon,v2-pcie-hip06",
+			.data	    = (void *) &v2_ops,
+	},
 	{},
 };
 
+
 MODULE_DEVICE_TABLE(of, hisi_pcie_of_match);
 
 static struct platform_driver hisi_pcie_driver = {
@@ -196,3 +252,8 @@ static struct platform_driver hisi_pcie_driver = {
 };
 
 module_platform_driver(hisi_pcie_driver);
+
+MODULE_AUTHOR("Zhou Wang <wangzhou1@hisilicon.com>");
+MODULE_AUTHOR("Dacai Zhu <zhudacai@hisilicon.com>");
+MODULE_AUTHOR("Gabriele Paoloni <gabriele.paoloni@huawei.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4

