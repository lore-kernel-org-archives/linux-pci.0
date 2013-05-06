Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:42047 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753697Ab3EFNoh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 6 May 2013 09:44:37 -0400
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Mon, 6 May 2013 09:44:36 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 9ACA26E803C
	for <linux-pci@vger.kernel.org>; Mon,  6 May 2013 09:44:31 -0400 (EDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r46DiRQB58720440
	for <linux-pci@vger.kernel.org>; Mon, 6 May 2013 09:44:28 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r46DiOCw011365
	for <linux-pci@vger.kernel.org>; Mon, 6 May 2013 07:44:26 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Cc: benh@kernel.crashing.org, yinghai@kernel.org, bhelgaas@google.com,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 2/3] powerpc/powernv: Disable IO space for PCI buses
Date: Mon,  6 May 2013 21:44:17 +0800
Message-Id: <1367847858-6506-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1367847858-6506-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1367847858-6506-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch intends to set the special flag (PCI_BUS_FLAGS_NO_IO) for
root buses so PCI core will skip assignment for IO stuff. Besides,
we also clear the IO resources on all PCI devices for PHB3.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h        |    3 ++
 arch/powerpc/kernel/pci-common.c          |    7 +++++
 arch/powerpc/platforms/powernv/pci-ioda.c |   38 +++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 3f3f691..ebc2ffd 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -220,6 +220,9 @@ struct machdep_calls {
 	/* Called during PCI resource reassignment */
 	resource_size_t (*pcibios_window_alignment)(struct pci_bus *, unsigned long type);
 
+	/* Called when adding PCI bus */
+	void (*pcibios_add_bus)(struct pci_bus *);
+
 	/* Called to shutdown machine specific hardware not already controlled
 	 * by other drivers.
 	 */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index f325dc9..7b8a6f1 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -120,6 +120,13 @@ resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 	return 1;
 }
 
+/* The function will be called while adding PCI bus to system */
+void pcibios_add_bus(struct pci_bus *bus)
+{
+	if (ppc_md.pcibios_add_bus)
+		ppc_md.pcibios_add_bus(bus);
+}
+
 static resource_size_t pcibios_io_size(const struct pci_controller *hose)
 {
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 8c6c9cf..0c3fa29 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1015,6 +1015,40 @@ static resource_size_t pnv_pci_window_alignment(struct pci_bus *bus,
 	return phb->ioda.io_segsize;
 }
 
+/*
+ * The function will be called while adding PCI bus to the
+ * system. In turn, we should set flag to indicate that the
+ * root bus doesn't have IO resources.
+ */
+static void pnv_pci_add_bus(struct pci_bus *bus)
+{
+	struct pci_controller *hose = pci_bus_to_host(bus);
+	struct pnv_phb *phb = hose->private_data;
+
+	/*
+	 * We only need set the flag for root bus since the
+	 * bus flags are copied over from parent to children
+	 */
+	if (pci_is_root_bus(bus) &&
+	    phb->model == PNV_PHB_MODEL_PHB3)
+		bus->bus_flags |= PCI_BUS_FLAGS_NO_IO;
+}
+
+static void pnv_pci_fixup_resources(struct pci_dev *dev)
+{
+	int i;
+	struct resource *res;
+
+	if (!(dev->bus->bus_flags & PCI_BUS_FLAGS_NO_IO))
+		return;
+
+	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+		res = dev->resource + i;
+		if (res->flags & IORESOURCE_IO)
+			res->flags = 0;
+	}
+}
+
 /* Prevent enabling devices for which we couldn't properly
  * assign a PE
  */
@@ -1189,6 +1223,10 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np, int ioda_type)
 	ppc_md.pcibios_fixup = pnv_pci_ioda_fixup;
 	ppc_md.pcibios_enable_device_hook = pnv_pci_enable_device_hook;
 	ppc_md.pcibios_window_alignment = pnv_pci_window_alignment;
+	if (ioda_type == PNV_PHB_IODA2) {
+		ppc_md.pcibios_add_bus = pnv_pci_add_bus;
+		ppc_md.pcibios_fixup_resources = pnv_pci_fixup_resources;
+	}
 	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
 
 	/* Reset IODA tables to a clean state */
-- 
1.7.5.4

