Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:51837 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965451AbbKDNOI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2015 08:14:08 -0500
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 4 Nov 2015 23:14:06 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
	bhelgaas@google.com, grant.likely@linaro.org,
	robherring2@gmail.com, panto@antoniou-consulting.com,
	frowand.list@gmail.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 28/50] powerpc/pci: Rename pcibios_{add,remove}_pci_devices()
Date: Thu,  5 Nov 2015 00:12:28 +1100
Message-Id: <1446642770-4681-29-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This renames pcibios_{add,remove}_pci_devices() to avoid conflicts
with names of the weak functions in PCI subsystem, which have the
prefix "pcibios". No logical changes introduced.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h |  4 ++--
 arch/powerpc/kernel/eeh_driver.c      | 12 ++++++------
 arch/powerpc/kernel/pci-hotplug.c     | 15 +++++++--------
 drivers/pci/hotplug/rpadlpar_core.c   |  2 +-
 drivers/pci/hotplug/rpaphp_core.c     |  4 ++--
 drivers/pci/hotplug/rpaphp_pci.c      |  2 +-
 6 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 0f2ff3a..c2360c8 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -260,10 +260,10 @@ static inline struct eeh_dev *pdn_to_eeh_dev(struct pci_dn *pdn)
 extern struct pci_bus *pcibios_find_pci_bus(struct device_node *dn);
 
 /** Remove all of the PCI devices under this bus */
-extern void pcibios_remove_pci_devices(struct pci_bus *bus);
+extern void pci_remove_pci_devices(struct pci_bus *bus);
 
 /** Discover new pci devices under this bus, and add them */
-extern void pcibios_add_pci_devices(struct pci_bus *bus);
+extern void pci_add_pci_devices(struct pci_bus *bus);
 
 
 extern void isa_bridge_find_early(struct pci_controller *hose);
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 80dfe89..f884aa7 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -560,12 +560,12 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 	 * We don't remove the corresponding PE instances because
 	 * we need the information afterwords. The attached EEH
 	 * devices are expected to be attached soon when calling
-	 * into pcibios_add_pci_devices().
+	 * into pci_add_pci_devices().
 	 */
 	eeh_pe_state_mark(pe, EEH_PE_KEEP);
 	if (bus) {
 		pci_lock_rescan_remove();
-		pcibios_remove_pci_devices(bus);
+		pci_remove_pci_devices(bus);
 		pci_unlock_rescan_remove();
 	} else if (frozen_bus) {
 		eeh_pe_dev_traverse(pe, eeh_rmv_device, &removed);
@@ -617,13 +617,13 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 		 * rebuilt when adding PCI devices.
 		 */
 		eeh_pe_traverse(pe, eeh_pe_detach_dev, NULL);
-		pcibios_add_pci_devices(bus);
+		pci_add_pci_devices(bus);
 	} else if (frozen_bus && removed) {
 		pr_info("EEH: Sleep 5s ahead of partial hotplug\n");
 		ssleep(5);
 
 		eeh_pe_traverse(pe, eeh_pe_detach_dev, NULL);
-		pcibios_add_pci_devices(frozen_bus);
+		pci_add_pci_devices(frozen_bus);
 	}
 	eeh_pe_state_clear(pe, EEH_PE_KEEP);
 
@@ -812,7 +812,7 @@ perm_error:
 		eeh_pe_dev_mode_mark(pe, EEH_DEV_REMOVED);
 
 		pci_lock_rescan_remove();
-		pcibios_remove_pci_devices(frozen_bus);
+		pci_remove_pci_devices(frozen_bus);
 		pci_unlock_rescan_remove();
 	}
 }
@@ -895,7 +895,7 @@ static void eeh_handle_special_event(void)
 				bus = eeh_pe_bus_get(phb_pe);
 				eeh_pe_dev_traverse(pe,
 					eeh_report_failure, NULL);
-				pcibios_remove_pci_devices(bus);
+				pci_remove_pci_devices(bus);
 			}
 			pci_unlock_rescan_remove();
 		}
diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 7f9ed0c..3f62821 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -38,20 +38,20 @@ void pcibios_release_device(struct pci_dev *dev)
 }
 
 /**
- * pcibios_remove_pci_devices - remove all devices under this bus
+ * pci_remove_pci_devices - remove all devices under this bus
  * @bus: the indicated PCI bus
  *
  * Remove all of the PCI devices under this bus both from the
  * linux pci device tree, and from the powerpc EEH address cache.
  */
-void pcibios_remove_pci_devices(struct pci_bus *bus)
+void pci_remove_pci_devices(struct pci_bus *bus)
 {
 	struct pci_dev *dev, *tmp;
 	struct pci_bus *child_bus;
 
 	/* First go down child busses */
 	list_for_each_entry(child_bus, &bus->children, node)
-		pcibios_remove_pci_devices(child_bus);
+		pci_remove_pci_devices(child_bus);
 
 	pr_debug("PCI: Removing devices on bus %04x:%02x\n",
 		 pci_domain_nr(bus),  bus->number);
@@ -60,11 +60,10 @@ void pcibios_remove_pci_devices(struct pci_bus *bus)
 		pci_stop_and_remove_bus_device(dev);
 	}
 }
-
-EXPORT_SYMBOL_GPL(pcibios_remove_pci_devices);
+EXPORT_SYMBOL_GPL(pci_remove_pci_devices);
 
 /**
- * pcibios_add_pci_devices - adds new pci devices to bus
+ * pci_add_pci_devices - adds new pci devices to bus
  * @bus: the indicated PCI bus
  *
  * This routine will find and fixup new pci devices under
@@ -74,7 +73,7 @@ EXPORT_SYMBOL_GPL(pcibios_remove_pci_devices);
  * is how this routine differs from other, similar pcibios
  * routines.)
  */
-void pcibios_add_pci_devices(struct pci_bus * bus)
+void pci_add_pci_devices(struct pci_bus *bus)
 {
 	int slotno, mode, pass, max;
 	struct pci_dev *dev;
@@ -114,4 +113,4 @@ void pcibios_add_pci_devices(struct pci_bus * bus)
 	}
 	pcibios_finish_adding_to_bus(bus);
 }
-EXPORT_SYMBOL_GPL(pcibios_add_pci_devices);
+EXPORT_SYMBOL_GPL(pci_add_pci_devices);
diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index e12bafd..ebd283b 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -381,7 +381,7 @@ int dlpar_remove_pci_slot(char *drc_name, struct device_node *dn)
 	}
 
 	/* Remove all devices below slot */
-	pcibios_remove_pci_devices(bus);
+	pci_remove_pci_devices(bus);
 
 	/* Unmap PCI IO space */
 	if (pcibios_unmap_io_space(bus)) {
diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index f2945fa..3034693 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -405,7 +405,7 @@ static int enable_slot(struct hotplug_slot *hotplug_slot)
 
 	if (state == PRESENT) {
 		pci_lock_rescan_remove();
-		pcibios_add_pci_devices(slot->bus);
+		pci_add_pci_devices(slot->bus);
 		pci_unlock_rescan_remove();
 		slot->state = CONFIGURED;
 	} else if (state == EMPTY) {
@@ -427,7 +427,7 @@ static int disable_slot(struct hotplug_slot *hotplug_slot)
 		return -EINVAL;
 
 	pci_lock_rescan_remove();
-	pcibios_remove_pci_devices(slot->bus);
+	pci_remove_pci_devices(slot->bus);
 	pci_unlock_rescan_remove();
 	vm_unmap_aliases();
 
diff --git a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
index 9243f3e7..256066c 100644
--- a/drivers/pci/hotplug/rpaphp_pci.c
+++ b/drivers/pci/hotplug/rpaphp_pci.c
@@ -116,7 +116,7 @@ int rpaphp_enable_slot(struct slot *slot)
 		}
 
 		if (list_empty(&bus->devices))
-			pcibios_add_pci_devices(bus);
+			pci_add_pci_devices(bus);
 
 		if (!list_empty(&bus->devices)) {
 			info->adapter_status = CONFIGURED;
-- 
2.1.0

