Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751723AbcLEX0B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Dec 2016 18:26:01 -0500
Subject: [PATCH v11 05/15] arm64: PCI: Manage controller-specific data on
 per-controller basis
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, Duc Dang <dhdang@apm.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Christopher Covington <cov@codeaurora.org>,
        Dongdong Liu <liudongdong3@huawei.com>
Date: Mon, 05 Dec 2016 17:25:57 -0600
Message-ID: <20161205232557.3957.84754.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161205232117.3957.50546.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161205232117.3957.50546.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Tomasz Nowicki <tn@semihalf.com>

Currently we use one shared global acpi_pci_root_ops structure to keep
controller-specific ops. We pass its pointer to acpi_pci_root_create() and
associate it with a host bridge instance for good.  Such a design implies
serious drawback. Any potential manipulation on the single system-wide
acpi_pci_root_ops leads to kernel crash. The structure content is not
really changing even across multiple host bridges creation; thus it was not
an issue so far.

In preparation for adding ECAM quirks mechanism (where controller-specific
PCI ops may be different for each host bridge) allocate new
acpi_pci_root_ops and fill in with data for each bridge. Now it is safe to
have different controller-specific info. As a consequence free
acpi_pci_root_ops when host bridge is released.

No functional changes in this patch.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/arm64/kernel/pci.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 7909f59..1eb42ba 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -169,33 +169,36 @@ static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
 
 	ri = container_of(ci, struct acpi_pci_generic_root_info, common);
 	pci_ecam_free(ri->cfg);
+	kfree(ci->ops);
 	kfree(ri);
 }
 
-static struct acpi_pci_root_ops acpi_pci_root_ops = {
-	.release_info = pci_acpi_generic_release_info,
-};
-
 /* Interface called from ACPI code to setup PCI host controller */
 struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 {
 	int node = acpi_get_node(root->device->handle);
 	struct acpi_pci_generic_root_info *ri;
 	struct pci_bus *bus, *child;
+	struct acpi_pci_root_ops *root_ops;
 
 	ri = kzalloc_node(sizeof(*ri), GFP_KERNEL, node);
 	if (!ri)
 		return NULL;
 
+	root_ops = kzalloc_node(sizeof(*root_ops), GFP_KERNEL, node);
+	if (!root_ops)
+		return NULL;
+
 	ri->cfg = pci_acpi_setup_ecam_mapping(root);
 	if (!ri->cfg) {
 		kfree(ri);
+		kfree(root_ops);
 		return NULL;
 	}
 
-	acpi_pci_root_ops.pci_ops = &ri->cfg->ops->pci_ops;
-	bus = acpi_pci_root_create(root, &acpi_pci_root_ops, &ri->common,
-				   ri->cfg);
+	root_ops->release_info = pci_acpi_generic_release_info;
+	root_ops->pci_ops = &ri->cfg->ops->pci_ops;
+	bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
 	if (!bus)
 		return NULL;
 

