Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:42053 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481AbbFDGnl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2015 02:43:41 -0400
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 4 Jun 2015 16:43:39 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
	panto@antoniou-consulting.com, robherring2@gmail.com,
	grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v5 35/42] powerpc/pci: Create eeh_dev while creating pci_dn
Date: Thu,  4 Jun 2015 16:42:04 +1000
Message-Id: <1433400131-18429-36-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The eeh_dev is always created based on pci_dn, but with initcall
core_initcall_sync(). The patch creates eeh_dev when pci_dn is
created, indicating they have same life cycle.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v5:
  * Derived from PATCH[v4 16/21]
---
 arch/powerpc/include/asm/eeh.h         |  6 ++++--
 arch/powerpc/kernel/eeh_dev.c          | 18 ++++--------------
 arch/powerpc/kernel/pci_dn.c           | 12 ++++++++++++
 arch/powerpc/platforms/pseries/setup.c |  6 +-----
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index ea1f13c4..c0236a6 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -272,7 +272,8 @@ void eeh_pe_restore_bars(struct eeh_pe *pe);
 const char *eeh_pe_loc_get(struct eeh_pe *pe);
 struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe);
 
-void *eeh_dev_init(struct pci_dn *pdn, void *data);
+struct eeh_dev *eeh_dev_init(struct pci_dn *pdn,
+			     struct pci_controller *phb);
 void eeh_dev_phb_init_dynamic(struct pci_controller *phb);
 int eeh_init(void);
 int __init eeh_ops_register(struct eeh_ops *ops);
@@ -325,7 +326,8 @@ static inline int eeh_init(void)
 	return 0;
 }
 
-static inline void *eeh_dev_init(struct pci_dn *pdn, void *data)
+static inline struct eeh_dev *eeh_dev_init(struct pci_dn *pdn,
+					   struct pci_controller *phb)
 {
 	return NULL;
 }
diff --git a/arch/powerpc/kernel/eeh_dev.c b/arch/powerpc/kernel/eeh_dev.c
index f33ce5b..7486932 100644
--- a/arch/powerpc/kernel/eeh_dev.c
+++ b/arch/powerpc/kernel/eeh_dev.c
@@ -44,14 +44,14 @@
 /**
  * eeh_dev_init - Create EEH device according to OF node
  * @pdn: PCI device node
- * @data: PHB
+ * @phb: PCI controller
  *
  * It will create EEH device according to the given OF node. The function
  * might be called by PCI emunation, DR, PHB hotplug.
  */
-void *eeh_dev_init(struct pci_dn *pdn, void *data)
+struct eeh_dev *eeh_dev_init(struct pci_dn *pdn,
+			     struct pci_controller *phb)
 {
-	struct pci_controller *phb = data;
 	struct eeh_dev *edev;
 
 	/* Allocate EEH device */
@@ -68,7 +68,7 @@ void *eeh_dev_init(struct pci_dn *pdn, void *data)
 	edev->phb = phb;
 	INIT_LIST_HEAD(&edev->list);
 
-	return NULL;
+	return edev;
 }
 
 /**
@@ -80,16 +80,8 @@ void *eeh_dev_init(struct pci_dn *pdn, void *data)
  */
 void eeh_dev_phb_init_dynamic(struct pci_controller *phb)
 {
-	struct pci_dn *root = phb->pci_data;
-
 	/* EEH PE for PHB */
 	eeh_phb_pe_create(phb);
-
-	/* EEH device for PHB */
-	eeh_dev_init(root, phb);
-
-	/* EEH devices for children OF nodes */
-	traverse_pci_dn(root, eeh_dev_init, phb);
 }
 
 /**
@@ -105,8 +97,6 @@ static int __init eeh_dev_phb_init(void)
 	list_for_each_entry_safe(phb, tmp, &hose_list, list_node)
 		eeh_dev_phb_init_dynamic(phb);
 
-	pr_info("EEH: devices created\n");
-
 	return 0;
 }
 
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index 35554c2..d4330d2 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -287,6 +287,9 @@ void *update_dn_pci_info(struct device_node *dn, void *data)
 	const __be32 *regs;
 	struct device_node *parent;
 	struct pci_dn *pdn;
+#ifdef CONFIG_EEH
+	struct eeh_dev *edev;
+#endif
 
 	pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
 	if (pdn == NULL)
@@ -317,6 +320,15 @@ void *update_dn_pci_info(struct device_node *dn, void *data)
 	/* Extended config space */
 	pdn->pci_ext_config_space = (type && of_read_number(type, 1) == 1);
 
+	/* Initialize EEH device */
+#ifdef CONFIG_EEH
+	edev = eeh_dev_init(pdn, phb);
+	if (!edev) {
+		kfree(pdn);
+		return NULL;
+	}
+#endif
+
 	/* Attach to parent node */
 	INIT_LIST_HEAD(&pdn->child_list);
 	INIT_LIST_HEAD(&pdn->list);
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 5f80758..92974aa 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -261,12 +261,8 @@ static int pci_dn_reconfig_notifier(struct notifier_block *nb, unsigned long act
 	switch (action) {
 	case OF_RECONFIG_ATTACH_NODE:
 		pci = np->parent->data;
-		if (pci) {
+		if (pci)
 			update_dn_pci_info(np, pci->phb);
-
-			/* Create EEH device for the OF node */
-			eeh_dev_init(PCI_DN(np), pci->phb);
-		}
 		break;
 	default:
 		err = NOTIFY_DONE;
-- 
2.1.0

