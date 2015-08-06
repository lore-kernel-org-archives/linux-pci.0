Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:44558 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754081AbbHFENk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Aug 2015 00:13:40 -0400
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 6 Aug 2015 14:13:38 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
	grant.likely@linaro.org, robherring2@gmail.com,
	panto@antoniou-consulting.com, aik@ozlabs.ru,
	Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v6 35/42] powerpc/pci: Export traverse_pci_device_nodes()
Date: Thu,  6 Aug 2015 14:11:40 +1000
Message-Id: <1438834307-26960-36-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Previously we wouldn't remove pdn because PCI hotplug isn't
supported. update_dn_pci_info() is called at system booting
time to create pdn for PCI device nodes. However, it's going
to be changed later because of PCI hotplug.

This converts update_dn_pci_info() to add_pci_device_node_info(),
traverse_pci_devices() to traverse_pci_device_nodes(). This also
adds remove_pci_device_node_info() which will be used in subsequent
patch at the moment of unplugging PCI devices. All those functions
are exported for PowerNV hotplug driver to use.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h  |  4 ++-
 arch/powerpc/include/asm/ppc-pci.h     |  8 ++++--
 arch/powerpc/kernel/pci_dn.c           | 51 +++++++++++++++++++++++++++++-----
 arch/powerpc/platforms/pseries/setup.c |  2 +-
 4 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 787a879..010eb54 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -237,7 +237,9 @@ extern struct pci_dn *pci_get_pdn_by_devfn(struct pci_bus *bus,
 extern struct pci_dn *pci_get_pdn(struct pci_dev *pdev);
 extern struct pci_dn *add_dev_pci_data(struct pci_dev *pdev);
 extern void remove_dev_pci_data(struct pci_dev *pdev);
-extern void *update_dn_pci_info(struct device_node *dn, void *data);
+extern void *add_pci_device_node_info(struct device_node *dn,
+				      struct pci_controller *phb);
+extern void remove_pci_device_node_info(struct device_node *np);
 
 static inline int pci_device_from_OF_node(struct device_node *np,
 					  u8 *bus, u8 *devfn)
diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index 916775d..c87ed42 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -33,9 +33,11 @@ extern struct pci_dev *isa_bridge_pcidev;	/* may be NULL if no ISA bus */
 struct device_node;
 struct pci_dn;
 
-typedef void *(*traverse_func)(struct device_node *me, void *data);
-void *traverse_pci_devices(struct device_node *start, traverse_func pre,
-		void *data);
+typedef void *(*traverse_func)(struct device_node *me,
+			       struct pci_controller *phb);
+void *traverse_pci_device_nodes(struct device_node *start,
+				traverse_func pre,
+				struct pci_controller *phb);
 void *traverse_pci_dn(struct pci_dn *root,
 		      void *(*fn)(struct pci_dn *, void *),
 		      void *data);
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index 53a11e9..3a38a55 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -283,9 +283,9 @@ void remove_dev_pci_data(struct pci_dev *pdev)
  * Traverse_func that inits the PCI fields of the device node.
  * NOTE: this *must* be done before read/write config to the device.
  */
-void *update_dn_pci_info(struct device_node *dn, void *data)
+void *add_pci_device_node_info(struct device_node *dn,
+			       struct pci_controller *phb)
 {
-	struct pci_controller *phb = data;
 	const __be32 *type = of_get_property(dn, "ibm,pci-config-space-type", NULL);
 	const __be32 *regs;
 	struct device_node *parent;
@@ -342,6 +342,42 @@ void *update_dn_pci_info(struct device_node *dn, void *data)
 
 	return NULL;
 }
+EXPORT_SYMBOL(add_pci_device_node_info);
+
+/**
+ * remove_pci_device_node_info - Remove pci_dn from PCI device node
+ * @dn: PCI device node
+ *
+ * Remove pci_dn from PCI device node. The pci_dn is also removed
+ * from the child list of the parent pci_dn.
+ */
+void remove_pci_device_node_info(struct device_node *np)
+{
+	struct pci_dn *pdn = np ? PCI_DN(np) : NULL;
+#ifdef CONFIG_EEH
+	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
+#endif
+
+	if (!pdn)
+		return;
+
+#ifdef CONFIG_EEH
+	if (edev) {
+		pdn->edev = NULL;
+		kfree(edev);
+	}
+#endif
+
+	BUG_ON(!list_empty(&pdn->child_list));
+	list_del(&pdn->list);
+	if (pdn->parent)
+		of_node_put(pdn->parent->node);
+
+	np->data = NULL;
+	kfree(pdn);
+}
+EXPORT_SYMBOL(remove_pci_device_node_info);
+
 
 /*
  * Traverse a device tree stopping each PCI device in the tree.
@@ -361,8 +397,8 @@ void *update_dn_pci_info(struct device_node *dn, void *data)
  * one of these nodes we also assume its siblings are non-pci for
  * performance.
  */
-void *traverse_pci_devices(struct device_node *start, traverse_func pre,
-		void *data)
+void *traverse_pci_device_nodes(struct device_node *start, traverse_func pre,
+				struct pci_controller *phb)
 {
 	struct device_node *dn, *nextdn;
 	void *ret;
@@ -377,7 +413,7 @@ void *traverse_pci_devices(struct device_node *start, traverse_func pre,
 		if (classp)
 			class = of_read_number(classp, 1);
 
-		if (pre && ((ret = pre(dn, data)) != NULL))
+		if (pre && ((ret = pre(dn, phb)) != NULL))
 			return ret;
 
 		/* If we are a PCI bridge, go down */
@@ -400,6 +436,7 @@ void *traverse_pci_devices(struct device_node *start, traverse_func pre,
 	}
 	return NULL;
 }
+EXPORT_SYMBOL(traverse_pci_device_nodes);
 
 static struct pci_dn *pci_dn_next_one(struct pci_dn *root,
 				      struct pci_dn *pdn)
@@ -455,7 +492,7 @@ void pci_devs_phb_init_dynamic(struct pci_controller *phb)
 	struct pci_dn *pdn;
 
 	/* PHB nodes themselves must not match */
-	update_dn_pci_info(dn, phb);
+	add_pci_device_node_info(dn, phb);
 	pdn = dn->data;
 	if (pdn) {
 		pdn->devfn = pdn->busno = -1;
@@ -465,7 +502,7 @@ void pci_devs_phb_init_dynamic(struct pci_controller *phb)
 	}
 
 	/* Update dn->phb ptrs for new phb and children devices */
-	traverse_pci_devices(dn, update_dn_pci_info, phb);
+	traverse_pci_device_nodes(dn, add_pci_device_node_info, phb);
 }
 
 /** 
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 92974aa..ed8c894 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -262,7 +262,7 @@ static int pci_dn_reconfig_notifier(struct notifier_block *nb, unsigned long act
 	case OF_RECONFIG_ATTACH_NODE:
 		pci = np->parent->data;
 		if (pci)
-			update_dn_pci_info(np, pci->phb);
+			add_pci_device_node_info(np, pci->phb);
 		break;
 	default:
 		err = NOTIFY_DONE;
-- 
2.1.0

