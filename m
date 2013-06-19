Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:42319 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934462Ab3FSQ4Y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jun 2013 12:56:24 -0400
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
	Thierry Reding <thierry.reding@avionic-design.de>
Subject: [PATCHv3 01/11] irqdomain: add irq_alloc_mapping() function
Date: Wed, 19 Jun 2013 18:56:09 +0200
Message-Id: <1371660979-21588-2-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit extends the irqdomain subsystem with an
irq_alloc_mapping() function which allows to let the irqdomain code
find an available hwirq number in the range [ 0 ; domain size ] for
the given domain, and create a virq mapping for it.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 include/linux/irqdomain.h |  2 ++
 kernel/irq/irqdomain.c    | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 02f7658..5f9c3ff 100644
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
index 836a0f7..be82d2e 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -375,6 +375,38 @@ unsigned int irq_create_direct_mapping(struct irq_domain *domain)
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
+
+	pr_debug("irq_alloc_mapping(0x%p)\n", domain);
+
+	for (hwirq = 0; hwirq < domain->hwirq_max; hwirq++)
+		if (!irq_find_mapping(domain, hwirq))
+			break;
+
+	if (hwirq == domain->hwirq_max) {
+		pr_debug("-> no available hwirq found\n");
+		return 0;
+	}
+
+	*out_hwirq = hwirq;
+	return irq_create_mapping(domain, hwirq);
+}
+EXPORT_SYMBOL_GPL(irq_alloc_mapping);
+
+/**
  * irq_create_mapping() - Map a hardware interrupt into linux irq space
  * @domain: domain owning this hardware interrupt or NULL for default domain
  * @hwirq: hardware irq number in that domain space
-- 
1.8.1.2

