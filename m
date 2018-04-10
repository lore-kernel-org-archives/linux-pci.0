Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753828AbeDJNZH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Apr 2018 09:25:07 -0400
Subject: [PATCH v1 1/2] microblaze/PCI: Remove
 pcibios_finish_adding_to_bus() dead code
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michal Simek <monstr@monstr.eu>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 10 Apr 2018 08:25:06 -0500
Message-ID: <152336670611.18958.11721407615659058726.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152336656418.18958.17017091754578447948.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152336656418.18958.17017091754578447948.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

pcibios_finish_adding_to_bus() is defined but never used.  Remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/microblaze/include/asm/pci.h |    2 --
 arch/microblaze/pci/pci-common.c  |   24 ------------------------
 2 files changed, 26 deletions(-)

diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
index 114b93488193..4a96480e7716 100644
--- a/arch/microblaze/include/asm/pci.h
+++ b/arch/microblaze/include/asm/pci.h
@@ -69,8 +69,6 @@ extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
 
 extern void pcibios_claim_one_bus(struct pci_bus *b);
 
-extern void pcibios_finish_adding_to_bus(struct pci_bus *bus);
-
 extern void pcibios_resource_survey(void);
 
 struct file;
diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index ae79e8638d50..61494c4379f9 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -1033,30 +1033,6 @@ void pcibios_claim_one_bus(struct pci_bus *bus)
 }
 EXPORT_SYMBOL_GPL(pcibios_claim_one_bus);
 
-
-/* pcibios_finish_adding_to_bus
- *
- * This is to be called by the hotplug code after devices have been
- * added to a bus, this include calling it for a PHB that is just
- * being added
- */
-void pcibios_finish_adding_to_bus(struct pci_bus *bus)
-{
-	pr_debug("PCI: Finishing adding to hotplug bus %04x:%02x\n",
-		 pci_domain_nr(bus), bus->number);
-
-	/* Allocate bus and devices resources */
-	pcibios_allocate_bus_resources(bus);
-	pcibios_claim_one_bus(bus);
-
-	/* Add new devices to global lists.  Register in proc, sysfs. */
-	pci_bus_add_devices(bus);
-
-	/* Fixup EEH */
-	/* eeh_add_device_tree_late(bus); */
-}
-EXPORT_SYMBOL_GPL(pcibios_finish_adding_to_bus);
-
 static void pcibios_setup_phb_resources(struct pci_controller *hose,
 					struct list_head *resources)
 {
