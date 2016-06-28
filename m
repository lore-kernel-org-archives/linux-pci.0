Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
From: Tomasz Nowicki <tn@semihalf.com>
To: helgaas@kernel.org,
	arnd@arndb.de,
	will.deacon@arm.com,
	catalin.marinas@arm.com,
	rafael@kernel.org,
	hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com,
	okaya@codeaurora.org,
	jchandra@broadcom.com
Cc: robert.richter@caviumnetworks.com,
	mw@semihalf.com,
	Liviu.Dudau@arm.com,
	ddaney@caviumnetworks.com,
	wangyijing@huawei.com,
	msalter@redhat.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org,
	jcm@redhat.com,
	andrea.gallo@linaro.org,
	dhdang@apm.com,
	jeremy.linton@arm.com,
	liudongdong3@huawei.com,
	cov@codeaurora.org,
	gabriele.paoloni@huawei.com,
	jhugo@codeaurora.org,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [RFC PATCH v4 2/5] PCI/ACPI: Move ACPI ECAM mapping to generic MCFG driver
Date: Tue, 28 Jun 2016 09:53:59 +0200
Message-Id: <1467100442-28078-3-git-send-email-tn@semihalf.com>
In-Reply-To: <1467100442-28078-1-git-send-email-tn@semihalf.com>
References: <1467100442-28078-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

pci_acpi_setup_ecam_mapping() is not really ARM64 specific so move it out
of arch/arm64/ directory. In preparation for adding MCFG quirk handling
extend pci_acpi_setup_ecam_mapping() functionality to accept custom
PCI config accessors (function's argument).

For ARM64 ACPI based PCI host controller we still use pci_generic_ecam_ops.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 arch/arm64/kernel/pci.c  | 41 ++---------------------------------------
 drivers/acpi/pci_mcfg.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-acpi.h |  3 +++
 3 files changed, 45 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index cb4dee7..addf00c 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -127,44 +127,6 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 	return 0;
 }
 
-/*
- * Lookup the bus range for the domain in MCFG, and set up config space
- * mapping.
- */
-static struct pci_config_window *
-pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
-{
-	struct resource *bus_res = &root->secondary;
-	u16 seg = root->segment;
-	struct pci_config_window *cfg;
-	struct resource cfgres;
-	unsigned int bsz;
-
-	/* Use address from _CBA if present, otherwise lookup MCFG */
-	if (!root->mcfg_addr)
-		root->mcfg_addr = pci_mcfg_lookup(seg, bus_res);
-
-	if (!root->mcfg_addr) {
-		dev_err(&root->device->dev, "%04x:%pR ECAM region not found\n",
-			seg, bus_res);
-		return NULL;
-	}
-
-	bsz = 1 << pci_generic_ecam_ops.bus_shift;
-	cfgres.start = root->mcfg_addr + bus_res->start * bsz;
-	cfgres.end = cfgres.start + resource_size(bus_res) * bsz - 1;
-	cfgres.flags = IORESOURCE_MEM;
-	cfg = pci_ecam_create(&root->device->dev, &cfgres, bus_res,
-			      &pci_generic_ecam_ops);
-	if (IS_ERR(cfg)) {
-		dev_err(&root->device->dev, "%04x:%pR error %ld mapping ECAM\n",
-			seg, bus_res, PTR_ERR(cfg));
-		return NULL;
-	}
-
-	return cfg;
-}
-
 /* release_info: free resources allocated by init_info */
 static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
 {
@@ -190,7 +152,8 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	if (!ri)
 		return NULL;
 
-	ri->cfg = pci_acpi_setup_ecam_mapping(root);
+	ri->cfg = pci_acpi_setup_ecam_mapping(root,
+					      &pci_generic_ecam_ops.pci_ops);
 	if (!ri->cfg) {
 		kfree(ri);
 		return NULL;
diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index b5b376e..331b560 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/pci-acpi.h>
+#include <linux/pci-ecam.h>
 
 /* Structure to hold entries from the MCFG table */
 struct mcfg_entry {
@@ -52,6 +53,45 @@ phys_addr_t pci_mcfg_lookup(u16 seg, struct resource *bus_res)
 	return 0;
 }
 
+/*
+ * Lookup the bus range for the domain in MCFG, and set up config space
+ * mapping.
+ */
+struct pci_config_window *
+pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root, struct pci_ops *ops)
+{
+	struct resource *bus_res = &root->secondary;
+	u16 seg = root->segment;
+	struct pci_config_window *cfg;
+	struct resource cfgres;
+	struct pci_ecam_ops ecam_ops = {
+			.bus_shift = 20,
+			.pci_ops = *ops,
+	};
+
+	/* Use address from _CBA if present, otherwise lookup MCFG */
+	if (!root->mcfg_addr)
+		root->mcfg_addr = pci_mcfg_lookup(seg, bus_res);
+
+	if (!root->mcfg_addr) {
+		dev_err(&root->device->dev, "%04x:%pR ECAM region not found\n",
+			seg, bus_res);
+		return NULL;
+	}
+
+	cfgres.start = root->mcfg_addr + (bus_res->start << 20);
+	cfgres.end = cfgres.start + (resource_size(bus_res) << 20) - 1;
+	cfgres.flags = IORESOURCE_MEM;
+	cfg = pci_ecam_create(&root->device->dev, &cfgres, bus_res, &ecam_ops);
+	if (IS_ERR(cfg)) {
+		dev_err(&root->device->dev, "%04x:%pR error %ld mapping ECAM\n",
+			seg, bus_res, PTR_ERR(cfg));
+		return NULL;
+	}
+
+	return cfg;
+}
+
 static __init int pci_mcfg_parse(struct acpi_table_header *header)
 {
 	struct acpi_table_mcfg *mcfg;
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 7d63a66..e9bfe00 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -26,6 +26,9 @@ extern phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle);
 
 extern phys_addr_t pci_mcfg_lookup(u16 domain, struct resource *bus_res);
 
+extern struct pci_config_window *
+pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root, struct pci_ops *ops);
+
 static inline acpi_handle acpi_find_root_bridge_handle(struct pci_dev *pdev)
 {
 	struct pci_bus *pbus = pdev->bus;
-- 
1.9.1
