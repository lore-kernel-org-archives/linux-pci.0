Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from up.free-electrons.com ([94.23.35.102]:53503 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754381Ab3HANZ3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Aug 2013 09:25:29 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCHv6 07/13] irqdomain: add function to find a MSI irq_domain
Date: Thu,  1 Aug 2013 15:25:10 +0200
Message-Id: <1375363516-2620-8-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1375363516-2620-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375363516-2620-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now that an irq_domain can be associated to a msi_chip structure, a
given PCIe driver will want to find this irq_domain, based on the
Device Tree node of the interrupt controller, as pointed by the
'msi-controller' DT property.

However, since on those platforms a single piece of hardware,
represented by a single DT node can provide both a "normal" IRQ domain
and a MSI-type IRQ domain, we need separate lookup functions to
distinguish them.

This patch makes irq_find_host() find only non-MSI-type IRQ domains,
and introduces irq_find_msi_host() to find only MSI-type IRQ
domains. It does so by factorizing the irq_find_host() logic into
__irq_find_host().

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 include/linux/irqdomain.h | 21 ++++++++++++++++++++-
 kernel/irq/irqdomain.c    | 13 ++++++++++---
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index b0504ff..fc669b4 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -129,7 +129,8 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
 					 irq_hw_number_t first_hwirq,
 					 const struct irq_domain_ops *ops,
 					 void *host_data);
-extern struct irq_domain *irq_find_host(struct device_node *node);
+struct irq_domain *__irq_find_host(struct device_node *node,
+				   bool findmsi);
 extern void irq_set_default_host(struct irq_domain *host);
 
 /**
@@ -196,6 +197,24 @@ static inline struct irq_domain *irq_domain_add_msi(struct device_node *of_node,
 }
 
 
+/**
+ * irq_find_host() - Locates a domain for a given device node
+ * @node: device-tree node of the interrupt controller
+ */
+static inline struct irq_domain *irq_find_host(struct device_node *node)
+{
+	return __irq_find_host(node, false);
+}
+
+/**
+ * irq_find_msi_host() - Locates a MSI domain for a given device node
+ * @node: device-tree node of the interrupt controller
+ */
+static inline struct irq_domain *irq_find_msi_host(struct device_node *node)
+{
+	return __irq_find_host(node, true);
+}
+
 extern void irq_domain_remove(struct irq_domain *host);
 
 extern int irq_domain_associate(struct irq_domain *domain, unsigned int irq,
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 8d02af7..6d066e2 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -197,10 +197,14 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
 EXPORT_SYMBOL_GPL(irq_domain_add_legacy);
 
 /**
- * irq_find_host() - Locates a domain for a given device node
+ * __irq_find_host() - Locates a domain for a given device node,
+ * taking into account whether the domain is of MSI-type or not.
  * @node: device-tree node of the interrupt controller
+ * @findmsi: true when the domain being search is of MSI-type, false
+ * otherwise.
  */
-struct irq_domain *irq_find_host(struct device_node *node)
+struct irq_domain *__irq_find_host(struct device_node *node,
+				   bool findmsi)
 {
 	struct irq_domain *h, *found = NULL;
 	int rc;
@@ -212,6 +216,9 @@ struct irq_domain *irq_find_host(struct device_node *node)
 	 */
 	mutex_lock(&irq_domain_mutex);
 	list_for_each_entry(h, &irq_domain_list, link) {
+		if ((findmsi && !h->msi_chip) ||
+		    (!findmsi && h->msi_chip))
+			continue;
 		if (h->ops->match)
 			rc = h->ops->match(h, node);
 		else
@@ -225,7 +232,7 @@ struct irq_domain *irq_find_host(struct device_node *node)
 	mutex_unlock(&irq_domain_mutex);
 	return found;
 }
-EXPORT_SYMBOL_GPL(irq_find_host);
+EXPORT_SYMBOL_GPL(__irq_find_host);
 
 /**
  * irq_set_default_host() - Set a "default" irq domain
-- 
1.8.1.2

