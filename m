Return-Path: <linux-kernel-owner@vger.kernel.org>
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	tglx@linutronix.de, haiyangz@microsoft.com, marc.zyngier@arm.com,
	jiang.liu@linux.intel.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v3 4/7] PCI: Record an fwnode associated with root PCI buses, optionally
Date: Mon, 26 Oct 2015 23:15:36 +0000
Message-Id: <1445901339-11924-5-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1445901339-11924-1-git-send-email-jakeo@microsoft.com>
References: <1445901339-11924-1-git-send-email-jakeo@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

This patch allows a PCI front-end implementation to supply an fwnode_handle
associated with a root PCI bus, optionally.  If supplied, the PCI driver
records this.

This patch supports the next patch in the series, which looks up an IRQ domain
through this handle.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 arch/sparc/kernel/pci.c       | 2 +-
 drivers/acpi/pci_root.c       | 2 +-
 drivers/parisc/lba_pci.c      | 2 +-
 drivers/pci/host/pci-xgene.c  | 2 +-
 drivers/pci/host/pcie-iproc.c | 3 ++-
 drivers/pci/probe.c           | 8 +++++---
 include/linux/pci.h           | 4 +++-
 7 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index b91d7f1..3d4e9f9 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -660,7 +660,7 @@ struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
 	pbm->busn.flags	= IORESOURCE_BUS;
 	pci_add_resource(&resources, &pbm->busn);
 	bus = pci_create_root_bus(parent, pbm->pci_first_busno, pbm->pci_ops,
-				  pbm, &resources);
+				  pbm, &resources, NULL);
 	if (!bus) {
 		printk(KERN_ERR "Failed to create bus for %s\n",
 		       node->full_name);
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 850d7bf..eab95bc 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -840,7 +840,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 	pci_acpi_root_add_resources(info);
 	pci_add_resource(&info->resources, &root->secondary);
 	bus = pci_create_root_bus(NULL, busnum, ops->pci_ops,
-				  sysdata, &info->resources);
+				  sysdata, &info->resources, NULL);
 	if (!bus)
 		goto out_release_info;
 
diff --git a/drivers/parisc/lba_pci.c b/drivers/parisc/lba_pci.c
index a32c1f6..a7b9d5c 100644
--- a/drivers/parisc/lba_pci.c
+++ b/drivers/parisc/lba_pci.c
@@ -1567,7 +1567,7 @@ lba_driver_probe(struct parisc_device *dev)
 	dev->dev.platform_data = lba_dev;
 	lba_bus = lba_dev->hba.hba_bus =
 		pci_create_root_bus(&dev->dev, lba_dev->hba.bus_num.start,
-				    cfg_ops, NULL, &resources);
+				    cfg_ops, NULL, &resources, NULL);
 	if (!lba_bus) {
 		pci_free_resource_list(&resources);
 		return 0;
diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index ae00ce2..95c20c8 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -545,7 +545,7 @@ static int xgene_pcie_probe_bridge(struct platform_device *pdev)
 		return ret;
 
 	bus = pci_create_root_bus(&pdev->dev, 0,
-					&xgene_pcie_ops, port, &res);
+					&xgene_pcie_ops, port, &res, NULL);
 	if (!bus)
 		return -ENOMEM;
 
diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 9193951..bc999b7 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -357,7 +357,8 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 	sysdata = pcie;
 #endif
 
-	bus = pci_create_root_bus(pcie->dev, 0, &iproc_pcie_ops, sysdata, res);
+	bus = pci_create_root_bus(pcie->dev, 0, &iproc_pcie_ops, sysdata, res,
+				  NULL);
 	if (!bus) {
 		dev_err(pcie->dev, "unable to create PCI root bus\n");
 		ret = -ENOMEM;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f441d1b..c0f2e44 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2039,7 +2039,8 @@ void __weak pcibios_remove_bus(struct pci_bus *bus)
 }
 
 struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
-		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+		struct pci_ops *ops, void *sysdata, struct list_head *resources,
+		struct fwnode_handle *fwnode)
 {
 	int error;
 	struct pci_host_bridge *bridge;
@@ -2069,6 +2070,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	if (!bridge)
 		goto err_out;
 
+	bridge->fwnode = fwnode;
 	bridge->dev.parent = parent;
 	bridge->dev.release = pci_release_host_bridge_dev;
 	dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
@@ -2223,7 +2225,7 @@ struct pci_bus *pci_scan_root_bus_msi(struct device *parent, int bus,
 			break;
 		}
 
-	b = pci_create_root_bus(parent, bus, ops, sysdata, resources);
+	b = pci_create_root_bus(parent, bus, ops, sysdata, resources, NULL);
 	if (!b)
 		return NULL;
 
@@ -2261,7 +2263,7 @@ struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops,
 	pci_add_resource(&resources, &ioport_resource);
 	pci_add_resource(&resources, &iomem_resource);
 	pci_add_resource(&resources, &busn_resource);
-	b = pci_create_root_bus(NULL, bus, ops, sysdata, &resources);
+	b = pci_create_root_bus(NULL, bus, ops, sysdata, &resources, NULL);
 	if (b) {
 		pci_scan_child_bus(b);
 	} else {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b54fbf1..86ce5fa 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -409,6 +409,7 @@ struct pci_host_bridge {
 	struct device dev;
 	struct pci_bus *bus;		/* root bus */
 	struct list_head windows;	/* resource_entry */
+	struct fwnode_handle *fwnode;
 	void (*release_fn)(struct pci_host_bridge *);
 	void *release_data;
 	unsigned int ignore_reset_delay:1;	/* for entire hierarchy */
@@ -789,7 +790,8 @@ void pci_bus_add_devices(const struct pci_bus *bus);
 struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata);
 struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 				    struct pci_ops *ops, void *sysdata,
-				    struct list_head *resources);
+				    struct list_head *resources,
+				    struct fwnode_handle *fwnode);
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busmax);
 int pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
 void pci_bus_release_busn_res(struct pci_bus *b);
-- 
1.9.1

