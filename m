Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753345AbcLAIbd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Dec 2016 03:31:33 -0500
Subject: [PATCH v10 09/12] PCI: Add MCFG quirks for HiSilicon Hip05/06/07
 host controllers
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, Duc Dang <dhdang@apm.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Christopher Covington <cov@codeaurora.org>,
        Dongdong Liu <liudongdong3@huawei.com>
Date: Thu, 01 Dec 2016 02:30:43 -0600
Message-ID: <20161201083043.12247.30980.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161201075131.12247.2211.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161201075131.12247.2211.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Dongdong Liu <liudongdong3@huawei.com>

The PCIe controller in Hip05/Hip06/Hip07 SoCs is not completely
ECAM-compliant.  It is non-ECAM only for the RC bus config space; for any
other bus underneath the root bus it does support ECAM access.

Add specific quirks for PCI config space accessors.  This involves:
1. New initialization call hisi_pcie_init() to obtain RC base
addresses from PNP0C02 at the root of the ACPI namespace (under \_SB).
2. New entry in common quirk array.

[bhelgaas: move to pcie-hisi.c and change Makefile/ifdefs so quirk doesn't
depend on CONFIG_PCI_HISI]
Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_mcfg.c      |   12 +++++
 drivers/pci/host/Makefile    |    2 -
 drivers/pci/host/pcie-hisi.c |   95 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-ecam.h     |    1 
 4 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index c74c054..c6a6949 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -62,6 +62,18 @@ static struct mcfg_fixup mcfg_quirks[] = {
 	QCOM_ECAM32(5),
 	QCOM_ECAM32(6),
 	QCOM_ECAM32(7),
+
+#define HISI_QUAD_DOM(table_id, seg, ops) \
+	{ "HISI  ", table_id, 0, seg + 0, MCFG_BUS_ANY, ops }, \
+	{ "HISI  ", table_id, 0, seg + 1, MCFG_BUS_ANY, ops }, \
+	{ "HISI  ", table_id, 0, seg + 2, MCFG_BUS_ANY, ops }, \
+	{ "HISI  ", table_id, 0, seg + 3, MCFG_BUS_ANY, ops }
+	HISI_QUAD_DOM("HIP05   ",  0, &hisi_pcie_ops),
+	HISI_QUAD_DOM("HIP06   ",  0, &hisi_pcie_ops),
+	HISI_QUAD_DOM("HIP07   ",  0, &hisi_pcie_ops),
+	HISI_QUAD_DOM("HIP07   ",  4, &hisi_pcie_ops),
+	HISI_QUAD_DOM("HIP07   ",  8, &hisi_pcie_ops),
+	HISI_QUAD_DOM("HIP07   ", 12, &hisi_pcie_ops),
 };
 
 static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 084cb49..64845f0 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -25,7 +25,7 @@ obj-$(CONFIG_PCIE_IPROC_PLATFORM) += pcie-iproc-platform.o
 obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
 obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
 obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
-obj-$(CONFIG_PCI_HISI) += pcie-hisi.o
+obj-$(CONFIG_ARM64) += pcie-hisi.o
 obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
 obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) += pci-thunder-ecam.o
 obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index 56154c2..ee378c2 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -18,8 +18,101 @@
 #include <linux/of_pci.h>
 #include <linux/platform_device.h>
 #include <linux/of_device.h>
+#include <linux/pci.h>
+#include <linux/pci-acpi.h>
+#include <linux/pci-ecam.h>
 #include <linux/regmap.h>
 
+#if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
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
+static int hisi_pcie_init(struct pci_config_window *cfg)
+{
+	struct device *dev = cfg->parent;
+	struct acpi_device *adev = to_acpi_device(dev);
+	struct acpi_pci_root *root = acpi_driver_data(adev);
+	struct resource *res;
+	void __iomem *reg_base;
+
+	/*
+	 * Retrieve RC base and size from a HISI0081 device with _UID
+	 * matching our segment.
+	 */
+	res = acpi_get_rc_resources("HISI0081", root->segment);
+	if (!res) {
+		dev_err(dev, "can't get rc base address\n");
+		return -ENOMEM;
+	}
+
+	reg_base = devm_ioremap(dev, res->start, resource_size(res));
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
+
+#endif
+
+#ifdef CONFIG_PCI_HISI
+
 #include "pcie-designware.h"
 
 #define PCIE_SUBCTRL_SYS_STATE4_REG		0x6818
@@ -227,3 +320,5 @@ static struct platform_driver hisi_pcie_driver = {
 	},
 };
 builtin_platform_driver(hisi_pcie_driver);
+
+#endif
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index 739d233..bdacbc8 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -61,6 +61,7 @@ extern struct pci_ecam_ops pci_generic_ecam_ops;
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
 extern struct pci_ecam_ops pci_32b_ops;		/* 32-bit accesses only */
+extern struct pci_ecam_ops hisi_pcie_ops;	/* HiSilicon */
 #endif
 
 #ifdef CONFIG_PCI_HOST_GENERIC

