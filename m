Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
From: Tomasz Nowicki <tn@semihalf.com>
To: helgaas@kernel.org,
	will.deacon@arm.com,
	catalin.marinas@arm.com,
	rafael@kernel.org,
	Lorenzo.Pieralisi@arm.com
Cc: arnd@arndb.de,
	hanjun.guo@linaro.org,
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
Subject: [PATCH V6 1/5] PCI/ACPI: Extend pci_mcfg_lookup() responsibilities
Date: Fri,  9 Sep 2016 21:24:03 +0200
Message-Id: <1473449047-10499-2-git-send-email-tn@semihalf.com>
In-Reply-To: <1473449047-10499-1-git-send-email-tn@semihalf.com>
References: <1473449047-10499-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

In preparation for adding MCFG platform specific quirk handling move
CFG resource calculation and ECAM ops assignment to pci_mcfg_lookup().
It becomes the gate for further ops and CFG resource manipulation
in arch-agnostic code (drivers/acpi/pci_mcfg.c).

No functionality changes in this patch.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 arch/arm64/kernel/pci.c  | 17 +++++------------
 drivers/acpi/pci_mcfg.c  | 28 +++++++++++++++++++++++++---
 include/linux/pci-acpi.h |  4 +++-
 3 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index acf3872..fb439c7 100644
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
-- 
1.9.1
