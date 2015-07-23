Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Marc Zyngier <marc.zyngier@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>
Cc: <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Ma Jun <majun258@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Duc Dang <dhdang@apm.com>
Subject: [PATCH v5 06/19] PCI/MSI: of: Allow msi_domain lookup using the host bridge node
Date: Thu, 23 Jul 2015 10:26:25 +0100
Message-Id: <1437643598-19795-7-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1437643598-19795-1-git-send-email-marc.zyngier@arm.com>
References: <1437643598-19795-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A number of platforms do not need to use the msi-parent property,
as the host bridge itself provides the MSI controller.

Allow this configuration by performing an irq domain lookup based
on the host bridge node if it doesn't have a valid msi-parent property.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/pci/of.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index e2ebb7d..fcfdadf 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -69,12 +69,21 @@ struct irq_domain *pci_host_bridge_of_msi_domain(struct pci_bus *bus)
 
 	if (!bus->dev.of_node)
 		return NULL;
+
+	/* Start looking for a phandle to an MSI controller. */
 	np = of_parse_phandle(bus->dev.of_node, "msi-parent", 0);
+
+	/*
+	 * If we don't have an msi-parent property, look for a domain
+	 * directly attached to the host bridge.
+	 */
 	if (!np)
-		return NULL;
+		np = bus->dev.of_node;
+
 	d = irq_find_matching_host(np, DOMAIN_BUS_PCI_MSI);
 	if (!d)
 		d = irq_find_host(np);
+
 	return d;
 #else
 	return NULL;
-- 
2.1.4

