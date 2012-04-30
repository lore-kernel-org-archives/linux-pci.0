Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:57609 "EHLO nbd.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754920Ab2D3Rs1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 30 Apr 2012 13:48:27 -0400
From: John Crispin <blogic@openwrt.org>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: John Crispin <blogic@openwrt.org>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, linux-mips@linux-mips.org
Subject: [PATCH] OF: PCI: const usage needed by MIPS
Date: Mon, 30 Apr 2012 19:46:59 +0200
Message-Id: <1335808019-24502-1-git-send-email-blogic@openwrt.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On MIPS we want to call of_irq_map_pci from inside

arch/mips/include/asm/pci.h:extern int pcibios_map_irq(
				const struct pci_dev *dev, u8 slot, u8 pin);

For this to work we need to change several functions to const usage.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-pci@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org
Cc: linux-mips@linux-mips.org
---
I am not sure which tree this should go via. Grant, can you take it ?

 drivers/of/of_pci_irq.c |    2 +-
 drivers/pci/pci.c       |    2 +-
 include/linux/of_pci.h  |    2 +-
 include/linux/pci.h     |    5 +++--
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/of/of_pci_irq.c b/drivers/of/of_pci_irq.c
index 9312516..6770538 100644
--- a/drivers/of/of_pci_irq.c
+++ b/drivers/of/of_pci_irq.c
@@ -15,7 +15,7 @@
  * PCI tree until an device-node is found, at which point it will finish
  * resolving using the OF tree walking.
  */
-int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq)
+int of_irq_map_pci(const struct pci_dev *pdev, struct of_irq *out_irq)
 {
 	struct device_node *dn, *ppnode;
 	struct pci_dev *ppdev;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d20f133..4c79586 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2363,7 +2363,7 @@ void pci_enable_acs(struct pci_dev *dev)
  * number is always 0 (see the Implementation Note in section 2.2.8.1 of
  * the PCI Express Base Specification, Revision 2.1)
  */
-u8 pci_swizzle_interrupt_pin(struct pci_dev *dev, u8 pin)
+u8 pci_swizzle_interrupt_pin(const struct pci_dev *dev, u8 pin)
 {
 	int slot;
 
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index f93e217..bb115de 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -5,7 +5,7 @@
 
 struct pci_dev;
 struct of_irq;
-int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq);
+int of_irq_map_pci(const struct pci_dev *pdev, struct of_irq *out_irq);
 
 struct device_node;
 struct device_node *of_pci_find_child_device(struct device_node *parent,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e444f5b..3bbc77e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -680,7 +680,7 @@ int __must_check pci_bus_add_device(struct pci_dev *dev);
 void pci_read_bridge_bases(struct pci_bus *child);
 struct resource *pci_find_parent_resource(const struct pci_dev *dev,
 					  struct resource *res);
-u8 pci_swizzle_interrupt_pin(struct pci_dev *dev, u8 pin);
+u8 pci_swizzle_interrupt_pin(const struct pci_dev *dev, u8 pin);
 int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
 u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp);
 extern struct pci_dev *pci_dev_get(struct pci_dev *dev);
@@ -1685,7 +1685,8 @@ extern void pci_release_bus_of_node(struct pci_bus *bus);
 /* Arch may override this (weak) */
 extern struct device_node * __weak pcibios_get_phb_of_node(struct pci_bus *bus);
 
-static inline struct device_node *pci_device_to_OF_node(struct pci_dev *pdev)
+static inline struct device_node *
+pci_device_to_OF_node(const struct pci_dev *pdev)
 {
 	return pdev ? pdev->dev.of_node : NULL;
 }
-- 
1.7.9.1

