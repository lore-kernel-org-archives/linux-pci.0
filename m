Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e24smtp03.br.ibm.com ([32.104.18.24]:54879 "EHLO
	e24smtp03.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307AbcCJSMP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2016 13:12:15 -0500
Received: from localhost
	by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gpiccoli@linux.vnet.ibm.com>;
	Thu, 10 Mar 2016 15:12:13 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
	by d24dlp02.br.ibm.com (Postfix) with ESMTP id A2D9F1DC0072
	for <linux-pci@vger.kernel.org>; Thu, 10 Mar 2016 13:12:05 -0500 (EST)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
	by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u2AHBgjo11469140
	for <linux-pci@vger.kernel.org>; Thu, 10 Mar 2016 14:11:42 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
	by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u2AIC90r029550
	for <linux-pci@vger.kernel.org>; Thu, 10 Mar 2016 13:12:10 -0500
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, mpe@ellerman.id.au,
	benh@kernel.crashing.org, paulus@samba.org, imunsie@au1.ibm.com,
	mikey@neuling.org, andrew.donnellan@au1.ibm.com,
	gwshan@linux.vnet.ibm.com, bhelgaas@google.com,
	gpiccoli@linux.vnet.ibm.com
Subject: [PATCH] powerpc/pci: Reuse PHB number on pci_controller add if available
Date: Thu, 10 Mar 2016 15:11:45 -0300
Message-Id: <1457633505-19857-2-git-send-email-gpiccoli@linux.vnet.ibm.com>
In-Reply-To: <1457633505-19857-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1457633505-19857-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The domain/PHB field of PCI addresses has its value obtained from a
global variable, incremented each time a new domain (represented by
struct pci_controller) is added on the system. The domain addition
process happens during boot or due to PCI device hotplug.

As recent kernels are using predictable naming for network interfaces,
the network stack is more tied to PCI naming. This can be a problem in
hotplug scenarios, because PCI addresses will change if a device is
removed and then re-added. This situation seems unusual, but it can
happen if a user wants to replace a NIC without rebooting the machine,
for example.

This patch changes the way PCI domain values are generated: the global
variable is no longer used; instead, a list is introduced, containing
a flag that indicates whenever a domain is in use or was released, for
example by a PCI hotplug remove. If the new PHB being added finds a
free domain, it will use its number; otherwise a new number is
generated incrementing the higher domain value present on the system.
No functional changes were introduced.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/pci-common.c | 47 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 0f7a60f..6eac0dd 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -44,8 +44,12 @@
 static DEFINE_SPINLOCK(hose_spinlock);
 LIST_HEAD(hose_list);
 
-/* XXX kill that some day ... */
-static int global_phb_number;		/* Global phb counter */
+/* Global PHB counter list */
+struct global_phb_number {
+	bool used;
+	struct list_head node;
+};
+LIST_HEAD(global_phb_number_list);
 
 /* ISA Memory physical address */
 resource_size_t isa_mem_base;
@@ -64,6 +68,42 @@ struct dma_map_ops *get_pci_dma_ops(void)
 }
 EXPORT_SYMBOL(get_pci_dma_ops);
 
+static int get_phb_number(void)
+{
+	struct global_phb_number *ptr;
+	int latest_number = 0;
+
+	list_for_each_entry(ptr, &global_phb_number_list, node) {
+		if (!ptr->used) {
+			ptr->used = true;
+			return latest_number;
+		}
+		latest_number++;
+	}
+
+	ptr = zalloc_maybe_bootmem(sizeof(struct global_phb_number), GFP_KERNEL);
+	BUG_ON(ptr == NULL);
+
+	ptr->used = true;
+	list_add_tail(&ptr->node, &global_phb_number_list);
+
+	return latest_number;
+}
+
+static void release_phb_number(int phb_number)
+{
+	struct global_phb_number *ptr;
+	int current_number = 0;
+
+	list_for_each_entry(ptr, &global_phb_number_list, node) {
+		if (current_number == phb_number) {
+			ptr->used = false;
+			return;
+		}
+		current_number++;
+	}
+}
+
 struct pci_controller *pcibios_alloc_controller(struct device_node *dev)
 {
 	struct pci_controller *phb;
@@ -72,7 +112,7 @@ struct pci_controller *pcibios_alloc_controller(struct device_node *dev)
 	if (phb == NULL)
 		return NULL;
 	spin_lock(&hose_spinlock);
-	phb->global_number = global_phb_number++;
+	phb->global_number = get_phb_number();
 	list_add_tail(&phb->list_node, &hose_list);
 	spin_unlock(&hose_spinlock);
 	phb->dn = dev;
@@ -94,6 +134,7 @@ EXPORT_SYMBOL_GPL(pcibios_alloc_controller);
 void pcibios_free_controller(struct pci_controller *phb)
 {
 	spin_lock(&hose_spinlock);
+	release_phb_number(phb->global_number);
 	list_del(&phb->list_node);
 	spin_unlock(&hose_spinlock);
 
-- 
2.1.0

