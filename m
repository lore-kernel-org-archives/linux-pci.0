Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:35606 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbbFDVuI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2015 17:50:08 -0400
Received: by obbgp2 with SMTP id gp2so19790004obb.2
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2015 14:50:07 -0700 (PDT)
Received: from localhost (172-9-203-140.lightspeed.spfdmo.sbcglobal.net. [172.9.203.140])
        by mx.google.com with ESMTPSA id l5sm2183176oey.5.2015.06.04.14.50.06
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Jun 2015 14:50:06 -0700 (PDT)
Subject: [PATCH 6/7] PCI: Remove unused pcibios_select_root() (again)
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 04 Jun 2015 16:50:05 -0500
Message-ID: <20150604215005.2399.4144.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150604214614.2399.5142.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150604214614.2399.5142.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

a6c140969b46 ("Delete pcibios_select_root") removed pcibios_select_root().
But a7db50405216 ("PCI: remove pcibios_scan_all_fns()") added a few copies
back, probably with some incorrect merge conflict resolutions.

Remove the still-unused pcibios_select_root() definitions.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/ia64/include/asm/pci.h       |   13 -------------
 arch/microblaze/include/asm/pci.h |   13 -------------
 arch/mn10300/include/asm/pci.h    |   13 -------------
 include/asm-generic/pci.h         |   13 -------------
 4 files changed, 52 deletions(-)

diff --git a/arch/ia64/include/asm/pci.h b/arch/ia64/include/asm/pci.h
index 52af5ed..32ea19a 100644
--- a/arch/ia64/include/asm/pci.h
+++ b/arch/ia64/include/asm/pci.h
@@ -108,19 +108,6 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 	return (pci_domain_nr(bus) != 0);
 }
 
-static inline struct resource *
-pcibios_select_root(struct pci_dev *pdev, struct resource *res)
-{
-	struct resource *root = NULL;
-
-	if (res->flags & IORESOURCE_IO)
-		root = &ioport_resource;
-	if (res->flags & IORESOURCE_MEM)
-		root = &iomem_resource;
-
-	return root;
-}
-
 #define HAVE_ARCH_PCI_GET_LEGACY_IDE_IRQ
 static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 {
diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
index 67224d3..e910a29 100644
--- a/arch/microblaze/include/asm/pci.h
+++ b/arch/microblaze/include/asm/pci.h
@@ -81,19 +81,6 @@ extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
  */
 #define PCI_DMA_BUS_IS_PHYS     (1)
 
-static inline struct resource *pcibios_select_root(struct pci_dev *pdev,
-			struct resource *res)
-{
-	struct resource *root = NULL;
-
-	if (res->flags & IORESOURCE_IO)
-		root = &ioport_resource;
-	if (res->flags & IORESOURCE_MEM)
-		root = &iomem_resource;
-
-	return root;
-}
-
 extern void pcibios_claim_one_bus(struct pci_bus *b);
 
 extern void pcibios_finish_adding_to_bus(struct pci_bus *bus);
diff --git a/arch/mn10300/include/asm/pci.h b/arch/mn10300/include/asm/pci.h
index 5f70af2..c222d17 100644
--- a/arch/mn10300/include/asm/pci.h
+++ b/arch/mn10300/include/asm/pci.h
@@ -83,19 +83,6 @@ extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 /* implement the pci_ DMA API in terms of the generic device dma_ one */
 #include <asm-generic/pci-dma-compat.h>
 
-static inline struct resource *
-pcibios_select_root(struct pci_dev *pdev, struct resource *res)
-{
-	struct resource *root = NULL;
-
-	if (res->flags & IORESOURCE_IO)
-		root = &ioport_resource;
-	if (res->flags & IORESOURCE_MEM)
-		root = &iomem_resource;
-
-	return root;
-}
-
 static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 {
 	return channel ? 15 : 14;
diff --git a/include/asm-generic/pci.h b/include/asm-generic/pci.h
index e80a049..f24bc51 100644
--- a/include/asm-generic/pci.h
+++ b/include/asm-generic/pci.h
@@ -6,19 +6,6 @@
 #ifndef _ASM_GENERIC_PCI_H
 #define _ASM_GENERIC_PCI_H
 
-static inline struct resource *
-pcibios_select_root(struct pci_dev *pdev, struct resource *res)
-{
-	struct resource *root = NULL;
-
-	if (res->flags & IORESOURCE_IO)
-		root = &ioport_resource;
-	if (res->flags & IORESOURCE_MEM)
-		root = &iomem_resource;
-
-	return root;
-}
-
 #ifndef HAVE_ARCH_PCI_GET_LEGACY_IDE_IRQ
 static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 {

