Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:56252 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646Ab2IGFA5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Sep 2012 01:00:57 -0400
Received: from /spool/local
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Thu, 6 Sep 2012 23:00:56 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com [9.17.195.228])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 785823E40039
	for <linux-pci@vger.kernel.org>; Thu,  6 Sep 2012 23:00:52 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q8750nD0185448
	for <linux-pci@vger.kernel.org>; Thu, 6 Sep 2012 23:00:49 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q8750mX0005854
	for <linux-pci@vger.kernel.org>; Thu, 6 Sep 2012 23:00:49 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, benh@kernel.crashing.org,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 5/5] ppc/pnv: I/O and memory alignment for p2p bridges
Date: Fri,  7 Sep 2012 13:00:35 +0800
Message-Id: <1346994035-16218-6-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1346994035-16218-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1346994035-16218-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch implements ppc_md.pcibios_window_alignment for powernv
platform so that the resource reassignment in PCI core will be
done according to the I/O and memory alignment returned from
powernv platform. The alignments returned from powernv platform
is closely depending on the scheme for PE segmenting. Besides,
the patch isn't useful for now, but the subsequent patches will
be working based on it.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   39 +++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 9cda6a1..f5479fe 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1139,6 +1139,44 @@ static void __devinit pnv_pci_ioda_fixup_phb(struct pci_controller *hose)
 	}
 }
 
+/*
+ * Returns the alignment for I/O or memory windows for p2p
+ * bridges. That actually depends on how PEs are segmented.
+ * For now, we return I/O or M32 segment size for PE sensitive
+ * p2p bridges. Otherwise, the default values (4KiB for I/O,
+ * 1MiB for memory) will be returned.
+ *
+ * The current PCI bus might be put into one PE, which was
+ * create againt the parent PCI bridge. For that case, we
+ * needn't enlarge the alignment so that we can save some
+ * resources.
+ */
+static resource_size_t pnv_pci_window_alignment(struct pci_bus *bus,
+						unsigned long type)
+{
+	struct pci_dev *bridge;
+	struct pci_controller *hose = pci_bus_to_host(bus);
+	struct pnv_phb *phb = hose->private_data;
+	int num_pci_bridges = 0;
+
+	bridge = bus->self;
+	while (bridge) {
+		if (bridge->pcie_type == PCI_EXP_TYPE_PCI_BRIDGE) {
+			num_pci_bridges++;
+			if (num_pci_bridges >= 2)
+				return 1;
+		}
+
+		bridge = bridge->bus->self;
+	}
+
+	/* We need support prefetchable memory window later */
+	if (type & IORESOURCE_MEM)
+		return phb->ioda.m32_segsize;
+
+	return phb->ioda.io_segsize;
+}
+
 /* Prevent enabling devices for which we couldn't properly
  * assign a PE
  */
@@ -1306,6 +1344,7 @@ void __init pnv_pci_init_ioda1_phb(struct device_node *np)
 	 */
 	ppc_md.pcibios_fixup_phb = pnv_pci_ioda_fixup_phb;
 	ppc_md.pcibios_enable_device_hook = pnv_pci_enable_device_hook;
+	ppc_md.pcibios_window_alignment = pnv_pci_window_alignment;
 	pci_add_flags(PCI_PROBE_ONLY | PCI_REASSIGN_ALL_RSRC);
 
 	/* Reset IODA tables to a clean state */
-- 
1.7.5.4

