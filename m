Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:45848 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965409AbbKDNOm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2015 08:14:42 -0500
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 4 Nov 2015 18:44:40 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
	bhelgaas@google.com, grant.likely@linaro.org,
	robherring2@gmail.com, panto@antoniou-consulting.com,
	frowand.list@gmail.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 32/50] powerpc/pci: Introduce pci_remove_device_node_info()
Date: Thu,  5 Nov 2015 00:12:32 +1100
Message-Id: <1446642770-4681-33-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
index 7e0c67d..b8ce4f4 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -237,6 +237,7 @@ extern struct pci_dn *add_dev_pci_data(struct pci_dev *pdev);
 extern void remove_dev_pci_data(struct pci_dev *pdev);
 extern struct pci_dn *pci_add_device_node_info(struct pci_controller *hose,
 					       struct device_node *dn);
+extern void pci_remove_device_node_info(struct device_node *dn);
 
 static inline int pci_device_from_OF_node(struct device_node *np,
 					  u8 *bus, u8 *devfn)
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index 36ae515..7f877a4 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -314,6 +314,29 @@ struct pci_dn *pci_add_device_node_info(struct pci_controller *hose,
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

