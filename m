Return-Path: <liudongdong3@huawei.com>
Return-Path: <liudongdong3@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
To: <helgaas@kernel.org>, <arnd@arndb.de>, <rafael@kernel.org>,
        <Lorenzo.Pieralisi@arm.com>, <tn@semihalf.com>,
        <wangzhou1@hisilicon.com>, <pratyush.anand@gmail.com>
CC: <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jcm@redhat.com>,
        <liudongdong3@huawei.com>, <gabriele.paoloni@huawei.com>,
        <charles.chenxin@huawei.com>, <hanjun.guo@linaro.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V6 2/2] PCI/ACPI: hisi: Add ACPI support for HiSilicon SoCs Host Controllers
Date: Tue, 22 Nov 2016 20:08:49 +0800
Message-ID: <1479816529-97410-3-git-send-email-liudongdong3@huawei.com>
In-Reply-To: <1479816529-97410-1-git-send-email-liudongdong3@huawei.com>
References: <1479816529-97410-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

PCIe controller in Hip05/HIP06/HIP07 SoCs is not ECAM compliant.
It is non ECAM only for the RC bus config space;for any other bus
underneath the root bus we support ECAM access.
Add specific quirks for PCI config space accessors.This involves:
1. New initialization call hisi_pcie_init() to obtain rc base
addresses from PNP0C02 at the root of the ACPI namespace (under \_SB).
2. New entry in common quirk array.

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 MAINTAINERS                       |   1 +
 drivers/acpi/pci_mcfg.c           |  13 +++++
 drivers/pci/host/Kconfig          |   7 +++
 drivers/pci/host/Makefile         |   1 +
 drivers/pci/host/pcie-hisi-acpi.c | 119 ++++++++++++++++++++++++++++++++++++++
 include/linux/pci-ecam.h          |   5 ++
 6 files changed, 146 insertions(+)
 create mode 100644 drivers/pci/host/pcie-hisi-acpi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1cd38a7..b224caa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9358,6 +9358,7 @@ L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
 F:	drivers/pci/host/pcie-hisi.c
+F:	drivers/pci/host/pcie-hisi-acpi.c
 
 PCIE DRIVER FOR ROCKCHIP
 M:	Shawn Lin <shawn.lin@rock-chips.com>
diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index ac21db3..3297c5a 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -57,6 +57,19 @@ struct mcfg_fixup {
 	{ "QCOM  ", "QDF2432 ", 1, 5, MCFG_BUS_ANY, &pci_32b_ops },
 	{ "QCOM  ", "QDF2432 ", 1, 6, MCFG_BUS_ANY, &pci_32b_ops },
 	{ "QCOM  ", "QDF2432 ", 1, 7, MCFG_BUS_ANY, &pci_32b_ops },
+#ifdef CONFIG_PCI_ECAM_QUIRKS
+	#define PCI_ACPI_QUIRK_QUAD_DOM(table_id, seg, ops) \
+	{ "HISI  ", table_id, 0, seg + 0, MCFG_BUS_ANY, ops }, \
+	{ "HISI  ", table_id, 0, seg + 1, MCFG_BUS_ANY, ops }, \
+	{ "HISI  ", table_id, 0, seg + 2, MCFG_BUS_ANY, ops }, \
+	{ "HISI  ", table_id, 0, seg + 3, MCFG_BUS_ANY, ops }
+	PCI_ACPI_QUIRK_QUAD_DOM("HIP05   ", 0, &hisi_pcie_ops),
+	PCI_ACPI_QUIRK_QUAD_DOM("HIP06   ", 0, &hisi_pcie_ops),
+	PCI_ACPI_QUIRK_QUAD_DOM("HIP07   ", 0, &hisi_pcie_ops),
+	PCI_ACPI_QUIRK_QUAD_DOM("HIP07   ", 4, &hisi_pcie_ops),
+	PCI_ACPI_QUIRK_QUAD_DOM("HIP07   ", 8, &hisi_pcie_ops),
+	PCI_ACPI_QUIRK_QUAD_DOM("HIP07   ", 12, &hisi_pcie_ops),
+#endif
 };
 
 static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index ae98644..1fbade5 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -301,4 +301,11 @@ config VMD
 	  To compile this driver as a module, choose M here: the
 	  module will be called vmd.
 
+config PCI_ECAM_QUIRKS
+	bool "PCI ECAM quirks for ARM64 platform"
+	depends on PCI_ECAM && ARM64 && ACPI
+	help
+	  Say y here to enable your platform-specific config access that
+	  is not ECAM compliant.
+
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 084cb49..15435b4 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
 obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
 obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
 obj-$(CONFIG_PCI_HISI) += pcie-hisi.o
+obj-$(CONFIG_PCI_ECAM_QUIRKS) += pcie-hisi-acpi.o
 obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
 obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) += pci-thunder-ecam.o
 obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
diff --git a/drivers/pci/host/pcie-hisi-acpi.c b/drivers/pci/host/pcie-hisi-acpi.c
new file mode 100644
index 0000000..8bb43b4
--- /dev/null
+++ b/drivers/pci/host/pcie-hisi-acpi.c
@@ -0,0 +1,119 @@
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
+#include "../pci.h"
+
+static int hisi_pcie_acpi_rd_conf(struct pci_bus *bus, u32 devfn, int where,
+				  int size, u32 *val)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	int dev = PCI_SLOT(devfn);
+
+	if (bus->number == cfg->busr.start) {
+		/* access only one slot on each root port */
+		if (dev > 0)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		else
+			return pci_generic_config_read32(bus, devfn, where,
+							 size, val);
+	}
+
+	return pci_generic_config_read(bus, devfn, where, size, val);
+}
+
+static int hisi_pcie_acpi_wr_conf(struct pci_bus *bus, u32 devfn,
+				  int where, int size, u32 val)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	int dev = PCI_SLOT(devfn);
+
+	if (bus->number == cfg->busr.start) {
+		/* access only one slot on each root port */
+		if (dev > 0)
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		else
+			return pci_generic_config_write32(bus, devfn, where,
+							  size, val);
+	}
+
+	return pci_generic_config_write(bus, devfn, where, size, val);
+}
+
+static void __iomem *hisi_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
+				       int where)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	void __iomem *reg_base = cfg->priv;
+
+	if (bus->number == cfg->busr.start)
+		return reg_base + where;
+	else
+		return pci_ecam_map_bus(bus, devfn, where);
+}
+
+/*
+ * Retrieve RC base and size from PNP0C02 at the root of the ACPI namespace
+ * (under \_SB).
+ * Scope(_SB)
+ * {
+ *   Device (PCI0)
+ *   {
+ *     Name(_HID, "PNP0A08")
+ *     Name(_CID, "PNP0A03")
+ *     Name(_SEG, 0)
+ *     ......
+ *   }
+ *   Device (RES0)
+ *   {
+ *     Name(_HID, "HISI0081")
+ *     Name(_CID, "PNP0C02")
+ *     Name(_UID, 0x0)
+ *     Name(_CRS, ResourceTemplate (){
+ *       Memory32Fixed (ReadWrite, 0xa0090000, 0x10000)
+ *     })
+ *   }
+ *   ......
+ * }
+ */
+static int hisi_pcie_init(struct pci_config_window *cfg)
+{
+	struct acpi_device *adev = to_acpi_device(cfg->parent);
+	struct acpi_pci_root *root = acpi_driver_data(adev);
+	void __iomem *reg_base;
+	struct resource *res;
+
+	res = acpi_get_rc_resources("HISI0081", root->segment);
+	if (!res) {
+		dev_err(&adev->dev, "can't get rc base address");
+		return -ENOMEM;
+	}
+
+	reg_base = devm_ioremap(&adev->dev, res->start, resource_size(res));
+	if (!reg_base)
+		return -ENOMEM;
+
+	cfg->priv = reg_base;
+	return 0;
+}
+
+struct pci_ecam_ops hisi_pcie_ops = {
+	.bus_shift    = 20,
+	.init         =  hisi_pcie_init,
+	.pci_ops      = {
+		.map_bus    = hisi_pcie_map_bus,
+		.read       = hisi_pcie_acpi_rd_conf,
+		.write      = hisi_pcie_acpi_wr_conf,
+	}
+};
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index f5740b7..40fab66 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -67,4 +67,9 @@ void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
 int pci_host_common_probe(struct platform_device *pdev,
 			  struct pci_ecam_ops *ops);
 #endif
+
+#ifdef CONFIG_PCI_ECAM_QUIRKS
+extern struct pci_ecam_ops hisi_pcie_ops;
+#endif
+
 #endif
-- 
1.9.1
