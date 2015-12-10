Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from o1.f.az.sendgrid.net ([208.117.55.132]:39078 "EHLO
	o1.f.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792AbbLJR4u (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Dec 2015 12:56:50 -0500
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	tglx@linutronix.de, haiyangz@microsoft.com, marc.zyngier@arm.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v10 5/7] PCI: irqdomain: Look up IRQ domain by fwnode_handle
Date: Thu, 10 Dec 2015 17:53:01 +0000
Message-Id: <1449769983-12948-6-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1449769983-12948-1-git-send-email-jakeo@microsoft.com>
References: <1449769983-12948-1-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

This patch adds a second way of finding an IRQ domain associated with
a root PCI bus.  After looking to see if one can be found through
the OF tree, it attempts to look up the IRQ domain through an
fwnode_handle stored in the pci_sysdata struct.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 drivers/pci/probe.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 750f907..c6369dd 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -674,6 +674,20 @@ static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
 	 */
 	d = pci_host_bridge_of_msi_domain(bus);
 
+#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
+	/*
+	 * If no IRQ domain was found via the OF tree, try looking it up
+	 * directly through the fwnode_handle.
+	 */
+	if (!d) {
+		struct fwnode_handle *fwnode = pci_root_bus_fwnode(bus);
+
+		if (fwnode)
+			d = irq_find_matching_fwnode(fwnode,
+						     DOMAIN_BUS_PCI_MSI);
+	}
+#endif
+
 	return d;
 }
 
-- 
1.9.1

