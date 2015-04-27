Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:53970 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579AbbD0Gi5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Apr 2015 02:38:57 -0400
Received: from /spool/local
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Mon, 27 Apr 2015 16:38:55 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id EC303357804F
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2015 16:38:52 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t3R6ciCi28835850
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2015 16:38:52 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t3R6cJLK028925
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2015 16:38:19 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, benh@kernel.crashing.org,
	bhelgaas@google.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v3 01/21] pci: Add pcibios_setup_bridge()
Date: Mon, 27 Apr 2015 16:37:33 +1000
Message-Id: <1430116673-22500-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1430116673-22500-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1430116673-22500-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently, PowerPC PowerNV platform utilizes ppc_md.pcibios_fixup(),
which is called for once after PCI probing and resource assignment
are completed, to allocate platform required resources for PCI devices:
PE#, IO and MMIO mapping, DMA address translation (TCE) table etc.
Obviously, it's not hotplug friendly.

The patch adds weak function pcibios_setup_bridge(), which is called
by pci_setup_bridge(). PowerPC PowerNV platform will reuse the function
to assign above platform required resources to newly added PCI devices,
in order to support PCI hotplug on PowerPC PowerNV platform.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/pci/setup-bus.c | 12 +++++++++---
 include/linux/pci.h     |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 4fd0cac..a7d0c3c 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -674,7 +674,8 @@ static void pci_setup_bridge_mmio_pref(struct pci_dev *bridge)
 	pci_write_config_dword(bridge, PCI_PREF_LIMIT_UPPER32, lu);
 }
 
-static void __pci_setup_bridge(struct pci_bus *bus, unsigned long type)
+
+void pci_setup_bridge_resources(struct pci_bus *bus, unsigned long type)
 {
 	struct pci_dev *bridge = bus->self;
 
@@ -693,12 +694,17 @@ static void __pci_setup_bridge(struct pci_bus *bus, unsigned long type)
 	pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, bus->bridge_ctl);
 }
 
+void __weak pcibios_setup_bridge(struct pci_bus *bus, unsigned long type)
+{
+	pci_setup_bridge_resources(bus, type);
+}
+
 void pci_setup_bridge(struct pci_bus *bus)
 {
 	unsigned long type = IORESOURCE_IO | IORESOURCE_MEM |
 				  IORESOURCE_PREFETCH;
 
-	__pci_setup_bridge(bus, type);
+	pcibios_setup_bridge(bus, type);
 }
 
 
@@ -1467,7 +1473,7 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 		/* avoiding touch the one without PREF */
 		if (type & IORESOURCE_PREFETCH)
 			type = IORESOURCE_PREFETCH;
-		__pci_setup_bridge(bus, type);
+		pci_setup_bridge_resources(bus, type);
 		/* for next child res under same bridge */
 		r->flags = old_flags;
 	}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 353db8d..68c5ef9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1175,6 +1175,7 @@ void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
 		  void *userdata);
 int pci_cfg_space_size(struct pci_dev *dev);
 unsigned char pci_bus_max_busnr(struct pci_bus *bus);
+void pci_setup_bridge_resources(struct pci_bus *bus, unsigned long type);
 void pci_setup_bridge(struct pci_bus *bus);
 resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 					 unsigned long type);
-- 
2.1.0

