Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:59690 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965147AbcBQDqA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Feb 2016 22:46:00 -0500
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 17 Feb 2016 13:45:58 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
	dja@axtens.net, bhelgaas@google.com, robherring2@gmail.com,
	grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v8 28/45] powerpc/pci: Introduce pci_remove_device_node_info()
Date: Wed, 17 Feb 2016 14:44:11 +1100
Message-Id: <1455680668-23298-29-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This implements and exports pci_remove_device_node_info(). It's
used to remove the pdn (struct pci_dn) for the indicated device
node. The function is going to be used by PowerNV PCI hotplug
driver.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h |  1 +
 arch/powerpc/kernel/pci_dn.c          | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 72a9d4e..c6310e2 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -240,6 +240,7 @@ extern struct pci_dn *add_dev_pci_data(struct pci_dev *pdev);
 extern void remove_dev_pci_data(struct pci_dev *pdev);
 extern struct pci_dn *pci_add_device_node_info(struct pci_controller *hose,
 					       struct device_node *dn);
+extern void pci_remove_device_node_info(struct device_node *dn);
 
 static inline int pci_device_from_OF_node(struct device_node *np,
 					  u8 *bus, u8 *devfn)
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index 0a249ff..ce10281 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -331,6 +331,29 @@ struct pci_dn *pci_add_device_node_info(struct pci_controller *hose,
 }
 EXPORT_SYMBOL_GPL(pci_add_device_node_info);
 
+void pci_remove_device_node_info(struct device_node *dn)
+{
+	struct pci_dn *pdn = dn ? PCI_DN(dn) : NULL;
+#ifdef CONFIG_EEH
+	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
+
+	if (edev)
+		edev->pdn = NULL;
+#endif
+
+	if (!pdn)
+		return;
+
+	WARN_ON(!list_empty(&pdn->child_list));
+	list_del(&pdn->list);
+	if (pdn->parent)
+		of_node_put(pdn->parent->node);
+
+	dn->data = NULL;
+	kfree(pdn);
+}
+EXPORT_SYMBOL_GPL(pci_remove_device_node_info);
+
 /*
  * Traverse a device tree stopping each PCI device in the tree.
  * This is done depth first.  As each node is processed, a "pre"
-- 
2.1.0

