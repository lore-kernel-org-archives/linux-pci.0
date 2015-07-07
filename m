Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36952 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932401AbbGGRSa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 7 Jul 2015 13:18:30 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>
Cc: <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Ma Jun <majun258@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v3 05/15] PCI/MSI: of: Add support for OF-provided msi_domain
Date: Tue,  7 Jul 2015 18:17:55 +0100
Message-Id: <1436289485-28230-6-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1436289485-28230-1-git-send-email-marc.zyngier@arm.com>
References: <1436289485-28230-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In order to populate the PHB msi_domain, use the "msi-parent"
attribute to lookup a corresponding irq domain. If found,
this is our MSI domain.

This gets plugged into the core PCI code.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/pci/of.c    | 19 +++++++++++++++++++
 drivers/pci/probe.c |  1 +
 include/linux/pci.h |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index f092993..09df465 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -9,6 +9,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/of.h>
@@ -59,3 +60,21 @@ struct device_node * __weak pcibios_get_phb_of_node(struct pci_bus *bus)
 		return of_node_get(bus->bridge->parent->of_node);
 	return NULL;
 }
+
+void pci_set_phb_of_msi_domain(struct pci_bus *bus)
+{
+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+	struct device_node *np;
+	struct irq_domain *d;
+
+	if (!bus->dev.of_node)
+		return;
+	np = of_parse_phandle(bus->dev.of_node, "msi-parent", 0);
+	if (!np)
+		return;
+	d = irq_find_matching_host(np, DOMAIN_BUS_PCI_MSI);
+	if (!d)
+		d = irq_find_host(np);
+	dev_set_msi_domain(&bus->dev, d);
+#endif
+}
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 376f6fa..c80626f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -663,6 +663,7 @@ static void pci_set_bus_speed(struct pci_bus *bus)
 
 void __weak pcibios_set_host_bridge_msi_domain(struct pci_bus *bus)
 {
+	pci_set_phb_of_msi_domain(bus);
 }
 
 static void pci_set_bus_msi_domain(struct pci_bus *bus)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3622453..ee3cdba 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1847,6 +1847,7 @@ void pci_set_of_node(struct pci_dev *dev);
 void pci_release_of_node(struct pci_dev *dev);
 void pci_set_bus_of_node(struct pci_bus *bus);
 void pci_release_bus_of_node(struct pci_bus *bus);
+void pci_set_phb_of_msi_domain(struct pci_bus *bus);
 
 /* Arch may override this (weak) */
 struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus);
@@ -1869,6 +1870,7 @@ static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
 static inline void pci_release_bus_of_node(struct pci_bus *bus) { }
 static inline struct device_node *
 pci_device_to_OF_node(const struct pci_dev *pdev) { return NULL; }
+static inline void pci_set_phb_of_msi_domain(struct pci_bus *bus) { }
 #endif  /* CONFIG_OF */
 
 #ifdef CONFIG_EEH
-- 
2.1.4

