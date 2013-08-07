Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:59029 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932266Ab3HGJdb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Aug 2013 05:33:31 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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
Subject: [PATCHv7 05/13] irqdomain: refactor __irq_domain_add()
Date: Wed,  7 Aug 2013 11:32:26 +0200
Message-Id: <1375867954-2320-6-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1375867954-2320-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375867954-2320-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently, the __irq_domain_add() function does both the irq_domain
allocation *and* registration. This is a problem for
irq_domain_add_*() helpers that need to do something between the
allocation and the registration, such as for example setting a
d->msi_chip pointer in the irq_domain structure before this structure
is made globally visible by being registered.

Moreover, the comment in __irq_domain_add() also suggests that an
irq_domain_register() function should exist.

Therefore, this commit:

 * Splits __irq_domain_add() into __irq_domain_alloc() (allocation and
   initialization of the irq_domain) and __irq_domain_register()
   (registration of the irq_domain to the global list)

 * Modifies the existing users of __irq_domain_add() to use those two
   functions.

A next commit will make another use of it when introducing support for
msi_chip in the irqdomain code.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Tested-by: Daniel Price <daniel.price@gmail.com>
---
 include/linux/irqdomain.h | 21 +++++++++++++++++----
 kernel/irq/irqdomain.c    | 40 +++++++++++++++++++++++++++-------------
 2 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 1ffa336..7113941 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -111,10 +111,11 @@ struct irq_domain {
 };
 
 #ifdef CONFIG_IRQ_DOMAIN
-struct irq_domain *__irq_domain_add(struct device_node *of_node, int size,
+struct irq_domain *__irq_domain_alloc(struct device_node *of_node, int size,
 				    irq_hw_number_t hwirq_max, int direct_max,
 				    const struct irq_domain_ops *ops,
 				    void *host_data);
+void __irq_domain_register(struct irq_domain *domain);
 struct irq_domain *irq_domain_add_simple(struct device_node *of_node,
 					 unsigned int size,
 					 unsigned int first_irq,
@@ -141,14 +142,22 @@ static inline struct irq_domain *irq_domain_add_linear(struct device_node *of_no
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(of_node, size, size, 0, ops, host_data);
+	struct irq_domain *d;
+	d = __irq_domain_alloc(of_node, size, size, 0, ops, host_data);
+	if (d)
+		__irq_domain_register(d);
+	return d;
 }
 static inline struct irq_domain *irq_domain_add_nomap(struct device_node *of_node,
 					 unsigned int max_irq,
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(of_node, 0, max_irq, max_irq, ops, host_data);
+	struct irq_domain *d;
+	d = __irq_domain_alloc(of_node, 0, max_irq, max_irq, ops, host_data);
+	if (d)
+		__irq_domain_register(d);
+	return d;
 }
 static inline struct irq_domain *irq_domain_add_legacy_isa(
 				struct device_node *of_node,
@@ -162,7 +171,11 @@ static inline struct irq_domain *irq_domain_add_tree(struct device_node *of_node
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(of_node, 0, ~0, 0, ops, host_data);
+	struct irq_domain *d;
+	d = __irq_domain_alloc(of_node, 0, ~0, 0, ops, host_data);
+	if (d)
+		__irq_domain_register(d);
+	return d;
 }
 
 extern void irq_domain_remove(struct irq_domain *host);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 034bbac..8d02af7 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -23,7 +23,7 @@ static DEFINE_MUTEX(revmap_trees_mutex);
 static struct irq_domain *irq_default_domain;
 
 /**
- * __irq_domain_add() - Allocate a new irq_domain data structure
+ * __irq_domain_alloc() - Allocate a new irq_domain data structure
  * @of_node: optional device-tree node of the interrupt controller
  * @size: Size of linear map; 0 for radix mapping only
  * @direct_max: Maximum value of direct maps; Use ~0 for no limit; 0 for no
@@ -31,14 +31,15 @@ static struct irq_domain *irq_default_domain;
  * @ops: map/unmap domain callbacks
  * @host_data: Controller private data pointer
  *
- * Allocates and initialize and irq_domain structure.  Caller is expected to
- * register allocated irq_domain with irq_domain_register().  Returns pointer
- * to IRQ domain, or NULL on failure.
+ * Allocates and initializes an irq_domain structure.  Caller is
+ * expected to register the allocated irq_domain with
+ * __irq_domain_register().  Returns pointer to IRQ domain, or NULL on
+ * failure.
  */
-struct irq_domain *__irq_domain_add(struct device_node *of_node, int size,
-				    irq_hw_number_t hwirq_max, int direct_max,
-				    const struct irq_domain_ops *ops,
-				    void *host_data)
+struct irq_domain *__irq_domain_alloc(struct device_node *of_node, int size,
+				      irq_hw_number_t hwirq_max, int direct_max,
+				      const struct irq_domain_ops *ops,
+				      void *host_data)
 {
 	struct irq_domain *domain;
 
@@ -56,14 +57,24 @@ struct irq_domain *__irq_domain_add(struct device_node *of_node, int size,
 	domain->revmap_size = size;
 	domain->revmap_direct_max_irq = direct_max;
 
+	return domain;
+}
+EXPORT_SYMBOL_GPL(__irq_domain_alloc);
+
+/**
+ * __irq_domain_register() - Register a new irq_domain that has been
+ * previously allocated with __irq_domain_alloc().
+ * @domain: irq_domain to registers
+ */
+void __irq_domain_register(struct irq_domain *domain)
+{
 	mutex_lock(&irq_domain_mutex);
 	list_add(&domain->link, &irq_domain_list);
 	mutex_unlock(&irq_domain_mutex);
 
 	pr_debug("Added domain %s\n", domain->name);
-	return domain;
 }
-EXPORT_SYMBOL_GPL(__irq_domain_add);
+EXPORT_SYMBOL_GPL(__irq_domain_register);
 
 /**
  * irq_domain_remove() - Remove an irq domain.
@@ -127,7 +138,7 @@ struct irq_domain *irq_domain_add_simple(struct device_node *of_node,
 {
 	struct irq_domain *domain;
 
-	domain = __irq_domain_add(of_node, size, size, 0, ops, host_data);
+	domain = __irq_domain_alloc(of_node, size, size, 0, ops, host_data);
 	if (!domain)
 		return NULL;
 
@@ -143,6 +154,8 @@ struct irq_domain *irq_domain_add_simple(struct device_node *of_node,
 		irq_domain_associate_many(domain, first_irq, 0, size);
 	}
 
+	__irq_domain_register(domain);
+
 	return domain;
 }
 EXPORT_SYMBOL_GPL(irq_domain_add_simple);
@@ -171,12 +184,13 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
 {
 	struct irq_domain *domain;
 
-	domain = __irq_domain_add(of_node, first_hwirq + size,
-				  first_hwirq + size, 0, ops, host_data);
+	domain = __irq_domain_alloc(of_node, first_hwirq + size,
+				    first_hwirq + size, 0, ops, host_data);
 	if (!domain)
 		return NULL;
 
 	irq_domain_associate_many(domain, first_irq, first_hwirq, size);
+	__irq_domain_register(domain);
 
 	return domain;
 }
-- 
1.8.1.2

