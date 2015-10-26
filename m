Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from o1.f.az.sendgrid.net ([208.117.55.132]:21781 "EHLO
	o1.f.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038AbbJZXW6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 26 Oct 2015 19:22:58 -0400
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	tglx@linutronix.de, haiyangz@microsoft.com, marc.zyngier@arm.com,
	jiang.liu@linux.intel.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v3 5/7] PCI: irqdomain: Look up IRQ domain by fwnode_handle
Date: Mon, 26 Oct 2015 23:15:37 +0000
Message-Id: <1445901339-11924-6-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1445901339-11924-1-git-send-email-jakeo@microsoft.com>
References: <1445901339-11924-1-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

The existing PCI code looks for an IRQ domain associated with a root PCI bus
by looking in the Open Firmware tree.  This patch introduces a second way
to identify the associated IRQ domain, if the lookup in the OF tree fails.
The handle used for the IRQ domain lookup was introduced in the previous patch
in the series.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 drivers/pci/probe.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c0f2e44..62c9ac7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -664,6 +664,7 @@ static void pci_set_bus_speed(struct pci_bus *bus)
 static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
 {
 	struct irq_domain *d;
+	struct pci_host_bridge *host_bridge;
 
 	/*
 	 * Any firmware interface that can resolve the msi_domain
@@ -671,6 +672,18 @@ static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
 	 */
 	d = pci_host_bridge_of_msi_domain(bus);
 
+	/*
+	 * If no IRQ domain was found via the OF tree, try looking it up
+	 * directly through the fwnode_handle.
+	 */
+	if (!d) {
+		host_bridge = to_pci_host_bridge(bus->bridge);
+		if (host_bridge->fwnode) {
+			d = irq_find_matching_fwnode(host_bridge->fwnode,
+						     DOMAIN_BUS_ANY);
+		}
+	}
+
 	return d;
 }
 
-- 
1.9.1

