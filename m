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
Subject: [PATCH V6 2/5] PCI/ACPI: Check platform specific ECAM quirks
Date: Fri,  9 Sep 2016 21:24:04 +0200
Message-Id: <1473449047-10499-3-git-send-email-tn@semihalf.com>
In-Reply-To: <1473449047-10499-1-git-send-email-tn@semihalf.com>
References: <1473449047-10499-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

Some platforms may not be fully compliant with generic set of PCI config
accessors. For these cases we implement the way to overwrite CFG accessors
set and configuration space range.

In first place pci_mcfg_parse() saves machine's IDs and revision number
(these come from MCFG header) in order to match against known quirk entries.
Then the algorithm traverses available quirk list (static array),
matches against <oem_id, oem_table_id, rev, domain, bus number range> and
returns custom PCI config ops and/or CFG resource structure.

When adding new quirk there are two possibilities:
1. Override default pci_generic_ecam_ops ops but CFG resource comes from MCFG
{ "OEM_ID", "OEM_TABLE_ID", <REV>, <DOMAIN>, <BUS_NR>, &foo_ops, MCFG_RES_EMPTY },
2. Override default pci_generic_ecam_ops ops and CFG resource. For this case
it is also allowed get CFG resource from quirk entry w/o having it in MCFG.
{ "OEM_ID", "OEM_TABLE_ID", <REV>, <DOMAIN>, <BUS_NR>, &boo_ops,
  DEFINE_RES_MEM(START, SIZE) },

pci_generic_ecam_ops and MCFG entries will be used for platforms
free from quirks.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
 drivers/acpi/pci_mcfg.c | 80 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 74 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index ffcc651..2b8acc7 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -32,6 +32,59 @@ struct mcfg_entry {
 	u8			bus_start;
 	u8			bus_end;
 };
+struct mcfg_fixup {
+	char oem_id[ACPI_OEM_ID_SIZE + 1];
+	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
+	u32 oem_revision;
+	u16 seg;
+	struct resource bus_range;
+	struct pci_ecam_ops *ops;
+	struct resource cfgres;
+};
+
+#define MCFG_DOM_ANY			(-1)
+#define MCFG_BUS_RANGE(start, end)	DEFINE_RES_NAMED((start),	\
+						((end) - (start) + 1),	\
+						NULL, IORESOURCE_BUS)
+#define MCFG_BUS_ANY		MCFG_BUS_RANGE(0x0, 0xff)
+#define MCFG_RES_EMPTY		DEFINE_RES_NAMED(0, 0, NULL, 0)
+
+static struct mcfg_fixup mcfg_quirks[] = {
+/*	{ OEM_ID, OEM_TABLE_ID, REV, DOMAIN, BUS_RANGE, cfgres, ops }, */
+};
+
+static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
+static char mcfg_oem_table_id[ACPI_OEM_TABLE_ID_SIZE];
+static u32 mcfg_oem_revision;
+
+static void pci_mcfg_match_quirks(struct acpi_pci_root *root,
+				  struct resource *cfgres,
+				  struct pci_ecam_ops **ecam_ops)
+{
+	struct mcfg_fixup *f;
+	int i;
+
+	/*
+	 * First match against PCI topology <domain:bus> then use OEM ID, OEM
+	 * table ID, and OEM revision from MCFG table standard header.
+	 */
+	for (i = 0, f = mcfg_quirks; i < ARRAY_SIZE(mcfg_quirks); i++, f++) {
+		if (f->seg == root->segment &&
+		    resource_contains(&f->bus_range, &root->secondary) &&
+		    !memcmp(f->oem_id, mcfg_oem_id, ACPI_OEM_ID_SIZE) &&
+		    !memcmp(f->oem_table_id, mcfg_oem_table_id,
+		            ACPI_OEM_TABLE_ID_SIZE) &&
+		    f->oem_revision == mcfg_oem_revision) {
+			if (f->cfgres.start)
+				*cfgres = f->cfgres;
+			if (f->ops)
+				*ecam_ops =  f->ops;
+			dev_info(&root->device->dev, "Applying PCI MCFG quirks for %s %s rev: %d\n",
+				 f->oem_id, f->oem_table_id, f->oem_revision);
+			return;
+		}
+	}
+}
 
 /* List to save MCFG entries */
 static LIST_HEAD(pci_mcfg_list);
@@ -61,14 +114,24 @@ int pci_mcfg_lookup(struct acpi_pci_root *root, struct resource *cfgres,
 
 	}
 
-	if (!root->mcfg_addr)
-		return -ENXIO;
-
 skip_lookup:
 	memset(&res, 0, sizeof(res));
-	res.start = root->mcfg_addr + (bus_res->start << 20);
-	res.end = res.start + (resource_size(bus_res) << 20) - 1;
-	res.flags = IORESOURCE_MEM;
+	if (root->mcfg_addr) {
+		res.start = root->mcfg_addr + (bus_res->start << 20);
+		res.end = res.start + (resource_size(bus_res) << 20) - 1;
+		res.flags = IORESOURCE_MEM;
+	}
+
+	/*
+	 * Let to override default ECAM ops and CFG resource range.
+	 * Also, this might even retrieve CFG resource range in case MCFG
+	 * does not have it. Invalid CFG start address means MCFG firmware bug
+	 * or we need another quirk in array.
+	 */
+	pci_mcfg_match_quirks(root, &res, &ops);
+	if (!res.start)
+		return -ENXIO;
+
 	*cfgres = res;
 	*ecam_ops = ops;
 	return 0;
@@ -101,6 +164,11 @@ static __init int pci_mcfg_parse(struct acpi_table_header *header)
 		list_add(&e->list, &pci_mcfg_list);
 	}
 
+	/* Save MCFG IDs and revision for quirks matching */
+	memcpy(mcfg_oem_id, header->oem_id, ACPI_OEM_ID_SIZE);
+	memcpy(mcfg_oem_table_id, header->oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
+	mcfg_oem_revision = header->revision;
+
 	pr_info("MCFG table detected, %d entries\n", n);
 	return 0;
 }
-- 
1.9.1
