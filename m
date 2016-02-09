Return-Path: <linux-kernel-owner@vger.kernel.org>
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
Subject: [RFC PATCH v3 3/3] PCI/ACPI: hisi: Add ACPI support for HiSilicon SoCs Host Controllers
Date: Tue, 9 Feb 2016 17:34:20 +0000
Message-ID: <1455039260-6040-4-git-send-email-gabriele.paoloni@huawei.com>
In-Reply-To: <1455039260-6040-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1455039260-6040-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: gabriele paoloni <gabriele.paoloni@huawei.com>

This patch adds specific quirks for PCI config space accessors,
it uses _HID to decide whether to hook pci_ops or not.

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 MAINTAINERS                       |   1 +
 drivers/pci/host/Kconfig          |   8 ++
 drivers/pci/host/Makefile         |   1 +
 drivers/pci/host/pcie-hisi-acpi.c | 188 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/host/pcie-hisi.c      |   2 -
 drivers/pci/host/pcie-hisi.h      |   2 +
 6 files changed, 200 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pci/host/pcie-hisi-acpi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d69f436..f184c3e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8412,6 +8412,7 @@ F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
 F:	drivers/pci/host/pcie-hisi.h
 F:	drivers/pci/host/pcie-hisi.c
 F:	drivers/pci/host/pcie-hisi-common.c
+F:	drivers/pci/host/pcie-hisi-acpi.c
 
 PCIE DRIVER FOR QUALCOMM MSM
 M:     Stanimir Varbanov <svarbanov@mm-sol.com>
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 75a6054..65b1add 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -181,6 +181,14 @@ config PCI_HISI
 	  Say Y here if you want PCIe controller support on HiSilicon
 	  Hip05 and Hip06 SoCs
 
+config PCI_HISI_ACPI
+	depends on ACPI
+	bool "HiSilicon Hip05 and Hip06 SoCs ACPI PCIe controllers"
+	select ACPI_PCI_HOST_GENERIC
+	help
+	  Say Y here if you want ACPI PCIe controller support on HiSilicon
+	  Hip05 and Hip06 SoCs
+
 config PCIE_QCOM
 	bool "Qualcomm PCIe controller"
 	depends on ARCH_QCOM && OF
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 8c93c0f..57e4379 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -21,4 +21,5 @@ obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
 obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
 obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
 obj-$(CONFIG_PCI_HISI) += pcie-hisi.o pcie-hisi-common.o
+obj-$(CONFIG_PCI_HISI_ACPI) += pcie-hisi-acpi.o pcie-hisi-common.o
 obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
diff --git a/drivers/pci/host/pcie-hisi-acpi.c b/drivers/pci/host/pcie-hisi-acpi.c
new file mode 100644
index 0000000..3605260
--- /dev/null
+++ b/drivers/pci/host/pcie-hisi-acpi.c
@@ -0,0 +1,188 @@
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
+static int hisi_pcie_link_up_acpi(struct acpi_pci_root *root)
+{
+	u32 val;
+	struct acpi_device *device;
+	union acpi_object *obj;
+
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
+	int ret;
+	struct acpi_device *device;
+	void __iomem *reg_base;
+
+	device =  root->device;
+	ret = hisi_pcie_get_addr(root, "rc-dbi", &reg_base);
+	if (ret) {
+		dev_err(&device->dev, "can't get rc-dbi\n");
+		return ret;
+	}
+
+	root->sysdata = reg_base;
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
+	return 1;
+}
+
+static int hisi_pcie_acpi_valid_config(struct acpi_pci_root *root,
+				struct pci_bus *bus, int dev)
+{
+	/* If there is no link, then there is no device */
+	if (bus->number != root->secondary.start) {
+		if (!hisi_pcie_link_up_acpi(root))
+			return 0;
+	}
+
+	/* access only one slot on each root port */
+	if (bus->number == root->secondary.start && dev > 0)
+		return 0;
+
+	/*
+	 * do not read more than one device on the bus directly attached
+	 * to RC's (Virtual Bridge's) DS side.
+	 */
+	if (bus->primary == root->secondary.start && dev > 0)
+		return 0;
+
+	return 1;
+}
+
+static int hisi_pcie_acpi_rd_conf(struct pci_bus *bus, u32 devfn, int where,
+		int size, u32 *val)
+{
+	struct acpi_pci_root *root = bus->sysdata;
+	void __iomem *reg_base = root->sysdata;
+
+	if (hisi_pcie_acpi_valid_config(root, bus, PCI_SLOT(devfn)) == 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (bus->number == root->secondary.start)
+		return hisi_pcie_common_cfg_read(reg_base, where, size, val);
+
+	return pci_generic_config_read(bus, devfn, where, size, val);
+}
+
+static int hisi_pcie_acpi_wr_conf(struct pci_bus *bus, u32 devfn,
+		int where, int size, u32 val)
+{
+	struct acpi_pci_root *root = bus->sysdata;
+	void __iomem *reg_base = root->sysdata;
+
+	if (hisi_pcie_acpi_valid_config(root, bus, PCI_SLOT(devfn)) == 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (bus->number == root->secondary.start)
+		return hisi_pcie_common_cfg_write(reg_base, where, size, val);
+
+	return pci_generic_config_write(bus, devfn, where, size, val);
+}
+
+struct pci_ops hisi_pcie_acpi_ops = {
+	.map_bus = pci_mcfg_dev_base,
+	.read = hisi_pcie_acpi_rd_conf,
+	.write = hisi_pcie_acpi_wr_conf,
+};
+
+
+DECLARE_ACPI_MCFG_FIXUP(NULL, hisi_pcie_match, &hisi_pcie_acpi_ops,
+	PCI_MCFG_DOMAIN_ANY, PCI_MCFG_BUS_ANY);
diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index d3e2047..d1ef346 100644
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
index 29e0790..45cf0fd 100644
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
