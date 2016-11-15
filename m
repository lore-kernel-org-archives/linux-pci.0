Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
From: Tomasz Nowicki <tn@semihalf.com>
To: helgaas@kernel.org,
	will.deacon@arm.com,
	catalin.marinas@arm.com,
	rafael@kernel.org,
	Lorenzo.Pieralisi@arm.com
Cc: arnd@arndb.de,
	jchandra@broadcom.com,
	ard.biesheuvel@linaro.org,
	robert.richter@caviumnetworks.com,
	mw@semihalf.com,
	ddaney@caviumnetworks.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linaro-acpi@lists.linaro.org,
	andrea.gallo@linaro.org,
	jeremy.linton@arm.com,
	liudongdong3@huawei.com,
	gabriele.paoloni@huawei.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jcm@redhat.com,
	msalter@redhat.com,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V1 1/2] PCI: thunder: Enable ACPI PCI controller for ThunderX pass2.x silicon version
Date: Tue, 15 Nov 2016 10:14:57 +0100
Message-Id: <1479201298-25494-2-git-send-email-tn@semihalf.com>
In-Reply-To: <1479201298-25494-1-git-send-email-tn@semihalf.com>
References: <1479201298-25494-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

ThunderX PCIe controller to off-chip devices (so-called PEM) is not fully
compliant with ECAM standard. It uses non-standard configuration space
accessors (see pci_thunder_pem_ops) and custom configuration space granulation
(see bus_shift = 24). In order to access configuration space and
probe PEM as ACPI based PCI host controller we need to add MCFG quirk
infrastructure. This involves:
1. thunder_pem_init() ACPI extension so that we can probe PEM-specific
   register ranges analogously to DT
2. Export PEM pci_thunder_pem_ops structure so it is visible to MCFG quirk
   code.
3. New quirk entries for each PEM segment. Each contains platform IDs,
   mentioned pci_thunder_pem_ops and CFG resources.

Quirk is considered for ThunderX silicon pass2.x only which is identified
via MCFG revision 1.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/acpi/pci_mcfg.c            |  20 +++++++
 drivers/pci/host/pci-thunder-pem.c | 107 ++++++++++++++++++++++++++++++++-----
 include/linux/pci-ecam.h           |   4 ++
 3 files changed, 117 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index ac21db3..e4e2b9b 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -57,6 +57,26 @@ static struct mcfg_fixup mcfg_quirks[] = {
 	{ "QCOM  ", "QDF2432 ", 1, 5, MCFG_BUS_ANY, &pci_32b_ops },
 	{ "QCOM  ", "QDF2432 ", 1, 6, MCFG_BUS_ANY, &pci_32b_ops },
 	{ "QCOM  ", "QDF2432 ", 1, 7, MCFG_BUS_ANY, &pci_32b_ops },
+#ifdef CONFIG_PCI_HOST_THUNDER_PEM
+#define THUNDER_MCFG_RES(addr, node) \
+	DEFINE_RES_MEM(addr + (node << 44), 0x39 * SZ_16M)
+#define THUNDER_MCFG_QUIRK(rev, node) \
+	{ "CAVIUM", "THUNDERX", rev, 4 + (10 * node), MCFG_BUS_ANY, \
+	  &pci_thunder_pem_ops, THUNDER_MCFG_RES(0x88001f000000UL, node) }, \
+	{ "CAVIUM", "THUNDERX", rev, 5 + (10 * node), MCFG_BUS_ANY, \
+	  &pci_thunder_pem_ops, THUNDER_MCFG_RES(0x884057000000UL, node) }, \
+	{ "CAVIUM", "THUNDERX", rev, 6 + (10 * node), MCFG_BUS_ANY, \
+	  &pci_thunder_pem_ops, THUNDER_MCFG_RES(0x88808f000000UL, node) }, \
+	{ "CAVIUM", "THUNDERX", rev, 7 + (10 * node), MCFG_BUS_ANY, \
+	  &pci_thunder_pem_ops, THUNDER_MCFG_RES(0x89001f000000UL, node) }, \
+	{ "CAVIUM", "THUNDERX", rev, 8 + (10 * node), MCFG_BUS_ANY, \
+	  &pci_thunder_pem_ops, THUNDER_MCFG_RES(0x894057000000UL, node) }, \
+	{ "CAVIUM", "THUNDERX", rev, 9 + (10 * node), MCFG_BUS_ANY, \
+	  &pci_thunder_pem_ops, THUNDER_MCFG_RES(0x89808f000000UL, node) }
+	/* SoC pass2.x */
+	THUNDER_MCFG_QUIRK(1, 0UL),
+	THUNDER_MCFG_QUIRK(1, 1UL),
+#endif
 };
 
 static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
index 6abaf80..7bdc4cd 100644
--- a/drivers/pci/host/pci-thunder-pem.c
+++ b/drivers/pci/host/pci-thunder-pem.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
+#include <linux/pci-acpi.h>
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
 
@@ -284,6 +285,84 @@ static int thunder_pem_config_write(struct pci_bus *bus, unsigned int devfn,
 	return pci_generic_config_write(bus, devfn, where, size, val);
 }
 
+#ifdef CONFIG_ACPI
+
+/*
+ * Retrieve PEM bridge register base and size from PNP0C02 sub-device under
+ * the RC.
+ *
+ * Device (RES0)
+ * {
+ *	Name (_HID, "THRX0002")
+ *	Name (_CID, "PNP0C02")
+ *	Name (_CRS, ResourceTemplate () {
+ *		// Device specific registers range
+ *		QWordMemory(ResourceConsumer, PosDecode, MinFixed,
+ *		MaxFixed, Cacheable, ReadWrite, 0,
+ *		0x87e0c2000000, 0x87E0C2FFFFFF, 0, 0x1000000)
+ *	})
+ * }
+ */
+
+static const struct acpi_device_id thunder_pem_reg_ids[] = {
+	{"THRX0002", 0},
+	{"", 0},
+};
+
+static struct resource *thunder_pem_acpi_res(struct pci_config_window *cfg)
+{
+	struct device *dev = cfg->parent;
+	struct acpi_device *adev = to_acpi_device(dev);
+	struct acpi_device *child_adev;
+	struct resource *res_pem;
+
+	res_pem = devm_kzalloc(dev, sizeof(*res_pem), GFP_KERNEL);
+	if (!res_pem) {
+		dev_err(dev, "failed to allocate PEM resource\n");
+		return NULL;
+	}
+
+	list_for_each_entry(child_adev, &adev->children, node) {
+		struct resource_entry *entry;
+		struct list_head list;
+		unsigned long flags;
+		int ret;
+
+		ret = acpi_match_device_ids(child_adev, thunder_pem_reg_ids);
+		if (ret)
+			continue;
+
+		INIT_LIST_HEAD(&list);
+		flags = IORESOURCE_MEM;
+		ret = acpi_dev_get_resources(child_adev, &list,
+					     acpi_dev_filter_resource_type_cb,
+					     (void *)flags);
+		if (ret < 0) {
+			dev_err(&child_adev->dev,
+				"failed to parse _CRS method, error code %d\n",
+				ret);
+			return NULL;
+		} else if (ret == 0) {
+			dev_err(&child_adev->dev,
+				"no memory resources present in _CRS\n");
+			return NULL;
+		}
+
+		entry = list_first_entry(&list, struct resource_entry, node);
+		*res_pem = *entry->res;
+		acpi_dev_free_resource_list(&list);
+		return res_pem;
+	}
+
+	return NULL;
+}
+#else
+static struct resource *thunder_pem_acpi_res(struct pci_config_window *cfg)
+{
+	return NULL;
+}
+#endif
+
 static int thunder_pem_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
@@ -292,24 +371,24 @@ static int thunder_pem_init(struct pci_config_window *cfg)
 	struct thunder_pem_pci *pem_pci;
 	struct platform_device *pdev;
 
-	/* Only OF support for now */
-	if (!dev->of_node)
-		return -EINVAL;
-
 	pem_pci = devm_kzalloc(dev, sizeof(*pem_pci), GFP_KERNEL);
 	if (!pem_pci)
 		return -ENOMEM;
 
-	pdev = to_platform_device(dev);
-
-	/*
-	 * The second register range is the PEM bridge to the PCIe
-	 * bus.  It has a different config access method than those
-	 * devices behind the bridge.
-	 */
-	res_pem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (acpi_disabled) {
+		pdev = to_platform_device(dev);
+
+		/*
+		 * The second register range is the PEM bridge to the PCIe
+		 * bus.  It has a different config access method than those
+		 * devices behind the bridge.
+		 */
+		res_pem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	} else {
+		res_pem = thunder_pem_acpi_res(cfg);
+	}
 	if (!res_pem) {
-		dev_err(dev, "missing \"reg[1]\"property\n");
+		dev_err(dev, "missing configuration region\n");
 		return -EINVAL;
 	}
 
@@ -332,7 +411,7 @@ static int thunder_pem_init(struct pci_config_window *cfg)
 	return 0;
 }
 
-static struct pci_ecam_ops pci_thunder_pem_ops = {
+struct pci_ecam_ops pci_thunder_pem_ops = {
 	.bus_shift	= 24,
 	.init		= thunder_pem_init,
 	.pci_ops	= {
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index f5740b7..3f2a98f 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -58,6 +58,10 @@ void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
 			       int where);
 /* default ECAM ops */
 extern struct pci_ecam_ops pci_generic_ecam_ops;
+/* ECAM ops for known quirks */
+#ifdef CONFIG_PCI_HOST_THUNDER_PEM
+extern struct pci_ecam_ops pci_thunder_pem_ops;
+#endif
 
 /* ops for buggy ECAM that supports only 32-bit accesses */
 extern struct pci_ecam_ops pci_32b_ops;
-- 
2.7.4
