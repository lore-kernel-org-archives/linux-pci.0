Return-Path: <liudongdong3@huawei.com>
Return-Path: <liudongdong3@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
To: <helgaas@kernel.org>, <arnd@arndb.de>, <rafael@kernel.org>,
        <Lorenzo.Pieralisi@arm.com>, <tn@semihalf.com>,
        <wangzhou1@hisilicon.com>, <pratyush.anand@gmail.com>
CC: <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jcm@redhat.com>,
        <liudongdong3@huawei.com>, <gabriele.paoloni@huawei.com>,
        <charles.chenxin@huawei.com>, <linuxarm@huawei.com>
Subject: [RFC PATCH 1/3] PCI: hisi: re-architect Hip05/Hip06 controllers driver to preapare for ACPI
Date: Tue, 12 Jul 2016 10:42:22 +0800
Message-ID: <1468291344-122909-2-git-send-email-liudongdong3@huawei.com>
In-Reply-To: <1468291344-122909-1-git-send-email-liudongdong3@huawei.com>
References: <1468291344-122909-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

re-architect the Hip05/Hip06 host controllers driver to prepare
for the ACPI based driver.
The common functions used also by the ACPI driver have been grouped
into a new "common" file.

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
 MAINTAINERS                         |   2 +
 drivers/pci/host/Makefile           |   2 +-
 drivers/pci/host/pcie-hisi-common.c |  66 ++++++++++++++++++++++
 drivers/pci/host/pcie-hisi.c        | 110 ++++++++++--------------------------
 drivers/pci/host/pcie-hisi.h        |  23 ++++++++
 5 files changed, 123 insertions(+), 80 deletions(-)
 create mode 100644 drivers/pci/host/pcie-hisi-common.c
 create mode 100644 drivers/pci/host/pcie-hisi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ed42cb6..7e8e2c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8829,7 +8829,9 @@ M:	Gabriele Paoloni <gabriele.paoloni@huawei.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
+F:	drivers/pci/host/pcie-hisi.h
 F:	drivers/pci/host/pcie-hisi.c
+F:	drivers/pci/host/pcie-hisi-common.c
 
 PCIE DRIVER FOR QUALCOMM MSM
 M:     Stanimir Varbanov <svarbanov@mm-sol.com>
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 5fadfd9..05950f3 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -24,7 +24,7 @@ obj-$(CONFIG_PCIE_IPROC_PLATFORM) += pcie-iproc-platform.o
 obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
 obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
 obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
-obj-$(CONFIG_PCI_HISI) += pcie-hisi.o
+obj-$(CONFIG_PCI_HISI) += pcie-hisi.o pcie-hisi-common.o
 obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
 obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) += pci-thunder-ecam.o
 obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
diff --git a/drivers/pci/host/pcie-hisi-common.c b/drivers/pci/host/pcie-hisi-common.c
new file mode 100644
index 0000000..5a5f269
--- /dev/null
+++ b/drivers/pci/host/pcie-hisi-common.c
@@ -0,0 +1,66 @@
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
+#include <linux/pci.h>
+#include "pcie-hisi.h"
+
+/* HipXX PCIe host only supports 32-bit config access */
+int hisi_pcie_common_cfg_read(void __iomem *reg_base, int where, int size,
+			      u32 *val)
+{
+	u32 reg;
+	u32 reg_val;
+	void *walker = &reg_val;
+
+	walker += (where & 0x3);
+	reg = where & ~0x3;
+	reg_val = readl(reg_base + reg);
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
+int hisi_pcie_common_cfg_write(void __iomem *reg_base, int where, int  size,
+				u32 val)
+{
+	u32 reg_val;
+	u32 reg;
+	void *walker = &reg_val;
+
+	walker += (where & 0x3);
+	reg = where & ~0x3;
+	if (size == 4)
+		writel(val, reg_base + reg);
+	else if (size == 2) {
+		reg_val = readl(reg_base + reg);
+		*(u16 __force *) walker = val;
+		writel(reg_val, reg_base + reg);
+	} else if (size == 1) {
+		reg_val = readl(reg_base + reg);
+		*(u8 __force *) walker = val;
+		writel(reg_val, reg_base + reg);
+	} else
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	return PCIBIOS_SUCCESSFUL;
+}
diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index 3e98d4e..086af15 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -21,6 +21,7 @@
 #include <linux/regmap.h>
 
 #include "pcie-designware.h"
+#include "pcie-hisi.h"
 
 #define PCIE_LTSSM_LINKUP_STATE				0x11
 #define PCIE_LTSSM_STATE_MASK				0x3F
@@ -30,12 +31,6 @@
 
 #define to_hisi_pcie(x)	container_of(x, struct hisi_pcie, pp)
 
-struct hisi_pcie;
-
-struct pcie_soc_ops {
-	int (*hisi_pcie_link_up)(struct hisi_pcie *pcie);
-};
-
 struct hisi_pcie {
 	struct regmap *subctrl;
 	void __iomem *reg_base;
@@ -44,87 +39,24 @@ struct hisi_pcie {
 	struct pcie_soc_ops *soc_ops;
 };
 
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
+struct pcie_soc_ops {
+	int (*hisi_pcie_link_up)(struct hisi_pcie *pcie);
+};
 
-/* HipXX PCIe host only supports 32-bit config access */
-static int hisi_pcie_cfg_read(struct pcie_port *pp, int where, int size,
-			      u32 *val)
+static inline int hisi_pcie_cfg_read(struct pcie_port *pp, int where,
+		int size, u32 *val)
 {
-	u32 reg;
-	u32 reg_val;
 	struct hisi_pcie *pcie = to_hisi_pcie(pp);
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
+	return hisi_pcie_common_cfg_read(pcie->reg_base, where, size, val);
 }
 
-static int hisi_pcie_link_up_hip05(struct hisi_pcie *hisi_pcie)
+static inline int hisi_pcie_cfg_write(struct pcie_port *pp, int where,
+		int size, u32 val)
 {
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
+	struct hisi_pcie *pcie = to_hisi_pcie(pp);
 
-	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
+	return hisi_pcie_common_cfg_write(pcie->reg_base, where, size, val);
 }
 
 static int hisi_pcie_link_up(struct pcie_port *pp)
@@ -215,6 +147,26 @@ static int hisi_pcie_probe(struct platform_device *pdev)
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
+	val = readl(hisi_pcie->reg_base + PCIE_HIP06_CTRL_OFF +
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
index 0000000..44fc680
--- /dev/null
+++ b/drivers/pci/host/pcie-hisi.h
@@ -0,0 +1,23 @@
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
+
+int hisi_pcie_common_cfg_read(void __iomem *reg_base, int where, int size,
+			      u32 *val);
+int hisi_pcie_common_cfg_write(void __iomem *reg_base, int where, int size,
+			       u32 val);
+
+#endif /* PCIE_HISI_H_ */
-- 
1.9.1
