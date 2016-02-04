Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <guohanjun@huawei.com>, <wangzhou1@hisilicon.com>,
	<liudongdong3@huawei.com>, <linuxarm@huawei.com>,
	<qiujiang@huawei.com>, <bhelgaas@google.com>, <arnd@arndb.de>,
	<Lorenzo.Pieralisi@arm.com>, <tn@semihalf.com>
CC: <gabriele.paoloni@huawei.com>, <zhangjukuo@huawei.com>,
	<xuwei5@hisilicon.com>, <liguozhu@hisilicon.com>,
	<linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jcm@redhat.com>
Subject: [RFC PATCH 2/4] PCI: hisi: re-architect Hip05/Hip06 controllers driver to preapare for ACPI
Date: Thu, 4 Feb 2016 19:37:38 +0800
Message-ID: <1454585860-60709-3-git-send-email-gabriele.paoloni@huawei.com>
In-Reply-To: <1454585860-60709-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1454585860-60709-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: gabriele paoloni <gabriele.paoloni@huawei.com>

re-architect the Hip05/Hip06 host controllers driver to prepare
for the ACPI based driver.
The common functions used also by the ACPI driver have been grouped
into a new "common" file

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 MAINTAINERS                         |   2 +
 drivers/pci/host/Makefile           |   2 +-
 drivers/pci/host/pcie-hisi-common.c |  88 +++++++++++++++++++++++
 drivers/pci/host/pcie-hisi.c        | 135 ++++++------------------------------
 drivers/pci/host/pcie-hisi.h        |  44 ++++++++++++
 5 files changed, 157 insertions(+), 114 deletions(-)
 create mode 100644 drivers/pci/host/pcie-hisi-common.c
 create mode 100644 drivers/pci/host/pcie-hisi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c80d9ff..8d6ec25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8247,7 +8247,9 @@ M:	Gabriele Paoloni <gabriele.paoloni@huawei.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
+F:	drivers/pci/host/pcie-hisi.h
 F:	drivers/pci/host/pcie-hisi.c
+F:	drivers/pci/host/pcie-hisi-common.c
 
 PCMCIA SUBSYSTEM
 P:	Linux PCMCIA Team
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 9d4d3c6..6248320 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -19,4 +19,4 @@ obj-$(CONFIG_PCIE_IPROC_PLATFORM) += pcie-iproc-platform.o
 obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
 obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
 obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
-obj-$(CONFIG_PCI_HISI) += pcie-hisi.o
+obj-$(CONFIG_PCI_HISI) += pcie-hisi.o pcie-hisi-common.o
diff --git a/drivers/pci/host/pcie-hisi-common.c b/drivers/pci/host/pcie-hisi-common.c
new file mode 100644
index 0000000..ff93293
--- /dev/null
+++ b/drivers/pci/host/pcie-hisi-common.c
@@ -0,0 +1,88 @@
+/*
+ * PCIe host controller common functions for HiSilicon SoCs
+ *
+ * Copyright (C) 2015 HiSilicon Co., Ltd. http://www.hisilicon.com
+ *
+ * Author: Zhou Wang <wangzhou1@hisilicon.com>
+ *         Dacai Zhu <zhudacai@hisilicon.com>
+ *         Gabriele Paoloni <gabriele.paoloni@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/acpi.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_pci.h>
+#include <linux/regmap.h>
+
+#include "pcie-designware.h"
+#include "pcie-hisi.h"
+
+/* HipXX PCIe host only supports 32-bit config access */
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
+	else if (size == 4)
+		*val = reg_val;
+	else
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+/* HipXX PCIe host only supports 32-bit config access */
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
+	struct hisi_pcie *hisi_pcie = to_hisi_pcie(pp);
+
+	return hisi_pcie->soc_ops->hisi_pcie_link_up(hisi_pcie);
+}
+
+struct pcie_host_ops hisi_pcie_host_ops = {
+	.rd_own_conf = hisi_pcie_cfg_read,
+	.wr_own_conf = hisi_pcie_cfg_write,
+	.link_up = hisi_pcie_link_up,
+};
diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index 3e98d4e..552ebfc 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -21,124 +21,13 @@
 #include <linux/regmap.h>
 
 #include "pcie-designware.h"
+#include "pcie-hisi.h"
 
 #define PCIE_LTSSM_LINKUP_STATE				0x11
 #define PCIE_LTSSM_STATE_MASK				0x3F
 #define PCIE_SUBCTRL_SYS_STATE4_REG			0x6818
-#define PCIE_SYS_STATE4						0x31c
 #define PCIE_HIP06_CTRL_OFF					0x1000
-
-#define to_hisi_pcie(x)	container_of(x, struct hisi_pcie, pp)
-
-struct hisi_pcie;
-
-struct pcie_soc_ops {
-	int (*hisi_pcie_link_up)(struct hisi_pcie *pcie);
-};
-
-struct hisi_pcie {
-	struct regmap *subctrl;
-	void __iomem *reg_base;
-	u32 port_id;
-	struct pcie_port pp;
-	struct pcie_soc_ops *soc_ops;
-};
-
-static inline void hisi_pcie_apb_writel(struct hisi_pcie *pcie,
-					u32 val, u32 reg)
-{
-	writel(val, pcie->reg_base + reg);
-}
-
-static inline u32 hisi_pcie_apb_readl(struct hisi_pcie *pcie, u32 reg)
-{
-	return readl(pcie->reg_base + reg);
-}
-
-/* HipXX PCIe host only supports 32-bit config access */
-static int hisi_pcie_cfg_read(struct pcie_port *pp, int where, int size,
-			      u32 *val)
-{
-	u32 reg;
-	u32 reg_val;
-	struct hisi_pcie *pcie = to_hisi_pcie(pp);
-	void *walker = &reg_val;
-
-	walker += (where & 0x3);
-	reg = where & ~0x3;
-	reg_val = hisi_pcie_apb_readl(pcie, reg);
-
-	if (size == 1)
-		*val = *(u8 __force *) walker;
-	else if (size == 2)
-		*val = *(u16 __force *) walker;
-	else if (size == 4)
-		*val = reg_val;
-	else
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-/* HipXX PCIe host only supports 32-bit config access */
-static int hisi_pcie_cfg_write(struct pcie_port *pp, int where, int  size,
-				u32 val)
-{
-	u32 reg_val;
-	u32 reg;
-	struct hisi_pcie *pcie = to_hisi_pcie(pp);
-	void *walker = &reg_val;
-
-	walker += (where & 0x3);
-	reg = where & ~0x3;
-	if (size == 4)
-		hisi_pcie_apb_writel(pcie, val, reg);
-	else if (size == 2) {
-		reg_val = hisi_pcie_apb_readl(pcie, reg);
-		*(u16 __force *) walker = val;
-		hisi_pcie_apb_writel(pcie, reg_val, reg);
-	} else if (size == 1) {
-		reg_val = hisi_pcie_apb_readl(pcie, reg);
-		*(u8 __force *) walker = val;
-		hisi_pcie_apb_writel(pcie, reg_val, reg);
-	} else
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int hisi_pcie_link_up_hip05(struct hisi_pcie *hisi_pcie)
-{
-	u32 val;
-
-	regmap_read(hisi_pcie->subctrl, PCIE_SUBCTRL_SYS_STATE4_REG +
-		    0x100 * hisi_pcie->port_id, &val);
-
-	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
-}
-
-static int hisi_pcie_link_up_hip06(struct hisi_pcie *hisi_pcie)
-{
-	u32 val;
-
-	val = hisi_pcie_apb_readl(hisi_pcie, PCIE_HIP06_CTRL_OFF +
-			PCIE_SYS_STATE4);
-
-	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
-}
-
-static int hisi_pcie_link_up(struct pcie_port *pp)
-{
-	struct hisi_pcie *hisi_pcie = to_hisi_pcie(pp);
-
-	return hisi_pcie->soc_ops->hisi_pcie_link_up(hisi_pcie);
-}
-
-static struct pcie_host_ops hisi_pcie_host_ops = {
-	.rd_own_conf = hisi_pcie_cfg_read,
-	.wr_own_conf = hisi_pcie_cfg_write,
-	.link_up = hisi_pcie_link_up,
-};
+#define PCIE_SYS_STATE4						0x31c
 
 static int hisi_add_pcie_port(struct pcie_port *pp,
 				     struct platform_device *pdev)
@@ -215,6 +104,26 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int hisi_pcie_link_up_hip05(struct hisi_pcie *hisi_pcie)
+{
+	u32 val;
+
+	regmap_read(hisi_pcie->subctrl, PCIE_SUBCTRL_SYS_STATE4_REG +
+		    0x100 * hisi_pcie->port_id, &val);
+
+	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
+}
+
+static int hisi_pcie_link_up_hip06(struct hisi_pcie *hisi_pcie)
+{
+	u32 val;
+
+	val = hisi_pcie_apb_readl(hisi_pcie, PCIE_HIP06_CTRL_OFF +
+			PCIE_SYS_STATE4);
+
+	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
+}
+
 static struct pcie_soc_ops hip05_ops = {
 		&hisi_pcie_link_up_hip05
 };
diff --git a/drivers/pci/host/pcie-hisi.h b/drivers/pci/host/pcie-hisi.h
new file mode 100644
index 0000000..f64249d
--- /dev/null
+++ b/drivers/pci/host/pcie-hisi.h
@@ -0,0 +1,44 @@
+/*
+ * PCIe host controller driver for HiSilicon SoCs
+ *
+ * Copyright (C) 2015 HiSilicon Co., Ltd. http://www.hisilicon.com
+ *
+ * Author: Zhou Wang <wangzhou1@hisilicon.com>
+ *         Dacai Zhu <zhudacai@hisilicon.com>
+ *         Gabriele Paoloni <gabriele.paoloni@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef PCIE_HISI_H_
+#define PCIE_HISI_H_
+
+struct hisi_pcie {
+	struct regmap *subctrl;
+	void __iomem *reg_base;
+	u32 port_id;
+	struct pcie_port pp;
+	struct pcie_soc_ops *soc_ops;
+};
+
+struct pcie_soc_ops {
+	int (*hisi_pcie_link_up)(struct hisi_pcie *pcie);
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
+#define to_hisi_pcie(x)	container_of(x, struct hisi_pcie, pp)
+
+extern struct pcie_host_ops hisi_pcie_host_ops;
+
+#endif /* PCIE_HISI_H_ */
-- 
1.9.1

