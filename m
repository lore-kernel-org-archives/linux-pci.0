Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from o1.f.az.sendgrid.net ([208.117.55.132]:35083 "EHLO
	o1.f.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbbIKAJo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2015 20:09:44 -0400
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	linux-pci@vger.kernel.org, bhelgaas@google.com, tglx@linutronix.de
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v2 02/12] kernel:irq: Change signature of irq_find_matching_host()
Date: Fri, 11 Sep 2015 00:01:01 +0000
Message-Id: <1441929670-10058-3-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1441929670-10058-1-git-send-email-jakeo@microsoft.com>
References: <1441929670-10058-1-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

In order to use the facility introduced in the last patch (the ability to
match on both bus type and something that identifies the specific bus of that
type,) irq_find_matching_host() needs to take that bus-specific parameter.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c      | 2 +-
 drivers/irqchip/irq-gic-v3-its-platform-msi.c | 2 +-
 drivers/of/irq.c                              | 2 +-
 drivers/pci/of.c                              | 2 +-
 include/linux/irqdomain.h                     | 5 +++--
 kernel/irq/irqdomain.c                        | 6 ++++--
 6 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index cf351c6..51521b5 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -118,7 +118,7 @@ static int __init its_pci_msi_init(void)
 		if (!of_property_read_bool(np, "msi-controller"))
 			continue;
 
-		parent = irq_find_matching_host(np, DOMAIN_BUS_NEXUS);
+		parent = irq_find_matching_host(np, DOMAIN_BUS_NEXUS, NULL);
 		if (!parent || !msi_get_domain_info(parent)) {
 			pr_err("%s: unable to locate ITS domain\n",
 			       np->full_name);
diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
index a865505..5a3ac02 100644
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -71,7 +71,7 @@ static int __init its_pmsi_init(void)
 		if (!of_property_read_bool(np, "msi-controller"))
 			continue;
 
-		parent = irq_find_matching_host(np, DOMAIN_BUS_NEXUS);
+		parent = irq_find_matching_host(np, DOMAIN_BUS_NEXUS, NULL);
 		if (!parent || !msi_get_domain_info(parent)) {
 			pr_err("%s: unable to locate ITS domain\n",
 			       np->full_name);
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 55317fa..1c9c944 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -593,7 +593,7 @@ void of_msi_configure(struct device *dev, struct device_node *np)
 	if (!msi_np)
 		return;
 
-	d = irq_find_matching_host(msi_np, DOMAIN_BUS_PLATFORM_MSI);
+	d = irq_find_matching_host(msi_np, DOMAIN_BUS_PLATFORM_MSI, NULL);
 	if (!d)
 		d = irq_find_host(msi_np);
 	dev_set_msi_domain(dev, d);
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 2e99a50..0da3bce 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -80,7 +80,7 @@ struct irq_domain *pci_host_bridge_of_msi_domain(struct pci_bus *bus)
 	if (!np)
 		np = bus->dev.of_node;
 
-	d = irq_find_matching_host(np, DOMAIN_BUS_PCI_MSI);
+	d = irq_find_matching_host(np, DOMAIN_BUS_PCI_MSI, NULL);
 	if (d)
 		return d;
 
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 4d89f98..12acddb 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -178,12 +178,13 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
 					 const struct irq_domain_ops *ops,
 					 void *host_data);
 extern struct irq_domain *irq_find_matching_host(struct device_node *node,
-						 enum irq_domain_bus_token bus_token);
+						 enum irq_domain_bus_token bus_token,
+						 void *bus_data);
 extern void irq_set_default_host(struct irq_domain *host);
 
 static inline struct irq_domain *irq_find_host(struct device_node *node)
 {
-	return irq_find_matching_host(node, DOMAIN_BUS_ANY);
+	return irq_find_matching_host(node, DOMAIN_BUS_ANY, NULL);
 }
 
 /**
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 8a8ef31..b4c15af 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -190,9 +190,11 @@ EXPORT_SYMBOL_GPL(irq_domain_add_legacy);
  * irq_find_matching_host() - Locates a domain for a given device node
  * @node: device-tree node of the interrupt controller
  * @bus_token: domain-specific data
+ * @bus_data: bus-specific data
  */
 struct irq_domain *irq_find_matching_host(struct device_node *node,
-					  enum irq_domain_bus_token bus_token)
+					  enum irq_domain_bus_token bus_token,
+					  void *bus_data)
 {
 	struct irq_domain *h, *found = NULL;
 	int rc;
@@ -209,7 +211,7 @@ struct irq_domain *irq_find_matching_host(struct device_node *node,
 	mutex_lock(&irq_domain_mutex);
 	list_for_each_entry(h, &irq_domain_list, link) {
 		if (h->ops->match)
-			rc = h->ops->match(h, node, bus_token, NULL);
+			rc = h->ops->match(h, node, bus_token, bus_data);
 		else
 			rc = ((h->of_node != NULL) && (h->of_node == node) &&
 			      ((bus_token == DOMAIN_BUS_ANY) ||
-- 
1.9.1

