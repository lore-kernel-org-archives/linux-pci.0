Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34704 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282AbbFDT5L (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2015 15:57:11 -0400
Received: by oifu123 with SMTP id u123so38896430oif.1
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2015 12:57:10 -0700 (PDT)
Subject: [PATCH] microblaze/PCI: Remove unused declarations
To: Michal Simek <monstr@monstr.eu>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Thu, 04 Jun 2015 14:57:06 -0500
Message-ID: <20150604195706.17951.85004.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The following declarations were copied from powerpc but are unused on
microblaze:

  struct pci_controller *init_phb_dynamic(struct device_node *dn)
  int remove_phb_dynamic(struct pci_controller *phb)
  struct pci_dev *of_create_pci_dev(struct device_node *node, ...)
  void of_scan_pci_bridge(struct device_node *node, ...)
  void of_scan_bus(struct device_node *node, struct pci_bus *bus)
  void of_rescan_bus(struct device_node *node, struct pci_bus *bus)

Remove them.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/microblaze/include/asm/pci.h |   12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
index 468aca8..b6b5b3c 100644
--- a/arch/microblaze/include/asm/pci.h
+++ b/arch/microblaze/include/asm/pci.h
@@ -102,18 +102,6 @@ extern void pcibios_finish_adding_to_bus(struct pci_bus *bus);
 
 extern void pcibios_resource_survey(void);
 
-extern struct pci_controller *init_phb_dynamic(struct device_node *dn);
-extern int remove_phb_dynamic(struct pci_controller *phb);
-
-extern struct pci_dev *of_create_pci_dev(struct device_node *node,
-					struct pci_bus *bus, int devfn);
-
-extern void of_scan_pci_bridge(struct device_node *node,
-				struct pci_dev *dev);
-
-extern void of_scan_bus(struct device_node *node, struct pci_bus *bus);
-extern void of_rescan_bus(struct device_node *node, struct pci_bus *bus);
-
 extern int pci_bus_find_capability(struct pci_bus *bus,
 						unsigned int devfn, int cap);
 

