Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:55211 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495AbbFDGpT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2015 02:45:19 -0400
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 4 Jun 2015 16:45:17 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
	panto@antoniou-consulting.com, robherring2@gmail.com,
	grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v5 37/42] powerpc/pci: Update bridge windows on PCI plugging
Date: Thu,  4 Jun 2015 16:42:06 +1000
Message-Id: <1433400131-18429-38-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

During the PCI plugging event, the PCI devices are rescanned and
their IO and MMIO resources are reassigned. However, the PowerNV
platform will assign PE# based on that, which depends on updating
to window of bridge of the PE's primary bus.

The patch updates the windows of bridge of PE's primary bus if
we have valid bridge. Otherwise, we assume it's root bus or SRIOV
virtual bus and PE won't be assigned during PCI plugging time.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v5:
  * Derived from PATCH[v4 18/21]
---
 arch/powerpc/kernel/pci-common.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 0358f24..811eb4d 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1471,8 +1471,12 @@ void pcibios_finish_adding_to_bus(struct pci_bus *bus)
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

