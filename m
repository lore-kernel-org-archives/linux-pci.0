Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:47421 "EHLO
	mail.free-electrons.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751112Ab3G2M0F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 29 Jul 2013 08:26:05 -0400
Date: Mon, 29 Jul 2013 14:26:00 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <robherring2@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Re: [PATCHv5 05/11] of: pci: add registry of MSI chips
Message-ID: <20130729142600.63eeab50@skate>
In-Reply-To: <20130729065431.GA1115@manwe>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1373889167-27878-6-git-send-email-thomas.petazzoni@free-electrons.com>
	<51E41F7A.4010502@gmail.com>
	<20130728043310.6CF1D3E08FE@localhost>
	<20130728162711.32a9a21e@skate>
	<20130729065431.GA1115@manwe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Thierry Reding,

On Mon, 29 Jul 2013 08:54:31 +0200, Thierry Reding wrote:

> > So what is your suggestion to allow the PCIe controller to retrieve the
> > correct irq_domain if we have only one DT node for the IRQ controller
> > that registers two irq_domains ?
> 
> If I understand correctly, Grant isn't objecting to the introduction of
> the lookup function, but rather its implementation. You could add a
> pointer to a struct msi_chip within struct irq_domain and then iterate
> over all irq_domain instances (see irq_find_host()) and find one which
> has the correct device_node pointer and the msi_chip pointer set.

Ah ok. The only trick is that we have to change irq_find_host() to
*not* match on MSI domains. Can you check the below patch to see if it
matches what Grant suggested? It works for me, and it allows to completely
remove the registry of msi_chip in drivers/of, as well as the of_node
pointer in struct msi_chip.

Thanks!

Thomas

>From c2c0137cb110270f96e1e0fa298a5d585b8d829e Mon Sep 17 00:00:00 2001
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Mon, 29 Jul 2013 14:12:31 +0200
Subject: [PATCHv6 05/11] irqdomain: add support to associate an irq_domain
 with a msi_chip

Message Signaled Interrupts are a PCI-specific mechanism that allows
PCI devices to notify interrupts to the CPU using in-band
messages. The PCI subsystem represents an MSI-capable interrupt
controller as an msi_chip structure, and this patch improves the
irqdomain subsystem with a new pointer associating an irq_domain with
the corresponding msi_chip.

The __irq_domain_add() function is augmented with an additional
argument, the 'msi_chip' pointer, and all callers of this function are
updated.

A new function irq_domain_add_msi() function is added to allow the
registration of an MSI-type irq domain.

The irq_find_host() function is modified to not match on MSI-type irq
domains: a given DT device node may represent both a normal interrupt
controller and a MSI interrupt controller. irq_find_host() should
return the irq_domain that corresponds to the normal interupt
controller.

An irq_find_msi() function is added to get the MSI_type irq domain
given a DT device node.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 include/linux/irqdomain.h | 20 +++++++++++++++++---
 kernel/irq/irqdomain.c    | 35 +++++++++++++++++++++++++++++++++--
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 1ffa336..f1b11c8 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -38,6 +38,7 @@
 struct device_node;
 struct irq_domain;
 struct of_device_id;
+struct msi_chip;
 
 /* Number of irqs reserved for a legacy isa controller */
 #define NUM_ISA_INTERRUPTS	16
@@ -101,6 +102,7 @@ struct irq_domain {
 	/* Optional data */
 	struct device_node *of_node;
 	struct irq_domain_chip_generic *gc;
+	struct msi_chip *msi_chip;
 
 	/* reverse map data. The linear map gets appended to the irq_domain */
 	irq_hw_number_t hwirq_max;
@@ -114,6 +116,7 @@ struct irq_domain {
 struct irq_domain *__irq_domain_add(struct device_node *of_node, int size,
 				    irq_hw_number_t hwirq_max, int direct_max,
 				    const struct irq_domain_ops *ops,
+				    struct msi_chip *msi_chip,
 				    void *host_data);
 struct irq_domain *irq_domain_add_simple(struct device_node *of_node,
 					 unsigned int size,
@@ -127,6 +130,7 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
 					 const struct irq_domain_ops *ops,
 					 void *host_data);
 extern struct irq_domain *irq_find_host(struct device_node *node);
+extern struct irq_domain *irq_find_msi(struct device_node *node);
 extern void irq_set_default_host(struct irq_domain *host);
 
 /**
@@ -141,14 +145,15 @@ static inline struct irq_domain *irq_domain_add_linear(struct device_node *of_no
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(of_node, size, size, 0, ops, host_data);
+	return __irq_domain_add(of_node, size, size, 0, ops, NULL, host_data);
 }
 static inline struct irq_domain *irq_domain_add_nomap(struct device_node *of_node,
 					 unsigned int max_irq,
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(of_node, 0, max_irq, max_irq, ops, host_data);
+	return __irq_domain_add(of_node, 0, max_irq, max_irq, ops, NULL,
+				host_data);
 }
 static inline struct irq_domain *irq_domain_add_legacy_isa(
 				struct device_node *of_node,
@@ -162,7 +167,16 @@ static inline struct irq_domain *irq_domain_add_tree(struct device_node *of_node
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(of_node, 0, ~0, 0, ops, host_data);
+	return __irq_domain_add(of_node, 0, ~0, 0, ops, NULL, host_data);
+}
+static inline struct irq_domain *irq_domain_add_msi(struct device_node *of_node,
+						    unsigned int size,
+						    const struct irq_domain_ops *ops,
+						    struct msi_chip *msi_chip,
+						    void *host_data)
+{
+	return __irq_domain_add(of_node, size, size, 0, ops,
+				msi_chip, host_data);
 }
 
 extern void irq_domain_remove(struct irq_domain *host);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index b9ddb94..80dc1ca 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -29,6 +29,7 @@ static struct irq_domain *irq_default_domain;
  * @direct_max: Maximum value of direct maps; Use ~0 for no limit; 0 for no
  *              direct mapping
  * @ops: map/unmap domain callbacks
+ * @msi_chip: pointer to MSI chip structure, for MSI domains
  * @host_data: Controller private data pointer
  *
  * Allocates and initialize and irq_domain structure.  Caller is expected to
@@ -38,6 +39,7 @@ static struct irq_domain *irq_default_domain;
 struct irq_domain *__irq_domain_add(struct device_node *of_node, int size,
 				    irq_hw_number_t hwirq_max, int direct_max,
 				    const struct irq_domain_ops *ops,
+				    struct msi_chip *msi_chip,
 				    void *host_data)
 {
 	struct irq_domain *domain;
@@ -52,6 +54,7 @@ struct irq_domain *__irq_domain_add(struct device_node *of_node, int size,
 	domain->ops = ops;
 	domain->host_data = host_data;
 	domain->of_node = of_node_get(of_node);
+	domain->msi_chip = msi_chip;
 	domain->hwirq_max = hwirq_max;
 	domain->revmap_size = size;
 	domain->revmap_direct_max_irq = direct_max;
@@ -127,7 +130,7 @@ struct irq_domain *irq_domain_add_simple(struct device_node *of_node,
 {
 	struct irq_domain *domain;
 
-	domain = __irq_domain_add(of_node, size, size, 0, ops, host_data);
+	domain = __irq_domain_add(of_node, size, size, 0, ops, NULL, host_data);
 	if (!domain)
 		return NULL;
 
@@ -172,7 +175,7 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
 	struct irq_domain *domain;
 
 	domain = __irq_domain_add(of_node, first_hwirq + size,
-				  first_hwirq + size, 0, ops, host_data);
+				  first_hwirq + size, 0, ops, NULL, host_data);
 	if (!domain)
 		return NULL;
 
@@ -198,6 +201,12 @@ struct irq_domain *irq_find_host(struct device_node *node)
 	 */
 	mutex_lock(&irq_domain_mutex);
 	list_for_each_entry(h, &irq_domain_list, link) {
+		/*
+		 * We only want to match normal interrupt domains, not
+		 * MSI domains
+		 */
+		if (h->msi_chip)
+			continue;
 		if (h->ops->match)
 			rc = h->ops->match(h, node);
 		else
@@ -214,6 +223,28 @@ struct irq_domain *irq_find_host(struct device_node *node)
 EXPORT_SYMBOL_GPL(irq_find_host);
 
 /**
+ * irq_find_msi() - Locates a MSI domain for a given device node
+ * @node: device-tree node of the interrupt controller
+ */
+struct irq_domain *irq_find_msi(struct device_node *node)
+{
+	struct irq_domain *h, *found = NULL;
+
+	mutex_lock(&irq_domain_mutex);
+	list_for_each_entry(h, &irq_domain_list, link) {
+		if (!h->msi_chip)
+			continue;
+		if (h->of_node && h->of_node == node) {
+			found = h;
+			break;
+		}
+	}
+	mutex_unlock(&irq_domain_mutex);
+	return found;
+}
+EXPORT_SYMBOL_GPL(irq_find_msi);
+
+/**
  * irq_set_default_host() - Set a "default" irq domain
  * @domain: default domain pointer
  *
-- 
1.8.1.2




-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
