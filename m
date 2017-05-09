Return-Path: <SRS0=Gf57=4P=vodafone.de=deathsimple@kernel.org>
Return-Path: <SRS0=Gf57=4P=vodafone.de=deathsimple@kernel.org>
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <deathsimple@vodafone.de>
To: linux-pci@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	helgaas@kernel.org
Subject: [PATCH v6 1/5] PCI: add a define for the PCI resource type mask v2
Date: Tue,  9 May 2017 18:49:03 +0200
Message-Id: <1494348547-1465-2-git-send-email-deathsimple@vodafone.de>
In-Reply-To: <1494348547-1465-1-git-send-email-deathsimple@vodafone.de>
References: <1494348547-1465-1-git-send-email-deathsimple@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

From: Christian König <christian.koenig@amd.com>

We use this mask multiple times in the bus setup.

v2: fix some style nit picks

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/pci/pci.h       |  4 ++++
 drivers/pci/setup-bus.c | 12 +++---------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4518562..56ad106 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -6,6 +6,10 @@
 
 #define PCI_FIND_CAP_TTL	48
 
+#define PCI_RES_TYPE_MASK \
+	(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH |\
+	 IORESOURCE_MEM_64)
+
 extern const unsigned char pcie_link_speed[];
 
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index f30ca75..efebd70 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1532,8 +1532,6 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 {
 	struct pci_dev *dev = bus->self;
 	struct resource *r;
-	unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM |
-				  IORESOURCE_PREFETCH | IORESOURCE_MEM_64;
 	unsigned old_flags = 0;
 	struct resource *b_res;
 	int idx = 1;
@@ -1576,7 +1574,7 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 	 */
 	release_child_resources(r);
 	if (!release_resource(r)) {
-		type = old_flags = r->flags & type_mask;
+		type = old_flags = r->flags & PCI_RES_TYPE_MASK;
 		dev_printk(KERN_DEBUG, &dev->dev, "resource %d %pR released\n",
 					PCI_BRIDGE_RESOURCES + idx, r);
 		/* keep the old size */
@@ -1767,8 +1765,6 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 	enum release_type rel_type = leaf_only;
 	LIST_HEAD(fail_head);
 	struct pci_dev_resource *fail_res;
-	unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM |
-				  IORESOURCE_PREFETCH | IORESOURCE_MEM_64;
 	int pci_try_num = 1;
 	enum enable_type enable_local;
 
@@ -1827,7 +1823,7 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 	 */
 	list_for_each_entry(fail_res, &fail_head, list)
 		pci_bus_release_bridge_resources(fail_res->dev->bus,
-						 fail_res->flags & type_mask,
+						 fail_res->flags & PCI_RES_TYPE_MASK,
 						 rel_type);
 
 	/* restore size and flags */
@@ -1871,8 +1867,6 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 	LIST_HEAD(fail_head);
 	struct pci_dev_resource *fail_res;
 	int retval;
-	unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM |
-				  IORESOURCE_PREFETCH | IORESOURCE_MEM_64;
 
 again:
 	__pci_bus_size_bridges(parent, &add_list);
@@ -1898,7 +1892,7 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 	 */
 	list_for_each_entry(fail_res, &fail_head, list)
 		pci_bus_release_bridge_resources(fail_res->dev->bus,
-						 fail_res->flags & type_mask,
+						 fail_res->flags & PCI_RES_TYPE_MASK,
 						 whole_subtree);
 
 	/* restore size and flags */
-- 
2.7.4
