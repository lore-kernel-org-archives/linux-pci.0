Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56165 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752748AbbIRVIz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 18 Sep 2015 17:08:55 -0400
Subject: [PATCH] PCI/MSI: Fix MSI IRQ domains for SR-IOV
From: Alex Williamson <alex.williamson@redhat.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, marc.zyngier@arm.com, tglx@linutronix.de,
	linux-kernel@vger.kernel.org
Date: Fri, 18 Sep 2015 15:08:54 -0600
Message-ID: <20150918210648.19363.35694.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SR-IOV creates a virtual bus where bus->self is NULL.  This results
in a segfault as VFs are added and we scan for an MSI domain without
taking that into account.  Detect this and scan up to the parent bus
until we find a real bridge.

Fixes: 44aa0c657e3e ("PCI/MSI: Add hooks to populate the msi_domain field")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/probe.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0b2be17..b42419e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -676,15 +676,20 @@ static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
 static void pci_set_bus_msi_domain(struct pci_bus *bus)
 {
 	struct irq_domain *d;
+	struct pci_bus *b;
 
 	/*
-	 * Either bus is the root, and we must obtain it from the
-	 * firmware, or we inherit it from the bridge device.
+	 * The bus can be a root bus, a subordinate bus, or a virtual bus
+	 * created by an SR-IOV device.  Walk up to the first bridge device
+	 * found or derive the domain from the host bridge.
 	 */
-	if (pci_is_root_bus(bus))
-		d = pci_host_bridge_msi_domain(bus);
-	else
-		d = dev_get_msi_domain(&bus->self->dev);
+	for (b = bus, d = NULL; !d && !pci_is_root_bus(b); b = b->parent) {
+		if (b->self)
+			d = dev_get_msi_domain(&b->self->dev);
+	}
+
+	if (!d)
+		d = pci_host_bridge_msi_domain(b);
 
 	dev_set_msi_domain(&bus->dev, d);
 }

