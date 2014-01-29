Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:61674 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277AbaA2SSv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jan 2014 13:18:51 -0500
Received: by mail-ig0-f172.google.com with SMTP id k19so15679649igc.5
        for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2014 10:18:50 -0800 (PST)
Subject: [PATCH 11/17] x86/PCI: Remove acpi_get_pxm() usage
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org, x86@kernel.org,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 29 Jan 2014 11:18:48 -0700
Message-ID: <20140129181848.15476.265.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140129174106.15476.7075.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140129174106.15476.7075.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI host bridge code doesn't care about _PXM values directly; it only
needs to know what NUMA node the hardware is on.

This uses acpi_get_node() directly and removes the _PXM stuff.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/acpi.c |   19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 6304ea0f426d..f44a64c74e37 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -480,9 +480,6 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	struct pci_bus *bus = NULL;
 	struct pci_sysdata *sd;
 	int node;
-#ifdef CONFIG_ACPI_NUMA
-	int pxm;
-#endif
 
 	if (pci_ignore_seg)
 		domain = 0;
@@ -494,12 +491,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		return NULL;
 	}
 
-	node = NUMA_NO_NODE;
-#ifdef CONFIG_ACPI_NUMA
-	pxm = acpi_get_pxm(device->handle);
-	if (pxm >= 0)
-		node = pxm_to_node(pxm);
-#endif
+	node = acpi_get_node(device->handle);
 	if (node == NUMA_NO_NODE)
 		node = x86_pci_root_bus_node(busnum);
 
@@ -570,15 +562,8 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 			pcie_bus_configure_settings(child);
 	}
 
-	if (bus && node != NUMA_NO_NODE) {
-#ifdef CONFIG_ACPI_NUMA
-		if (pxm >= 0)
-			dev_printk(KERN_DEBUG, &bus->dev,
-				   "on NUMA node %d (pxm %d)\n", node, pxm);
-#else
+	if (bus && node != NUMA_NO_NODE)
 		dev_printk(KERN_DEBUG, &bus->dev, "on NUMA node %d\n", node);
-#endif
-	}
 
 	return bus;
 }

