Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137]:35685 "EHLO e7.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754040Ab2FYDLC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 24 Jun 2012 23:11:02 -0400
Received: from /spool/local
	by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Sun, 24 Jun 2012 23:11:01 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 24D576E804C
	for <linux-pci@vger.kernel.org>; Sun, 24 Jun 2012 23:10:32 -0400 (EDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q5P3AVXt207596
	for <linux-pci@vger.kernel.org>; Sun, 24 Jun 2012 23:10:31 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q5P3AUcM017947
	for <linux-pci@vger.kernel.org>; Sun, 24 Jun 2012 21:10:31 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: bhelgaas@google.com, benh@kernel.crashing.org,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH V3 1/2] PCI: retrieve host bridge by PCI bus
Date: Mon, 25 Jun 2012 11:10:19 +0800
Message-Id: <1340593821-19011-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

With current implementation, there is one function to retrieve
the corresponding host bridge (struct pci_host_bridge) according
to the given PCI device (struct pci_dev) and that function has
been declared as "static". Further, we don't have the public
function to retrieve host bridge from PCI bus yet. The function
is useful somewhere.

The additional information like minimal resource alignment for I/O
and MMIO bars of p2p bridges will be put into the PCI host bridge.
The patch introduces the public function pci_bus_host_bridge() to
retrieve the corresponding PCI host bridge according to the specified
PCI bus, then accessing the information regarding the minimal resource
alignment for I/O and MMIO bars of p2p bridges.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
Reviewed-by: Ram Pai <linuxram@us.ibm.com>
Reviewed-by: Richard Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/pci/host-bridge.c |   13 +++++++++++++
 include/linux/pci.h       |    2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index a68dc61..b95f0ce 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -27,6 +27,19 @@ static struct pci_host_bridge *find_pci_host_bridge(struct pci_dev *dev)
 	return to_pci_host_bridge(bus->bridge);
 }
 
+struct pci_host_bridge *pci_bus_host_bridge(struct pci_bus *bus)
+{
+	struct pci_bus *b = bus;
+
+	/* Find the PCI root bus */
+	while (b->parent)
+		b = b->parent;
+
+	return to_pci_host_bridge(b->bridge);
+}
+
+EXPORT_SYMBOL(pci_bus_host_bridge);
+
 void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 				 void (*release_fn)(struct pci_host_bridge *),
 				 void *release_data)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index fefb4e1..6d5bb1c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -656,7 +656,7 @@ void pcibios_update_irq(struct pci_dev *, int irq);
 void pci_fixup_cardbus(struct pci_bus *);
 
 /* Generic PCI functions used internally */
-
+struct pci_host_bridge *pci_bus_host_bridge(struct pci_bus *bus);
 void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
 			     struct resource *res);
 void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
-- 
1.7.9.5

