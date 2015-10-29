Return-Path: <linux-kernel-owner@vger.kernel.org>
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	tglx@redhat.com, haiyangz@microsoft.com, marc.zyngier@arm.com,
	jiang.liu@linux.intel.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v4 5/7] PCI: irqdomain: Look up IRQ domain by fwnode_handle
Date: Thu, 29 Oct 2015 23:46:14 +0000
Message-Id: <1446162376-43419-6-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1446162376-43419-1-git-send-email-jakeo@microsoft.com>
References: <1446162376-43419-1-git-send-email-jakeo@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

This patch adds a second way of finding an IRQ domain associated with
a root PCI bus.  After looking to see if one can be found through
the OF tree, it attempts to look up the IRQ domain through an
fwnode_handle stored in the pci_sysdata struct.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 drivers/pci/probe.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f441d1b..3d5d7d6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -671,6 +671,19 @@ static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
 	 */
 	d = pci_host_bridge_of_msi_domain(bus);
 
+#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
+	/*
+	 * If no IRQ domain was found via the OF tree, try looking it up
+	 * directly through the fwnode_handle.
+	 */
+	if (!d) {
+		if (pci_fwnode(bus)) {
+			d = irq_find_matching_fwnode(pci_fwnode(bus),
+						     DOMAIN_BUS_PCI_MSI);
+		}
+	}
+#endif
+
 	return d;
 }
 
-- 
1.9.1

