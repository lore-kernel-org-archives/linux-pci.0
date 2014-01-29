Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37099 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168AbaA2SSV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jan 2014 13:18:21 -0500
Received: by mail-ig0-f179.google.com with SMTP id c10so5224958igq.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2014 10:18:21 -0800 (PST)
Subject: [PATCH 07/17] x86/PCI: Use x86_pci_root_bus_node() instead of
 get_mp_bus_to_node()
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org, x86@kernel.org,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 29 Jan 2014 11:18:19 -0700
Message-ID: <20140129181819.15476.16563.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140129174106.15476.7075.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140129174106.15476.7075.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This replaces all uses of get_mp_bus_to_node() with x86_pci_root_bus_node().

I think these uses are all on root buses, except possibly for blind
probing, where NUMA node information is unimportant.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/acpi.c   |    2 +-
 arch/x86/pci/common.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 4f25ec077552..3f42c5c05bf6 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -503,7 +503,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		set_mp_bus_to_node(busnum, node);
 	else
 #endif
-		node = get_mp_bus_to_node(busnum);
+		node = x86_pci_root_bus_node(busnum);
 
 	if (node != -1 && !node_online(node))
 		node = -1;
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 600e5925f1a4..f7d6800f10d1 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -467,7 +467,7 @@ void pcibios_scan_root(int busnum)
 		printk(KERN_ERR "PCI: OOM, skipping PCI bus %02x\n", busnum);
 		return;
 	}
-	sd->node = get_mp_bus_to_node(busnum);
+	sd->node = x86_pci_root_bus_node(busnum);
 	x86_pci_root_bus_resources(busnum, &resources);
 	printk(KERN_DEBUG "PCI: Probing PCI hardware (bus %02x)\n", busnum);
 	bus = pci_scan_root_bus(NULL, busnum, &pci_root_ops, sd, &resources);

