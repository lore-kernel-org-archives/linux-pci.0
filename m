Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:51335 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756097Ab2HTNtb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Aug 2012 09:49:31 -0400
Received: from /spool/local
	by e5.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Mon, 20 Aug 2012 09:49:27 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id D76E26E8044
	for <linux-pci@vger.kernel.org>; Mon, 20 Aug 2012 09:49:10 -0400 (EDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q7KDn5eu156774
	for <linux-pci@vger.kernel.org>; Mon, 20 Aug 2012 09:49:10 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q7KDko9F005198
	for <linux-pci@vger.kernel.org>; Mon, 20 Aug 2012 07:46:58 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, benh@kernel.crashing.org,
	weiyang@linux.vnet.ibm.com, linuxram@us.ibm.com,
	yinghai@kernel.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 8/8] ppc/pnv: I/O and memory alignment for p2p bridges
Date: Mon, 20 Aug 2012 21:46:35 +0800
Message-Id: <1345470395-17295-9-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1345470395-17295-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1345470395-17295-1-git-send-email-shangw@linux.vnet.ibm.com>
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
 arch/powerpc/platforms/powernv/pci-ioda.c |   38 +++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 9cda6a1..af6b7fb 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1139,6 +1139,43 @@ static void __devinit pnv_pci_ioda_fixup_phb(struct pci_controller *hose)
 	}
 }
 
+/*
+ * Returns the alignment for I/O or memory windows for p2p
+ * bridges. That actually depends on how PEs are segmented.
+ * For now, we return I/O or M32 segment size for PE sensitive
+ * p2p bridges. Otherwise, the default values (4KiB for I/O,
+ * 1MiB for memory) will be returned.
+ */
+static resource_size_t pnv_pci_window_alignment(struct pci_bus *bus,
+						unsigned long type)
+{
+	struct pci_dev *dev = bus->self;
+	struct pci_controller *hose = pci_bus_to_host(bus);
+	struct pnv_phb *phb = hose->private_data;
+
+	/* PCI root bus will be assigned with segment size */
+	if (!dev)
+		goto out;
+
+	/*
+	 * If the parent bridge is PCI bridge, we will return
+	 * the default values
+	 */
+	dev = dev->bus->self;
+	if (!dev)
+		goto out;
+	if (dev->pcie_type == PCI_EXP_TYPE_PCI_BRIDGE) {
+		return 1;
+	}
+
+out:
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
@@ -1306,6 +1343,7 @@ void __init pnv_pci_init_ioda1_phb(struct device_node *np)
 	 */
 	ppc_md.pcibios_fixup_phb = pnv_pci_ioda_fixup_phb;
 	ppc_md.pcibios_enable_device_hook = pnv_pci_enable_device_hook;
+	ppc_md.pcibios_window_alignment = pnv_pci_window_alignment;
 	pci_add_flags(PCI_PROBE_ONLY | PCI_REASSIGN_ALL_RSRC);
 
 	/* Reset IODA tables to a clean state */
-- 
1.7.5.4

