Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16018 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751955AbbKPEXu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 15 Nov 2015 23:23:50 -0500
From: Jiang Liu <jiang.liu@linux.intel.com>
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Liu Jiang <jiang.liu@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, x86@kernel.org,
	Keith Busch <keith.busch@intel.com>,
	Arthur Marsh <arthur.marsh@internode.on.net>
Subject: [Bugfix] x86/PCI: Fix regression caused by commit 4d6b4e69a245
Date: Mon, 16 Nov 2015 12:27:37 +0800
Message-Id: <1447648057-13644-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Liu Jiang <jiang.liu@linux.intel.com>

Commit 4d6b4e69a245 ("x86/PCI/ACPI: Use common interface to support
PCI host bridge") converted x86 to use the common interface
acpi_pci_root_create, but the conversion missed on code piece in
arch/x86/pci/bus_numa.c, which causes regression on some legacy
AMD platforms as reported by Arthur Marsh <arthur.marsh@internode.on.net>.
The root causes is that acpi_pci_root_create() fails to insert
host bridge resources into iomem_resource/ioport_resource because
x86_pci_root_bus_resources() has already inserted those resources.
So change x86_pci_root_bus_resources() to not insert resources into
iomem_resource/ioport_resource.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Reported-and-tested-by: Arthur Marsh <arthur.marsh@internode.on.net>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Arthur Marsh <arthur.marsh@internode.on.net>
---
 arch/x86/pci/bus_numa.c |   16 +++-------------
 drivers/acpi/pci_root.c |    7 +++++++
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/x86/pci/bus_numa.c b/arch/x86/pci/bus_numa.c
index 7bcf06a7cd12..ce53b5b64f51 100644
--- a/arch/x86/pci/bus_numa.c
+++ b/arch/x86/pci/bus_numa.c
@@ -41,27 +41,17 @@ void x86_pci_root_bus_resources(int bus, struct list_head *resources)
 	       bus);
 
 	/* already added by acpi ? */
-	resource_list_for_each_entry(window, resources)
+	resource_list_for_each_entry(window, &info->resources)
 		if (window->res->flags & IORESOURCE_BUS) {
 			found = true;
 			break;
 		}
-
 	if (!found)
 		pci_add_resource(resources, &info->busn);
 
-	list_for_each_entry(root_res, &info->resources, list) {
-		struct resource *res;
-		struct resource *root;
+	list_for_each_entry(root_res, &info->resources, list)
+		pci_add_resource(resources, &root_res->res);
 
-		res = &root_res->res;
-		pci_add_resource(resources, res);
-		if (res->flags & IORESOURCE_IO)
-			root = &ioport_resource;
-		else
-			root = &iomem_resource;
-		insert_resource(root, res);
-	}
 	return;
 
 default_resources:
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 850d7bf0c873..ae3fe4e64203 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -768,6 +768,13 @@ static void pci_acpi_root_add_resources(struct acpi_pci_root_info *info)
 		else
 			continue;
 
+		/*
+		 * Some legacy x86 host bridge drivers use iomem_resource and
+		 * ioport_resource as default resource pool, skip it.
+		 */
+		if (res == root)
+			continue;
+
 		conflict = insert_resource_conflict(root, res);
 		if (conflict) {
 			dev_info(&info->bridge->dev,
-- 
1.7.10.4

