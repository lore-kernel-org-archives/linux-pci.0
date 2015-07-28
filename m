Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59085 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932363AbbG1Nqo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 28 Jul 2015 09:46:44 -0400
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
Subject: [PATCH v6 05/19] PCI/MSI: of: Add support for OF-provided msi_domain
Date: Tue, 28 Jul 2015 14:46:12 +0100
Message-Id: <1438091186-10244-6-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1438091186-10244-1-git-send-email-marc.zyngier@arm.com>
References: <1438091186-10244-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In order to populate the PCI host bridge msi_domain, use the
"msi-parent" attribute to lookup a corresponding irq domain.
If found, this is our MSI domain.

This gets plugged into the core PCI code.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/pci/of.c    | 25 +++++++++++++++++++++++++
 drivers/pci/probe.c |  5 ++++-
 include/linux/pci.h |  4 ++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index f092993..85844d8 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -9,6 +9,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/of.h>
@@ -59,3 +60,27 @@ struct device_node * __weak pcibios_get_phb_of_node(struct pci_bus *bus)
 		return of_node_get(bus->bridge->parent->of_node);
 	return NULL;
 }
+
+struct irq_domain *pci_host_bridge_of_msi_domain(struct pci_bus *bus)
+{
+#ifdef CONFIG_IRQ_DOMAIN
+	struct device_node *np;
+	struct irq_domain *d;
+
+	if (!bus->dev.of_node)
+		return NULL;
+
+	/* Start looking for a phandle to an MSI controller. */
+	np = of_parse_phandle(bus->dev.of_node, "msi-parent", 0);
+	if (!np)
+		return NULL;
+
+	d = irq_find_matching_host(np, DOMAIN_BUS_PCI_MSI);
+	if (d)
+		return d;
+
+	return irq_find_host(np);
+#else
+	return NULL;
+#endif
+}
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c03ecbf..a7afeac 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -663,12 +663,15 @@ static void pci_set_bus_speed(struct pci_bus *bus)
 
 static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
 {
+	struct irq_domain *d;
+
 	/*
 	 * Any firmware interface that can resolve the msi_domain
 	 * should be called from here.
 	 */
+	d = pci_host_bridge_of_msi_domain(bus);
 
-	return NULL;
+	return d;
 }
 
 static void pci_set_bus_msi_domain(struct pci_bus *bus)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index fbf245f..772616d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1841,10 +1841,12 @@ int pci_vpd_find_info_keyword(const u8 *buf, unsigned int off,
 /* PCI <-> OF binding helpers */
 #ifdef CONFIG_OF
 struct device_node;
+struct irq_domain;
 void pci_set_of_node(struct pci_dev *dev);
 void pci_release_of_node(struct pci_dev *dev);
 void pci_set_bus_of_node(struct pci_bus *bus);
 void pci_release_bus_of_node(struct pci_bus *bus);
+struct irq_domain *pci_host_bridge_of_msi_domain(struct pci_bus *bus);
 
 /* Arch may override this (weak) */
 struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus);
@@ -1867,6 +1869,8 @@ static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
 static inline void pci_release_bus_of_node(struct pci_bus *bus) { }
 static inline struct device_node *
 pci_device_to_OF_node(const struct pci_dev *pdev) { return NULL; }
+static inline struct irq_domain *
+pci_host_bridge_of_msi_domain(struct pci_bus *bus) { return NULL; }
 #endif  /* CONFIG_OF */
 
 #ifdef CONFIG_EEH
-- 
2.1.4

