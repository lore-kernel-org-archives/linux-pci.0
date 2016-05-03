Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([125.16.236.4]:33109 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933398AbcECNds (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2016 09:33:48 -0400
Received: from localhost
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Tue, 3 May 2016 18:53:36 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
	bhelgaas@google.com, robherring2@gmail.com, dja@axtens.net,
	alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v9 11/22] powerpc/pci: Update bridge windows on PCI plug
Date: Tue,  3 May 2016 23:22:42 +1000
Message-Id: <1462281773-26438-12-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
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

