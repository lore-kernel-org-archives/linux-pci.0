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
Subject: [RFC PATCH 4/4] PCI/ACPI: hisi: Add ACPI support for HiSilicon SoCs Host Controllers
Date: Thu, 4 Feb 2016 19:37:40 +0800
Message-ID: <1454585860-60709-5-git-send-email-gabriele.paoloni@huawei.com>
In-Reply-To: <1454585860-60709-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1454585860-60709-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: gabriele paoloni <gabriele.paoloni@huawei.com>

This patch adds specific quirks for PCI config space accessors,
it uses _HID to decide whether to hook pci_ops or not.

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 MAINTAINERS                       |   1 +
 drivers/pci/host/Kconfig          |   9 +++
 drivers/pci/host/Makefile         |   1 +
 drivers/pci/host/pcie-hisi-acpi.c | 147 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/host/pcie-hisi.c      |   2 -
 drivers/pci/host/pcie-hisi.h      |   6 ++
 6 files changed, 164 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pci/host/pcie-hisi-acpi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d6ec25..d35c300 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8250,6 +8250,7 @@ F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
 F:	drivers/pci/host/pcie-hisi.h
 F:	drivers/pci/host/pcie-hisi.c
 F:	drivers/pci/host/pcie-hisi-common.c
+F:	drivers/pci/host/pcie-hisi-acpi.c
 
 PCMCIA SUBSYSTEM
 P:	Linux PCMCIA Team
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 4d385d6..7a6b80d 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -174,4 +174,13 @@ config PCI_HISI
 	  Say Y here if you want PCIe controller support on HiSilicon
 	  Hip05 and Hip06 SoCs
 
+config PCI_HISI_ACPI
+	bool "ACPI PCI HiSilicon SoC HIP05 PCIe controller"
+	depends on ACPI
+	select ACPI_PCI_HOST_GENERIC
+	select PCIE_DW
+	help
+	  Say Y here if you want ACPI PCIe controller support on
+	  HiSilicon Hip05 and Hip06 SoCs
+
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 6248320..ff010b6 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
 obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
 obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
 obj-$(CONFIG_PCI_HISI) += pcie-hisi.o pcie-hisi-common.o
+obj-$(CONFIG_PCI_HISI_ACPI) += pcie-hisi-acpi.o pcie-hisi-common.o
diff --git a/drivers/pci/host/pcie-hisi-acpi.c b/drivers/pci/host/pcie-hisi-acpi.c
new file mode 100644
index 0000000..1bca4f1
--- /dev/null
+++ b/drivers/pci/host/pcie-hisi-acpi.c
@@ -0,0 +1,147 @@
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
+#include <linux/interrupt.h>
+#include <linux/acpi.h>
+#include <linux/ecam.h>
+#include <linux/pci.h>
+#include <linux/pci-acpi.h>
+#include "pcie-designware.h"
+#include "pcie-hisi.h"
+
+#define GET_PCIE_LINK_STATUS  0x0
+
+/* uuid 6d30f553-836c-408e-b6ad-45bccc957949 */
+const u8 hisi_pcie_acpi_dsm_uuid[] = {
+	0x53, 0xf5, 0x30, 0x6d, 0x6c, 0x83, 0x8e, 0x40,
+	0xb6, 0xad, 0x45, 0xbc, 0xcc, 0x95, 0x79, 0x49
+};
+
+static const struct acpi_device_id hisi_pcie_ids[] = {
+	{"HISI0080", 0},
+	{"", 0},
+};
+
+static int hisi_pcie_get_addr(struct acpi_pci_root *root, const char *name,
+				void __iomem **addr)
+{
+	struct acpi_device *device;
+	u64 base;
+	u64 size;
+	u32 buf[4];
+	int ret;
+
+	device =  root->device;
+	ret = fwnode_property_read_u32_array(&device->fwnode, name,
+					buf, ARRAY_SIZE(buf));
+	if (ret) {
+		dev_err(&device->dev, "can't get %s\n", name);
+		return ret;
+	}
+
+	base = ((u64)buf[0] << 32) | buf[1];
+	size =  ((u64)buf[2] << 32) | buf[3];
+	*addr = devm_ioremap(&device->dev, base, size);
+	if (!(*addr)) {
+		dev_err(&device->dev, "error with ioremap\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+
+static int hisi_pcie_link_up_acpi(struct hisi_pcie *hisi_pcie)
+{
+	u32 val;
+
+	struct acpi_pci_root *root;
+	struct acpi_device *device;
+	union acpi_object *obj;
+
+	root = hisi_pcie->root;
+	device = root->device;
+	obj = acpi_evaluate_dsm(device->handle,
+		hisi_pcie_acpi_dsm_uuid, 0,
+		GET_PCIE_LINK_STATUS, NULL);
+
+	if (!obj  ||  obj->type != ACPI_TYPE_INTEGER)  {
+		dev_err(&device->dev, "can't get link status from _DSM\n");
+		return 0;
+	}
+	val = obj->integer.value;
+
+	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
+
+}
+
+static struct pcie_soc_ops acpi_ops = {
+		&hisi_pcie_link_up_acpi
+};
+
+/*
+ * Retrieve rc_dbi base and size from _DSD
+ * Name (_DSD, Package () {
+ *	ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+ *	Package () {
+ *	Package () {"rc-dbi", Package () { 0x0, 0xb0080000, 0x0, 0x10000 }},
+ *	}
+ *	})
+ */
+static int hisi_pcie_init(struct acpi_pci_root *root)
+{
+	struct hisi_pcie  *pcie;
+	int ret;
+	struct acpi_device *device;
+
+	device =  root->device;
+	pcie = devm_kzalloc(&device->dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	ret = hisi_pcie_get_addr(root, "rc-dbi", &pcie->reg_base);
+	if (ret) {
+		dev_err(&device->dev, "can't get rc-dbi\n");
+		return ret;
+	}
+
+	pcie->pp.dbi_base = pcie->reg_base;
+	pcie->pp.root_bus_nr = root->secondary.start;
+	pcie->pp.ops = &hisi_pcie_host_ops;
+	pcie->root = root;
+	pcie->soc_ops = &acpi_ops;
+	root->sysdata = &pcie->pp;
+	return 0;
+}
+
+static int hisi_pcie_match(struct pci_mcfg_fixup *fixup,
+			struct acpi_pci_root *root)
+{
+	int ret;
+	struct acpi_device *device;
+
+	device = root->device;
+	ret = acpi_match_device_ids(device, hisi_pcie_ids);
+	if (ret)
+		return 0;
+
+	ret = hisi_pcie_init(root);
+	if (ret)
+		dev_warn(&device->dev, "hisi pcie init fail\n");
+
+	dw_pcie_ops.map_bus = pci_mcfg_dev_base;
+
+	return 1;
+}
+
+DECLARE_ACPI_MCFG_FIXUP(NULL, hisi_pcie_match, &dw_pcie_ops,
+	PCI_MCFG_DOMAIN_ANY, PCI_MCFG_BUS_ANY);
diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index 1e45869..d7867cf 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -23,8 +23,6 @@
 #include "pcie-designware.h"
 #include "pcie-hisi.h"
 
-#define PCIE_LTSSM_LINKUP_STATE				0x11
-#define PCIE_LTSSM_STATE_MASK				0x3F
 #define PCIE_SUBCTRL_SYS_STATE4_REG			0x6818
 #define PCIE_HIP06_CTRL_OFF					0x1000
 #define PCIE_SYS_STATE4						0x31c
diff --git a/drivers/pci/host/pcie-hisi.h b/drivers/pci/host/pcie-hisi.h
index f64249d..396deb2 100644
--- a/drivers/pci/host/pcie-hisi.h
+++ b/drivers/pci/host/pcie-hisi.h
@@ -15,6 +15,9 @@
 #define PCIE_HISI_H_
 
 struct hisi_pcie {
+#ifdef CONFIG_PCI_HISI_ACPI
+	struct acpi_pci_root *root;
+#endif /* CONFIG_ACPI_HOST_GENERIC */
 	struct regmap *subctrl;
 	void __iomem *reg_base;
 	u32 port_id;
@@ -41,4 +44,7 @@ static inline u32 hisi_pcie_apb_readl(struct hisi_pcie *pcie, u32 reg)
 
 extern struct pcie_host_ops hisi_pcie_host_ops;
 
+#define PCIE_LTSSM_LINKUP_STATE				0x11
+#define PCIE_LTSSM_STATE_MASK				0x3F
+
 #endif /* PCIE_HISI_H_ */
-- 
1.9.1

