Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751501AbcLAIbd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Dec 2016 03:31:33 -0500
Subject: [PATCH v10 05/12] PCI/ACPI: Extend pci_mcfg_lookup() to return ECAM
 config accessors
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, Duc Dang <dhdang@apm.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Christopher Covington <cov@codeaurora.org>,
        Dongdong Liu <liudongdong3@huawei.com>
Date: Thu, 01 Dec 2016 02:30:02 -0600
Message-ID: <20161201083002.12247.663.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161201075131.12247.2211.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161201075131.12247.2211.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Tomasz Nowicki <tn@semihalf.com>

pci_mcfg_lookup() is the external interface to the generic MCFG code.
Previously it merely looked up the ECAM base address for a given domain and
bus range.  We want a way to add MCFG quirks, some of which may require
special config accessors and adjustments to the ECAM address range.

Extend pci_mcfg_lookup() so it can return a pointer to a pci_ecam_ops
structure and a struct resource for the ECAM address space.  For now, it
always returns &pci_generic_ecam_ops (the standard accessor) and the
resource described by the MCFG.

No functional changes intended.

[bhelgaas: changelog]
Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/arm64/kernel/pci.c  |   17 +++++------------
 drivers/acpi/pci_mcfg.c  |   28 +++++++++++++++++++++++++---
 include/linux/pci-acpi.h |    4 +++-
 3 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 95e0bb4..5c08baf 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -125,24 +125,17 @@ pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
 	u16 seg = root->segment;
 	struct pci_config_window *cfg;
 	struct resource cfgres;
-	unsigned int bsz;
+	struct pci_ecam_ops *ecam_ops;
+	int ret;
 
-	/* Use address from _CBA if present, otherwise lookup MCFG */
-	if (!root->mcfg_addr)
-		root->mcfg_addr = pci_mcfg_lookup(seg, bus_res);
-
-	if (!root->mcfg_addr) {
+	ret = pci_mcfg_lookup(root, &cfgres, &ecam_ops);
+	if (ret) {
 		dev_err(&root->device->dev, "%04x:%pR ECAM region not found\n",
 			seg, bus_res);
 		return NULL;
 	}
 
-	bsz = 1 << pci_generic_ecam_ops.bus_shift;
-	cfgres.start = root->mcfg_addr + bus_res->start * bsz;
-	cfgres.end = cfgres.start + resource_size(bus_res) * bsz - 1;
-	cfgres.flags = IORESOURCE_MEM;
-	cfg = pci_ecam_create(&root->device->dev, &cfgres, bus_res,
-			      &pci_generic_ecam_ops);
+	cfg = pci_ecam_create(&root->device->dev, &cfgres, bus_res, ecam_ops);
 	if (IS_ERR(cfg)) {
 		dev_err(&root->device->dev, "%04x:%pR error %ld mapping ECAM\n",
 			seg, bus_res, PTR_ERR(cfg));
diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index b5b376e..ffcc651 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/pci-acpi.h>
+#include <linux/pci-ecam.h>
 
 /* Structure to hold entries from the MCFG table */
 struct mcfg_entry {
@@ -35,9 +36,18 @@ struct mcfg_entry {
 /* List to save MCFG entries */
 static LIST_HEAD(pci_mcfg_list);
 
-phys_addr_t pci_mcfg_lookup(u16 seg, struct resource *bus_res)
+int pci_mcfg_lookup(struct acpi_pci_root *root, struct resource *cfgres,
+		    struct pci_ecam_ops **ecam_ops)
 {
+	struct pci_ecam_ops *ops = &pci_generic_ecam_ops;
+	struct resource *bus_res = &root->secondary;
+	u16 seg = root->segment;
 	struct mcfg_entry *e;
+	struct resource res;
+
+	/* Use address from _CBA if present, otherwise lookup MCFG */
+	if (root->mcfg_addr)
+		goto skip_lookup;
 
 	/*
 	 * We expect exact match, unless MCFG entry end bus covers more than
@@ -45,10 +55,22 @@ phys_addr_t pci_mcfg_lookup(u16 seg, struct resource *bus_res)
 	 */
 	list_for_each_entry(e, &pci_mcfg_list, list) {
 		if (e->segment == seg && e->bus_start == bus_res->start &&
-		    e->bus_end >= bus_res->end)
-			return e->addr;
+		    e->bus_end >= bus_res->end) {
+			root->mcfg_addr = e->addr;
+		}
+
 	}
 
+	if (!root->mcfg_addr)
+		return -ENXIO;
+
+skip_lookup:
+	memset(&res, 0, sizeof(res));
+	res.start = root->mcfg_addr + (bus_res->start << 20);
+	res.end = res.start + (resource_size(bus_res) << 20) - 1;
+	res.flags = IORESOURCE_MEM;
+	*cfgres = res;
+	*ecam_ops = ops;
 	return 0;
 }
 
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 7d63a66..7a4e83a 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -24,7 +24,9 @@ static inline acpi_status pci_acpi_remove_pm_notifier(struct acpi_device *dev)
 }
 extern phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle);
 
-extern phys_addr_t pci_mcfg_lookup(u16 domain, struct resource *bus_res);
+struct pci_ecam_ops;
+extern int pci_mcfg_lookup(struct acpi_pci_root *root, struct resource *cfgres,
+			   struct pci_ecam_ops **ecam_ops);
 
 static inline acpi_handle acpi_find_root_bridge_handle(struct pci_dev *pdev)
 {

