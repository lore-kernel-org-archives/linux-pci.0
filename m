Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
From: Tomasz Nowicki <tn@semihalf.com>
To: helgaas@kernel.org,
	arnd@arndb.de,
	will.deacon@arm.com,
	catalin.marinas@arm.com,
	rafael@kernel.org,
	Lorenzo.Pieralisi@arm.com
Cc: hanjun.guo@linaro.org,
	okaya@codeaurora.org,
	jchandra@broadcom.com,
	cov@codeaurora.org,
	dhdang@apm.com,
	ard.biesheuvel@linaro.org,
	robert.richter@caviumnetworks.com,
	mw@semihalf.com,
	Liviu.Dudau@arm.com,
	ddaney@caviumnetworks.com,
	wangyijing@huawei.com,
	msalter@redhat.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linaro-acpi@lists.linaro.org,
	jcm@redhat.com,
	andrea.gallo@linaro.org,
	jeremy.linton@arm.com,
	liudongdong3@huawei.com,
	gabriele.paoloni@huawei.com,
	jhugo@codeaurora.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [RFC PATCH V5 5/5] PCI: thunder-pem: Support quirky configuration space access for ACPI based PCI host controller
Date: Mon,  8 Aug 2016 15:05:41 +0200
Message-Id: <1470661541-26270-6-git-send-email-tn@semihalf.com>
In-Reply-To: <1470661541-26270-1-git-send-email-tn@semihalf.com>
References: <1470661541-26270-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

Add infrastructure to support ThunderX PEM specific PCI configuration space
access for ACPI based PCI host controller. This involves:
1. New initialization call thunder_pem_cfg_init() to create configuration
space mapping based on hardcoded range addresses
2. thunder_pem_init() ACPI extension to obtain hardcoded addresses for
PEM specific register ranges
3. New quirk entry (for common quirk array) which identifies platform and
calls thunder_pem_cfg_init() from [1]

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/pci/host/mcfg-quirks.c     |  7 +++
 drivers/pci/host/mcfg-quirks.h     |  4 ++
 drivers/pci/host/pci-thunder-pem.c | 96 ++++++++++++++++++++++++++++++++------
 3 files changed, 94 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/host/mcfg-quirks.c b/drivers/pci/host/mcfg-quirks.c
index aa9907b..2993a72 100644
--- a/drivers/pci/host/mcfg-quirks.c
+++ b/drivers/pci/host/mcfg-quirks.c
@@ -44,6 +44,13 @@ struct pci_cfg_fixup {
 
 static struct pci_cfg_fixup mcfg_quirks[] __initconst = {
 /*	{ OEM_ID, OEM_TABLE_ID, REV, DOMAIN, BUS_RANGE, pci_ops, init_hook }, */
+#ifdef CONFIG_PCI_HOST_THUNDER_PEM
+	/* Pass2.0 */
+	{ "CAVIUM", "THUNDERX", 1, MCFG_DOM_RANGE(4, 9), MCFG_BUS_ANY, NULL,
+	  thunder_pem_cfg_init },
+	{ "CAVIUM", "THUNDERX", 1, MCFG_DOM_RANGE(14, 19), MCFG_BUS_ANY, NULL,
+	  thunder_pem_cfg_init },
+#endif
 };
 
 static bool pci_mcfg_fixup_match(struct pci_cfg_fixup *f,
diff --git a/drivers/pci/host/mcfg-quirks.h b/drivers/pci/host/mcfg-quirks.h
index 45cbd16..411c667 100644
--- a/drivers/pci/host/mcfg-quirks.h
+++ b/drivers/pci/host/mcfg-quirks.h
@@ -16,5 +16,9 @@
 #define __MCFG_QUIRKS_H__
 
 /* MCFG quirks initialize call list */
+#ifdef CONFIG_PCI_HOST_THUNDER_PEM
+struct pci_config_window *
+thunder_pem_cfg_init(struct acpi_pci_root *root, struct pci_ops *ops);
+#endif
 
 #endif /* __MCFG_QUIRKS_H__ */
diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
index 6abaf80..3f06e49 100644
--- a/drivers/pci/host/pci-thunder-pem.c
+++ b/drivers/pci/host/pci-thunder-pem.c
@@ -18,9 +18,12 @@
 #include <linux/init.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
+#include <linux/pci-acpi.h>
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
 
+#include "mcfg-quirks.h"
+
 #define PEM_CFG_WR 0x28
 #define PEM_CFG_RD 0x30
 
@@ -284,6 +287,37 @@ static int thunder_pem_config_write(struct pci_bus *bus, unsigned int devfn,
 	return pci_generic_config_write(bus, devfn, where, size, val);
 }
 
+#ifdef CONFIG_ACPI
+
+static struct resource thunder_pem_reg_res[] = {
+	[4] = DEFINE_RES_MEM(0x87e0c0000000UL, SZ_16M),
+	[5] = DEFINE_RES_MEM(0x87e0c1000000UL, SZ_16M),
+	[6] = DEFINE_RES_MEM(0x87e0c2000000UL, SZ_16M),
+	[7] = DEFINE_RES_MEM(0x87e0c3000000UL, SZ_16M),
+	[8] = DEFINE_RES_MEM(0x87e0c4000000UL, SZ_16M),
+	[9] = DEFINE_RES_MEM(0x87e0c5000000UL, SZ_16M),
+	[14] = DEFINE_RES_MEM(0x97e0c0000000UL, SZ_16M),
+	[15] = DEFINE_RES_MEM(0x97e0c1000000UL, SZ_16M),
+	[16] = DEFINE_RES_MEM(0x97e0c2000000UL, SZ_16M),
+	[17] = DEFINE_RES_MEM(0x97e0c3000000UL, SZ_16M),
+	[18] = DEFINE_RES_MEM(0x97e0c4000000UL, SZ_16M),
+	[19] = DEFINE_RES_MEM(0x97e0c5000000UL, SZ_16M),
+};
+
+static struct resource *thunder_pem_acpi_res(struct pci_config_window *cfg)
+{
+	struct acpi_device *adev = to_acpi_device(cfg->parent);
+	struct acpi_pci_root *root = acpi_driver_data(adev);
+
+	return &thunder_pem_reg_res[root->segment];
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
@@ -292,24 +326,24 @@ static int thunder_pem_init(struct pci_config_window *cfg)
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
 
@@ -360,3 +394,39 @@ static struct platform_driver thunder_pem_driver = {
 	.probe = thunder_pem_probe,
 };
 builtin_platform_driver(thunder_pem_driver);
+
+#ifdef CONFIG_ACPI
+
+static struct resource thunder_pem_cfg_res[] = {
+	[4] = DEFINE_RES_MEM(0x88001f000000UL, 0x39 * SZ_16M),
+	[5] = DEFINE_RES_MEM(0x884057000000UL, 0x39 * SZ_16M),
+	[6] = DEFINE_RES_MEM(0x88808f000000UL, 0x39 * SZ_16M),
+	[7] = DEFINE_RES_MEM(0x89001f000000UL, 0x39 * SZ_16M),
+	[8] = DEFINE_RES_MEM(0x894057000000UL, 0x39 * SZ_16M),
+	[9] = DEFINE_RES_MEM(0x89808f000000UL, 0x39 * SZ_16M),
+	[14] = DEFINE_RES_MEM(0x98001f000000UL, 0x39 * SZ_16M),
+	[15] = DEFINE_RES_MEM(0x984057000000UL, 0x39 * SZ_16M),
+	[16] = DEFINE_RES_MEM(0x98808f000000UL, 0x39 * SZ_16M),
+	[17] = DEFINE_RES_MEM(0x99001f000000UL, 0x39 * SZ_16M),
+	[18] = DEFINE_RES_MEM(0x994057000000UL, 0x39 * SZ_16M),
+	[19] = DEFINE_RES_MEM(0x99808f000000UL, 0x39 * SZ_16M),
+};
+
+struct pci_config_window *
+thunder_pem_cfg_init(struct acpi_pci_root *root, struct pci_ops *ops)
+{
+	struct resource *bus_res = &root->secondary;
+	u16 seg = root->segment;
+	struct pci_config_window *cfg;
+
+	cfg = pci_ecam_create(&root->device->dev, &thunder_pem_cfg_res[seg],
+			      bus_res, &pci_thunder_pem_ops);
+	if (IS_ERR(cfg)) {
+		dev_err(&root->device->dev, "%04x:%pR error %ld mapping ECAM\n",
+			seg, bus_res, PTR_ERR(cfg));
+		return NULL;
+	}
+
+	return cfg;
+}
+#endif
-- 
1.9.1
