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
Subject: [RFC PATCH 3/3] PCI/ACPI: hisi: Add ACPI support for HiSilicon SoCs Host Controllers
Date: Tue, 12 Jul 2016 10:42:24 +0800
Message-ID: <1468291344-122909-4-git-send-email-liudongdong3@huawei.com>
In-Reply-To: <1468291344-122909-1-git-send-email-liudongdong3@huawei.com>
References: <1468291344-122909-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

Add specific quirks for PCI config space accessors.This involves:
1. New initialization call hisi_pcie_acpi_init() to get RC config resource
with hardcoded range address and setup ecam mapping.
2. New entry in common quirk array.

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 MAINTAINERS                       |   1 +
 drivers/pci/host/Kconfig          |   7 ++
 drivers/pci/host/Makefile         |   1 +
 drivers/pci/host/mcfg-quirks.c    |   8 ++
 drivers/pci/host/mcfg-quirks.h    |   8 ++
 drivers/pci/host/pcie-hisi-acpi.c | 151 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/host/pcie-hisi.c      |   2 -
 drivers/pci/host/pcie-hisi.h      |   2 +
 8 files changed, 178 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pci/host/pcie-hisi-acpi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e8e2c9..c51c736 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8832,6 +8832,7 @@ F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
 F:	drivers/pci/host/pcie-hisi.h
 F:	drivers/pci/host/pcie-hisi.c
 F:	drivers/pci/host/pcie-hisi-common.c
+F:	drivers/pci/host/pcie-hisi-acpi.c
 
 PCIE DRIVER FOR QUALCOMM MSM
 M:     Stanimir Varbanov <svarbanov@mm-sol.com>
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 5d2374e..15b73a6 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -210,6 +210,13 @@ config PCI_HISI
 	  Say Y here if you want PCIe controller support on HiSilicon
 	  Hip05 and Hip06 SoCs
 
+config PCI_HISI_ACPI
+	depends on ACPI && ARM64
+	bool "HiSilicon Hip05 and Hip06 SoCs ACPI PCIe controllers"
+	help
+	  Say Y here if you want ACPI PCIe controller support on HiSilicon
+	  Hip05 and Hip06 SoCs
+
 config PCIE_QCOM
 	bool "Qualcomm PCIe controller"
 	depends on ARCH_QCOM && OF
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 05950f3..4843142 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
 obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
 obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
 obj-$(CONFIG_PCI_HISI) += pcie-hisi.o pcie-hisi-common.o
+obj-$(CONFIG_PCI_HISI_ACPI) += pcie-hisi-acpi.o pcie-hisi-common.o
 obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
 obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) += pci-thunder-ecam.o
 obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
diff --git a/drivers/pci/host/mcfg-quirks.c b/drivers/pci/host/mcfg-quirks.c
index a4bb76a..e65cd99 100644
--- a/drivers/pci/host/mcfg-quirks.c
+++ b/drivers/pci/host/mcfg-quirks.c
@@ -51,6 +51,14 @@ static struct pci_cfg_fixup mcfg_qurks[] __initconst = {
 	{ "CAVIUM", "THUNDERX", 1, MCFG_DOM_RANGE(14, 19), MCFG_BUS_ANY,
 	  NULL, thunder_pem_cfg_init},
 #endif
+#ifdef CONFIG_PCI_HISI_ACPI
+	{ "HISI", "HISI0660", 0, MCFG_DOM_RANGE(0, 3), MCFG_BUS_ANY,
+	  NULL, hisi_pcie_acpi_hip05_init},
+	{ "HISI", "HISI1610", 0, MCFG_DOM_RANGE(0, 3), MCFG_BUS_ANY,
+	  NULL, hisi_pcie_acpi_hip06_init},
+	{ "HISI", "HISI1612", 0, MCFG_DOM_RANGE(0, 3), MCFG_BUS_ANY,
+	  NULL, hisi_pcie_acpi_hip06_init},
+#endif
 };
 
 static bool pci_mcfg_fixup_match(struct pci_cfg_fixup *f,
diff --git a/drivers/pci/host/mcfg-quirks.h b/drivers/pci/host/mcfg-quirks.h
index 411c667..a2d2aaa 100644
--- a/drivers/pci/host/mcfg-quirks.h
+++ b/drivers/pci/host/mcfg-quirks.h
@@ -21,4 +21,12 @@ struct pci_config_window *
 thunder_pem_cfg_init(struct acpi_pci_root *root, struct pci_ops *ops);
 #endif
 
+#ifdef CONFIG_PCI_HISI_ACPI
+struct pci_config_window *
+hisi_pcie_acpi_hip05_init(struct acpi_pci_root *root, struct pci_ops *ops);
+
+struct pci_config_window *
+hisi_pcie_acpi_hip06_init(struct acpi_pci_root *root, struct pci_ops *ops);
+#endif
+
 #endif /* __MCFG_QUIRKS_H__ */
diff --git a/drivers/pci/host/pcie-hisi-acpi.c b/drivers/pci/host/pcie-hisi-acpi.c
new file mode 100644
index 0000000..93572d0
--- /dev/null
+++ b/drivers/pci/host/pcie-hisi-acpi.c
@@ -0,0 +1,151 @@
+/*
+ * PCIe host controller driver for HiSilicon HipXX SoCs
+ *
+ * Copyright (C) 2016 HiSilicon Co., Ltd. http://www.hisilicon.com
+ *
+ * Author: Dongdong Liu <liudongdong3@huawei.com>
+ *         Gabriele Paoloni <gabriele.paoloni@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/pci.h>
+#include <linux/pci-acpi.h>
+#include <linux/pci-ecam.h>
+
+#include "mcfg-quirks.h"
+#include "pcie-hisi.h"
+
+#define DEBUG0          0x728
+#define RC_NUM          4
+
+enum soc_type {
+	HIP05,
+	HIP06,
+};
+
+struct hisi_rc_res {
+	int soc_type;
+	struct resource res[RC_NUM];
+};
+
+static int hisi_pcie_link_up_acpi(struct pci_config_window *cfg)
+{
+	u32 val;
+	void __iomem *reg_base = cfg->priv;
+
+	val = readl(reg_base + DEBUG0);
+	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
+
+}
+
+static int hisi_pcie_acpi_valid_config(struct pci_config_window *cfg,
+				       struct pci_bus *bus, int dev)
+{
+	/* If there is no link, then there is no device */
+	if (bus->number != cfg->busr.start) {
+		if (!hisi_pcie_link_up_acpi(cfg))
+			return 0;
+	}
+
+	/* access only one slot on each root port */
+	if (bus->number == cfg->busr.start && dev > 0)
+		return 0;
+
+	/*
+	 * do not read more than one device on the bus directly attached
+	 * to RC's (Virtual Bridge's) DS side.
+	 */
+	if (bus->primary == cfg->busr.start && dev > 0)
+		return 0;
+
+	return 1;
+}
+
+static int hisi_pcie_acpi_rd_conf(struct pci_bus *bus, u32 devfn, int where,
+				  int size, u32 *val)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	void __iomem *reg_base = cfg->priv;
+
+	if (hisi_pcie_acpi_valid_config(cfg, bus, PCI_SLOT(devfn)) == 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (bus->number == cfg->busr.start)
+		return hisi_pcie_common_cfg_read(reg_base, where, size, val);
+
+	return pci_generic_config_read(bus, devfn, where, size, val);
+}
+
+static int hisi_pcie_acpi_wr_conf(struct pci_bus *bus, u32 devfn,
+				  int where, int size, u32 val)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	void __iomem *reg_base = cfg->priv;
+
+	if (hisi_pcie_acpi_valid_config(cfg, bus, PCI_SLOT(devfn)) == 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (bus->number == cfg->busr.start)
+		return hisi_pcie_common_cfg_write(reg_base, where, size, val);
+
+	return pci_generic_config_write(bus, devfn, where, size, val);
+}
+
+static struct pci_ops hisi_pcie_ops = {
+	.map_bus	= pci_ecam_map_bus,
+	.read		= hisi_pcie_acpi_rd_conf,
+	.write		= hisi_pcie_acpi_wr_conf,
+};
+
+static struct hisi_rc_res rc_res[] = {
+	{HIP05,
+	{DEFINE_RES_MEM(0xb0070000, SZ_4K), DEFINE_RES_MEM(0xb0080000, SZ_4K),
+	 DEFINE_RES_MEM(0xb0090000, SZ_4K), DEFINE_RES_MEM(0xb00a0000, SZ_4K)}
+	},
+	{HIP06,
+	{DEFINE_RES_MEM(0xa0090000, SZ_4K), DEFINE_RES_MEM(0xa0200000, SZ_4K),
+	 DEFINE_RES_MEM(0xa00a0000, SZ_4K), DEFINE_RES_MEM(0xa00b0000, SZ_4K)}
+	}
+};
+
+struct pci_config_window *hisi_pcie_acpi_init(struct acpi_pci_root *root,
+					      struct pci_ops *ops,
+					      int soc_type)
+{
+	struct acpi_device *adev = root->device;
+	void __iomem *reg_base;
+	struct pci_config_window *cfg;
+	struct resource *res;
+
+	res = &rc_res[soc_type].res[root->segment];
+	reg_base = devm_ioremap_resource(&adev->dev, res);
+	if (!reg_base)
+		return ERR_PTR(-ENOMEM);
+
+	cfg = pci_acpi_setup_ecam_mapping(root, &hisi_pcie_ops);
+	if (IS_ERR(cfg)) {
+		dev_err(&adev->dev, "error %ld mapping ECAM\n", PTR_ERR(cfg));
+		return NULL;
+	}
+
+	cfg->priv = reg_base;
+
+	if (!hisi_pcie_link_up_acpi(cfg))
+		dev_warn(&adev->dev, "link status is down\n");
+
+	return cfg;
+}
+
+struct pci_config_window *hisi_pcie_acpi_hip05_init(struct acpi_pci_root *root,
+						    struct pci_ops *ops)
+{
+	return hisi_pcie_acpi_init(root, ops, HIP05);
+}
+
+struct pci_config_window *hisi_pcie_acpi_hip06_init(struct acpi_pci_root *root,
+						    struct pci_ops *ops)
+{
+	return hisi_pcie_acpi_init(root, ops, HIP06);
+}
diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index c42ef84..f4d0d8c 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -23,8 +23,6 @@
 #include "pcie-designware.h"
 #include "pcie-hisi.h"
 
-#define PCIE_LTSSM_LINKUP_STATE				0x11
-#define PCIE_LTSSM_STATE_MASK				0x3F
 #define PCIE_SUBCTRL_SYS_STATE4_REG			0x6818
 #define PCIE_SYS_STATE4						0x31c
 #define PCIE_HIP06_CTRL_OFF					0x1000
diff --git a/drivers/pci/host/pcie-hisi.h b/drivers/pci/host/pcie-hisi.h
index 44fc680..edb4977 100644
--- a/drivers/pci/host/pcie-hisi.h
+++ b/drivers/pci/host/pcie-hisi.h
@@ -14,6 +14,8 @@
 #ifndef PCIE_HISI_H_
 #define PCIE_HISI_H_
 
+#define PCIE_LTSSM_LINKUP_STATE				0x11
+#define PCIE_LTSSM_STATE_MASK				0x3F
 
 int hisi_pcie_common_cfg_read(void __iomem *reg_base, int where, int size,
 			      u32 *val);
-- 
1.9.1
