Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Timmy Li <lixiaoping3@huawei.com>
To: <bhelgaas@google.com>, <tn@semihalf.com>,
        <lorenzo.pieralisi@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Timmy Li <lixiaoping3@huawei.com>
Subject: [PATCH] arm64: PCI: free all allocated memory in case of failure
Date: Fri, 12 May 2017 17:57:47 +0800
Message-ID: <20170512095747.744688-1-lixiaoping3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There are some memory allocations in pci_acpi_scan_root(). But
ri, root_ops and ri->cfg are not freed properly in failure cases,
which results in memory leaks. This patch fixes the potential
memory leaks.

Signed-off-by: Timmy Li <lixiaoping3@huawei.com>
---
 arch/arm64/kernel/pci.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 4f0e3eb..e7e88ce 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -188,25 +188,22 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 
 	ri = kzalloc_node(sizeof(*ri), GFP_KERNEL, node);
 	if (!ri)
-		return NULL;
+		goto err_allocri;
 
 	root_ops = kzalloc_node(sizeof(*root_ops), GFP_KERNEL, node);
 	if (!root_ops)
-		return NULL;
+		goto err_allocops;
 
 	ri->cfg = pci_acpi_setup_ecam_mapping(root);
-	if (!ri->cfg) {
-		kfree(ri);
-		kfree(root_ops);
-		return NULL;
-	}
+	if (!ri->cfg)
+		goto err_ecam;
 
 	root_ops->release_info = pci_acpi_generic_release_info;
 	root_ops->prepare_resources = pci_acpi_root_prepare_resources;
 	root_ops->pci_ops = &ri->cfg->ops->pci_ops;
 	bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
 	if (!bus)
-		return NULL;
+		goto err_rootcreate;
 
 	pci_bus_size_bridges(bus);
 	pci_bus_assign_resources(bus);
@@ -215,6 +212,15 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		pcie_bus_configure_settings(child);
 
 	return bus;
+
+err_rootcreate:
+	pci_ecam_free(ri->cfg);
+err_ecam:
+	kfree(root_ops);
+err_allocops:
+	kfree(ri);
+err_allocri:
+	return NULL;
 }
 
 void pcibios_add_bus(struct pci_bus *bus)
-- 
1.9.1
