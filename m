Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:41082 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932067AbbD0GjU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Apr 2015 02:39:20 -0400
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Mon, 27 Apr 2015 16:39:18 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 19CE42CE805C
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2015 16:39:17 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t3R6d8CA38535192
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2015 16:39:16 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t3R6cgIe013059
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2015 16:38:43 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, benh@kernel.crashing.org,
	bhelgaas@google.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v3 19/21] powerpc/pci: Update bridge windows on PCI plugging
Date: Mon, 27 Apr 2015 16:37:51 +1000
Message-Id: <1430116673-22500-20-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1430116673-22500-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1430116673-22500-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
 arch/powerpc/kernel/pci-common.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 01d2a84..cb0bb3f 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1473,8 +1473,12 @@ void pcibios_finish_adding_to_bus(struct pci_bus *bus)
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

