Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <bhelgaas@google.com>, <arnd@arndb.de>, <will.deacon@arm.com>,
	<catalin.marinas@arm.com>, <hanjun.guo@linaro.org>,
	<Lorenzo.Pieralisi@arm.com>, <Liviu.Dudau@arm.com>,
	<tn@semihalf.com>
CC: <jiang.liu@linux.intel.com>, <tglx@linutronix.de>,
	<wangyijing@huawei.com>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linaro-acpi@lists.linaro.org>, <wangzhou1@hisilicon.com>,
	<liudongdong3@huawei.com>, <xuwei5@hisilicon.com>,
	<liguozhu@hisilicon.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>
Subject: [RFC PATCH 2/2] PCI/ACPI: HiSi: Add ACPI support for HiSi PCIe Host Bridge
Date: Thu, 3 Dec 2015 23:19:59 +0800
Message-ID: <1449155999-220955-3-git-send-email-gabriele.paoloni@huawei.com>
In-Reply-To: <1449155999-220955-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1449155999-220955-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds ACPI support for HiSilicon PCIe Host Bridge
controller

Signed-off-by: Liudongdong <liudongdong3@huawei.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 MAINTAINERS                       |   8 ++
 arch/arm64/kernel/Makefile        |   1 +
 arch/arm64/kernel/pci.c           |   1 +
 arch/arm64/kernel/pci_acpi_hisi.c | 211 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 221 insertions(+)
 create mode 100644 arch/arm64/kernel/pci_acpi_hisi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5f46784..b84f359 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7943,6 +7943,14 @@ F:	include/linux/pci*
 F:	arch/x86/pci/
 F:	arch/x86/kernel/quirks.c
 
+PCI ACPI DRIVER FOR HISILICON HIP05
+M:	Dongdong Liu <liudongdong3@huawei.com>
+M:	Gabriele Paoloni <gabriele.paoloni@huawei.com>
+L:	linux-pci@vger.kernel.org
+L:	linux-arm-kernel@lists.infradead.org
+S:	Maintained
+F:	arch/arm64/kernel/pci_acpi_hisi.c
+
 PCI DRIVER FOR ARM VERSATILE PLATFORM
 M:	Rob Herring <robh@kernel.org>
 L:	linux-pci@vger.kernel.org
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 22dc9bc..1c89d07 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -36,6 +36,7 @@ arm64-obj-$(CONFIG_EFI)			+= efi.o efi-stub.o efi-entry.o
 arm64-obj-$(CONFIG_PCI)			+= pci.o
 arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
 arm64-obj-$(CONFIG_ACPI)		+= acpi.o
+arm64-obj-$(CONFIG_ACPI)		+= pci_acpi_hisi.o
 
 obj-y					+= $(arm64-obj-y) vdso/
 obj-m					+= $(arm64-obj-m)
diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index d60edb4..391e743 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -236,6 +236,7 @@ static struct acpi_pci_root_ops acpi_pci_root_ops = {
  * Host Bridge controllers that are non ECAM compliant
  */
 static struct acpi_scan_handler *quirks_array[] = {
+		&pci_root_hisi_handler,
 		0
 };
 
diff --git a/arch/arm64/kernel/pci_acpi_hisi.c b/arch/arm64/kernel/pci_acpi_hisi.c
new file mode 100644
index 0000000..c528604
--- /dev/null
+++ b/arch/arm64/kernel/pci_acpi_hisi.c
@@ -0,0 +1,211 @@
+/*
+ * PCIe host controller driver for HiSilicon Hip05 SoC
+ *
+ * Copyright (C) 2015 HiSilicon Co., Ltd. http://www.hisilicon.com
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/pci-acpi.h>
+#include <linux/acpi.h>
+#include <linux/ecam.h>
+
+#include "pci_quirks.h"
+
+
+#define MAX_PCIE_PORT_NUM 4
+static int acpi_pci_root_hisi_add(struct acpi_device *device,
+			     const struct acpi_device_id *not_used);
+
+static void acpi_pci_root_hisi_remove(struct acpi_device *device);
+
+
+static const struct acpi_device_id root_hisi_device_ids[] = {
+	{"HISI0080", 0},
+	{"", 0},
+};
+
+struct acpi_scan_handler pci_root_hisi_handler = {
+	.ids = root_hisi_device_ids,
+	.attach = acpi_pci_root_hisi_add,
+	.detach = acpi_pci_root_hisi_remove,
+};
+
+static void __iomem *rc_base[MAX_PCIE_PORT_NUM];
+
+static void __iomem *
+pci_mcfg_dev_base(struct pci_bus *bus, unsigned int devfn, int offset)
+{
+	struct pci_mmcfg_region *cfg;
+
+	cfg = pci_mmconfig_lookup(pci_domain_nr(bus), bus->number);
+	if (cfg && cfg->virt)
+		return cfg->virt +
+			(PCI_MMCFG_BUS_OFFSET(bus->number) | (devfn << 12)) +
+			offset;
+	return NULL;
+}
+
+
+/* Hip05 PCIe host only supports 32-bit config access */
+static int hisi_pcie_cfg_read(void __iomem *addr, int where, int size,
+				u32 *val)
+{
+	u32 reg;
+	u32 reg_val;
+	void *walker = &reg_val;
+
+	walker += (where & 0x3);
+	reg = where & ~0x3;
+	reg_val = readl(addr + reg);
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
+
+/* Hip05 PCIe host only supports 32-bit config access */
+static int hisi_pcie_cfg_write(void __iomem *addr, int where, int  size,
+				u32 val)
+{
+	u32 reg_val;
+	u32 reg;
+	void *walker = &reg_val;
+
+	walker += (where & 0x3);
+	reg = where & ~0x3;
+	if (size == 4)
+		writel(val, addr + reg);
+	else if (size == 2) {
+		reg_val = readl(addr + reg);
+		*(u16 __force *) walker = val;
+		writel(reg_val, addr + reg);
+	} else if (size == 1) {
+		reg_val = readl(addr + reg);
+		*(u8 __force *) walker = val;
+		writel(reg_val, addr + reg);
+	} else
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+/*
+* hip05 support ECAM to access EP config space
+* but not support RC
+*/
+static int pci_read(struct pci_bus *bus, unsigned int devfn, int where,
+		    int size, u32 *value)
+{
+	struct acpi_pci_root *root = bus->sysdata;
+	int ret;
+
+	if (bus->number == root->secondary.start)
+		ret = hisi_pcie_cfg_read(rc_base[root->segment], where, size,
+				value);
+	else
+		ret = pci_generic_config_read(bus, devfn, where, size, value);
+
+	return ret;
+}
+
+static int pci_write(struct pci_bus *bus, unsigned int devfn, int where,
+		     int size, u32 value)
+{
+	struct acpi_pci_root *root = bus->sysdata;
+	int ret;
+
+	if (bus->number == root->secondary.start)
+		ret = hisi_pcie_cfg_write(rc_base[root->segment], where, size,
+				value);
+	else
+		ret = pci_generic_config_write(bus, devfn, where, size, value);
+	return ret;
+}
+
+static struct pci_ops pci_root_ops = {
+	.map_bus = pci_mcfg_dev_base,
+	.read = pci_read,
+	.write = pci_write,
+};
+
+
+/*
+* Sample DSDT (PCIe Root bus)
+*
+* Device (RC0)
+*{
+*	Name (_HID, "HISI0081")
+*	Name (_CID, "HISI0080")
+*	Name(_SEG, 0)
+*	Name (_DSD, Package () {
+*	ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+*		Package () {
+*		Package () {"rc-base", 0xb0070000}
+*		Package () {"rc-size", 0x10000}
+*	})
+*}
+*Device (PCI0)
+*{
+*	Name (_HID, "PNP0A08") // PCI Express Root Bridge
+*	Name (_CID, "PNP0A03") // Compatible PCI Root Bridge
+*.....
+*}
+*
+*use segment to distinguish pcie host controller
+*0-pcie0
+*1-pcie1
+*/
+static int acpi_pci_root_hisi_add(struct acpi_device *device,
+			     const struct acpi_device_id *not_used)
+{
+	u32 base;
+	u32 size;
+	int ret;
+	unsigned long long segment;
+	acpi_status status;
+	acpi_handle handle = device->handle;
+
+	ret = fwnode_property_read_u32(&device->fwnode, "rc-base", &base);
+	if (ret) {
+		dev_err(&device->dev,  "can't get rc-base\n");
+		return ret;
+	}
+
+	ret =  fwnode_property_read_u32(&device->fwnode, "rc-size", &size);
+	if (ret) {
+		dev_err(&device->dev,  "can't get rc-size\n");
+		return ret;
+	}
+
+	status = acpi_evaluate_integer(handle, METHOD_NAME__SEG, NULL,
+				       &segment);
+	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
+		dev_err(&device->dev,  "can't evaluate _SEG\n");
+		return -ENODEV;
+	}
+
+	rc_base[segment] = ioremap(base, size);
+	set_quirk_pci_ops(&pci_root_ops);
+
+	return 0;
+}
+
+static void acpi_pci_root_hisi_remove(struct acpi_device *device)
+{
+	unset_quirk_pci_ops();
+}
-- 
1.9.1

