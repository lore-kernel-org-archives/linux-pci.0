Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:59018 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932266Ab3HGJd2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Aug 2013 05:33:28 -0400
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
Subject: [PATCHv7 04/13] irqdomain: add irq_alloc_mapping() function
Date: Wed,  7 Aug 2013 11:32:25 +0200
Message-Id: <1375867954-2320-5-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1375867954-2320-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375867954-2320-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit extends the irqdomain subsystem with an
irq_alloc_mapping() function which allows to let the irqdomain code
find an available hwirq number in the range [ 0 ; domain size ] for
the given domain, and create a virq mapping for it.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Grant Likely <grant.likely@linaro.org>
Tested-by: Daniel Price <daniel.price@gmail.com>
---
 include/linux/irqdomain.h |  2 ++
 kernel/irq/irqdomain.c    | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index c983ed1..1ffa336 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -195,6 +195,8 @@ static inline unsigned int irq_linear_revmap(struct irq_domain *domain,
 extern unsigned int irq_find_mapping(struct irq_domain *host,
 				     irq_hw_number_t hwirq);
 extern unsigned int irq_create_direct_mapping(struct irq_domain *host);
+extern unsigned int irq_alloc_mapping(struct irq_domain *host,
+				      irq_hw_number_t *hwirq);
 extern int irq_create_strict_mappings(struct irq_domain *domain,
 				      unsigned int irq_base,
 				      irq_hw_number_t hwirq_base, int count);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 706724e..034bbac 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -375,6 +375,42 @@ unsigned int irq_create_direct_mapping(struct irq_domain *domain)
 EXPORT_SYMBOL_GPL(irq_create_direct_mapping);
 
 /**
+ * irq_alloc_mapping() - Allocate an irq for mapping
+ * @domain: domain to allocate the irq for or NULL for default domain
+ * @hwirq:  reference to the returned hwirq
+ *
+ * This routine are used for irq controllers which can choose the
+ * hardware interrupt number from a range [ 0 ; domain size ], such as
+ * is often the case with PCI MSI controllers. The function will
+ * returned the allocated hwirq number in the hwirq pointer, and the
+ * corresponding virq number as the return value.
+ */
+unsigned int irq_alloc_mapping(struct irq_domain *domain,
+			       irq_hw_number_t *out_hwirq)
+{
+	irq_hw_number_t hwirq;
+	int rc;
+
+	pr_debug("irq_alloc_mapping(0x%p)\n", domain);
+
+	for (hwirq = 0; hwirq < domain->revmap_size; hwirq++)
+		if (domain->linear_revmap[hwirq] == 0)
+			break;
+
+	if (hwirq == domain->hwirq_max) {
+		pr_debug("-> no available hwirq found\n");
+		return 0;
+	}
+
+	rc = irq_create_mapping(domain, hwirq);
+	if (rc)
+		*out_hwirq = hwirq;
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(irq_alloc_mapping);
+
+/**
  * irq_create_mapping() - Map a hardware interrupt into linux irq space
  * @domain: domain owning this hardware interrupt or NULL for default domain
  * @hwirq: hardware irq number in that domain space
-- 
1.8.1.2

