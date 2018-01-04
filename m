Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:39374 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752617AbeADVMV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jan 2018 16:12:21 -0500
From: Rob Herring <robh@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frank Rowand <frowand.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: [PATCH 3/3] PCI: make of_irq_parse_pci static
Date: Thu,  4 Jan 2018 15:12:15 -0600
Message-Id: <20180104211215.11344-4-robh@kernel.org>
In-Reply-To: <20180104211215.11344-1-robh@kernel.org>
References: <20180104211215.11344-1-robh@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now that the DT PCI code is merged into drivers/pci, of_irq_parse_pci can
be static.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/of.c       | 3 +--
 include/linux/of_pci.h | 6 ------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 859a43dd098d..511a5ec83f6e 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -479,7 +479,7 @@ int of_pci_map_rid(struct device_node *np, u32 rid,
  * PCI tree until an device-node is found, at which point it will finish
  * resolving using the OF tree walking.
  */
-int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq)
+static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq)
 {
 	struct device_node *dn, *ppnode;
 	struct pci_dev *ppdev;
@@ -569,7 +569,6 @@ int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq
 	}
 	return rc;
 }
-EXPORT_SYMBOL_GPL(of_irq_parse_pci);
 
 /**
  * of_irq_parse_and_map_pci() - Decode a PCI irq from the device tree and map to a virq
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index f0e129e848ea..88865e0ebf4d 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -10,7 +10,6 @@ struct of_phandle_args;
 struct device_node;
 
 #if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_PCI)
-int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq);
 struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn);
 int of_pci_get_devfn(struct device_node *np);
@@ -23,11 +22,6 @@ int of_pci_map_rid(struct device_node *np, u32 rid,
 		   const char *map_name, const char *map_mask_name,
 		   struct device_node **target, u32 *id_out);
 #else
-static inline int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq)
-{
-	return 0;
-}
-
 static inline struct device_node *of_pci_find_child_device(struct device_node *parent,
 					     unsigned int devfn)
 {
-- 
2.14.1
