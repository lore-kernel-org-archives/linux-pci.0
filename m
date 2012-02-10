Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: [PATCH v2 17/18] xtensa/PCI: get rid of device resource fixups
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org, Chris Zankel <chris@zankel.net>
Date: Thu, 09 Feb 2012 19:37:48 -0700
Message-ID: <20120210023748.10311.59774.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120210023424.10311.82445.stgit@bhelgaas.mtv.corp.google.com>
References: <20120210023424.10311.82445.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Tell the PCI core about host bridge address translation so it can take
care of bus-to-resource conversion for us.

CC: Chris Zankel <chris@zankel.net>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/xtensa/kernel/pci.c |   17 +----------------
 1 files changed, 1 insertions(+), 16 deletions(-)

diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
index 61045c1..eb30e35 100644
--- a/arch/xtensa/kernel/pci.c
+++ b/arch/xtensa/kernel/pci.c
@@ -153,7 +153,7 @@ static void __init pci_controller_apertures(struct pci_controller *pci_ctrl,
 	}
 	res->start += io_offset;
 	res->end += io_offset;
-	pci_add_resource(resources, res);
+	pci_add_resource_offset(resources, res, io_offset);
 
 	for (i = 0; i < 3; i++) {
 		res = &pci_ctrl->mem_resources[i];
@@ -200,24 +200,9 @@ subsys_initcall(pcibios_init);
 
 void __init pcibios_fixup_bus(struct pci_bus *bus)
 {
-	struct pci_controller *pci_ctrl = bus->sysdata;
-	struct resource *res;
-	unsigned long io_offset;
-	int i;
-
-	io_offset = (unsigned long)pci_ctrl->io_space.base;
 	if (bus->parent) {
 		/* This is a subordinate bridge */
 		pci_read_bridge_bases(bus);
-
-		for (i = 0; i < 4; i++) {
-			if ((res = bus->resource[i]) == NULL || !res->flags)
-				continue;
-			if (io_offset && (res->flags & IORESOURCE_IO)) {
-				res->start += io_offset;
-				res->end += io_offset;
-			}
-		}
 	}
 }
 

