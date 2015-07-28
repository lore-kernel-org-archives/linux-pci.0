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
	Duc Dang <dhdang@apm.com>, Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v6 06/19] PCI/MSI: of: Allow msi_domain lookup using the host bridge node
Date: Tue, 28 Jul 2015 14:46:13 +0100
Message-Id: <1438091186-10244-7-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1438091186-10244-1-git-send-email-marc.zyngier@arm.com>
References: <1438091186-10244-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A number of platforms do not need to use the msi-parent property,
as the host bridge itself provides the MSI controller.

Allow this configuration by performing an irq domain lookup based
on the host bridge node if it doesn't have a valid msi-parent property.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/pci/of.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 85844d8..2e99a50 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -72,8 +72,13 @@ struct irq_domain *pci_host_bridge_of_msi_domain(struct pci_bus *bus)
 
 	/* Start looking for a phandle to an MSI controller. */
 	np = of_parse_phandle(bus->dev.of_node, "msi-parent", 0);
+
+	/*
+	 * If we don't have an msi-parent property, look for a domain
+	 * directly attached to the host bridge.
+	 */
 	if (!np)
-		return NULL;
+		np = bus->dev.of_node;
 
 	d = irq_find_matching_host(np, DOMAIN_BUS_PCI_MSI);
 	if (d)
-- 
2.1.4

