Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:63792 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755843AbaEHUtE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 May 2014 16:49:04 -0400
Received: by mail-ig0-f182.google.com with SMTP id uy17so305263igb.15
        for <linux-pci@vger.kernel.org>; Thu, 08 May 2014 13:49:04 -0700 (PDT)
Subject: [PATCH v3 3/4] sh/PCI: Pass GAPSPCI_DMA_BASE CPU & bus address to
 dma_declare_coherent_memory()
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joerg Roedel <joro@8bytes.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	linux-kernel@vger.kernel.org,
	James Bottomley <jbottomley@parallels.com>,
	Magnus Damm <damm@opensource.se>, linux-pci@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>
Date: Thu, 08 May 2014 14:49:07 -0600
Message-ID: <20140508204907.17877.4848.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140508204257.17877.4639.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140508204257.17877.4639.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

dma_declare_coherent_memory() needs both the CPU physical address and the
bus address of the device memory.  They are the same on this platform, but
in general we should use pcibios_resource_to_bus() to account for any
address translation done by the PCI host bridge.

This makes no difference on Dreamcast, but is safer if the usage is copied
to future drivers.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
CC: Magnus Damm <damm@opensource.se>
CC: linux-sh@vger.kernel.org
---
 arch/sh/drivers/pci/fixups-dreamcast.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/sh/drivers/pci/fixups-dreamcast.c b/arch/sh/drivers/pci/fixups-dreamcast.c
index d6cde700e316..f22127f966ce 100644
--- a/arch/sh/drivers/pci/fixups-dreamcast.c
+++ b/arch/sh/drivers/pci/fixups-dreamcast.c
@@ -31,6 +31,8 @@
 static void gapspci_fixup_resources(struct pci_dev *dev)
 {
 	struct pci_channel *p = dev->sysdata;
+	struct resource res;
+	struct pci_bus_region region;
 
 	printk(KERN_NOTICE "PCI: Fixing up device %s\n", pci_name(dev));
 
@@ -50,11 +52,21 @@ static void gapspci_fixup_resources(struct pci_dev *dev)
 
 		/*
 		 * Redirect dma memory allocations to special memory window.
+		 *
+		 * If this GAPSPCI region were mapped by a BAR, the CPU
+		 * phys_addr_t would be pci_resource_start(), and the bus
+		 * address would be pci_bus_address(pci_resource_start()).
+		 * But apparently there's no BAR mapping it, so we just
+		 * "know" its CPU address is GAPSPCI_DMA_BASE.
 		 */
+		res.start = GAPSPCI_DMA_BASE;
+		res.end = GAPSPCI_DMA_BASE + GAPSPCI_DMA_SIZE - 1;
+		res.flags = IORESOURCE_MEM;
+		pcibios_resource_to_bus(dev, &region, &resource);
 		BUG_ON(!dma_declare_coherent_memory(&dev->dev,
-						GAPSPCI_DMA_BASE,
-						GAPSPCI_DMA_BASE,
-						GAPSPCI_DMA_SIZE,
+						res.start,
+						region.start,
+						resource_size(&res),
 						DMA_MEMORY_MAP |
 						DMA_MEMORY_EXCLUSIVE));
 		break;

