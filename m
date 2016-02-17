Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:46003 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965114AbcBQDp6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Feb 2016 22:45:58 -0500
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 17 Feb 2016 13:45:56 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
	dja@axtens.net, bhelgaas@google.com, robherring2@gmail.com,
	grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v8 32/45] powerpc/pci: Update bridge windows on PCI plug
Date: Wed, 17 Feb 2016 14:44:15 +1100
Message-Id: <1455680668-23298-33-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On the PCI plugging event, PCI slot's subordinate devices are
scanned and their (IO and MMIO) resources are assigned. Platform
dependent resources (PE#, IO/MMIO/DMA windows) are allocated or
created on updating windows of the slot's upstream bridge.

This updates the windows of the hot plugged slot's upstream bridge
in pcibios_finish_adding_to_bus() so that the platform resources
(PE#, IO/MMIO/DMA segments) are allocated or created accordingly.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/pci-common.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 40df3a5..be9e515 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1444,8 +1444,12 @@ void pcibios_finish_adding_to_bus(struct pci_bus *bus)
 	/* Allocate bus and devices resources */
 	pcibios_allocate_bus_resources(bus);
 	pcibios_claim_one_bus(bus);
-	if (!pci_has_flag(PCI_PROBE_ONLY))
-		pci_assign_unassigned_bus_resources(bus);
+	if (!pci_has_flag(PCI_PROBE_ONLY)) {
+		if (bus->self)
+			pci_assign_unassigned_bridge_resources(bus->self);
+		else
+			pci_assign_unassigned_bus_resources(bus);
+	}
 
 	/* Fixup EEH */
 	eeh_add_device_tree_late(bus);
-- 
2.1.0

